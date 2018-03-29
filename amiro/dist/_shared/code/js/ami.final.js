AMI.UI.MediaBox.PageImages = {
    aGroups: {},
    groupsNumber: 0,

    init: function(){
        AMI.Browser.Event.addHandler(window, 'load', function(){AMI.UI.MediaBox.PageImages.onLoadHandler()});
        AMI.Message.addListener('ON_AMI_MEDIABOX_GROUPS_NUMBER', function(oResponse){AMI.UI.MediaBox.PageImages.getGroupsNumber(oResponse)});
        AMI.Message.addListener('ON_AMI_MEDIABOX_GET_GROUP', function(oData, oResponse){AMI.UI.MediaBox.PageImages.getGroup(oData, oResponse)});
    },

    getImageLink: function(imageLink){
        if(!/^https?:\/\//.test(imageLink)){
            imageLink = frontBaseHref + imageLink;
        }
        return imageLink;
    },

    onLoadHandler: function(){
        var aImages = AMI.find('img');
        for(var i = 0; i < aImages.length; i++){
            var popupImage = aImages[i].getAttribute('data-ami-mbpopup');
            if(popupImage != null && popupImage != ''){
                popupImage = this.getImageLink(popupImage);
                aImages[i].setAttribute('data-ami-mbpopup', popupImage);

                /*
                AMI.Browser.Event.addHandler(aImages[i], 'mouseover', function(evt){AMI.Browser.Event.getTarget(evt).style.cursor = 'pointer'});
                AMI.Browser.Event.addHandler(aImages[i], 'mouseout', function(evt){AMI.Browser.Event.getTarget(evt).style.cursor = 'default'});
                */
                AMI.Browser.Event.addHandler(aImages[i], 'click', function(evt){AMI.UI.MediaBox.openFromObject(AMI.Browser.Event.getTarget(evt))});
            }

            var group = aImages[i].getAttribute('data-ami-mbgrp');
            if(group != null && group != '' && popupImage != null && popupImage != ''){
                if(typeof(this.aGroups[group]) == 'undefined'){
                    this.aGroups[group] = [];
                    this.groupsNumber ++;
                }
                this.aGroups[group].push(aImages[i]);
            }

            var overImage = aImages[i].getAttribute('data-ami-mbover');
            if(overImage != null && overImage != ''){
                overImage = this.getImageLink(overImage);
                aImages[i].setAttribute('data-ami-mbover', overImage);
                AMI.Browser.Event.addHandler(aImages[i], 'mouseover', function(evt){AMI.UI.OverImage.onOver(evt)});
                AMI.Browser.Event.addHandler(aImages[i], 'mouseout', function(evt){AMI.UI.OverImage.onOut(evt)});
                AMI.Browser.Event.addHandler(aImages[i], 'click', function(evt){AMI.UI.OverImage.stopWaiting(evt)});
            }
        }
    },

    getGroupsNumber: function(oResponse){
        oResponse.result = this.groupsNumber;
        return true;
    },

    getGroup: function(oData, oResponse){
        var groupName = oData.groupName;
        if(typeof(this.aGroups[groupName]) != 'undefined'){
            oResponse.aGroupImages = this.aGroups[groupName];
        }

        return true;
    }
}
AMI.UI.MediaBox.PageImages.init();

/* Stars Rating Like */

