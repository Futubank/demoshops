AMI.Browser.Event = {

    globalEvent: null,

    validate: function(oEvent){
        return oEvent ? oEvent : window.event;
    },

    getTarget: function(oEvent){
        oEvent = this.validate(oEvent);
        if(oEvent && typeof(oEvent.srcElement) == 'unknown') return null; // IE hack
        return (oEvent) ? (oEvent.srcElement || oEvent.target) : null;
    },

    fire: function(oTarget, sEvent){
        if(document.createEventObject){
            var oEvent = document.createEventObject();
            oTarget.fireEvent('on' + sEvent, oEvent);
        }else if(document.createEvent){
            var oEvent = document.createEvent("HTMLEvents");
            oEvent.initEvent(sEvent, true, true);
            oTarget.dispatchEvent(oEvent);
        }else{
            return false;
        }
        return true;
    },

    addHandler: function(oTarget, sEvent, oHandler){
        if(typeof(oTarget.addEventListener) != 'undefined'){
            if(sEvent == 'mousewheel'){
                // Mozilla hack
                oTarget.addEventListener('DOMMouseScroll', oHandler, false);
            }
            oTarget.addEventListener(sEvent, oHandler, false);
        }else{
            oTarget.attachEvent('on' + sEvent, oHandler);
        }
        return oHandler;
    },

    removeHandler: function(oTarget, sEvent, oHandler){
        if(typeof(oTarget.removeEventListener) != 'undefined'){
            if(sEvent == 'mousewheel'){
                sEvent = 'DOMMouseScroll';
            }
            oTarget.removeEventListener(sEvent, oHandler, false);
        }else if(oTarget.detachEvent){
            oTarget.detachEvent('on' + sEvent, oHandler);
        }
    },

    stopProcessing: function(oEvent){
        oEvent = this.validate(oEvent);
        if(typeof(oEvent.stopPropagation) != 'undefined'){
            oEvent.stopPropagation();
        }else if(typeof(oEvent.cancelBubble) != 'undefined'){
            oEvent.cancelBubble = true;
        }
        if(typeof(oEvent.preventDefault) != 'undefined'){
            oEvent.preventDefault();
        }else{
            oEvent.returnValue = false;
        }
    }
}

AMI.Browser.Event.addHandler(window,'load', function(){
    AMI.Browser.Event.addHandler(document.body,'mousedown', function(e){
        AMI.Browser.Event.globalEvent = (e) ? e :((window.event) ? window.event : null);
    });
});