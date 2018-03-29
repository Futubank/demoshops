/**
 * Popup Manager
 */
AMI.UI.PopupManager = {
    popupCount: 0,
    nextId: 1,
    popups: {},

    add: function(id, obj){
        this.popups[id] = obj;
        this.popupCount++;
        this.nextId++;
    },

    del: function(id){
        this.popups[id] = null;
        this.popupCount--;
    },

    show: function(id){
        this.popups[id].up();
    },

    findParentPopup: function(obj){
        while(obj = obj.parentNode){
            if(obj.popupId != undefined){
                return this.popups[obj.popupId];
            }
        }
        return false;
    }
};

/**
 * content:     [object/string] object to wrap or a text string,
 * params:
 * {
 *      id:                 [string] popup id
 *      width:              [int] popup width
 *      height:             [int] popup height
 *      autoHeight:         [bool]
 *      header:             [string] header string
 *      modal:              [bool] modal or not
 *      disableLayerClick:  [bool] do not close modal window on layer click (default = false)
 *      hasCloseBtn:        [bool] has close button in header or not
 *      movable:            [bool] can be moved by dragging header
 *      dragBy:             [string] header/body
 *      autoshow:           [bool] show on init
 *      autocenter:         [bool] center popup automatically
 *      position:           [string] position: 'fixed', 'absolute'
 *      animated:           [bool] is animated
 *      animation:          [object] {open: none/fadein/resize, close: none/fadeout/resize}
 *      openFrom:           [object] {x: x-position, y: y-position} Start coordinates of opening animation
 *      closeTo:            [object] {x: x-position, y: y-position} End coordinates of closing animation
 *      showAt:             [object] {x: x-position, y: y-position} Coordinates of open popup
 *      onInit:             [function] onInit callback
 *      onShow:             [function] onShow callback
 *      onClose:            [function] ocClose callback
 *      className:          [string] popup window class name, defaul - amiPopup
 *      zIndex:             [int] Exact z-index value of popup window
 * }
 */