amiRatingLike = {
    checkLikeForm: function() {
        if(AMI.Browser.Cookie.get('moduleRatingsValue') != null && AMI.$('.rating__like-form').length != 0) {
            moduleName = AMI.$('[data-module-name]').eq(0).attr('data-module-name');
            for(i=0;i<AMI.$('[data-ami-rating-id]').length;i++) {
                for(j=0;j<AMI.Browser.Cookie.get('moduleRatingsValue').split('|').length;j++) {
                    if (AMI.Browser.Cookie.get('moduleRatingsValue').split('|')[j].indexOf(moduleName) >= 0) {
                        for(n=0;n<AMI.Browser.Cookie.get('moduleRatingsValue').split('|')[j].split(':')[1].split(';').length;n++) {
                            if(AMI.Browser.Cookie.get('moduleRatingsValue').split('|')[j].split(':')[1].split(';')[n].split(',')[0] == AMI.$('[data-ami-rating-id]').eq(i).attr('data-ami-rating-id')) {
                                AMI.$('[data-ami-rating-id] .rating-like__form-block').eq(i).attr('title', AMI.$('[data-ami-rating-id] .rating-like__form-block').eq(i).attr('data-already-like'));
                                AMI.$('[data-ami-rating-id] .rating-like__form-block').eq(i).removeClass('rating-like__form-block-on');
                                AMI.$('[data-ami-rating-id] .rating-like__form-block').eq(i).addClass('rating-like__form-block-off');
                                AMI.$('[data-ami-rating-id] .rating-like__form-block').eq(i).removeAttr('onclick');
                                if(AMI.Browser.Cookie.get('moduleRatingsValue').split('|')[j].split(':')[1].split(';')[n].split(',')[2] > AMI.$('[data-ami-rating-id]').eq(i).attr('data-rating-votes-count')) {
                                    AMI.$('[data-ami-rating-id] .rating-like__form-block__like-count').eq(i).text(AMI.Browser.Cookie.get('moduleRatingsValue').split('|')[j].split(':')[1].split(';')[n].split(',')[2]);
                                    AMI.$('[data-ami-rating-id] .rating-like__form-block__like-count').eq(i).removeAttr('style');
                                }
                            }
                        } 
                    }
                }
            }
		}
    },
    ajaxLikeSubmit: function(id, module_name) {
        AMI.$('#rating-like'+id).css('visibility', 'hidden');
        AMI.$('#rating-like'+id).after('<div class="like__ajax-loader"></div>');
        AMI.HTTPRequest.submitForm('POST', document.forms['rating'+id], {is_ajax: true}, function(status, data){
            if(data){
                var parts = data.split('|');
                var cookieString = parts[0];
                var cookieLifetime = parts[1];
                var ratingBlock = parts[2];
                var votesBlock = parts[3];
                var statusMsg = parts[4];
                var isError = parts[5];   
                
                if(AMI.$('#rating-like'+id+' .rating-like__form-popup').length == 0) {
                    AMI.$('#rating-like'+id).after('<div class="rating-like__form-popup" id="rating-like5__popup" style="display: none;"><div class="rating-like__form-popup__txt"></div><span class="rating-like__form-popup__arrow"></span></div>');
                }
                
                if(isError == '1') {
                    AMI.$('#rating-like'+id).removeClass('rating-like__form-block-on');
                    AMI.$('#rating-like'+id).addClass('rating-like__form-block-off');
                    AMI.$('#rating-like'+id).removeAttr('onclick');
                    AMI.$('#rating-like'+id).attr('title', AMI.$('#rating-like'+id).attr('data-already-like'));
                    AMI.$('#rating__like-form'+id).find('.rating-like__form-popup__txt').text(AMI.$('#rating-like'+id).attr('data-already-like'));
                } else {
                    AMI.$('#votes_block'+id).replaceWith(votesBlock);
                    AMI.$('#rating-like__count'+id).text(AMI.$('#votes_block'+id).text());
                    AMI.$('#rating-like__count'+id).removeAttr('style');
                    AMI.$('#rating-like'+id).attr('title', AMI.$('#rating-like'+id).attr('data-already-like'));
                    AMI.$('#rating-like'+id).removeClass('rating-like__form-block-on');
                    AMI.$('#rating-like'+id).addClass('rating-like__form-block-off');
                    AMI.$('#rating-like'+id).removeAttr('onclick');
                    AMI.$('#rating__like-form'+id).find('.rating-like__form-popup__txt').text(AMI.$('#rating-like'+id).attr('data-like-thanks'));
                }

                AMI.$('#rating__like-form'+id+' .rating-like__form-popup').css('top', -AMI.$('#rating__like-form'+id+' .rating-like__form-popup').height()-10+'px');
                AMI.$('#rating-like'+id).css('visibility', 'visible');
                AMI.$('#rating__like-form'+id).find('.rating-like__form-popup').fadeIn();
                setTimeout(function() {AMI.$('#rating__like-form'+id).find('.rating-like__form-popup').fadeOut()}, 2000); 
                AMI.$('#rating__like-form'+id).find('.like__ajax-loader').fadeOut();
                
                if(AMI.Browser.Cookie.get('moduleRatingsValue') == null) {
                    AMI.Browser.Cookie.set('moduleRatingsValue', module_name+':'+id+','+AMI.$('#rating_block'+id).text()+','+AMI.$('#votes_block'+id).text(), cookieLifetime);                
                } else if(AMI.Browser.Cookie.get('moduleRatingsValue').indexOf(module_name) >= 0) {
                    AMI.Browser.Cookie.set('moduleRatingsValue', AMI.Browser.Cookie.get('moduleRatingsValue').replace(module_name+':', module_name+':'+id+','+AMI.$('#rating_block'+id).text()+','+AMI.$('#votes_block'+id).text()+';'), cookieLifetime);
                } else {
                    AMI.Browser.Cookie.set('moduleRatingsValue', AMI.Browser.Cookie.get('moduleRatingsValue')+'|'+module_name+':'+id+','+AMI.$('#rating_block'+id).text()+','+AMI.$('#votes_block'+id).text(), cookieLifetime);
                }
            }
        });    
    },
    ratingLikeSubmit: function(id, confirm_register, module_name) { 
        if(confirm_register == 'true'){
           alert(AMI.$('#rating-like'+id).attr('data-like-register'));
           return false; 
        }
        document.forms['rating'+id].rating.value = 1;
        if(AMI.$('#votes_block'+id).length == 0) {
            AMI.$('#rating__like-form'+id).after('<span style="display: none;" id="votes_block'+id+'">1</span>');
        }
        amiRatingLike.ajaxLikeSubmit(id, module_name);
    }
}
AMI.$(function() {amiRatingLike.checkLikeForm();});

