AMI.Browser = {
    isIE: document.swapNode,
    isWebKit: /WebKit/.test(navigator.userAgent),
    isOpera: window.opera,
    isIOS: navigator.appVersion.indexOf('iPad;') >= 0 || navigator.appVersion.indexOf('iPhone;') >= 0 || navigator.appVersion.indexOf('iPod;') >= 0,
    isSensor: this.isIOS || navigator.appVersion.indexOf('Android') >= 0 || navigator.appVersion.indexOf('Symbian') >= 0 || navigator.appVersion.indexOf('Windows CE') >= 0,
    isLowResolution: screen.width <= 800 || screen.height <= 480,

    getWindowWidth : function(oWindow){
        if(typeof(oWindow) == 'undefined'){
            oWindow = window;
        }
        return oWindow.document.compatMode == 'CSS1Compat' ? oWindow.document.documentElement.clientWidth : oWindow.document.body.clientWidth;
    },

    getWindowHeight : function(oWindow){
        if(typeof(oWindow) == 'undefined'){
            oWindow = window;
        }
        return oWindow.document.compatMode == 'CSS1Compat' ? oWindow.document.documentElement.clientHeight : oWindow.document.body.clientHeight;
    },

    getDocumentWidth : function(oWindow){
        if(typeof(oWindow) == 'undefined'){
            oWindow = window;
        }
        return Math.max(oWindow.document.compatMode != 'CSS1Compat' ? oWindow.document.body.scrollWidth : oWindow.document.documentElement.scrollWidth, this.getWindowWidth(oWindow));
    },

    getDocumentHeight : function(oWindow){
        if(typeof(oWindow) == 'undefined'){
            oWindow = window;
        }
        return Math.max(oWindow.document.compatMode != 'CSS1Compat' ? oWindow.document.body.scrollHeight : oWindow.document.documentElement.scrollHeight, this.getWindowHeight(oWindow));
    },

    getDocumentLeft: function(oWindow){
        if(typeof(oWindow) == 'undefined'){
            oWindow = window;
            var oDocument = document;
        }else{
            oDocument = oWindow.document;
        }
        return oWindow.pageXOffset || (oDocument.documentElement && oDocument.documentElement.scrollLeft) || (oDocument.body && oDocument.body.scrollLeft);
    },

    getDocumentTop: function(oWindow){
        if(typeof(oWindow) == 'undefined'){
            oWindow = window;
            var oDocument = document;
        }else{
            oDocument = oWindow.document;
        }
        return oWindow.pageYOffset || (oDocument.documentElement && oDocument.documentElement.scrollTop) || (oDocument.body && oDocument.body.scrollTop);
    },

    setDocumentLeft: function(value){
        if(document.documentElement){
            document.documentElement.scrollLeft = value;
        }else if(document.body){
            document.body.scrollLeft = value;
        }
    },

    setDocumentTop: function(value){
        if(document.documentElement){
            document.documentElement.scrollTop = value;
        }else if(document.body){
            document.body.scrollTop = value;
        }
    },

    getPointerPosition : function(oEvent){
        var aData = [0, 0];
        oEvent = AMI.Browser.Event.validate(oEvent);
        if(oEvent.pageX || oEvent.pageY){
            aData[0] = oEvent.pageX;
            aData[1] = oEvent.pageY;
        }else if(oEvent.clientX || oEvent.clientY){
            aData[0] = oEvent.clientX + (document.documentElement.scrollLeft || document.body.scrollLeft) - document.documentElement.clientLeft;
            aData[1] = oEvent.clientY + (document.documentElement.scrollTop || document.body.scrollTop) - document.documentElement.clientTop;
        }
        return aData;
    },

    getObjectPosition : function(oObject, bStopOnRelative){
        if(typeof(bStopOnRelative) == 'undefined'){
            bStopOnRelative = false;
        }
        var aData = [0, 0];
        if(!oObject) return aData;
        do{
            if(bStopOnRelative){
                var positionStyle = AMI.Browser.DOM.getStyle(oObject, 'position');
                if(positionStyle == 'relative' || positionStyle == 'absolute' || positionStyle == 'fixed'){
                    break;
                }
            }
            aData[0] += oObject.offsetLeft;
            aData[1] += oObject.offsetTop;
        }while((oObject = oObject.offsetParent) != null);
        return aData;
    },

    getCaretPosition : function(textObject){
        var result = 0;
        textObject.focus();
        if(textObject.selectionStart){
            result = textObject.selectionStart;
        }else if(document.selection){
            var rangeSelect = document.selection.createRange();
            rangeSelect.collapse(true);
            var rangeObject = textObject.createTextRange();
            if((typeof(rangeObject.inRange) != 'undefined') && rangeObject.inRange(rangeSelect)){
                rangeObject.setEndPoint('EndToEnd', rangeSelect);
                result = rangeObject.text.length
            }

        }
        return result;
    },

    setCaretPosition : function(textObject, position){
        textObject.focus();
        if(textObject.selectionStart){
            textObject.selectionStart = position;
            textObject.selectionEnd = position;
        }else if(document.selection){
            var rangeObject = textObject.createTextRange();
            rangeObject.move('character', position);
            rangeObject.select();
        }
    },

    setOpacity: function(oElement, iOpacity){
        if(typeof(oElement.style.MozOpacity) != "undefined"){
            oElement.style.MozOpacity = iOpacity;
        }else if(typeof(oElement.style.opacity) != "undefined"){
            oElement.style.opacity = iOpacity;
        }else if(typeof(oElement.style.KhtmlOpacity) != "undefined"){
            oElement.style.KhtmlOpacity = iOpacity;
        }else{
            oElement.style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=" + (iOpacity * 100) + ");";
        }
    }
}