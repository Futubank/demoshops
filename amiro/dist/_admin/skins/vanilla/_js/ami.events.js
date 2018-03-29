var oEvents = {
    stopEvent : function(currentEvent){
        currentEvent = currentEvent ? currentEvent : window.event;
        if(typeof(currentEvent.stopPropagation) != 'undefined'){
            currentEvent.stopPropagation();
        }else if(typeof(currentEvent.cancelBubble) != 'undefined'){
            currentEvent.cancelBubble = true;
        }
        if(typeof(currentEvent.preventDefault) != 'undefined'){
            currentEvent.preventDefault();
        }else{
            currentEvent.returnValue = false;
        }
    }
}