/* End Rating Like */

/* Start Rating Stars Oneblock */

ratingStarsOneblock = {
    getOffsetLeftStars: function(el){ 
        var ol = el.offsetLeft; 
        while ((el = el.offsetParent) != null) ol += el.offsetLeft;
        return ol;
    },
    onRatingOverStars: function(event){
        if (event.target){
            oElement = event.target;
        }else{
            oElement = event.srcElement;
        }
        var num = parseInt(((event.clientX + document.body.scrollLeft - 3 - ratingStarsOneblock.getOffsetLeftStars(oElement)) / oElement.offsetWidth) * 5) + 1;
        oElement.src="_img/rating/medium_stars/stars"+num+".gif";
    },
    onRatingClearStars: function(event){
        if (event.target){
            oElement = event.target;
        }else{
            oElement = event.srcElement;
        }
        var idRating = AMI.$(oElement).attr('data-ami-img-rating-id');
        if(document.forms['rating'+idRating].rating.value!=''){
            oElement.src="_img/rating/medium_stars/stars"+(parseInt(document.forms['rating'+idRating].rating.value)+1)+".gif";
        }else{
            oElement.src="_img/spacer.gif";
        }
    },
    onRatingSetStars: function(event, confirm_register, module_name){
        if (event.target){
            oElement = event.target;
        }else{
            oElement = event.srcElement;
        }
        var idRating = AMI.$(oElement).attr('data-ami-img-rating-id');
        if(confirm_register == 'true'){
           alert(AMI.$('.rating-stars__form-votes').eq(0).attr('data-stars-register'));
           return false; 
        }
        var num = parseInt(((event.clientX  + document.body.scrollLeft - 3 - ratingStarsOneblock.getOffsetLeftStars(oElement)) / oElement.offsetWidth) * 5) + 1;
        oElement.style.cursor = 'default';
        document.forms['rating'+idRating].rating.value = num - 1;   

        if(AMI.$('#rating_block'+idRating == false)) {
            AMI.$('#rating__stars-form'+idRating).after('<span style="display: none;" data-ami-rating'+idRating+'="1" id="rating_block'+idRating+'"></span>');
            AMI.$('#rating__stars-form'+idRating).after('<span style="display: none;" id="votes_block'+idRating+'"></span>');
        }
        ratingStarsOneblock.ajaxCheckStars(idRating, module_name);
    },
    checkRatingFormStars: function() {
        if(AMI.Browser.Cookie.get('moduleRatingsValue') != null && AMI.$('.rating__stars-form').length != 0) {
            moduleName = AMI.$('[data-module-name]').eq(0).attr('data-module-name');
            for(i=0;i<AMI.$('[data-ami-rating-id]').length;i++) {
                for(j=0;j<AMI.Browser.Cookie.get('moduleRatingsValue').split('|').length;j++) {
                    if (AMI.Browser.Cookie.get('moduleRatingsValue').split('|')[j].indexOf(moduleName) >= 0) {
                        for(n=0;n<AMI.Browser.Cookie.get('moduleRatingsValue').split('|')[j].split(':')[1].split(';').length;n++) {
                            if(AMI.Browser.Cookie.get('moduleRatingsValue').split('|')[j].split(':')[1].split(';')[n].split(',')[0] == AMI.$('[data-ami-rating-id]').eq(i).attr('data-ami-rating-id')) {
                                AMI.$('[data-ami-rating-id] .rating-stars__form-votes').eq(i).attr('title', AMI.$('[data-ami-rating-id] .rating-stars__form-votes').eq(i).attr('data-already-stars'));
                                AMI.$('[data-ami-rating-id] .rating-stars__form-block').eq(i).css('display', 'none');
                                if(AMI.Browser.Cookie.get('moduleRatingsValue').split('|')[j].split(':')[1].split(';')[n].split(',')[2] > AMI.$('[data-ami-rating-id]').eq(i).attr('data-rating-votes-count')) {
                                    AMI.$('[data-ami-rating-id] .rating-stars__rate-area').eq(i).text(AMI.$('[data-ami-rating-id] .rating-stars__votes-area').eq(i).attr('data-rates-title')+': '+AMI.Browser.Cookie.get('moduleRatingsValue').split('|')[j].split(':')[1].split(';')[n].split(',')[1]);
                                    AMI.$('[data-ami-rating-id] .rating-stars__votes-area').eq(i).text('('+AMI.$('[data-ami-rating-id] .rating-stars__votes-area').eq(i).attr('data-votes-rates-title')+': '+AMI.Browser.Cookie.get('moduleRatingsValue').split('|')[j].split(':')[1].split(';')[n].split(',')[2]+')');
                                    AMI.$('[data-ami-rating-id] .rating-stars__form-votes').eq(i).css('background-image', 'url(_img/rating/medium_stars/stars'+Math.round(AMI.Browser.Cookie.get('moduleRatingsValue').split('|')[j].split(':')[1].split(';')[n].split(',')[1])+'.gif)');
                                }
                            }
                        } 
                    }
                }
            }
        }
    }, 
    ajaxCheckStars: function(idRating, module_name) {
        AMI.HTTPRequest.submitForm('POST', document.forms['rating'+idRating], {is_ajax: true}, function(status, data){
            if(data){
                var parts = data.split('|');
                var cookieString = parts[0];
                var cookieLifetime = parts[1];
                var ratingBlock = parts[2];
                var votesBlock = parts[3];
                var statusMsg = parts[4];
                var isError = parts[5];   
                
                if(isError == '1') {
                    AMI.$('#rating-stars__form-votes'+idRating).attr('title', statusMsg);
                    AMI.$('#rating_value'+idRating).css('display', 'none');
                } else {
                    AMI.$('#rating_block'+idRating).replaceWith(ratingBlock);
                    AMI.$('#votes_block'+idRating).replaceWith(votesBlock);
                    AMI.$('#rating-stars__rate-block-count'+idRating).html(AMI.$('#rating_block'+idRating).text());
                    AMI.$('#rating-stars__rate-block-count-votes'+idRating).html(AMI.$('#votes_block'+idRating).text());
                    AMI.$('#rating-stars__form-votes'+idRating).attr('title', AMI.$('#rating_block'+idRating).text());
                    AMI.$('#rating-stars__rate-block-status'+idRating).html('<span class="rating-stars__rate-on">'+AMI.$('.rating-stars__form-votes').eq(0).attr('data-stars-thanks')+'</span>');
                    AMI.$('#rating-stars__form-votes'+idRating).css('background-image', 'url(_img/rating/medium_stars/stars'+Math.round(AMI.$('#rating_block'+idRating).attr('data-ami-rating'+idRating))+'.gif)');
                    AMI.$('#rating_value'+idRating).css('display', 'none');
                }
                if(AMI.Browser.Cookie.get('moduleRatingsValue') == null) {
                    AMI.Browser.Cookie.set('moduleRatingsValue', module_name+':'+idRating+','+AMI.$('#rating_block'+idRating).attr('data-ami-rating'+idRating)+','+AMI.$('#votes_block'+idRating).attr('data-ami-votes'+idRating), cookieLifetime);                
                } else if(AMI.Browser.Cookie.get('moduleRatingsValue').indexOf(module_name) >= 0) {
                    AMI.Browser.Cookie.set('moduleRatingsValue', AMI.Browser.Cookie.get('moduleRatingsValue').replace(module_name+':', module_name+':'+idRating+','+AMI.$('#rating_block'+idRating).attr('data-ami-rating'+idRating)+','+AMI.$('#votes_block'+idRating).attr('data-ami-votes'+idRating)+';'), cookieLifetime);
                } else {
                    AMI.Browser.Cookie.set('moduleRatingsValue', AMI.Browser.Cookie.get('moduleRatingsValue')+'|'+module_name+':'+idRating+','+AMI.$('#rating_block'+idRating).attr('data-ami-rating'+idRating)+','+AMI.$('#votes_block'+idRating).attr('data-ami-votes'+idRating), cookieLifetime);
                }
            }
        });    
    }
}
AMI.$(function() {ratingStarsOneblock.checkRatingFormStars();});

