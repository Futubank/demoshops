AMI.UI.MediaBox = {
    iImageAnimateTime: 100, //ms
    iImageFadeInTime: 100, //ms

    bOpenEnlarged: false,
    bShowGroupName: true,
    bShowGroupNameIfSingle: false,
    bShowSlider: false,

    bInitialized: false,
    oMediaShadow: null, oMediaBox: null, oLoader: null, oClose: null,
    oGroup: null, oHeader: null, oURL: null, oDescription: null,
    oImageArea: null, oPrevious: null, oNext: null, oImageContainer: null, oImage: null, oImageZoom: null, oImageZoomA: null,
    oSliderPrevious: null, oSliderNext: null, oSlider: null, oSliderCtrl: null, oImageCounter: null,
    sImageType: 'image',
    iImageWidthAddon: 20,
    iImageHeightAddon: 20,
    iImageHeightAddonOriginal: 20,

    hAnimateTimeout: null,
    iAnimateStepTime: null,
    iAnimateStepX: 0,
    iAnimateStepY: 0,
    iAnimateCurrentWidth: 0,
    iAnimateCurrentHeight: 0,
    iAnimateWidthTo: 0,
    iAnimateHeightTo: 0,
    iFadeInStep: 0,
    iFadeAnimationStep: 0,
    isOpening: false,
    isClosing: false,

    _iDocLeft: 0,
    _iDocTop: 0,
    _iWndWidth: 0,
    _iWndHeight: 0,
    _iTimeAnimateStop: 0,

    aGroupImages: [],
    groupCurrentIndex: 0,

    imageSizeCache: {},

    oSkins: {
        __default: {'skin': 'MediaBoxWhite', 'iWidthAddon': 20, 'iHeightAddon': 20}
    },

    addSkin: function(sSkin, aExtensions, iWidthAddon, iHeightAddon){
        if(typeof(aExtensions) == 'object'){
            for(var i = 0; i < aExtensions.length; i++){
                this.oSkins[aExtensions[i]] = {'skin': sSkin, 'iWidthAddon': iWidthAddon || 0, 'iHeightAddon':iHeightAddon || 0};
            }
        }
    },

    setOpenEnlarged: function(bState){
        this.bOpenEnlarged = bState;
    },

    setShowGroupName: function(bState){
        this.bShowGroupName = bState;
    },

    setShowGroupNameIfSingle: function(bState){
        this.bShowGroupNameIfSingle = bState;
    },

    open: function(imageUrl, imageWidth, imageHeight, groupName, header, url, urlCaption, description){
        if(this.isOpening){
            return;
        }
        this.isOpening = true;

        AMI.Browser.Event.addHandler(document, 'keydown', AMI.UI.MediaBox.closeOnEscape);

        imageWidth = imageWidth || 170;
        imageHeight = imageHeight || 150;
        groupName = groupName || '';
        header = header || '';
        url = url || '';
        urlCaption = urlCaption || '';
        description = description || '';

        var self = this;

        if(!this.bInitialized){
            this.oMediaShadow = AMI.Browser.DOM.create('DIV', '', 'MediaBox_shadow', '', document.body);
            this.oMediaBox = AMI.Browser.DOM.create('DIV', 'MediaBox', 'MediaBox', '', document.body);
            AMI.Browser.DOM.create('DIV', '', 'MediaBox_shadowL', '', this.oMediaBox);
            AMI.Browser.DOM.create('DIV', '', 'MediaBox_shadowR', '', this.oMediaBox);
            AMI.Browser.DOM.create('DIV', '', 'MediaBox_shadowT', '', this.oMediaBox);
            AMI.Browser.DOM.create('DIV', '', 'MediaBox_shadowB', '', this.oMediaBox);
            AMI.Browser.DOM.create('DIV', '', 'MediaBox_shadowLT', '', this.oMediaBox);
            AMI.Browser.DOM.create('DIV', '', 'MediaBox_shadowRT', '', this.oMediaBox);
            AMI.Browser.DOM.create('DIV', '', 'MediaBox_shadowLB', '', this.oMediaBox);
            AMI.Browser.DOM.create('DIV', '', 'MediaBox_shadowRB', '', this.oMediaBox);
            AMI.Browser.DOM.create('DIV', '', 'MediaBox_speckLT', '', this.oMediaBox);
            AMI.Browser.DOM.create('DIV', '', 'MediaBox_speckRB', '', this.oMediaBox);
            this.oClose = AMI.Browser.DOM.create('DIV', '', 'MediaBox_close', '', this.oMediaBox);
            this.oLoader = AMI.Browser.DOM.create('DIV', '', 'MediaBox_loader', '', this.oMediaBox);

            this.oGroup = AMI.Browser.DOM.create('DIV', '', 'MediaBox_group', '', this.oMediaBox);
            this.oHeader = AMI.Browser.DOM.create('DIV', '', 'MediaBox_header', '', this.oMediaBox);

            this.oImageArea = AMI.Browser.DOM.create('DIV', 'MediaBox_imageArea', 'MediaBox_imageArea', '', this.oMediaBox);
            this.oPrevious = AMI.Browser.DOM.create('DIV', 'MediaBox_previous', 'MediaBox_previous', '', this.oImageArea);
            this.oNext = AMI.Browser.DOM.create('DIV', 'MediaBox_next', 'MediaBox_next', '', this.oImageArea);
            this.oImageContainer = AMI.Browser.DOM.create('DIV', '', 'MediaBox_container', '', this.oImageArea);
            this.oImageZoom = AMI.Browser.DOM.create('DIV', '', 'MediaBox_zoom', '', this.oMediaBox);
            this.oImageZoomA = AMI.Browser.DOM.create('A', '', 'MediaBox_zoomA', '', this.oImageZoom);
            this.oImageZoomA.href = '';

            this.oDescription = AMI.Browser.DOM.create('DIV', '', 'MediaBox_description', '', this.oMediaBox);
            this.oURL = AMI.Browser.DOM.create('DIV', '', 'MediaBox_url', '', this.oMediaBox);

            this.oSliderPrevious = AMI.Browser.DOM.create('DIV', 'MediaBox_sliderPrevious', '', '', this.oMediaBox);
            this.oSliderNext = AMI.Browser.DOM.create('DIV', 'MediaBox_sliderNext', '', '', this.oMediaBox);
            this.oSlider = AMI.Browser.DOM.create('DIV', '', 'MediaBox_slider', '', this.oMediaBox);
            this.oImageCounter = AMI.Browser.DOM.create('DIV', '', 'MediaBox_counter', '', this.oMediaBox);

            if(AMI.Browser.isIE){
                if (navigator.appVersion.indexOf('MSIE 7.0') >= 0){
                    AMI.find('#MediaBox_previous').style.left = '-38px';
                    header = '<span style="font-size:1px;">&nbsp;</span>';
                    setInterval(
                        function() {
                            var height = AMI.find('#MediaBox').offsetHeight;
                            AMI.find('#MediaBox_previous').style.top = height ? parseInt(height/2-32) + 'px' : '50%';
                            AMI.find('#MediaBox_next').style.top = height ? parseInt(height/2-32) + 'px' : '50%';
                        }, 
                        100
                    );
                }
            }

            AMI.Browser.Event.addHandler(this.oClose, 'click', function(){self.close()});
            AMI.Browser.Event.addHandler(this.oMediaShadow, 'click', function(){self.close()});
            AMI.Browser.Event.addHandler(this.oPrevious, 'click', function(){self.previous()});
            AMI.Browser.Event.addHandler(this.oNext, 'click', function(){self.next()});

            this.bInitialized = true;
        }
        if(this.bInitialized){
            this.oMediaShadow.style.display = 'block';
            if(AMI.Browser.isIE || AMI.Browser.isIOS){
                this.oMediaShadow.style.width = AMI.Browser.getDocumentWidth() + 'px';
                this.oMediaShadow.style.height = AMI.Browser.getDocumentHeight() + 'px';
                this.oMediaBox.style.position = 'absolute';
            }
            this.startShadowAnimation(0);
            this.fadeInShadow();

            itemExtension = '';
            if(aMatches = imageUrl.match(/\.([a-zA-Z]{3,4})$/)){
                var itemExtension = aMatches[1].toLowerCase();
            }else if(aMatches = imageUrl.match(/\?sname=[^&]*\.([a-zA-Z]{3,4})&/)){
                var itemExtension = aMatches[1].toLowerCase();
            }
            var extension = typeof(this.oSkins[itemExtension]) != 'undefined' ? itemExtension : '__default';

            this.oMediaBox.className = 'MediaBox ' + this.oSkins[extension]['skin'];
            this.iImageWidthAddon = parseInt(this.oSkins[extension]['iWidthAddon']);
            this.iImageHeightAddon = this.iImageHeightAddonOriginal = parseInt(this.oSkins[extension]['iHeightAddon']);

            if(AMI.Browser.isIE || AMI.Browser.isIOS){
                this._iDocLeft = AMI.Browser.getDocumentLeft();
                this._iDocTop = AMI.Browser.getDocumentTop();
            }
            this._iWndWidth = AMI.Browser.getWindowWidth();
            this._iWndHeight = AMI.Browser.getWindowHeight();

            this.getGroupData(groupName, imageUrl);
            this.initSlider();
            this.updatePrevNext(false);
            this.loadImage(imageUrl, imageWidth, imageHeight, groupName, header, url, urlCaption, description);
        }
    },

    loadImage: function(imageUrl, imageWidth, imageHeight, groupName, header, url, urlCaption, description){
        var self = this;

        var bSWF = imageUrl.match(/\.swf$/i);

        this.setGroup(groupName);
        this.setHeader(header);
        this.setDescription(description);
        this.setURL(url, urlCaption);
        this.setZoom(false, [], false);
        this.setCounter(this.groupCurrentIndex + 1);

        if(imageWidth > 0 && imageHeight > 0){
            var ratio = this.getRatio(imageWidth, imageHeight, bSWF);
            imageWidth = Math.floor(imageWidth * ratio);
            imageHeight = Math.floor(imageHeight * ratio);

            this.positionBox(imageWidth + this.iImageWidthAddon, imageHeight + this.iImageHeightAddon);
        }

        if(!bSWF){
            this.sImageType = 'image';
            this.oLoader.style.display = 'block';
            this.oImage = new Image();
            this.oImage.className = 'MediaBox_image';
            this.oImage.onload = function(){self.displayImage();}
            if(this.aGroupImages.length > 1){
                this.oImage.onclick = function(evt){self.onImageClick(evt);}
            }
            this.oImage.src = imageUrl;
        }else{
            this.updatePrevNext();
            this.sImageType = 'FLASH';
            this.oLoader.style.display = 'none';
            this.oImageContainer.style.width = imageWidth + 'px';
            this.oImageContainer.style.height = imageHeight + 'px';

            this.showGroup();
            this.showHeader();
            this.showZoom();
            this.showDescription();
            this.showURL();
            this.showSlider();
            this.showCounter();

            this.oImageContainer.innerHTML = '<object type="application/x-shockwave-flash" data="' + imageUrl + '" width="' + imageWidth + '" height="' + imageHeight + '"><param name="movie" value="' + imageUrl + '"><param name="wmode" value="opaque"></object>';
        }
    },

    openFromObject: function(oElement){
        var image = oElement.getAttribute('data-ami-mbpopup') || '';
        var imageWidth = oElement.getAttribute('data-ami-mbpopup-width') || 0;
        var imageHeight = oElement.getAttribute('data-ami-mbpopup-height') || 0;
        var groupName = oElement.getAttribute('data-ami-mbgrp') || '';
        var header = oElement.getAttribute('data-ami-mbhdr') || '';
        var url = oElement.getAttribute('data-ami-mburl') || '';
        var urlCaption = oElement.getAttribute('data-ami-mburlcapt') || '';
        var description = oElement.getAttribute('data-ami-mbdescr') || '';

        if(AMI.Browser.isIE){
            if (navigator.appVersion.indexOf('MSIE 7.0') >= 0 ){
                if(!header){
                    header = '<span style="font-size:1px;">&nbsp;</span>';
                }
            }
        }
        
        if(image != ''){
            if(!image.match(/\.swf$/i)){
                imageWidth = 0;
                imageHeight = 0;
            }
            if(this.isOpening){
                this.loadImage(image, imageWidth, imageHeight, groupName, header, url, urlCaption, description);
            }else{
                this.open(image, imageWidth, imageHeight, groupName, header, url, urlCaption, description);
            }
        }
    },

    openByUrl: function(url){
        url = AMI.UI.MediaBox.PageImages.getImageLink(url);
        var aImages = AMI.find('img');
        for(var i = 0; i < aImages.length; i++){
            var popupImage = aImages[i].getAttribute('data-ami-mbpopup');
            if(popupImage != null && popupImage == url){
                this.openFromObject(aImages[i]);
                break;
            }
        }
    },

    openByIndex: function(index){
        if(index >= 0 && index < this.aGroupImages.length){
            this.groupCurrentIndex = index;
            this.openFromObject(this.aGroupImages[this.groupCurrentIndex]);
        }
    },

    closeOnEscape: function(e){
        if (!e) e = window.event; // fix IE
        if (e.keyCode) // IE
        {
            if (e.keyCode == "27") AMI.UI.MediaBox.close();
        }
        else if (e.charCode) // Netscape/Firefox/Opera
        {
            if (e.charCode == "27") AMI.UI.MediaBox.close();
        }
    },

    close: function(){
        if(!this.isClosing){
            this.isClosing = true;
            clearTimeout(this.hAnimateTimeout);

            if(this.oImage){
                this.oImage.onload = null;
                this.oImage = null;
            }
            this.oImageContainer.innerHTML = '';
            this.oMediaBox.style.display = 'none';

            this.startShadowAnimation(3)
            this.fadeOutShadow();
        }
    },

    previous: function(){
        this.openByIndex(this.groupCurrentIndex - 1);
    },

    next: function(){
        this.openByIndex(this.groupCurrentIndex + 1);
    },

    onImageClick: function(evt){
        var aPosition = AMI.Browser.getPointerPosition(evt);
        var aImagePosition = AMI.Browser.getObjectPosition(this.oImage);
        var clickX = aPosition[0] - aImagePosition[0] - AMI.Browser.getDocumentLeft();
        var median = this.oImage.offsetWidth / 2;
        if(clickX <= median){
            this.previous();
        }else{
            this.next();
        }
    },

    getGroupData: function(groupName, currentImageUrl){
        this.aGroupImages = [];
        this.groupCurrentIndex = 0;

        if(groupName != ''){
            var oRequest = {'groupName': groupName};
            var oResponse = {'aGroupImages': []};
            AMI.Message.send('ON_AMI_MEDIABOX_GET_GROUP', oRequest, oResponse);
            this.aGroupImages = oResponse.aGroupImages;
            for(var i = 0; i < this.aGroupImages.length; i++){
                if(this.aGroupImages[i].getAttribute('data-ami-mbpopup') == currentImageUrl){
                    this.groupCurrentIndex = i;
                    break;
                }
            }
        }
    },

    initSlider: function(){
        this.oSlider.innerHTML = '';
        this.oSlider.style.visibility = 'hidden';
        this.oSliderPrevious.style.visibility = 'hidden';
        this.oSliderNext.style.visibility = 'hidden';

        if(!this.bShowSlider || this.aGroupImages.length <= 1){
            this.oSlider.style.display = 'none';
            this.oSliderPrevious.style.display = 'none';
            this.oSliderNext.style.display = 'none';
            return;
        }else{
            this.oSlider.style.display = 'block';
            this.oSliderPrevious.style.display = 'block';
            this.oSliderNext.style.display = 'block';
        }

        var self = this;

        var oSliderContent = AMI.Browser.DOM.create('DIV', '', '', 'position: absolute', this.oSlider);
        for(var i = 0; i < this.aGroupImages.length; i++){
            if(i > 0){
                AMI.Browser.DOM.create('DIV', '', 'MediaBox_sliderDelimeter', '', oSliderContent).innerHTML = '&nbsp;';
            }
            var oSliderImage = AMI.Browser.DOM.create('IMG', '', 'MediaBox_sliderImage', '', oSliderContent);
            oSliderImage.src = this.aGroupImages[i].getAttribute('data-ami-mbpopup');
            AMI.Browser.Event.addHandler(oSliderImage, 'click', function(_this, _i){return function(){_this.openByIndex(_i)}}(this, i));
        }
        this.oSliderCtrl = new AMI.UI.Slider(this.oSlider, this.oSliderPrevious, this.oSliderNext, 50, true);
    },

    updatePrevNext: function(bForceValue){
        if(typeof(bForceValue) != 'undefined'){
            this.oPrevious.style.display = bForceValue ? 'block' : 'none';
            this.oNext.style.display = bForceValue ? 'block' : 'none';
        }else{
            this.oPrevious.style.display = this.aGroupImages.length > 1 && this.groupCurrentIndex > 0 ? 'block' : 'none';
            this.oNext.style.display = this.aGroupImages.length > 1 && this.groupCurrentIndex < this.aGroupImages.length - 1 ? 'block' : 'none';
        }
    },

    setGroup: function(groupName){
        if(!this.bShowGroupName){
            groupName = '';
        }else if(groupName != '' && !this.bShowGroupNameIfSingle){
            var oResponse = {result: 0};
            AMI.Message.send('ON_AMI_MEDIABOX_GROUPS_NUMBER', oResponse);
            if(oResponse.result <= 1){
                groupName = '';
            }
        }

        this.oGroup.style.display = groupName == '' ? 'none' : 'block';
        this.oGroup.style.visibility = 'hidden';
        this.oGroup.innerHTML = groupName;
    },

    showGroup: function(){
        if(this.oGroup.style.display == 'block'){
            this.oGroup.style.visibility = 'visible';
        }
    },

    setHeader: function(header){
        this.oHeader.style.display = header == '' ? 'none' : 'block';
        this.oHeader.style.visibility = 'hidden';
        this.oHeader.innerHTML = header;
    },

    showHeader: function(){
        if(this.oHeader.style.display == 'block'){
            this.oHeader.style.visibility = 'visible';
        }
    },

    setURL: function(url, urlCaption){
        this.oURL.style.display = url == '' ? 'none' : 'block';
        this.oURL.style.visibility = 'hidden';
        this.oURL.innerHTML = '<a href="' + url + '" target="_blank">' + (urlCaption != '' ? urlCaption : url) + '</a>';
    },

    showURL: function(){
        if(this.oURL.style.display == 'block'){
            this.oURL.style.visibility = 'visible';
        }
    },

    setDescription: function(description){
        this.oDescription.style.display = description == '' ? 'none' : 'block';
        this.oDescription.style.visibility = 'hidden';
        this.oDescription.innerHTML = description;
    },

    showDescription: function(){
        if(this.oDescription.style.display == 'block'){
            this.oDescription.style.visibility = 'visible';
        }
    },

    setZoom: function(bZoommed, aSizes, bShow){
        this.oImageZoom.style.display = bShow ? 'block' : 'none';
        this.oImageZoom.style.visibility = 'hidden';
        this.setZoomText(bZoommed, aSizes);
    },

    setZoomText: function(bZoommed, aSizes){
        var zoomText = bZoommed ? AMI.Template.Locale.get('mediaBoxZommed') : AMI.Template.Locale.get('mediaBoxNotZommed');
        zoomText = zoomText.replace('__width__', aSizes[0]).replace('__height__', aSizes[1]);
        this.oImageZoom.innerHTML = zoomText;
    },

    showZoom: function(){
        if(this.oImageZoom.style.display == 'block'){
            this.oImageZoom.style.visibility = 'visible';
        }
    },

    showSlider: function(){
        if(this.oSlider.style.display == 'block'){
            this.oSlider.style.visibility = 'visible';
            this.oSliderPrevious.style.visibility = 'visible';
            this.oSliderNext.style.visibility = 'visible';
            this.oSliderCtrl.reInit(this.oSlider.offsetWidth);
        }
    },

    setCounter: function(currentImage){
        this.oImageCounter.style.display = this.aGroupImages.length > 1 ? 'block' : 'none';
        this.oImageCounter.style.visibility = 'hidden';
        this.oImageCounter.innerHTML = AMI.Template.Locale.get('mediaBoxCounter').replace('__current__', currentImage).replace('__total__', this.aGroupImages.length);
    },

    showCounter: function(){
        if(this.oImageCounter.style.display == 'block'){
            this.oImageCounter.style.visibility = 'visible';
        }
    },

    getRatioIndex: function(iImageWidth, iImageHeight){
        var ratio = 1;
        if(iImageWidth > this._iWndWidth - this.iImageWidthAddon - 30 || iImageHeight > this._iWndHeight - this.iImageHeightAddon - 30){
            var ratioX = (this._iWndWidth - this.iImageWidthAddon - 30) / iImageWidth;
            var ratioY = (this._iWndHeight - this.iImageHeightAddon - 30) / iImageHeight;
            ratio = Math.min(ratioX, ratioY);
        }
        return ratio;
    },

    getRatio: function(imageWidth, imageHeight, bCorrectRation){
        if(typeof(bCorrectRation) == 'undefined'){
            bCorrectRation = true;
        }

        var ratio = this.getRatioIndex(imageWidth, imageHeight);
        if(!bCorrectRation){
            return ratio;
        }

        for(var i = 0; i < 10 /*max iterations*/; i++){
            var addon = 0;
            this.iImageHeightAddon = this.iImageHeightAddonOriginal;
            if(this.oGroup.style.display == 'block'){
                addon += this.getBlockHeight(this.oGroup, Math.floor(imageWidth * ratio));
            }
            if(this.oHeader.style.display == 'block'){
                addon += this.getBlockHeight(this.oHeader, Math.floor(imageWidth * ratio));
            }
            if(this.oImageZoom.style.display == 'block'){
                addon += this.getBlockHeight(this.oImageZoom, Math.floor(imageWidth * ratio));
            }
            if(this.oDescription.style.display == 'block'){
                addon += this.getBlockHeight(this.oDescription, Math.floor(imageWidth * ratio));
            }
            if(this.oURL.style.display == 'block'){
                addon += this.getBlockHeight(this.oURL, Math.floor(imageWidth * ratio));
            }
            if(this.oSlider.style.display == 'block'){
                addon += this.getBlockHeight(this.oSlider, Math.floor(imageWidth * ratio));
            }
            if(this.oImageCounter.style.display == 'block'){
                addon += this.getBlockHeight(this.oImageCounter, Math.floor(imageWidth * ratio));
            }
            if(addon == 0){
                break;
            }else{
                this.iImageHeightAddon += addon;
                newRatio = this.getRatioIndex(imageWidth, imageHeight);
                if(ratio == newRatio){
                    break;
                }else{
                    ratio = newRatio;
                }
            }
        }

        return ratio;
    },

    getBlockHeight: function(oBlock, width){
        var oClone = oBlock.cloneNode(true);
        oClone.style.position = 'static';
        oClone.style.display = 'block';
        oClone.style.visibility = 'visible';

        var oBlock = AMI.Browser.DOM.create('DIV', '', '', 'position: absolute; left: -10000px; top: -10000px; width: ' + (width + this.iImageWidthAddon) + 'px', document.body);
        oClone = oBlock.appendChild(oClone);
        var height = oBlock.offsetHeight;
        oBlock.parentNode.removeChild(oBlock);

        return height;
    },

    positionBox: function(width, height){
        var deltaX = this._iDocLeft;
        var deltaY = this._iDocTop;
        this.oMediaBox.style.width = width + 'px';
        this.oMediaBox.style.height = height + 'px';
        this.oMediaBox.style.left = Math.max(this._iDocLeft + 10, parseInt((this._iWndWidth - ( (width > 320) ? width : 320) ) / 2 + deltaX)) + 'px';
        this.oMediaBox.style.top = Math.max(this._iDocTop + 10, parseInt((this._iWndHeight - height) / 2 + deltaY)) + 'px';
        this.oMediaBox.style.display = 'block';
    },

    displayImage: function(){
        var iNumberOfAnimateIterations = 13;
        if(AMI.Browser.isIE || AMI.Browser.isIOS){
            var iNumberOfAnimateIterations = 3;
        }

        var ratio = this.getRatio(this.oImage.width, this.oImage.height);
        if(ratio < 1){
            this.setZoom(!this.bOpenEnlarged, [this.oImage.width, this.oImage.height], true);
            ratio = this.getRatio(this.oImage.width, this.oImage.height);
        }

        if(this.bOpenEnlarged && ratio < 1){
            this.iAnimateWidthTo = Math.min(this._iWndWidth - this.iImageWidthAddon, this.oImage.width + this.iImageWidthAddon + 16);
            this.iAnimateHeightTo = Math.min(this._iWndHeight - this.iImageHeightAddon, this.oImage.height + this.iImageHeightAddon + 16);
        }else{
            this.iAnimateWidthTo = Math.floor(this.oImage.width * ratio) + this.iImageWidthAddon;
            this.iAnimateHeightTo = Math.floor(this.oImage.height * ratio) + this.iImageHeightAddon;
        }

        if(ratio < 1){
            var iCalculatedWidth = Math.floor(this.oImage.width * ratio);
            var iCalculatedHeight = Math.floor(this.oImage.height * ratio);
            this.oImageZoom.onclick = function(_this, _iImageWidth, _iImageHeight, _iCalculatedWidth, _iCalculatedHeight){return function(){_this.resizeImage(_iImageWidth, _iImageHeight, _iCalculatedWidth, _iCalculatedHeight);return false;}}(this, this.oImage.width, this.oImage.height, iCalculatedWidth, iCalculatedHeight);
            if(this.bOpenEnlarged){
                this.oImage.setAttribute('bOriginalSize', '1');
                /*
                this.oImage.style.width = this.oImage.style.width + 'px';
                this.oImage.style.height = this.oImage.style.height + 'px';
                */
                this.oImageContainer.style.width = this.iAnimateWidthTo - this.iImageWidthAddon + 'px';
                this.oImageContainer.style.height = this.iAnimateHeightTo - this.iImageHeightAddon + 'px';
                this.oImageContainer.style.overflow = 'auto';
            }else{
                this.oImage.setAttribute('bOriginalSize', '0');
                this.oImageContainer.style.overflow = 'hidden';
                this.oImageContainer.style.width = this.oImage.style.width = iCalculatedWidth + 'px';
                this.oImageContainer.style.height = this.oImage.style.height = iCalculatedHeight + 'px';
            }
        }else{
            this.oImageContainer.style.width = this.oImage.width + 'px';
            this.oImageContainer.style.height = this.oImage.height + 'px';
        }

        this.iAnimateStepX = Math.ceil((this.iAnimateWidthTo - parseInt(this.oMediaBox.style.width)) / iNumberOfAnimateIterations),
        this.iAnimateStepY = Math.ceil((this.iAnimateHeightTo - parseInt(this.oMediaBox.style.height)) / iNumberOfAnimateIterations),
        this.iAnimateStepTime = this.iImageAnimateTime / iNumberOfAnimateIterations;

        this.oLoader.style.display = 'none';
        this.oImageContainer.style.display = 'none';

        if(this.iAnimateStepX == 0 || this.iAnimateStepY == 0 || this.iAnimateStepTime == 0){
            this.positionBox(this.iAnimateWidthTo, this.iAnimateHeightTo);

            this.showGroup();
            this.showHeader();
            this.showZoom();
            this.showDescription();
            this.showURL();
            this.showSlider();
            this.showCounter();
            this.updatePrevNext();

            this.oImageContainer.innerHTML = '';
            this.oImageContainer.style.display = 'block';
            this.oImageContainer.appendChild(this.oImage);
            AMI.Browser.setOpacity(this.oImage, 0);
            this.iFadeInStep = 0;
            this.fadeIn();
        }else{
            this._iTimeAnimateStop = (new Date()).getTime() + this.iImageAnimateTime;
            this.animatePosition();
        }
    },

    animatePosition: function(){
        var bFinalStep = (new Date()).getTime() > this._iTimeAnimateStop;
        if(!bFinalStep){
            var width = parseInt(this.oMediaBox.style.width) + this.iAnimateStepX;
            var height = parseInt(this.oMediaBox.style.height) + this.iAnimateStepY;
            if(width >= this.iAnimateWidthTo || height >= this.iAnimateHeightTo){
                width = this.iAnimateWidthTo;
                height = this.iAnimateHeightTo;
                bFinalStep = true;
            }else{
                bFinalStep = false;
                this.positionBox(width, height);
            }
        }
        if(bFinalStep){
            this.positionBox(this.iAnimateWidthTo, this.iAnimateHeightTo);

            this.showGroup();
            this.showHeader();
            this.showZoom();
            this.showDescription();
            this.showURL();
            this.showSlider();
            this.showCounter();
            this.updatePrevNext();

            this.oImageContainer.innerHTML = '';
            this.oImageContainer.style.display = 'block';
            this.oImageContainer.appendChild(this.oImage);
            AMI.Browser.setOpacity(this.oImage, 0);
            this.iFadeInStep = 0;
            this.fadeIn();
        }else{
            var self = this;
            this.hAnimateTimeout = setTimeout(function(){self.animatePosition()}, this.iAnimateStepTime);
        }
    },

    fadeIn: function(){
        if(AMI.Browser.isIE || AMI.Browser.isIOS){
            this.iFadeInStep += 3;
        }else{
            this.iFadeInStep ++;
        }
        AMI.Browser.setOpacity(this.oImage, this.iFadeInStep / 10);
        if(this.iFadeInStep < 10){
            var self = this;
            this.hAnimateTimeout = setTimeout(function(){self.fadeIn()}, 12);
        }else{
            AMI.Browser.setOpacity(this.oImage, 1);
            this.isOpening = true;
        }
    },

    startShadowAnimation: function(iStartOpacity){
        this.iFadeAnimationStep = 0;
        AMI.Browser.setOpacity(this.oMediaShadow, iStartOpacity);
    },


    fadeInShadow: function(){
        AMI.Browser.setOpacity(this.oMediaShadow, ++this.iFadeAnimationStep / 10);
        if(this.iFadeAnimationStep < (AMI.Browser.isIE || AMI.Browser.isIOS ? 2 : 3)){
            var self = this;
            this.hAnimateTimeout = setTimeout(function(){self.fadeInShadow()}, 24);
        }
    },

    fadeOutShadow: function(){
        AMI.Browser.setOpacity(this.oMediaShadow, (3 - ++this.iFadeAnimationStep) / 10);
        if(this.iFadeAnimationStep < (AMI.Browser.isIE || AMI.Browser.isIOS ? 2 : 3)){
            var self = this;
            this.hAnimateTimeout = setTimeout(function(){self.fadeOutShadow()}, 24);
        }else{
            this.oMediaShadow.style.display = 'none';
            this.isOpening = false;
            this.isClosing = false;
        }
    },

    resizeImage :function(iImageWidth, iImageHeight, iCalculatedWidth, iCalculatedHeight){
        var bOriginalSize = this.oImage.getAttribute('bOriginalSize') == 1 ? 0 : 1;
        this.oImage.setAttribute('bOriginalSize', bOriginalSize);
        if(bOriginalSize == 0){
            this.oImage.style.width = iCalculatedWidth + 'px';
            this.oImage.style.height = iCalculatedHeight + 'px';

            var iWndWidth = Math.min(this._iWndWidth - this.iImageWidthAddon, iCalculatedWidth + this.iImageWidthAddon);
            var iWndHeight = Math.min(this._iWndHeight - this.iImageHeightAddonOriginal, iCalculatedHeight + this.iImageHeightAddon);
            this.positionBox(iWndWidth, iWndHeight);

            this.oImageContainer.style.width = iWndWidth - this.iImageWidthAddon + 'px';
            this.oImageContainer.style.height = iWndHeight - this.iImageHeightAddon + 'px';
            this.oImageContainer.style.overflow = 'hidden';

            this.setZoomText(true, [iImageWidth, iImageHeight]);
        }else{
            this.oImage.style.width = iImageWidth + 'px';
            this.oImage.style.height = iImageHeight + 'px';

            var iWndWidth = Math.min(this._iWndWidth - this.iImageWidthAddon, iImageWidth + this.iImageWidthAddon + 16);
            var iWndHeight = Math.min(this._iWndHeight - this.iImageHeightAddonOriginal, iImageHeight + this.iImageHeightAddon + 16);
            this.positionBox(iWndWidth, iWndHeight);

            this.oImageContainer.style.width = iWndWidth - this.iImageWidthAddon + 'px';
            this.oImageContainer.style.height = iWndHeight - this.iImageHeightAddon + 'px';
            this.oImageContainer.style.overflow = 'auto';

            this.setZoomText(false, [iImageWidth, iImageHeight]);
        }
    }
}

AMI.UI.MediaBox.addSkin('MediaBoxBlack', ['swf'], 0, 0);
