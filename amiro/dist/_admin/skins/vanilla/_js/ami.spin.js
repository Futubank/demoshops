var amiSpin = {
    
    mousewheelevt : (/Firefox/i.test(navigator.userAgent))? "DOMMouseScroll" : "mousewheel",

    addFields : function(aTargets, min, max, step, postfix, oCallback){
        for(var i = 0; i < aTargets.length; i++){
            amiCommon.setEventHandler(this.mousewheelevt, aTargets[i],  function(_min, _max, _step, _postfix, _oCallback){ return function(oEvt){ amiSpin.spin(oEvt, _min, _max, _step, _postfix, _oCallback); } }(min, max, step, postfix, oCallback));
            amiCommon.setEventHandler('keydown', aTargets[i],  function(_min, _max, _step, _postfix, _oCallback){ return function(oEvt){ return amiSpin.spin(oEvt, _min, _max, _step, _postfix, _oCallback); } }(min, max, step, postfix, oCallback));
            amiCommon.setEventHandler('focus', aTargets[i],  function(oObject){ return function(oEvt){  oObject.className = 'spin-control-active'; oObject.select(); oObject.hasFocus = true;} }(aTargets[i]));
            amiCommon.setEventHandler('blur', aTargets[i],  function(oObject){ return function(oEvt){ oObject.className = 'spin-control'; oObject.hasFocus = false;} }(aTargets[i]));
        }
    },
    
    spin : function(evt, numMax, numMin, iStep, sPostfixDef, oCallback){

        if(typeof(iStep) == 'undefined'){
            var iStep = 1;
        }

        if(typeof(numMax) == 'undefined'){
            var numMax = 100000;
        }

        if(typeof(numMin) == 'undefined'){
            var numMin = -100000;
        }
        
        if(typeof(oCallback) == 'undefined'){
            oCallback = null;
        }
        
        evt = top.amiCommon.getValidEvent(evt);
        var target = top.amiCommon.getEventTarget(evt);

        // Mozilla workaround
        if(typeof(evt.which) != 'undefined'){
            evt.keyCode = evt.which;
        }

        if(evt.keyCode > 57){
            amiCommon.stopEvent(evt);
            return true;
        }

        if(target.value != '' && isNaN(parseInt(target.value))){
            amiCommon.stopEvent(evt);
            return true;
        }

        var iVal = target.value == '' ? 0 : parseInt(target.value);
        var sPostfix = target.value.substr((iVal+'').length);
        sPostfix = ((sPostfix == '') && (typeof(sPostfixDef) != 'undefined')) ? sPostfixDef : sPostfix;

        var bStopEvent = false;
        
        if(target.hasFocus){
            if (evt.wheelDelta){
                var wheelDelta = Math.round(evt.wheelDelta/120);
            }else if (evt.detail){
                var wheelDelta = Math.round(-evt.detail/3);
            }

            var newValue = iVal + wheelDelta * iStep;
            if(typeof(wheelDelta) != "undefined" && newValue >= numMin && newValue <= numMax){
                target.value = newValue + sPostfix;
                target.select();
                bStopEvent = true;
            }
        }

        if(evt.keyCode == 38 && iVal < numMax){
            target.value = iVal + iStep + sPostfix;
            target.select();
            bStopEvent = true;
        }
        
        if(evt.keyCode == 40 && iVal > numMin){
            target.value = iVal - iStep + sPostfix;
            target.select();
            bStopEvent = true;
        }

        if(evt.keyCode == 33){
            if(iVal < numMax - 10){
                target.value = iVal + 10 * iStep + sPostfix;
                target.select();
            }else{
                target.value = numMax;
                target.select();
            }
            bStopEvent = true;
        }
        
        if(evt.keyCode == 34){
            if (iVal > numMin + 10){
                target.value = iVal - 10 * iStep + sPostfix;
                target.select();
            }else{
                target.value = numMin + sPostfix;
                target.select();
            }
            bStopEvent = true;
        }

        if(oCallback != null){
            oCallback();
        }
        
        if(bStopEvent){
            amiCommon.stopEvent(evt);
        }
    }
}