/* End Rating Stars Oneblock */

/* Start Photoalbum 6.0 */

if(location.href.indexOf('?fullscreen=on') >= 0) {
    AMI.$('html').css({background: '#000', position: 'absolute', left: '-5000px'});
    AMI.$(document).ready(function(){
        showFullScreenImg();
        AMI.$('html').removeAttr('style');
    });
}

function showFullScreenImg(show) {
    if(AMI.$('#photo-itemd').hasClass('fullscreen-img__off') && show != 'close') {
        AMI.$('#photo-itemd').removeClass('fullscreen-img__off');
        AMI.$('#photo-itemd').addClass('fullscreen-img__on');
        AMI.$('#next-link__img').attr('href', AMI.$('#next-link__img').attr('href')+'?fullscreen=on');
        AMI.$('#prev-link__img').attr('href', AMI.$('#prev-link__img').attr('href')+'?fullscreen=on');
        AMI.$('.photoalbum_item-detail__img').css({top: '50%', marginTop: -AMI.$('.photoalbum_item-detail__img').attr('data-amiphoto-height')/2+'px'});
    } else {
        AMI.$('#photo-itemd').removeClass('fullscreen-img__on');
        AMI.$('#photo-itemd').addClass('fullscreen-img__off');
        AMI.$('#next-link__img').attr('href', AMI.$('#next-link__img').attr('data-link'));
        AMI.$('#prev-link__img').attr('href', AMI.$('#prev-link__img').attr('data-link'));
        AMI.$('.photoalbum_item-detail__img').removeAttr('css');
    }
}
    
