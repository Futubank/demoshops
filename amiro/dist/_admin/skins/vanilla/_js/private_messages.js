document.write('<span class="private-messages" onclick="location.href = \'engine.php?mod_id=private_messages\'" ></span>');

amiMessages = {
    messagesDivName: 'private-messages',
    messagesCookieName: 'amiAdmMessages',
    checkMessagesIntervalId: 0,

    displayMessages: function(content){
        if(content == -1){
            // Server error
            return;
        }
        else{
            if(isNaN(content)){
                // Server error
                return;
            }
            if(interface_lang == 'ru') {
                countMessages = 'У вас '+ content +' непрочитанных сообщений';
                noMessages = 'У вас нет непрочитанных сообщений';
            } else {
                countMessages = 'You have '+ content +' unread message';
                noMessages = 'You have not unread message';
            }
            
            if((parseInt(content) == 0) || (content == '')) {
                AMI.$('.private-messages').attr('title', noMessages);
                if(AMI.$('.private-messages__letters-count').length != content) {
                    AMI.$('.private-messages').removeClass('private-messages__on');
                    AMI.$('.private-messages__letters-count').fadeOut();
                    setTimeout(function() {AMI.$('.private-messages__letters-count').remove()}, 500);
                }
            } else {
                if(AMI.$('.private-messages__letters-count').length == 0) {
                    AMI.$('.private-messages').addClass('private-messages__on');
                    AMI.$('.private-messages').attr('title', countMessages);
                    AMI.$('.private-messages').append('<span class="private-messages__letters-count"><span class="private-messages__letters-count-link">' + content + '</span></span>');
                    setTimeout(function() {AMI.$('.private-messages__letters-count').delay(1000).fadeIn().fadeOut().fadeIn().fadeIn().fadeOut().fadeIn()}, 2500);
                } else if(AMI.$('.private-messages__letters-count-link').text() != content) {
                    AMI.$('.private-messages__letters-count-link').animate({ top: '-10px' }, 200);
                    setTimeout(function() {AMI.$('.private-messages__letters-count-link').remove(); AMI.$('.private-messages__letters-count').html('<span class="private-messages__letters-count-link">' + content + '</span>'); AMI.$('.private-messages__letters-count-link').css('top', '10px').animate({ top: '-1px' }, 200); AMI.$('.private-messages__letters-count').fadeIn().fadeOut().fadeIn()}, 200);
                }
            }
        }
    },

    setMessages: function(status, content){
        if(status == 1){
            var cookieTime = 10;
            if(parseInt(content) > 0){
                cookieTime = 60;
            }
            set_cookie(amiMessages.messagesCookieName, content, '', 0, 0, cookieTime);
            amiMessages.displayMessages(content);
        }
    },

    getMessages: function(){
        var val = get_cookie(amiMessages.messagesCookieName);

        if(val != null){
            amiMessages.displayMessages(val);
        }else{
            set_cookie(amiMessages.messagesCookieName, -1, '', 0, 0, 10);
            AMI.HTTPRequest.getContent('GET', ajaxProcessURL, 'type=private_messages&action=get_count', amiMessages.setMessages);
        }
    },

    checkMessagesCookie: function(){
        var val = get_cookie(amiMessages.messagesCookieName);

        if(val == -1){
            setTimeout("amiMessages.getMessages()", 60000);
        }else if(val != null){
            amiMessages.displayMessages(val);
        }else{
            amiMessages.getMessages();
        }
    }
}

amiMessages.checkMessagesCookie();
amiMessages.checkMessagesIntervalId = setInterval("amiMessages.checkMessagesCookie()", 30000);

AMI.Message.addListener('ON_COMPONENT_GET_REQUEST_DATA', function(oComponent, oParameters){
    var moduleId = 'private_messages';
    if(oComponent.oModule.moduleId == moduleId){
        var hashData = AMI.Page.getHashData(moduleId);
        oParameters['mode'] = 'inbox';
        if(hashData.sent){
            oParameters['mode'] = 'sent';
        }
        if(hashData.deleted){
            oParameters['mode'] = 'deleted';
        }
        if((AMI.Page.aModules[moduleId] != undefined) && (AMI.Page.aModules[moduleId].mode != undefined)){
            oParameters['mode'] = AMI.Page.aModules[moduleId].mode;
        }
    }
    return true;
});