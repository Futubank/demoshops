function doRatingRequest(item_id, user_id, rating){
    var aData = {
        service   : 'rate_user',
        module_id : active_module,
        id        : item_id,
        user_id   : user_id,
        rating    : rating,
        locale    : AMI_SessionData.locale
    };
    AMI.HTTPRequest.getContent('GET', frontBaseHref + 'ami_service.php', aData, function(status, content){
        if(content.substr(0, 1) == '{' && content.substr(content.length - 1, 1) == '}'){
            var oData = AMI.String.decodeJSON(content);
            if(typeof(oData) == 'object'){
                oData = oData.data;
                refreshRatingDivs(oData);
                alert(oData.status_msg, (oData.status == 1) ? 'status_notice' : 'status_error');
            }
        }
    });
}

function refreshRatingDivs(oData){
    var aDivs = AMI.find('.amiUserRatingValue');
    if(aDivs && aDivs.length){
        for(var i=0; i<aDivs.length; i++){
            var userId = aDivs[i].getAttribute('data-ami-user');
            if(userId == oData.user_id){
                aDivs[i].innerHTML = oData.user_rating_html;
                AMI.Message.send('AMI_USER_RATING_NEW_VALUE_ARRIVED', aDivs[i], oData);
            }
        }
    }
    var aDivs = AMI.find('.amiItemRatingValue');
    if(aDivs && aDivs.length){
        for(var i=0; i<aDivs.length; i++){
            var itemId = aDivs[i].getAttribute('data-ami-item');
            if(itemId == oData.item_id){
                aDivs[i].innerHTML = oData.item_rating_html;
            }
        }
    }
}

function changeUserRating(e, value){
    var oTarget = AMI.Browser.Event.getTarget(e);
    var item_id = oTarget.getAttribute('data-ami-item');
    var user_id = oTarget.getAttribute('data-ami-user');
    doRatingRequest(item_id, user_id, value);
}

function decreaseUserRating(e){
    changeUserRating(e, -1);
}

function increaseUserRating(e){
    changeUserRating(e, 1);
}

function addUserRatingHandlers(className, callback){
    var myId = amiSession.get('id_cookie');
    var myRating = amiSession.get('rating');
    var aButtons = AMI.find('.' + className);
    if(aButtons && aButtons.length){
        for(var i=0; i<aButtons.length; i++){
            var userId = aButtons[i].getAttribute('data-ami-user');
            if(myId == userId){
                if(typeof(amiUserRatingVoteForYourself) != 'undefined'){
                    AMI.Browser.Event.addHandler(aButtons[i], 'click', function(){ alert(amiUserRatingVoteForYourself, 'status_error'); });
                }
            }else if(!myId){
                if(typeof(amiUserRatingVoteGuest) != 'undefined'){
                    AMI.Browser.Event.addHandler(aButtons[i], 'click', function(){ alert(amiUserRatingVoteGuest, 'status_error'); });
                }
            }else if(myRating < 0){
                if(typeof(amiUserRatingVoteNegative) != 'undefined'){
                    AMI.Browser.Event.addHandler(aButtons[i], 'click', function(){ alert(amiUserRatingVoteNegative, 'status_error'); });
                }
            }else{
                AMI.Browser.Event.addHandler(aButtons[i], 'click', callback);
            }
        }
    }
}

addOnLoadEvent(function(){
    addUserRatingHandlers('amiUserRatingDec', decreaseUserRating);
    addUserRatingHandlers('amiUserRatingInc', increaseUserRating);
});