amiPhotoalbum = function(photoBlock, photoRow, photoRowItem, photoRowItemContant, photoRowItemImg) {
    AMI.$('.'+photoRowItemImg).each(function(i){ AMI.$(this).height(AMI.$(this).height()/1.2);});
    photoRowItemOb = AMI.$('.'+photoRowItem);

    photoRowItemOb.each(function(){
        if(AMI.$(this).parent().hasClass(photoBlock)) {
            AMI.$(this).addClass(photoRowItem+parseInt(AMI.$(this).offset().top));
        }
    });
                                   
    nameClassRow = '';
    photoRowItemOb.each(function(i){
        offsetTop = parseInt(AMI.$(this).offset().top);
        if(AMI.$(this).next()[0] == undefined) {
            if(nameClassRow == '') {
                nameClassRow += offsetTop;
            } else {
                nameClassRow += ','+offsetTop;
            }
        } else {
            if(offsetTop != parseInt(AMI.$(this).next().offset().top)) {
                if(nameClassRow == '') {
                    nameClassRow += offsetTop;
                } else {
                    nameClassRow += ','+offsetTop;
                }
            } 
        }
    });

    for(i=0;i<nameClassRow.split(',').length;i++) {
        AMI.$('.'+photoRowItem+nameClassRow.split(',')[i]).wrapAll('<div class="'+photoRow+'"></div>');
    }

    containerBlock = AMI.$('.'+photoBlock);
    containerRow = AMI.$('.'+photoRow);
    containerRowCount = AMI.$('.'+photoRow).length;
    border = (AMI.$('.'+photoRowItemContant).eq(0).outerWidth()-AMI.$('.'+photoRowItemContant).eq(0).width());

    containerRow.each(function(k){
        if(AMI.$(this).parent().hasClass(photoBlock)) {
            mediumHeight = 0;
            imgWidth = 0;
            
            countItems = AMI.$(this).children().length;
            
            AMI.$(this).find('.'+photoRowItemImg).each(function(){ 
                if(AMI.$(this).height() > mediumHeight) {
                    mediumHeight = AMI.$(this).height();
                } else {
                    minHeight = AMI.$(this).height();
                }
            });
            
            if(k+1 == containerRowCount) {
                if(AMI.$('.'+photoBlock).hasClass('photoalbum_item-cat-list') == true) {
                    AMI.$(this).find('.'+photoRowItemImg).height(Math.ceil(minHeight));
                    AMI.$(this).find('.'+photoRowItemImg).parent().parent().height(Math.ceil(minHeight));
                    AMI.$(this).find('.'+photoRowItemImg).parent().parent().width(AMI.$(this).find('.'+photoRowItemImg).width());
                } else {
                    if(countItems > 1) {
                        AMI.$(this).find('.'+photoRowItemImg).height(Math.ceil(minHeight));
                        AMI.$(this).find('.'+photoRowItemImg).parent().parent().height(Math.ceil(minHeight));
                    }
                }
            } else {
                AMI.$(this).find('.'+photoRowItemImg).height(minHeight);
                AMI.$(this).find('.'+photoRowItemImg).parent().parent().height(minHeight);
                AMI.$(this).find('.'+photoRowItemImg).each(function(){ imgWidth = imgWidth + AMI.$(this).width() });
                AMI.$(this).find('.'+photoRowItemImg).each(function(){
                    AMI.$(this).height(Math.ceil(AMI.$(this).height()*((containerBlock.width()-border*countItems+2)/imgWidth)));
                    AMI.$(this).parent().parent().height(AMI.$(this).height());
                    AMI.$(this).parent().parent().width(AMI.$(this).width());
                });
            }
        }
    });
}
    
