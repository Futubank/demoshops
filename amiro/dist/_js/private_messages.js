document.write('<span id="my_messages" style="display:none;"></span>');

amiMessages = {
	messagesDivName: 'my_messages',
	messagesCookieName: 'amiMessages',
	checkMessagesIntervalId: 0,
	sessionCookieLang: window.sessionCookieName.replace('session_', ''),
	dataLang: ((window.AMI_SessionData['locale'] != 'undefined' && window.AMI_SessionData['locale'] != '') ? window.AMI_SessionData['locale'] : ''),
    displayMessages: function(content){
		if(content == -1){
			// Server error
			return;
		}else if(content == -2){
			// User not logged in
			return;
		}else{
			if(isNaN(content)){
				// Server error
				return;
			}
			if(parseInt(content) == 0){
				//0 messages
				content = '';
				document.getElementById('my_messages').style.display = 'none';
			}else{
				var multiLang = '';
				if(amiMessages.sessionCookieLang.length > 0){
					multiLang = '&multi_lang=1';
				}
				if(content > 99){
					content = '99+';
				}
				content = '<a href="' + frontBaseHref + 'ami_service.php?service=private_messages&action=view_messages&lang_data=' + amiMessages.dataLang + multiLang + '">' + content + '</a>';
				document.getElementById('my_messages').style.display = 'inline-block';
			}
		}
		AMI.Browser.DOM.setInnerHTML(AMI.find('#' + amiMessages.messagesDivName), content);
	},

	setMessages: function(status, content){
		if(status == 1){
			var cookieTime = 10;
			if(parseInt(content) > 0){
				cookieTime = 60;
			}
			setCookie(amiMessages.messagesCookieName, content, '/', 0, 0, false, cookieTime);
			amiMessages.displayMessages(content);
		}
	},

	getMessages: function(){
		var val = getCookie(amiMessages.messagesCookieName);

		if(val != null){
			amiMessages.displayMessages(val);
		}else{
			setCookie(amiMessages.messagesCookieName, -1, '/', 0, 0, false, 10);
			AMI.HTTPRequest.getContent('GET', frontBaseHref + 'ami_service.php', 'service=private_messages&action=get_count&scname=' + window.sessionCookieName, amiMessages.setMessages);
		}
	},

	checkMessagesCookie: function(){
		if(getCookie('is_logged_in') != '1'){
			clearInterval(amiMessages.checkMessagesIntervalId);
			return;
		}

		var val = getCookie(amiMessages.messagesCookieName);

		if(val == -1){
			setTimeout("amiMessages.getMessages()", 60000);
		}else if(val != null){
			amiMessages.displayMessages(val);
		}else{
			amiMessages.getMessages();
		}
	}
}

if(getCookie('is_logged_in') == '1'){
	amiMessages.checkMessagesCookie();
	amiMessages.checkMessagesIntervalId = setInterval("amiMessages.checkMessagesCookie()", 30000);
}
