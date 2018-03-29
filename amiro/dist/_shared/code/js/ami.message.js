AMI.Message = {
    oListeners: {},

    addListener: function(sMessage, oCallback, isImportant){
        if(typeof(this.oListeners[sMessage]) == 'undefined'){
            this.oListeners[sMessage] = [];
        }
        if(typeof(isImportant) != 'undefined'){
            this.oListeners[sMessage].unshift(oCallback); // Place callback to the start
        }else{
            this.oListeners[sMessage].push(oCallback); // Place callback to the end
        }
    },

    removeListener: function(sMessage, oCallback){
        if(typeof(sMessage) == 'undefined'){
            this.oListeners = {};
        }else if(typeof(oCallback) == 'undefined'){
            if(typeof(this.oListeners[sMessage]) != 'undefined'){
                this.oListeners[sMessage] = [];
            }
        }else{
            if(typeof(this.oListeners[sMessage]) != 'undefined'){
                var iListenersNumber = this.oListeners[sMessage].length;
                for(var i = 0; i < iListenersNumber; i++){
                    if(this.oListeners[sMessage][i] == oCallback){
                        this.oListeners[sMessage][i] = null;
                    }
                }
            }
        }
    },

    hasListeners: function(sMessage){
        return (typeof(this.oListeners[sMessage]) != 'undefined') && this.oListeners[sMessage].length;
    },

    send: function(sMessage, param1, param2){
        var bResult = true;
        if(typeof(this.oListeners[sMessage]) != 'undefined'){
            /*
            param1 = typeof(param1) == 'undefined' ? null : param1;
            param2 = typeof(param2) == 'undefined' ? null : param2;
            */
            if(typeof(param1) == 'undefined'){
                param1 = null;
            }
            if(typeof(param2) == 'undefined'){
                param2 = null;
            }
            for(var i in this.oListeners[sMessage]){
                if(typeof(this.oListeners[sMessage][i]) == 'function'){
                    bResult = this.oListeners[sMessage][i](param1, param2);
                    if(!bResult){
                        break;
                    }
                }
            }
        }

        return bResult;
    }
}