amiPhotoCatImgRotate = {
    imagesRotateOn: function(col) {	
        var currentImage = (AMI.$('.cat-row__images-block__slider:eq('+col+') img.show')?  AMI.$('.cat-row__images-block__slider:eq('+col+') img.show') : AMI.$('.cat-row__images-block__slider:eq('+col+') img:first').next());
        var nextImage = ((currentImage.next().length) ? ((currentImage.next().hasClass('show')) ? AMI.$('.cat-row__images-block__slider:eq('+col+') img:first') :currentImage.next()) : AMI.$('.cat-row__images-block__slider:eq('+col+') img:first').next());	

        nextImage.css({opacity: 0.0})
        .addClass('show')
        .css('margin-left', -nextImage.width()/2)
        .animate({opacity: 1.0}, 1000);
        currentImage.animate({opacity: 0.0}, 1000)
        .removeClass('show');
    },
    imagesRotateToFirst: function(col) {
        clearInterval(startRotate);
        var firstImage = AMI.$('.cat-row__images-block__slider:eq('+col+') img:first');
        var currentImage = (AMI.$('.cat-row__images-block__slider:eq('+col+') img.show')?  AMI.$('.cat-row__images-block__slider:eq('+col+') img.show') : AMI.$('.cat-row__images-block__slider:eq('+col+') img:first'));
        if(currentImage.prev().length) {
            currentImage.removeClass('show');
            currentImage.animate({opacity: 0.0}, 1000);
            firstImage.animate({opacity: 1.0}, 1000)
            .addClass('show');
        }
    },
    imagesRotate: function(col) {
        if(AMI.$('.cat-row__images-block__slider:eq('+col+') img').css('opacity') == '1') {
            AMI.$('.cat-row__images-block__slider:eq('+col+') img').css({opacity: 0.0});
            AMI.$('.cat-row__images-block__slider:eq('+col+') img:first').css({opacity: 1.0});
            amiPhotoCatImgRotate.imagesRotateOn(col);
            startRotate = setInterval('amiPhotoCatImgRotate.imagesRotateOn('+col+')', 1500);
        }
    }
}
    
