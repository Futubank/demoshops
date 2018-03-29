AMI.UI = {

     /**
     * Property to save old alert
     */
    _savedAlert: null,

     /**
     * Alert window container
     */
    oAlertWindow: null,

     /**
     * Alert window timer
     */
    alertWindowTimer: null,

    /**
     * Is alert visible?
     */
    alertVisible: false,

    /**
     * Is body onclick handler attached?
     */
    bodyClickHandler: false,

     /**
     * Overload default alert() function with a custom div
     *
     * @param {bool} bState true if overload
     * @returns {void}
     */
    overloadAlert: function(bState){
        window.onloadAlerted = false;
        if(bState){
            this._savedAlert = window.alert;
            window.alert = function(message, type){
                if((window.pageLoaded == undefined) || !window.pageLoaded) return;
                window.onloadAlerted = true;
                if(!message || (message == '')){
                    return false;
                }
                AMI.UI.Alert.show(message, type);
            }
        }else{
            if(typeof(this._savedAlert) == 'function'){
                alert = this._savedAlert;
            }
        }
    },

    center: function(div){
        AMI.UI.centerH(div);
        AMI.UI.centerW(div);
    },

    centerH: function(div){
        var divHeight = div.offsetHeight;
        var scrHeight = AMI.Browser.getWindowHeight();
        div.style.top = parseInt((scrHeight - divHeight) / 2) + 'px';
    },

    centerW: function(div){
        var divWidth = div.offsetWidth;
        var scrWidth = AMI.Browser.getWindowWidth();
        div.style.left = parseInt((scrWidth - divWidth) / 2) + 'px';
    }
}
