AMI.UI.Alert = {

    states: ['status_normal', 'status_notice', 'status_error'],
    defaultState: 'status_notice',
    modalStates: ['status_error'],
    alertWindow: null,
    isModal: false,
    alertDivId: 'status_message',
    alertPopupId: 'status_message_popup',

    hide: function(popup){
        return function(){
            popup.close();
        }
    },

    show: function(message, type){
        var obj = AMI.find('#' + this.alertDivId);
        if (!obj){
            if(type == undefined){
                type = this.defaultState;
            }
            obj = AMI.Browser.DOM.create('DIV', this.alertDivId, type, '', document.body);
            obj.innerHTML = message;
        }else{
            if(type == undefined){
                type = this._checkType(obj);
            }
        }
        this.isModal = this._checkModal(type);
        obj.className = type;

        if(this.alertWindow){
            if(this.alertWindow.killTimer){
                clearTimeout(this.alertWindow.killTimer);
            }
            if(this.alertWindow.bodyClickHandler){
                AMI.Browser.Event.removeHandler(window.document.body, 'click', this.alertWindow.bodyClickHandler);
            }
            if(obj.innerHTML != message){
                obj.innerHTML = obj.innerHTML + '<br />' + message;
                this.alertWindow.setHTML(obj.innerHTML);
                this.alertWindow.autosize();
            }
        }else{
            this.alertWindow = new AMI.UI.Popup(AMI.find('#' + AMI.UI.Alert.alertDivId).innerHTML, {
                id: this.alertPopupId,
                width: 350,
                height: 16,
                modal: this.isModal,
                movable: true,
                dragBy: 'body',
                className: 'AlertWindow ' + type,
                animation: {open: 'fadein', close: 'fadeout'},
                autosize: false,
                onShow: function(popup){
                    popup.setHTML(AMI.find('#' + AMI.UI.Alert.alertDivId).innerHTML);
                    if(!AMI.UI.Alert.isModal){
                        if(popup.killTimer){
                            clearTimeout(popup.killTimer);
                        }
                        popup.killTimer = setTimeout(AMI.UI.Alert.hide(popup), 4000);
                        popup.bodyClickHandler = AMI.UI.Alert.hide(popup);
                        AMI.Browser.Event.addHandler(window.document.body, 'click', popup.bodyClickHandler);
                        AMI.Browser.Event.addHandler(popup.object, 'mouseout', function(popupWnd){
                            return function(){
                                if(!popupWnd.killTimer){
                                    popupWnd.killTimer = setTimeout(AMI.UI.Alert.hide(popup), 4000);
                                }
                            }
                        }(popup));
                        AMI.Browser.Event.addHandler(popup.object, 'mouseover', function(popupWnd){
                            return function(){
                                if(popupWnd.killTimer){
                                    clearTimeout(popupWnd.killTimer);
                                    popupWnd.killTimer = null;
                                }
                            }
                        }(popup));
                    }
                },
                onClose: function(popup){
                    AMI.UI.Alert.alertWindow = null;
                    if(popup.killTimer){
                        clearTimeout(popup.killTimer);
                    }
                    if(popup.bodyClickHandler){
                        AMI.Browser.Event.removeHandler(window.document.body, 'click', popup.bodyClickHandler);
                    }
                    var obj = AMI.find('#' + AMI.UI.Alert.alertDivId);
                    if(obj && obj.parentNode){
                        obj.parentNode.removeChild(obj);
                    }
                }
            });
        }
    },

    _checkType: function(obj){
        for(var i=0; i < this.states.length; i++){
            if(AMI.hasClass(obj, this.states[i])){
                return this.states[i];
            }
        }
        return this.defaultState;
    },
    
    _checkModal: function(type){
        return (this.modalStates.indexOf(type) >= 0);
    }
}