AMI.$(window).load(
    function() {
        if(AMI.$('.amiphoto-block').length > 0) {
            amiPhotoalbum('amiphoto-block', 'amiphoto-block__row', 'amiphoto-block__row-item', 'amiphoto-block__row-item__contant', 'amiphoto-block__row-item__img');
            AMI.$('.amiphoto-hide').fadeOut();
            if(AMI.$('.cat-row__images-block').length > 0) {
                for(i=0;i<AMI.$('.cat-row__images-block').length;i++) {
                    AMI.$('.cat-row__images-block').eq(i).attr('ami-id-img-block', +i);
                    var catImg = AMI.$('.cat-row__images-block').eq(i).find('.amiphoto-block__row-item__img').eq(0);
                    var catImgWidth = AMI.$('.cat-row__images-block').eq(i).find('.amiphoto-block__row-item__img').eq(0).width();
                    AMI.$('.cat-row__images-block').eq(i).html('');
                    AMI.$('.cat-row__images-block').eq(i).append('<div class="cat-row__images-block__slider"></div>');
                    AMI.$('.cat-row__images-block .cat-row__images-block__slider').eq(i).append("<img style='height: "+catImg.height()+"px; margin-left: -"+catImgWidth/2+"px;' src="+catImg.attr('src')+" class='amiphoto-block__row-item__img show' />");
                    for(k=0;k<AMI.$('.photoalbum_item-cat-row').eq(i).find('.photoalbum_item-list__subitem-list .amiphoto-block__row-item__img').length;k++) {
                        AMI.$('.cat-row__images-block .cat-row__images-block__slider').eq(i).append("<img style='height: "+AMI.$('.cat-row__images-block').eq(i).find('.amiphoto-block__row-item__img').eq(0).height()+"px' src="+AMI.$('.photoalbum_item-list__subitem-list').eq(i).find('.amiphoto-block__row-item__img').eq(k).attr('src')+" class='amiphoto-block__row-item__img' />");
                    }
                    if(AMI.$('.cat-row__images-block').eq(i).find('.cat-row__images-block__slider img').length > 2) {
                        AMI.$('.cat-row__images-block').eq(i).hover(
                            function(){
                              amiPhotoCatImgRotate.imagesRotate(AMI.$(this).attr('ami-id-img-block'));
                            },
                            function(){
                              amiPhotoCatImgRotate.imagesRotateToFirst(AMI.$(this).attr('ami-id-img-block'));
                        });
                    }
                }
            }
            AMI.$('#photoalbum_itemd__img').fadeIn();
            AMI.$(document).keyup(function(e) {
                if (e.keyCode == 27) { 
                    showFullScreenImg('close');
                }
            });
            if(AMI.$('.amiphotoalbum .browse-item-list__hide').length > 0) {
                AMI.$('#slider-nav__browse-pad').removeClass('null-width');
                AMI.$('.browse-item-list__hide').fadeOut();
            }
        }
    }
);

/* End Photoalbum 6.0 */