AMI.UI.Popup = function(content, params){

    this.params = params;

    this.ieCompat = false;
    if(AMI.Browser.isIE){
        this.ieCompat = (document.documentMode) ? document.documentMode : (document.compatMode && document.compatMode=="CSS1Compat") ? 7 : 5;
    }

    /**
     * Constructor.
     */
    this.init = function(){
        this.popupId = (this.params.id != undefined) ? this.params.id : 'ami_popup_' + AMI.UI.PopupManager.nextId;
        this.content.popupId = this.popupId;
        this.layer = null;
        this.originParent = null;
        this.originNextSibling = null;
        this.popupContent = null;
        this.header = null;
        this.object = null;
        this.className = (this.params.className != undefined) ? params.className : 'amiPopup';
        this.hasCloseBtn = (this.params.hasCloseBtn != undefined) ? this.params.hasCloseBtn : true;
        this.openAnimation = ((this.params.animation != undefined) && (this.params.animation.open != undefined)) ? this.params.animation.open : 'resize';
        this.closeAnimation = ((this.params.animation != undefined) && (this.params.animation.close != undefined)) ? this.params.animation.close : 'resize';
        this.dragBy = (this.params.dragBy != undefined) ? this.params.dragBy : 'header';

        this.params.position = (typeof(this.params.position) != 'undefined') ? this.params.position : 'fixed';
        this.params.autocenter = (typeof(this.params.autocenter) != 'undefined') ? this.params.autocenter : true;

        this.disableLayerClick = (this.params.disableLayerClick != undefined) ? params.disableLayerClick : false;

        var clientWidth = AMI.Browser.getWindowWidth();
        var clientHeight = AMI.Browser.getWindowHeight();

        this.params.width = (this.params.width != undefined) ? this.params.width : 500;
        this.params.height = (this.params.height != undefined) ? this.params.height : 500;

        this.params.autoHeight = (this.params.autoHeight != undefined) ? this.params.autoHeight : false;

        this.params.width = Math.min(this.params.width, clientWidth - 40);
        this.params.height = Math.min(this.params.height, clientHeight - 40);

        this.positionX = Math.max(0, Math.round((clientWidth - this.params.width) / 2));
        this.positionY = Math.max(0, Math.round((clientHeight - this.params.height) / 2));

        var oTarget = AMI.Browser.Event.getTarget(AMI.Browser.Event.globalEvent);
        this.openX = Math.round(AMI.Browser.getWindowWidth()/2);
        this.openY = Math.round(AMI.Browser.getWindowHeight()/2);
        if(oTarget && !AMI.Browser.isOpera){
            var coords = AMI.Browser.getObjectPosition(oTarget);
            if(AMI.UI.PopupManager.findParentPopup(oTarget)){
                // link in a popup
                this.openX = coords[0];
                this.openY = coords[1];
            }else{
                // link on a document body
                this.openX = coords[0] - AMI.Browser.getDocumentLeft();
                this.openY = coords[1] - AMI.Browser.getDocumentTop();
            }
        }
        this.closeX = this.openX;
        this.closeY = this.openY;

        if(this.params.openFrom != undefined){
            this.openX = this.params.openFrom.x;
            this.openY = this.params.openFrom.y;
        }
        if(this.params.closeTo != undefined){
            this.closeX = this.params.closeTo.x;
            this.closeY = this.params.closeTo.y;
        }
        if(this.params.showAt != undefined){
            this.positionX = this.params.showAt.x;
            this.positionY = this.params.showAt.y;
        }

        this.zIndex = (typeof(this.params.zIndex) != 'undefined') ? this.params.zIndex : 100000;

        AMI.UI.PopupManager.add(this.popupId, this);

        if((this.params.modal == undefined) || this.params.modal){
            this._createLayer();
        }
        this._createWindow();
        this.placeContent();

        // Set margin-box box sizing for popup, header and content
        var boxSizing = 'border-box';
        this.content.style.boxSizing = boxSizing;
        this.content.style.MozBoxSizing = boxSizing;
        this.content.style.webkitBoxSizing = boxSizing;
        this.header.style.boxSizing = boxSizing;
        this.header.style.MozBoxSizing = boxSizing;
        this.header.style.webkitBoxSizing = boxSizing;

        var boxSizing = 'content-box';
        this.object.style.boxSizing = boxSizing;
        this.object.style.MozBoxSizing = boxSizing;
        this.object.style.webkitBoxSizing = boxSizing;

        // onInit callback
        if(typeof(params.onInit) == 'function'){
            params.onInit(this);
        }

        // Auto show
        if((typeof(params.autoShow) == 'undefined') || params.autoShow){
            this.show();
        }
    };

    /**
     * Display popup.
     */
    this.show = function(){
        if (this.layer) this.layer.style.display = 'block';
        this.object.style.left = parseInt(this.openX) + 'px';
        this.object.style.top = parseInt(this.openY) + 'px';
        this.object.style.display = 'block';
        this.object.style.position = (this.ieCompat == 5) ? 'absolute' : this.params.position;
        if((this.params.animated == undefined) || this.params.animated){
            switch(this.openAnimation){
                case 'resize':
                    this._openResize();
                    break;
                case 'fadein':
                    this._openFadein();
                    break;
                default:
                    this._openNone();
                    break;
            }
        }else{
            this._openNone();
        }
    };

    /**
     * Place popup content into popup window.
     */
    this.placeContent = function(){

        if(this.origin){
            this.originParent = (this.origin.parentNode != undefined) ? this.origin.parentNode : null;
            this.originNextSibling = (this.origin.nextSibling != undefined) ? this.origin.nextSibling : null;
            this.originParent.removeChild(this.origin);
        }
        this.popupContent.appendChild(this.content);
        var headerH = this.header.offsetHeight;
        this.params.width = Math.max(this.params.width, this.content.offsetWidth);
        this.params.height = Math.max(this.params.height, this.content.offsetHeight + headerH);

        if(this.params.autocenter){
            AMI.UI.center(this.object);
        }
        if(this.ieCompat == 5){
            this.object.style.top = (parseInt(this.object.style.top) + AMI.Browser.getDocumentTop(window)) + 'px';
        }
    };

    /**
     * Set popup size according to its content.
     */
    this.autosize = function(allowShrink){

        var popupHeight = parseInt(this.object.style.height);
        if(this.ieCompat == 5){
            this.contentHeight = this.content.offsetHeight + (this.content.offsetTop * 2);
            this.object.style.height = this.contentHeight + this.header.offsetHeight + 'px';
        }else{
            var doResize = ((allowShrink == undefined) || !allowShrink) ?
                (this.content.offsetHeight > (popupHeight - this.header.offsetHeight)) :
                (this.content.offsetHeight != (popupHeight - this.header.offsetHeight));
            if(doResize){
                this.resize({
                    height: this.content.offsetHeight + this.header.offsetHeight
                });
            }
        }
    }

    /**
     * Resizes popup
     *
     * @param {Object} newSize {height: int, width: int}
     */
    this.resize = function(newSize){
        if(typeof(newSize['height']) != 'undefined'){
            this.object.style.height = parseInt(newSize['height']) + 'px';
            if((typeof(this.params.movable) != 'undefined') && !this.params.movable){
                if(this.params.autocenter){
                    AMI.UI.centerH(this.object);
                }
                this.object.style.top = (parseInt(this.object.style.top) + AMI.Browser.getDocumentTop(window)) + 'px';
            }
        }
        if(typeof(newSize['width']) != 'undefined'){
            this.object.style.width = parseInt(newSize['width']) + 'px';
            if((typeof(this.params.movable) != 'undefined') && !this.params.movable){
                if(this.params.autocenter){
                    AMI.UI.centerW(this.object);
                }
            }
        }
    }

    /**
     * Close the popup.
     */
    this.close = function(){
        if(this.resizeTimer != undefined){
            clearInterval(this.resizeTimer);
        }
        AMI.UI.PopupManager.del(this.popupId);
        if(this.layer && this.layer.parentNode){
            this.layer.parentNode.removeChild(this.layer);
        }
        this.content.popupId = null;
        this.content.style.display = 'none';
        /*if(this.content.parentNode){
            this.content.parentNode.removeChild(this.content);
        }*/

        if((this.params.animated == undefined) || this.params.animated){
            switch(this.closeAnimation){
                case 'resize':
                    this._closeResize();
                    break;
                case 'fadeout':
                    this._closeFadeout();
                    break;
                default:
                    this._closeNone();
                    break;
            }
        }else{
            this._closeNone();
        }
    };

    /**
     * Set content of the popup as raw HTML.
     */
    this.setHTML = function(html){
        this.content.innerHTML = html;
    }

    /**
     * --------------------------------------------------
     *                 Private methods
     * --------------------------------------------------
     */

    /**
     * Open popup with no animation.
     */
    this._openNone = function(){
        this.object.style.left = parseInt(this.positionX) + 'px';
        this.object.style.top = parseInt(this.positionY) + 'px';
        this.object.style.width = this.params.width + 'px';
        this.object.style.height = this.params.autoHeight ? 'auto' : (this.params.height + 'px');
        this.content.style.display = 'block';
        this.object.style.display = 'block';
        this.object.style.visibility = 'visible';

        if(((this.params.height == undefined)||(this.params.width == undefined))||(this.content.offsetHeight > this.params.height)){
            this.autosize();
        }

        AMI.Browser.Event.addHandler(this.content, 'click', function(_this){return function(e){_this.autosize();}}(this));

        // Correct popup top in IE compatibility mode 5
        if(this.ieCompat == 5){
            this.object.style.top = (parseInt(this.object.style.top) + AMI.Browser.getDocumentTop(window)) + 'px';
        }

        // Fix for alerts
        if(this.ieCompat == 5){
            var contentHeight = this.content.offsetHeight + (this.content.offsetTop * 2);
            this.object.style.height = contentHeight + this.header.offsetHeight + 'px';
        }

        // Close popup by layer click
        if(this.layer && !this.disableLayerClick){
            AMI.Browser.Event.addHandler(this.layer, 'click', function(popup){return function(){popup.close();}}(this));
        }
        if(typeof(this.params.onShow) == 'function'){
            this.params.onShow(this);
        }
    },

    /**
     * Open popup with resize animation.
     */
    this._openResize = function(){

        // Do not use effects in compatibility mode
        if(this.ieCompat == 5){
            this._openNone();
            return;
        }

        AMI.UI.Effects.animate(
            this.object,
            {   // initial state
                left:   this.openX,
                top:    this.openY,
                width:  0,
                height: 0
            },
            {   // final state
                left:   this.positionX,
                top:    this.positionY,
                width:  this.params.width,
                height: this.params.autoHeight ? 'auto' : this.params.height
            },
            300, // Open in 300 ms.
            function(popup){
                return function(){
                    popup._openNone();
                }
            }(this)
        );
    },

    /**
     * Open popup with fade in animation.
     */
    this._openFadein = function(){

        // Do not use effects in compatibility mode
        if(this.ieCompat == 5){
            this._openNone();
            return;
        }

        this.object.style.left = parseInt(this.positionX) + 'px';
        this.object.style.top = parseInt(this.positionY) + 'px';
        this.object.style.width = this.params.width + 'px';
        this.object.style.height = this.params.autoHeight ? 'auto' : (this.params.height + 'px');

        this.object.style.visibility = 'hidden';
        this.object.style.display = 'block';
        if(((this.params.height == undefined)||(this.params.width == undefined))||(this.content.offsetHeight > this.params.height)){
            this.autosize();
        }
        this.content.style.display = 'block';
        AMI.UI.Effects.fadeIn(
            this.object,
            600,
            function(popup){
                return function(){
                    popup._openNone();
                }
            }(this)
        );
    },

    /**
     * Close popup with no animation.
     */
    this._closeNone = function(){
        if(this.object.parentNode){
            this.object.parentNode.removeChild(this.object);
        }
        if(this.origin){
            this.originParent.appendChild(this.origin);
        }
        if(typeof(this.params.onClose) == 'function'){
            this.params.onClose(this);
        }
    },

    /**
     * Close popup with resize animation.
     */
    this._closeResize = function(){

        // Do not use effects in compatibility mode
        if(this.ieCompat == 5){
            this._closeNone();
            return;
        }

        AMI.UI.Effects.animate(
            this.object,
            {   // initial state
                left:   parseInt(this.object.style.left),
                top:    parseInt(this.object.style.top),
                width:  this.object.offsetWidth,
                height: this.object.offsetHeight
            },
            {   // final state
                left:   this.closeX,
                top:    this.closeY,
                width:  0,
                height: 0
            },
            300, // Open in 300 ms.
            function(popup){
                return function(){
                    popup._closeNone();
                }
            }(this)
        );
    },

    /**
     * Close popup with fadeout effect.
     */
    this._closeFadeout = function(){

        // Do not use effects in compatibility mode
        if(this.ieCompat == 5){
            this._closeNone();
            return;
        }

        AMI.UI.Effects.fadeOut(
            this.object,
            500,
            function(popup){
                return function(){
                    popup._closeNone();
                }
            }(this)
        );
    },

    this._createLayer = function(){
        var layer = document.createElement('DIV');
        layer.className = 'popupWindowShadow';
        layer.id = this.popupId + '_layer';
        layer.style.zIndex = this.zIndex;
        layer.style.display = 'none';
        if(this.ieCompat == 5){
            layer.style.position = 'absolute';
            layer.style.height = AMI.Browser.getDocumentHeight(window) + 'px';
        }
        document.body.appendChild(layer);
        this.layer = layer;
    }

    this._createWindow = function(){
        // Create popup layout
        var popup = document.createElement('DIV');
        popup.id = this.popupId;
        popup.style.width = 0;
        popup.style.height = 0;
        popup.className = this.className;
        popup.style.display = 'none';
        popup.style.zIndex = this.zIndex + 1;

        var popupHeader = document.createElement('DIV');
        popupHeader.id = this.popupId + '_header';
        popupHeader.className = 'popupHeader';
        popup.appendChild(popupHeader);

        var popupHeaderText = document.createElement('DIV');
        popupHeaderText.className = 'popupHeaderText';
        popupHeaderText.innerHTML = (this.params.header != undefined) ? this.params.header : '&nbsp;';
        popupHeader.appendChild(popupHeaderText);
        if(this.hasCloseBtn){
            var popupClose = document.createElement('DIV');
            popupClose.className = 'popupClose';
            AMI.Browser.Event.addHandler(popupClose,'click', function(popup){return function(){popup.close();}}(this)); // Close by click
            popupHeader.appendChild(popupClose);
        }

        var popupContent = document.createElement('DIV');
        popupContent.className = 'popupContent';
        popup.appendChild(popupContent);

        document.body.appendChild(popup);

        // Increase window z-index if not a modal window
        AMI.Browser.Event.addHandler(popupHeader,'mousedown', function(popup){
            return function(){
                popup.up();
            }
        }(this));

        // Initialize drag'n'drop: move popup by dragging header
        if((this.params.movable == undefined) || this.params.movable){
            AMI.UI.DnD.initElement(popup, (this.dragBy == 'header') ? popupHeader : popup);
        }

        this.header = popupHeader;
        this.popupContent = popupContent;
        this.object = popup;
    }

    this.up = function(){
        if((typeof(this.params.modal) != "undefined") && !this.params.modal){
            var maxZIndex = AMI.Browser.DOM.getMaxZIndex();
            if(maxZIndex > (this.zIndex + 1)){
                this.zIndex = AMI.Browser.DOM.getMaxZIndex() + 10;
                this.object.style.zIndex = this.zIndex + 1;
            }
        }
    }

    if(typeof(content) == 'object'){
        if(content.popupId != undefined){
            AMI.UI.PopupManager.show(content.popupId);
            return;
        }
        this.origin = content;
        this.content = content; //  .cloneNode(true); <- many bad things happen
        this.origin.style.display = 'none';
    }else{
        if((params.id != undefined) && (AMI.UI.PopupManager.popups[params.id] != undefined)){
            AMI.UI.PopupManager.show(params.id);
            return;
        }
        this.origin = null;
        this.content = document.createElement('DIV');
        this.setHTML(content);
    }

    this.init();
}

/**
 * Closes any pupup window found up by the DOM tree.
 */
function closePopup(){
    obj = AMI.Browser.Event.getTarget(AMI.Browser.Event.globalEvent);
    if(popup = AMI.UI.PopupManager.findParentPopup(obj)){
        popup.close();
    }
}