nc_auth = function ( settings ) {
    if ( !settings ) settings = {};
    // проверять логин
    this.check_login = settings.check_login;// || true;
    // минимальная длина пароля
    this.pass_min = settings.pass_min || 0;
    // id input'a для логина
    this.login_id = '#' + (settings.login_id || 'f_Login');
    // id input'a для пароля
    this.pass1_id = '#' + (settings.pass1_id || 'Password1');
    // id input'a для подтверждения пароля
    this.pass2_id = '#' + (settings.pass2_id || 'Password2');
    // id элемента "ждите"
    this.wait_id = '#' + (settings.wait_id || 'nc_auth_wait');
    // id элемента "логин свободен"
    this.login_ok_id = '#' + (settings.login_ok_id || 'nc_auth_login_ok');
    // id элемента "логин занят"
    this.login_fail_id = '#' + (settings.login_fail_id || 'nc_auth_login_fail');
    // id элемента "логин содержит запрещенные символы"
    this.login_incorrect_id = '#' + (settings.login_incorrect_id || 'nc_auth_login_incorrect');
    // id элемента "надежность пароля"
    this.pass1_security = '#' + (settings.pass1_security || 'nc_auth_pass1_security');
    // id элемента "пароль не может быть пустым"
    this.pass1_empty = '#' + (settings.pass1_empty || 'nc_auth_pass1_empty');
    // id элемента "пароли совпадают"
    this.pass2_ok_id = '#' + (settings.pass2_ok_id || 'nc_auth_pass2_ok');
    // id элемента "пароли не совпадают"
    this.pass2_fail_id = '#' + (settings.pass2_fail_id || 'nc_auth_pass2_fail');

    if ( this.check_login && this.check_login != "0" ) {
        jQuery(this.login_id).change ( function() {
            nc_auth_obj.check_loginf()
            } );
        jQuery(this.login_id).keypress( function() {
            jQuery('.nc_auth_login_check').hide()
            } );
        this.check_loginf();
    }
  
    if ( settings.check_pass && settings.check_pass != "0")
        jQuery(this.pass1_id).bind ( 'keyup change', function() {
            nc_auth_obj.check_pass()
            } );
    if ( settings.check_pass2 && settings.check_pass2 != "0")
        jQuery(this.pass2_id).bind ( 'keyup change', function() {
            nc_auth_obj.check_pass2()
            } );

    this.cache_pass = '';

  
}

nc_auth.prototype = {

    check_loginf : function () {
        if ( !jQuery(this.login_id).val().length ) {
            jQuery('.nc_auth_login_check').hide();
            jQuery('.nc_auth_pass1_check').hide();
            jQuery('.nc_auth_pass2_check').hide();
            return false;
        }

        jQuery.post(NETCAT_PATH + 'modules/auth/ajax.php',
            'act=check_login&login='+jQuery(this.login_id).val(),
            function(res) {
                nc_auth_obj.check_login_res(res);
            },
            "json"  );
        this.process = true;
        jQuery('.nc_auth_login_check').hide();
        jQuery('.nc_auth_pass1_check').hide();
        jQuery('.nc_auth_pass2_check').hide();
        jQuery(this.wait_id).show();
        return false;
    },


    check_login_res : function ( res ) {
        jQuery('.nc_auth_login_check').hide();
        jQuery('.nc_auth_pass1_check').hide();
        jQuery('.nc_auth_pass2_check').hide();
        
        if ( res == 2 ) {
            jQuery(this.login_fail_id).show();
        }
        else if ( res == 1 ) {
            jQuery(this.login_incorrect_id).show();
        }
        else {
            jQuery(this.login_ok_id).show();
        }
    },


    check_pass : function () {
        var p = jQuery(this.pass1_id).val();
        // кэширование во избежание одинаковых проверок
        if ( this.cache_pass == p ) return false;
        this.cache_pass = p;

        jQuery('.nc_auth_pass1_check').hide();
    
        var l = p.length;

        if ( !l ) {
            jQuery(this.pass1_empty).show();
            jQuery(this.pass1_security).hide();
            return false;
        }
        else {
            jQuery(this.pass1_empty).hide();
        }

        if ( l < this.pass_min ) {
            jQuery("#nc_auth_pass_min").show();
            jQuery(this.pass1_security).hide();
            return false;
        }
        jQuery("#nc_auth_pass_min").hide();

        // количетво множеств, из которых составлен пароль ( a-z, A-Z, 0-9, остальные)
        var s = 0;
        var expr1 = new RegExp('[a-z]');
        var expr2 = new RegExp('[A-Z]');
        var expr3 = new RegExp('[0-9]');
        var expr4 = new RegExp('[^a-zA-Z0-9]');
        if ( expr1.test(p) ) s++;
        if ( expr2.test(p) ) s++;
        if ( expr3.test(p) ) s++;
        if ( expr4.test(p) ) s++;

    
        jQuery(this.pass1_security).show();

        if ( s == 4 && l >= 12 ) {
            jQuery('#nc_auth_pass1_s4').show();
        }
        else if ( s >= 3 && l >= 8 ) {
            jQuery('#nc_auth_pass1_s3').show();
        }
        else if ( s >= 2 && l >= 6 ) {
            jQuery('#nc_auth_pass1_s2').show();
        }
        else {
            jQuery('#nc_auth_pass1_s1').show();
        }

        if ( jQuery(this.pass2_id).val() ) this.check_pass2();
        return false;
    },


    check_pass2 : function () {
        jQuery('.nc_auth_pass2_check').hide();
        if ( jQuery(this.pass1_id).val() == jQuery(this.pass2_id).val() ) {
            jQuery(this.pass2_ok_id).show();
        }
        else {
            jQuery(this.pass2_fail_id).show();
        }
    }
  
}


nc_auth_token = function ( settings ) {
    // случайное числов
    this.randnum = settings.randnum || 0;
    // id формы
    this.form_id = settings.form_id || 'nc_auth_form';
    // id селекта с логинами
    this.select_id = settings.select_id || 'nc_token_login';
    // id input'a для ввода нового логина
    this.login_id = settings.login_id || 'nc_token_login';
    // id скрытого поля с цифровой подписью/публичный ключом
    this.token_id = settings.token_id || 'nc_token_signature';
    // id объекта-плагина
    this.plugin_id = settings.plugin_id || 'nc_token_plugin';
    this.plugin = document.getElementById(this.plugin_id);
}


nc_auth_token.prototype = {

    load : function () {
        if ( !this.plugin.rtwIsTokenPresentAndOK()  ) return false;
        i=0;
        this.plugin.rtwGetNumberOfContainers();
        while ( (cont_name = this.plugin.rtwGetContainerName(i++)) ) {
            this.add_option(cont_name, cont_name, 0, 0);
        }
    
        return true;
    },

    add_option : function (text, value, isDefaultSelected, isSelected) {
        oListbox = document.getElementById(this.select_id);
        var oOption = document.createElement("option");
        oOption.appendChild(document.createTextNode(text));
        oOption.setAttribute("value", value);
        if (isDefaultSelected) oOption.defaultSelected = true;
        else if (isSelected) oOption.selected = true;
        oListbox.appendChild(oOption);
    },

  
    sign : function () {
        // Проверки:
        // плагин не установлен
        if ( !this.plugin.valid ) return 1;
        // токен отсутсвует
        if ( !this.plugin.rtwIsTokenPresentAndOK() ) return 2;
        // диалоговое окно ввода пин-кода
        if ( !this.plugin.rtwIsUserLoggedIn()) this.plugin.rtwUserLoginDlg();
        // ошибочный пин-код
        if ( !this.plugin.rtwIsUserLoggedIn()) return 3;
    
        tsign = document.getElementById(this.token_id);
        ltlog = document.getElementById(this.select_id);
        //  заполнение эцп
        tsign.value = this.plugin.rtwSign(ltlog.value, this.randnum);
        this.plugin.rtwLogout();
		
        if (tsign.value){
            document.getElementById('nc_token_form').submit();
        }
        else {
            return 4;
        }

        return 0;

    },

    reg : function () {
        // Проверки:
        // плагин не установлен
        if ( !this.plugin.valid ) return 1;
        // токен отсутсвует
        if ( !this.plugin.rtwIsTokenPresentAndOK() ) return 2;
        // диалоговое окно ввода пин-кода
        if ( !this.plugin.rtwIsUserLoggedIn()) this.plugin.rtwUserLoginDlg();
        // ошибочный пин-код
        if ( !this.plugin.rtwIsUserLoggedIn()) return 3;
        // логин отсутствует
        if ( !jQuery('#' + this.login_id).val() ) return 4;

        // регистрация
        var key = this.plugin.rtwGenKeyPair(jQuery('#' + this.login_id).val());
        this.plugin.rtwLogout();

        // ошибка создания ключа
        if ( !key ) return 5;

        jQuery('#' + this.token_id).val(key);

        return 0;
    },

    attempt_delete : function  ( name ) {
        if ( !this.plugin.valid || !this.plugin.rtwIsTokenPresentAndOK() ) return false;
        //запрос пин-кода
        if ( !this.plugin.rtwIsUserLoggedIn()) this.plugin.rtwUserLoginDlg();
        if ( !this.plugin.rtwIsUserLoggedIn()) return false;
        // удаление
        var r = this.plugin.rtwDestroyContainer(name);
        this.plugin.rtwLogout();

        return r;
    }
}


nc_auth_ajax = function ( settings ) {
    if ( !settings ) settings = {};
    this.auth_link = '#' + (settings.auth_link || 'nc_auth_link');
    this.params = settings.params || '';
    this.params_hash = settings.param_hash;
    this.postlink = settings.postlink || NETCAT_PATH + 'modules/auth/ajax.php';
    this.template = settings.template || '';
    this.template_hash = settings.template_hash;
    jQuery(this.auth_link).click( function(){
        nc_auth_ajax_obj.show_layer();
    } );
    jQuery('#nc_auth_form_ajax').submit( function(){
        nc_auth_ajax_obj.sign();
        return false;
    } );
}

nc_auth_ajax.prototype = {
    show_layer : function () {
        jQuery('#nc_auth_layer').modal();
    },

    sign : function () {
        // collect form values into array
        oForm = document.getElementById('nc_auth_form_ajax');
        var values = 'act=auth&params=' + nc_auth_ajax_obj.params + '&template=' + nc_auth_ajax_obj.template +
            '&params_hash=' + nc_auth_ajax_obj.params_hash +
            '&template_hash=' + nc_auth_ajax_obj.template_hash;
        for (var i=0; i < oForm.length; i++) {
            var el = oForm.elements[i];
            if (el.tagName=="SELECT") {
                values +=  '&' + el.name + '=' + el.options[el.options.selectedIndex].value;
            }
            else if (el.tagName=="INPUT" && (el.type=="checkbox" || el.type=="radio")) {
                if (el.checked) values +=  '&' + el.name + '=' + el.value;
            }
            else if (el.name && el.value != undefined) {
                values +=  '&' + el.name + '=' + el.value;
            }
        }

        jQuery.post(this.postlink, values, function(res) {
            nc_auth_ajax_obj.sign_res(res);
        }, 'json');
    },


    sign_res : function ( res ) {
        if ( res.captcha_wrong ) {
            jQuery('#nc_auth_captcha_error').show();
            var s = jQuery("#nc_auth_form_ajax img[name='nc_captcha_img']").attr('src');
            s = s.replace(/code=[a-z0-9]+/, "code="+res.captcha_hash);
            jQuery("#nc_auth_form_ajax img[name='nc_captcha_img']").attr('src', s);
            return false;
        }
    
        if ( !res.user_id ) {
            jQuery('#nc_auth_error').show();
            return false;
        }

        jQuery.modal.close();
        jQuery('.auth_block').replaceWith(res.auth_block);

        return false;
    }
}

function nc_auth_openid_select ( url ) {
    oTxt = document.getElementById('openid_url');
    oTxt.value = url;

    if ( (start = url.indexOf("USERNAME") ) > 0 ) {
        length = 8;
        if (oTxt.createTextRange) {
            var oRange = oTxt.createTextRange();
            oRange.moveStart("character", start);
            oRange.moveEnd("character", length - oTxt.value.length);
            oRange.select();
        }
        else if (oTxt.setSelectionRange) {
            oTxt.setSelectionRange(start, start+length);
        }
        oTxt.focus();
    }




}

/*! Copyright (c) 2013 Brandon Aaron (http://brandonaaron.net)
 * Licensed under the MIT License (LICENSE.txt).
 *
 * Thanks to: http://adomas.org/javascript-mouse-wheel/ for some pointers.
 * Thanks to: Mathias Bank(http://www.mathias-bank.de) for a scope bug fix.
 * Thanks to: Seamus Leahy for adding deltaX and deltaY
 *
 * Version: 3.1.3
 *
 * Requires: 1.2.2+
 */

(function (factory) {
    if ( typeof define === 'function' && define.amd ) {
        // AMD. Register as an anonymous module.
        define(['jquery'], factory);
    } else if (typeof exports === 'object') {
        // Node/CommonJS style for Browserify
        module.exports = factory;
    } else {
        // Browser globals
        factory(jQuery);
    }
}(function ($) {

    var toFix = ['wheel', 'mousewheel', 'DOMMouseScroll', 'MozMousePixelScroll'];
    var toBind = 'onwheel' in document || document.documentMode >= 9 ? ['wheel'] : ['mousewheel', 'DomMouseScroll', 'MozMousePixelScroll'];
    var lowestDelta, lowestDeltaXY;

    if ( $.event.fixHooks ) {
        for ( var i = toFix.length; i; ) {
            $.event.fixHooks[ toFix[--i] ] = $.event.mouseHooks;
        }
    }

    $.event.special.mousewheel = {
        setup: function() {
            if ( this.addEventListener ) {
                for ( var i = toBind.length; i; ) {
                    this.addEventListener( toBind[--i], handler, false );
                }
            } else {
                this.onmousewheel = handler;
            }
        },

        teardown: function() {
            if ( this.removeEventListener ) {
                for ( var i = toBind.length; i; ) {
                    this.removeEventListener( toBind[--i], handler, false );
                }
            } else {
                this.onmousewheel = null;
            }
        }
    };

    $.fn.extend({
        mousewheel: function(fn) {
            return fn ? this.bind("mousewheel", fn) : this.trigger("mousewheel");
        },

        unmousewheel: function(fn) {
            return this.unbind("mousewheel", fn);
        }
    });


    function handler(event) {
        var orgEvent = event || window.event,
            args = [].slice.call(arguments, 1),
            delta = 0,
            deltaX = 0,
            deltaY = 0,
            absDelta = 0,
            absDeltaXY = 0,
            fn;
        event = $.event.fix(orgEvent);
        event.type = "mousewheel";

        // Old school scrollwheel delta
        if ( orgEvent.wheelDelta ) { delta = orgEvent.wheelDelta; }
        if ( orgEvent.detail )     { delta = orgEvent.detail * -1; }

        // New school wheel delta (wheel event)
        if ( orgEvent.deltaY ) {
            deltaY = orgEvent.deltaY * -1;
            delta  = deltaY;
        }
        if ( orgEvent.deltaX ) {
            deltaX = orgEvent.deltaX;
            delta  = deltaX * -1;
        }

        // Webkit
        if ( orgEvent.wheelDeltaY !== undefined ) { deltaY = orgEvent.wheelDeltaY; }
        if ( orgEvent.wheelDeltaX !== undefined ) { deltaX = orgEvent.wheelDeltaX * -1; }

        // Look for lowest delta to normalize the delta values
        absDelta = Math.abs(delta);
        if ( !lowestDelta || absDelta < lowestDelta ) { lowestDelta = absDelta; }
        absDeltaXY = Math.max(Math.abs(deltaY), Math.abs(deltaX));
        if ( !lowestDeltaXY || absDeltaXY < lowestDeltaXY ) { lowestDeltaXY = absDeltaXY; }

        // Get a whole value for the deltas
        fn = delta > 0 ? 'floor' : 'ceil';
        delta  = Math[fn](delta / lowestDelta);
        deltaX = Math[fn](deltaX / lowestDeltaXY);
        deltaY = Math[fn](deltaY / lowestDeltaXY);

        // Add event and delta to the front of the arguments
        args.unshift(event, delta, deltaX, deltaY);

        return ($.event.dispatch || $.event.handle).apply(this, args);
    }

}));
/*!
 * jScrollPane - v2.0.14 - 2013-05-01
 * http://jscrollpane.kelvinluck.com/
 *
 * Copyright (c) 2010 Kelvin Luck
 * Dual licensed under the MIT or GPL licenses.
 */
(function(b,a,c){b.fn.jScrollPane=function(e){function d(D,O){var ay,Q=this,Y,aj,v,al,T,Z,y,q,az,aE,au,i,I,h,j,aa,U,ap,X,t,A,aq,af,am,G,l,at,ax,x,av,aH,f,L,ai=true,P=true,aG=false,k=false,ao=D.clone(false,false).empty(),ac=b.fn.mwheelIntent?"mwheelIntent.jsp":"mousewheel.jsp";aH=D.css("paddingTop")+" "+D.css("paddingRight")+" "+D.css("paddingBottom")+" "+D.css("paddingLeft");f=(parseInt(D.css("paddingLeft"),10)||0)+(parseInt(D.css("paddingRight"),10)||0);function ar(aQ){var aL,aN,aM,aJ,aI,aP,aO=false,aK=false;ay=aQ;if(Y===c){aI=D.scrollTop();aP=D.scrollLeft();D.css({overflow:"hidden",padding:0});aj=D.innerWidth()+f;v=D.innerHeight();D.width(aj);Y=b('<div class="jspPane" />').css("padding",aH).append(D.children());al=b('<div class="jspContainer" />').css({width:aj+"px",height:v+"px"}).append(Y).appendTo(D)}else{D.css("width","");aO=ay.stickToBottom&&K();aK=ay.stickToRight&&B();aJ=D.innerWidth()+f!=aj||D.outerHeight()!=v;if(aJ){aj=D.innerWidth()+f;v=D.innerHeight();al.css({width:aj+"px",height:v+"px"})}if(!aJ&&L==T&&Y.outerHeight()==Z){D.width(aj);return}L=T;Y.css("width","");D.width(aj);al.find(">.jspVerticalBar,>.jspHorizontalBar").remove().end()}Y.css("overflow","auto");if(aQ.contentWidth){T=aQ.contentWidth}else{T=Y[0].scrollWidth}Z=Y[0].scrollHeight;Y.css("overflow","");y=T/aj;q=Z/v;az=q>1;aE=y>1;if(!(aE||az)){D.removeClass("jspScrollable");Y.css({top:0,width:al.width()-f});n();E();R();w()}else{D.addClass("jspScrollable");aL=ay.maintainPosition&&(I||aa);if(aL){aN=aC();aM=aA()}aF();z();F();if(aL){N(aK?(T-aj):aN,false);M(aO?(Z-v):aM,false)}J();ag();an();if(ay.enableKeyboardNavigation){S()}if(ay.clickOnTrack){p()}C();if(ay.hijackInternalLinks){m()}}if(ay.autoReinitialise&&!av){av=setInterval(function(){ar(ay)},ay.autoReinitialiseDelay)}else{if(!ay.autoReinitialise&&av){clearInterval(av)}}aI&&D.scrollTop(0)&&M(aI,false);aP&&D.scrollLeft(0)&&N(aP,false);D.trigger("jsp-initialised",[aE||az])}function aF(){if(az){al.append(b('<div class="jspVerticalBar" />').append(b('<div class="jspCap jspCapTop" />'),b('<div class="jspTrack" />').append(b('<div class="jspDrag" />').append(b('<div class="jspDragTop" />'),b('<div class="jspDragBottom" />'))),b('<div class="jspCap jspCapBottom" />')));U=al.find(">.jspVerticalBar");ap=U.find(">.jspTrack");au=ap.find(">.jspDrag");if(ay.showArrows){aq=b('<a class="jspArrow jspArrowUp" />').bind("mousedown.jsp",aD(0,-1)).bind("click.jsp",aB);af=b('<a class="jspArrow jspArrowDown" />').bind("mousedown.jsp",aD(0,1)).bind("click.jsp",aB);if(ay.arrowScrollOnHover){aq.bind("mouseover.jsp",aD(0,-1,aq));af.bind("mouseover.jsp",aD(0,1,af))}ak(ap,ay.verticalArrowPositions,aq,af)}t=v;al.find(">.jspVerticalBar>.jspCap:visible,>.jspVerticalBar>.jspArrow").each(function(){t-=b(this).outerHeight()});au.hover(function(){au.addClass("jspHover")},function(){au.removeClass("jspHover")}).bind("mousedown.jsp",function(aI){b("html").bind("dragstart.jsp selectstart.jsp",aB);au.addClass("jspActive");var s=aI.pageY-au.position().top;b("html").bind("mousemove.jsp",function(aJ){V(aJ.pageY-s,false)}).bind("mouseup.jsp mouseleave.jsp",aw);return false});o()}}function o(){ap.height(t+"px");I=0;X=ay.verticalGutter+ap.outerWidth();Y.width(aj-X-f);try{if(U.position().left===0){Y.css("margin-left",X+"px")}}catch(s){}}function z(){if(aE){al.append(b('<div class="jspHorizontalBar" />').append(b('<div class="jspCap jspCapLeft" />'),b('<div class="jspTrack" />').append(b('<div class="jspDrag" />').append(b('<div class="jspDragLeft" />'),b('<div class="jspDragRight" />'))),b('<div class="jspCap jspCapRight" />')));am=al.find(">.jspHorizontalBar");G=am.find(">.jspTrack");h=G.find(">.jspDrag");if(ay.showArrows){ax=b('<a class="jspArrow jspArrowLeft" />').bind("mousedown.jsp",aD(-1,0)).bind("click.jsp",aB);x=b('<a class="jspArrow jspArrowRight" />').bind("mousedown.jsp",aD(1,0)).bind("click.jsp",aB);
if(ay.arrowScrollOnHover){ax.bind("mouseover.jsp",aD(-1,0,ax));x.bind("mouseover.jsp",aD(1,0,x))}ak(G,ay.horizontalArrowPositions,ax,x)}h.hover(function(){h.addClass("jspHover")},function(){h.removeClass("jspHover")}).bind("mousedown.jsp",function(aI){b("html").bind("dragstart.jsp selectstart.jsp",aB);h.addClass("jspActive");var s=aI.pageX-h.position().left;b("html").bind("mousemove.jsp",function(aJ){W(aJ.pageX-s,false)}).bind("mouseup.jsp mouseleave.jsp",aw);return false});l=al.innerWidth();ah()}}function ah(){al.find(">.jspHorizontalBar>.jspCap:visible,>.jspHorizontalBar>.jspArrow").each(function(){l-=b(this).outerWidth()});G.width(l+"px");aa=0}function F(){if(aE&&az){var aI=G.outerHeight(),s=ap.outerWidth();t-=aI;b(am).find(">.jspCap:visible,>.jspArrow").each(function(){l+=b(this).outerWidth()});l-=s;v-=s;aj-=aI;G.parent().append(b('<div class="jspCorner" />').css("width",aI+"px"));o();ah()}if(aE){Y.width((al.outerWidth()-f)+"px")}Z=Y.outerHeight();q=Z/v;if(aE){at=Math.ceil(1/y*l);if(at>ay.horizontalDragMaxWidth){at=ay.horizontalDragMaxWidth}else{if(at<ay.horizontalDragMinWidth){at=ay.horizontalDragMinWidth}}h.width(at+"px");j=l-at;ae(aa)}if(az){A=Math.ceil(1/q*t);if(A>ay.verticalDragMaxHeight){A=ay.verticalDragMaxHeight}else{if(A<ay.verticalDragMinHeight){A=ay.verticalDragMinHeight}}au.height(A+"px");i=t-A;ad(I)}}function ak(aJ,aL,aI,s){var aN="before",aK="after",aM;if(aL=="os"){aL=/Mac/.test(navigator.platform)?"after":"split"}if(aL==aN){aK=aL}else{if(aL==aK){aN=aL;aM=aI;aI=s;s=aM}}aJ[aN](aI)[aK](s)}function aD(aI,s,aJ){return function(){H(aI,s,this,aJ);this.blur();return false}}function H(aL,aK,aO,aN){aO=b(aO).addClass("jspActive");var aM,aJ,aI=true,s=function(){if(aL!==0){Q.scrollByX(aL*ay.arrowButtonSpeed)}if(aK!==0){Q.scrollByY(aK*ay.arrowButtonSpeed)}aJ=setTimeout(s,aI?ay.initialDelay:ay.arrowRepeatFreq);aI=false};s();aM=aN?"mouseout.jsp":"mouseup.jsp";aN=aN||b("html");aN.bind(aM,function(){aO.removeClass("jspActive");aJ&&clearTimeout(aJ);aJ=null;aN.unbind(aM)})}function p(){w();if(az){ap.bind("mousedown.jsp",function(aN){if(aN.originalTarget===c||aN.originalTarget==aN.currentTarget){var aL=b(this),aO=aL.offset(),aM=aN.pageY-aO.top-I,aJ,aI=true,s=function(){var aR=aL.offset(),aS=aN.pageY-aR.top-A/2,aP=v*ay.scrollPagePercent,aQ=i*aP/(Z-v);if(aM<0){if(I-aQ>aS){Q.scrollByY(-aP)}else{V(aS)}}else{if(aM>0){if(I+aQ<aS){Q.scrollByY(aP)}else{V(aS)}}else{aK();return}}aJ=setTimeout(s,aI?ay.initialDelay:ay.trackClickRepeatFreq);aI=false},aK=function(){aJ&&clearTimeout(aJ);aJ=null;b(document).unbind("mouseup.jsp",aK)};s();b(document).bind("mouseup.jsp",aK);return false}})}if(aE){G.bind("mousedown.jsp",function(aN){if(aN.originalTarget===c||aN.originalTarget==aN.currentTarget){var aL=b(this),aO=aL.offset(),aM=aN.pageX-aO.left-aa,aJ,aI=true,s=function(){var aR=aL.offset(),aS=aN.pageX-aR.left-at/2,aP=aj*ay.scrollPagePercent,aQ=j*aP/(T-aj);if(aM<0){if(aa-aQ>aS){Q.scrollByX(-aP)}else{W(aS)}}else{if(aM>0){if(aa+aQ<aS){Q.scrollByX(aP)}else{W(aS)}}else{aK();return}}aJ=setTimeout(s,aI?ay.initialDelay:ay.trackClickRepeatFreq);aI=false},aK=function(){aJ&&clearTimeout(aJ);aJ=null;b(document).unbind("mouseup.jsp",aK)};s();b(document).bind("mouseup.jsp",aK);return false}})}}function w(){if(G){G.unbind("mousedown.jsp")}if(ap){ap.unbind("mousedown.jsp")}}function aw(){b("html").unbind("dragstart.jsp selectstart.jsp mousemove.jsp mouseup.jsp mouseleave.jsp");if(au){au.removeClass("jspActive")}if(h){h.removeClass("jspActive")}}function V(s,aI){if(!az){return}if(s<0){s=0}else{if(s>i){s=i}}if(aI===c){aI=ay.animateScroll}if(aI){Q.animate(au,"top",s,ad)}else{au.css("top",s);ad(s)}}function ad(aI){if(aI===c){aI=au.position().top}al.scrollTop(0);I=aI;var aL=I===0,aJ=I==i,aK=aI/i,s=-aK*(Z-v);if(ai!=aL||aG!=aJ){ai=aL;aG=aJ;D.trigger("jsp-arrow-change",[ai,aG,P,k])}u(aL,aJ);Y.css("top",s);D.trigger("jsp-scroll-y",[-s,aL,aJ]).trigger("scroll")}function W(aI,s){if(!aE){return}if(aI<0){aI=0}else{if(aI>j){aI=j}}if(s===c){s=ay.animateScroll}if(s){Q.animate(h,"left",aI,ae)
}else{h.css("left",aI);ae(aI)}}function ae(aI){if(aI===c){aI=h.position().left}al.scrollTop(0);aa=aI;var aL=aa===0,aK=aa==j,aJ=aI/j,s=-aJ*(T-aj);if(P!=aL||k!=aK){P=aL;k=aK;D.trigger("jsp-arrow-change",[ai,aG,P,k])}r(aL,aK);Y.css("left",s);D.trigger("jsp-scroll-x",[-s,aL,aK]).trigger("scroll")}function u(aI,s){if(ay.showArrows){aq[aI?"addClass":"removeClass"]("jspDisabled");af[s?"addClass":"removeClass"]("jspDisabled")}}function r(aI,s){if(ay.showArrows){ax[aI?"addClass":"removeClass"]("jspDisabled");x[s?"addClass":"removeClass"]("jspDisabled")}}function M(s,aI){var aJ=s/(Z-v);V(aJ*i,aI)}function N(aI,s){var aJ=aI/(T-aj);W(aJ*j,s)}function ab(aV,aQ,aJ){var aN,aK,aL,s=0,aU=0,aI,aP,aO,aS,aR,aT;try{aN=b(aV)}catch(aM){return}aK=aN.outerHeight();aL=aN.outerWidth();al.scrollTop(0);al.scrollLeft(0);while(!aN.is(".jspPane")){s+=aN.position().top;aU+=aN.position().left;aN=aN.offsetParent();if(/^body|html$/i.test(aN[0].nodeName)){return}}aI=aA();aO=aI+v;if(s<aI||aQ){aR=s-ay.verticalGutter}else{if(s+aK>aO){aR=s-v+aK+ay.verticalGutter}}if(aR){M(aR,aJ)}aP=aC();aS=aP+aj;if(aU<aP||aQ){aT=aU-ay.horizontalGutter}else{if(aU+aL>aS){aT=aU-aj+aL+ay.horizontalGutter}}if(aT){N(aT,aJ)}}function aC(){return -Y.position().left}function aA(){return -Y.position().top}function K(){var s=Z-v;return(s>20)&&(s-aA()<10)}function B(){var s=T-aj;return(s>20)&&(s-aC()<10)}function ag(){al.unbind(ac).bind(ac,function(aL,aM,aK,aI){var aJ=aa,s=I;Q.scrollBy(aK*ay.mouseWheelSpeed,-aI*ay.mouseWheelSpeed,false);return aJ==aa&&s==I})}function n(){al.unbind(ac)}function aB(){return false}function J(){Y.find(":input,a").unbind("focus.jsp").bind("focus.jsp",function(s){ab(s.target,false)})}function E(){Y.find(":input,a").unbind("focus.jsp")}function S(){var s,aI,aK=[];aE&&aK.push(am[0]);az&&aK.push(U[0]);Y.focus(function(){D.focus()});D.attr("tabindex",0).unbind("keydown.jsp keypress.jsp").bind("keydown.jsp",function(aN){if(aN.target!==this&&!(aK.length&&b(aN.target).closest(aK).length)){return}var aM=aa,aL=I;switch(aN.keyCode){case 40:case 38:case 34:case 32:case 33:case 39:case 37:s=aN.keyCode;aJ();break;case 35:M(Z-v);s=null;break;case 36:M(0);s=null;break}aI=aN.keyCode==s&&aM!=aa||aL!=I;return !aI}).bind("keypress.jsp",function(aL){if(aL.keyCode==s){aJ()}return !aI});if(ay.hideFocus){D.css("outline","none");if("hideFocus" in al[0]){D.attr("hideFocus",true)}}else{D.css("outline","");if("hideFocus" in al[0]){D.attr("hideFocus",false)}}function aJ(){var aM=aa,aL=I;switch(s){case 40:Q.scrollByY(ay.keyboardSpeed,false);break;case 38:Q.scrollByY(-ay.keyboardSpeed,false);break;case 34:case 32:Q.scrollByY(v*ay.scrollPagePercent,false);break;case 33:Q.scrollByY(-v*ay.scrollPagePercent,false);break;case 39:Q.scrollByX(ay.keyboardSpeed,false);break;case 37:Q.scrollByX(-ay.keyboardSpeed,false);break}aI=aM!=aa||aL!=I;return aI}}function R(){D.attr("tabindex","-1").removeAttr("tabindex").unbind("keydown.jsp keypress.jsp")}function C(){if(location.hash&&location.hash.length>1){var aK,aI,aJ=escape(location.hash.substr(1));try{aK=b("#"+aJ+', a[name="'+aJ+'"]')}catch(s){return}if(aK.length&&Y.find(aJ)){if(al.scrollTop()===0){aI=setInterval(function(){if(al.scrollTop()>0){ab(aK,true);b(document).scrollTop(al.position().top);clearInterval(aI)}},50)}else{ab(aK,true);b(document).scrollTop(al.position().top)}}}}function m(){if(b(document.body).data("jspHijack")){return}b(document.body).data("jspHijack",true);b(document.body).delegate("a[href*=#]","click",function(s){var aI=this.href.substr(0,this.href.indexOf("#")),aK=location.href,aO,aP,aJ,aM,aL,aN;if(location.href.indexOf("#")!==-1){aK=location.href.substr(0,location.href.indexOf("#"))}if(aI!==aK){return}aO=escape(this.href.substr(this.href.indexOf("#")+1));aP;try{aP=b("#"+aO+', a[name="'+aO+'"]')}catch(aQ){return}if(!aP.length){return}aJ=aP.closest(".jspScrollable");aM=aJ.data("jsp");aM.scrollToElement(aP,true);if(aJ[0].scrollIntoView){aL=b(a).scrollTop();aN=aP.offset().top;if(aN<aL||aN>aL+b(a).height()){aJ[0].scrollIntoView()}}s.preventDefault()
})}function an(){var aJ,aI,aL,aK,aM,s=false;al.unbind("touchstart.jsp touchmove.jsp touchend.jsp click.jsp-touchclick").bind("touchstart.jsp",function(aN){var aO=aN.originalEvent.touches[0];aJ=aC();aI=aA();aL=aO.pageX;aK=aO.pageY;aM=false;s=true}).bind("touchmove.jsp",function(aQ){if(!s){return}var aP=aQ.originalEvent.touches[0],aO=aa,aN=I;Q.scrollTo(aJ+aL-aP.pageX,aI+aK-aP.pageY);aM=aM||Math.abs(aL-aP.pageX)>5||Math.abs(aK-aP.pageY)>5;return aO==aa&&aN==I}).bind("touchend.jsp",function(aN){s=false}).bind("click.jsp-touchclick",function(aN){if(aM){aM=false;return false}})}function g(){var s=aA(),aI=aC();D.removeClass("jspScrollable").unbind(".jsp");D.replaceWith(ao.append(Y.children()));ao.scrollTop(s);ao.scrollLeft(aI);if(av){clearInterval(av)}}b.extend(Q,{reinitialise:function(aI){aI=b.extend({},ay,aI);ar(aI)},scrollToElement:function(aJ,aI,s){ab(aJ,aI,s)},scrollTo:function(aJ,s,aI){N(aJ,aI);M(s,aI)},scrollToX:function(aI,s){N(aI,s)},scrollToY:function(s,aI){M(s,aI)},scrollToPercentX:function(aI,s){N(aI*(T-aj),s)},scrollToPercentY:function(aI,s){M(aI*(Z-v),s)},scrollBy:function(aI,s,aJ){Q.scrollByX(aI,aJ);Q.scrollByY(s,aJ)},scrollByX:function(s,aJ){var aI=aC()+Math[s<0?"floor":"ceil"](s),aK=aI/(T-aj);W(aK*j,aJ)},scrollByY:function(s,aJ){var aI=aA()+Math[s<0?"floor":"ceil"](s),aK=aI/(Z-v);V(aK*i,aJ)},positionDragX:function(s,aI){W(s,aI)},positionDragY:function(aI,s){V(aI,s)},animate:function(aI,aL,s,aK){var aJ={};aJ[aL]=s;aI.animate(aJ,{duration:ay.animateDuration,easing:ay.animateEase,queue:false,step:aK})},getContentPositionX:function(){return aC()},getContentPositionY:function(){return aA()},getContentWidth:function(){return T},getContentHeight:function(){return Z},getPercentScrolledX:function(){return aC()/(T-aj)},getPercentScrolledY:function(){return aA()/(Z-v)},getIsScrollableH:function(){return aE},getIsScrollableV:function(){return az},getContentPane:function(){return Y},scrollToBottom:function(s){V(i,s)},hijackInternalLinks:b.noop,destroy:function(){g()}});ar(O)}e=b.extend({},b.fn.jScrollPane.defaults,e);b.each(["arrowButtonSpeed","trackClickSpeed","keyboardSpeed"],function(){e[this]=e[this]||e.speed});return this.each(function(){var f=b(this),g=f.data("jsp");if(g){g.reinitialise(e)}else{b("script",f).filter('[type="text/javascript"],:not([type])').remove();g=new d(f,e);f.data("jsp",g)}})};b.fn.jScrollPane.defaults={showArrows:false,maintainPosition:true,stickToBottom:false,stickToRight:false,clickOnTrack:true,autoReinitialise:false,autoReinitialiseDelay:500,verticalDragMinHeight:0,verticalDragMaxHeight:99999,horizontalDragMinWidth:0,horizontalDragMaxWidth:99999,contentWidth:c,animateScroll:false,animateDuration:300,animateEase:"linear",hijackInternalLinks:false,verticalGutter:4,horizontalGutter:4,mouseWheelSpeed:3,arrowButtonSpeed:0,arrowRepeatFreq:50,arrowScrollOnHover:false,trackClickSpeed:0,trackClickRepeatFreq:70,verticalArrowPositions:"split",horizontalArrowPositions:"split",enableKeyboardNavigation:true,hideFocus:false,keyboardSpeed:0,initialDelay:300,speed:30,scrollPagePercent:0.8}})(jQuery,this);
/*!
 * jQuery Cookie Plugin v1.4.1
 * https://github.com/carhartl/jquery-cookie
 *
 * Copyright 2013 Klaus Hartl
 * Released under the MIT license
 */
(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD
		define(['jquery'], factory);
	} else if (typeof exports === 'object') {
		// CommonJS
		factory(require('jquery'));
	} else {
		// Browser globals
		factory(jQuery);
	}
}(function ($) {

	var pluses = /\+/g;

	function encode(s) {
		return config.raw ? s : encodeURIComponent(s);
	}

	function decode(s) {
		return config.raw ? s : decodeURIComponent(s);
	}

	function stringifyCookieValue(value) {
		return encode(config.json ? JSON.stringify(value) : String(value));
	}

	function parseCookieValue(s) {
		if (s.indexOf('"') === 0) {
			// This is a quoted cookie as according to RFC2068, unescape...
			s = s.slice(1, -1).replace(/\\"/g, '"').replace(/\\\\/g, '\\');
		}

		try {
			// Replace server-side written pluses with spaces.
			// If we can't decode the cookie, ignore it, it's unusable.
			// If we can't parse the cookie, ignore it, it's unusable.
			s = decodeURIComponent(s.replace(pluses, ' '));
			return config.json ? JSON.parse(s) : s;
		} catch(e) {}
	}

	function read(s, converter) {
		var value = config.raw ? s : parseCookieValue(s);
		return $.isFunction(converter) ? converter(value) : value;
	}

	var config = $.cookie = function (key, value, options) {

		// Write

		if (value !== undefined && !$.isFunction(value)) {
			options = $.extend({}, config.defaults, options);

			if (typeof options.expires === 'number') {
				var days = options.expires, t = options.expires = new Date();
				t.setTime(+t + days * 864e+5);
			}

			return (document.cookie = [
				encode(key), '=', stringifyCookieValue(value),
				options.expires ? '; expires=' + options.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
				options.path    ? '; path=' + options.path : '',
				options.domain  ? '; domain=' + options.domain : '',
				options.secure  ? '; secure' : ''
			].join(''));
		}

		// Read

		var result = key ? undefined : {};

		// To prevent the for loop in the first place assign an empty array
		// in case there are no cookies at all. Also prevents odd result when
		// calling $.cookie().
		var cookies = document.cookie ? document.cookie.split('; ') : [];

		for (var i = 0, l = cookies.length; i < l; i++) {
			var parts = cookies[i].split('=');
			var name = decode(parts.shift());
			var cookie = parts.join('=');

			if (key && key === name) {
				// If second argument (value) is a function it's a converter...
				result = read(cookie, value);
				break;
			}

			// Prevent storing a cookie that we couldn't decode.
			if (!key && (cookie = read(cookie)) !== undefined) {
				result[name] = cookie;
			}
		}

		return result;
	};

	config.defaults = {};

	$.removeCookie = function (key, options) {
		if ($.cookie(key) === undefined) {
			return false;
		}

		// Must not alter options, thus extending a fresh object...
		$.cookie(key, '', $.extend({}, options, { expires: -1 }));
		return !$.cookie(key);
	};

}));

var ncLang = {
  // управление правами пользователя
  UserSelectRights : "Выберите тип прав.",
  UserHelpDirector : "Пользователь с правами «Директор» имеет полные права на управление всеми сайтами, пользователями и инструментами в системе.",
  UserHelpSupervisor : "Пользователь с правами «Супервизор» имеет полные права на управление всеми сайтами, пользователями и инструментами в системе, за исключением управления пользователями, имеющими права «Директор».",
  UserHelpEditor : "Пользователь с правами «Редактор» имеет права на управление только назначенного сайта, раздела или компонента в разделе. Действия изменения, включения/выключения, удаления относятся только ко своим собственным объектам.",
  UserHelpModerator : "Пользователь с правами «Управление пользователями» имеет возможность управлять (добавлять, изменять, удалять) пользователями, не имеющими прав в системе.",
  UserHelpClassificator : "Пользователь с правами «Администратор списка» имеет права на управление списками.",
  UserHelpBanned : "Пользователь с правами этой категории будет ограничен в выбранных вами действиях.",
  UserHelpGuest : "Пользователь с правом «Гость» может \"ходить\" по системе администрирования, однако ему запрещено производить какие-либо операции с системой (демонстрационный режим).",
  UserHelpSubscriber : "Пользователь с правом «Подписчик» имеет право подписаться на выбранную рассылку.",
  UserPasswordsMismatch : "Пароли не совпадают!",
  WarnAddTemplate : "Альтернативная форма добавления не пустая! Заменить текст в этом поле на новый?",
  WarnEditTemplate : "Альтернативная форма изменения не пустая! Заменить текст в этом поле на новый?",
  WarnDeleteTemplate : "Альтернативная форма удаления не пустая! Заменить текст в этом поле на новый?",
  WarnSearchTemplate : "Форма поиска  объектов не пустая! Заменить текст в этом поле на новый?",
  WarnFullSearchTemplate : "Форма поиска перед списком объектов не пустая! Заменить текст в этом поле на новый?",
  WarnAddCond : "Поле \"условие добавления\" не пустое! Заменить текст в этом поле на новый?",
  WarnEditCond : "Поле \"условие изменения\" не пустое! Заменить текст в этом поле на новый?",
  WarnAddActionTemplate : "Поле \"действие после добавления\" не пустое! Заменить текст в этом поле на новый?",
  WarnEditActionTemplate : "Поле \"действие после изменения\" не пустое! Заменить текст в этом поле на новый?",
  WarnCheckActionTemplate : "Поле \"действие после включения\" не пустое! Заменить текст в этом поле на новый?",
  WarnDeleteActionTemplatee : "Поле \"действие после удаления\" не пустое! Заменить текст в этом поле на новый?",
  WarnAuthMail : "Восстановить значение по умолчанию?",
  WarnReplace : "Текущее значение шаблона будет заменено. Продолжить?",
  FieldFromUser : "Поля из системной таблицы Пользователи",
  Drop : "Удалить",
  DropHard : "Удалить безвозвратно?",
  Cancel : "Отмена",
  AddSubsection: "добавить подраздел",
  DebugCheckData: "Проверка данных",
  MessageError: "Ошибка",
  NetcatCMS: "Система управления NetCat",
  RemindSaveWarning: "У вас есть несохраненные изменения. Продолжить без сохранения?",
  Close: "Закрыть",
  DragAndDropConfirm: {
    buttons: { inside: 'Переместить', default: 'Всё верно' },
    site_below_site: { title: 'Изменение сортировки сайтов', text: 'Сайт «%1» в списках сайтов будет располагаться после сайта «%2».' },
    sub_inside_sub: { title: 'Перемещение раздела', text: 'Раздел «%1» будет подразделом в разделе «%2».' },
    sub_below_sub: { title: 'Изменение сортировки разделов', text: 'Раздел «%1» в списках разделов будет располагаться после раздела «%2».' },
    sub_firstIn_sub: { title: 'Изменение сортировки разделов', text: 'Раздел «%1» будет первым подразделом в разделе «%2».' },
    sub_inside_site: { title: 'Перемещение раздела', text: 'Раздел «%1» будет располагаться в корне сайта «%2».' },
    sub_firstIn_site: { title: 'Изменение сортировки разделов', text: 'Раздел «%1» будет первым в корне сайта «%2».' },
    subclass_inside_sub: { title: 'Перемещение инфоблока', text: 'Инфоблок «%1» будет перемещён в раздел «%2».' },
    message_inside_sub: { title: 'Перемещение объекта', text: '«%1» будет перемещён в инфоблок в разделе «%2».' },
    message_inside_message: { title: 'Изменение сортировки объектов', text: '«%1» при сортировке по умолчанию будет располагаться после «%2».', button: 'Всё верно' },
    template_inside_template: { title: 'Изменение иерархии макетов', text: 'Макет «%1» станет наследником макета «%2».', button: 'Всё верно' },
    template_below_template: { title: 'Изменение сортировки макетов', text: 'Макет «%1» в списках макетов будет располагаться после макета «%2».' },
    template_firstIn_template: { title: 'Изменение сортировки макетов', text: 'Макет «%1» в списках макетов будет располагаться первым в списке дочерних макетов «%2».' },
    field_below_field: { title: 'Изменение сортировки полей', text: 'Поле «%1» в списке полей и стандартных формах будет располагаться ниже поля «%2».' },
    systemfield_below_systemfield: { title: 'Изменение сортировки полей', text: 'Поле «%1» в списке полей и стандартных формах будет располагаться ниже поля «%2».' },
    dataclass_below_dataclass: { title: 'Изменение сортировки компонентов', text: 'Компонент «%1» в списках компонентов будет располагаться ниже компонента «%2».' },
    dataclass_inside_group: { title: 'Изменение группы компонента', text: 'Компонент «%1» будет перемещён в группу «%2».' }
  }
};
(function(c,g){var b=function(a,h){return typeof a===h};if(b(c.nc,"function"))return c.nc;"object"!==typeof JSON&&(JSON={});JSON.stringify=JSON.stringify||function(a){var d=typeof a;if("object"!==d||null===a)return"string"===d&&(a='"'+a+'"'),String(a);var c,e=[],f=a&&a.constructor===Array;for(c in a){var b=a[c];d=typeof b;"string"===d?b='"'+b+'"':"object"===d&&null!==b&&(b=JSON.stringify(b));e.push((f?"":'"'+c+'":')+String(b))}return(f?"[":"{")+String(e)+(f?"]":"}")};var f=!1,e={netcat_path:"undefined"===
typeof NETCAT_PATH?"/netcat/":NETCAT_PATH,admin_path:"undefined"===typeof ADMIN_PATH?"/netcat/admin/":ADMIN_PATH,custom_scroll:!0},k=!1,a=function(){return g.apply(null,arguments)};a.$=g;a.window=c;a.root=a;a.view={};a.process_list={};b(c.parent.nc,"function")&&(a.root=c.parent.nc.root);a.is=b;a.debug=function(d,h){a.is_bool(d)&&!a.is_undefined(d)?f=d:f&&console.log(d+":",h);return f};a.key_exists=function(a,h){return h?h.hasOwnProperty(a):!1};a.is_object=function(a){return b(a,"object")};a.is_undefined=
function(a){return b(a,"undefined")};a.is_bool=function(a){return b(a,"boolean")};a.is_string=function(a){return b(a,"string")};a.is_function=function(a){return b(a,"function")};a.is_empty=function(a){switch(!0){case !a:return!0;case a.length&&0<a.length:return!1;case 0===a.length:return!0}for(var d in a)if(a.hasOwnProperty(d))return!1;return!0};a.is_touch=function(){var a=navigator.userAgent.toLowerCase(),h=["iphone","ipad","ipod","android"],c;for(c in h)if(-1!==a.indexOf(h[c]))return h[c];return!1};
a.is_root=function(){return a.root===a};a.ext=function(d,c,b){b=b||"root";a.is_undefined(a[b][d])?(a[b][d]=c,a.key_exists("__init",c)&&a.is_function(c.__init)&&c.__init()):"root"!==b&&(a[b][d]=c);"root"===b&&a.set_global(d)};a.set_global=function(d,c){c&&(a.root[d]=c);a[d]=a.root[d];for(var b in a.view)a.view[b][d]=a.root[d]};a._view="";a.register_view=function(d){for(var c in a.root.process_list)a.root.process_list[c].view===d&&delete a.root.process_list[c];a.process_stop();k=d;a.ext(d,a,"view");
a.event.call(["nc","register_view"],d)};a.process_start=function(d,c){a.is_empty(a.root.process_list)&&a.event.call(["nc","loading","start"]);a.root.process_list[d]={view:k,obj:c};a.ui.loader_show(c);a.event.call(["nc","process","start"],d,c)};a.process_stop=function(d,c){var b;d&&a.key_exists(d,a.root.process_list)&&((b=a(a.root.process_list[d].obj))&&a.ui.loader_hide(b,c),a.event.call(["nc","process","stop"],d,b),delete a.root.process_list[d]);a.is_empty(a.root.process_list)&&(a.ui.loader_hide(null,
c),a.event.call(["nc","loading","stop"]))};a.config=function(d,c){if(a.is_undefined(d))return e;if(!a.is_undefined(c))e[d]=c;else if(a.is_object(d)){for(var b in d)e[b]=d[b];return e}return e[d]};a.load_dialog=function(c,b,f){return(new a.ui.modal_dialog({url:c,parameters:b||{admin_modal:1,isNaked:1},method:f})).open()};a.load_script=function(a,c){return g.ajax({url:a,dataType:"script",cache:!0,async:!!c})};a.set_global("debug");a.set_global("view");a.set_global("config");c.nc=a})(window,jQuery);
(function(c){var g={},b=function(b,e){c.is_undefined(g[b])&&(g[b]=[]);g[b].push(e)};b.selector=[];b.call=function(c){b.selector=c.slice();var e,f,a=[],d="";for(e in c)d=(d?d+".":"")+c[e],a.unshift(d);d=[].slice.call(arguments);d[0]=b;for(e in a)if(g[a[e]])for(f in g[a[e]])g[a[e]][f].apply(null,d)};c.ext("event",b)})(nc);
(function(c){var g=!1,b=function(){};b.__init=function(){c.event(["nc.process.stop"],function(f,e){if("loadIframe()"===e)(f=c("#mainViewIframe"))&&f.attr("title",c("#mainViewHeader").text());else if("tree"===e.split(".")[0]&&c.view&&c.view.tree)return b.accessibility_link(c.view.tree("a"))})};b.loader_show=function(b){b&&c(b).addClass("nc--loading");g&&clearTimeout(g);c.root("#nc-navbar-loader").show()};b.loader_hide=function(b,e){e=e||300;b?setTimeout(function(){b.removeClass("nc--loading")},e):
g=setTimeout(function(){c.root("#nc-navbar-loader").hide()},e)};b.ext=function(b,e){c.root.ui[b]=e};b.custom_scroll=function(b){return c.config("custom_scroll")&&b.length?b.jScrollPane({autoReinitialise:!0}):!1};b.accessibility_link=function(b){b.each(function(){var b=c(this),f=b.attr("title"),a=this.innerText;a=f?f:a;if(!f){if(!a)return c.debug("badlink",b);f||b.attr("title",a)}})};c(function(){b.accessibility_link(c("a"));c(document).on("click","div.nc-panel-toggle",function(){c(this).parents("div.nc-panel").toggleClass("nc--open nc--close")})});
c.ext("ui",b)})(nc);

(function(){function f(a){if(!(this instanceof f))return new f(a);this.options=c.extend(!0,{},this.options);this.set_options(a);this.options.url||(this.is_loaded=!0);return this}if("undefined"!==typeof nc&&nc===nc.root){var c=nc.root.$;c(window).on("resize.modal_dialog",function(){var a=c(".nc-modal-dialog:visible").data("modal_dialog");a&&a.resize&&a.resize()});var h=null,m=function(){if(!1===c.modal.onCloseCheck())return c.modal.impl.occb=!1,c.modal.impl.bindEvents(),!1;var a=f.get_opened_dialog();
if(null!==a){var b=a.options.persist,d=c("#simplemodal-placeholder");b&&this.d.placeholder?d.replaceWith(this.d.data.removeClass("simplemodal-data").css("display",this.display)):(d.remove(),a.dialog_container.remove());c("#simplemodal-container, #simplemodal-overlay").remove();this.d={};h=null}},k=function(a){return'[data-tab-id="'+a+'"]'},l=function(a,b,c){a&&((new RegExp("[?&]"+b+"=")).test(a)||(a+=(0<=a.indexOf("?")?"&":"?")+b+"="+c));return a},n=function(a){return"boolean"!=typeof a?!/^(no|false|0)$/i.test(a.toString()):
a};f.get_opened_dialog=function(){return h&&h.is_open?h:null};f.get_current_dialog=function(){return h};f.prototype={constructor:f,options:{url:null,parameters:null,persist:!1,confirm_close:!0,on_show:c.noop,on_resize:c.noop,on_submit_response:null,width:null,height:null,min_width:600,max_width:1200,full_markup:'<div class="nc-modal-dialog"><div class="nc-modal-dialog-header"><h2>&nbsp;</h2></div><div class="nc-modal-dialog-body"></div><div class="nc-modal-dialog-footer"></div></div>',hidden_tabs:null,
show_close_button:!0},loaded_markup:null,dialog_container:null,parts:{header:".nc-modal-dialog-header",title:".nc-modal-dialog-header h2",header_tabs:".nc-modal-dialog-header-tabs",body:".nc-modal-dialog-body",body_tabs:".nc-modal-dialog-body-tab",footer:".nc-modal-dialog-footer"},is_loaded:!1,is_open:!1,are_tabs_initialized:!1,has_header:!0,set_options:function(a){this.options=c.extend(this.options,a)},set_option:function(a,b){this.options[a]=b},get_option:function(a){return this.options[a]},load:function(){var a=
this;nc.process_start("nc.ui.modal_dialog.load()");return c.ajax({method:this.options.method||"GET",url:this.options.url,data:c.extend({isNaked:1},this.options.parameters||{})}).done(function(b){a.loaded_markup=c.trim(b)}).always(function(){a.is_loaded=!0;nc.process_stop("nc.ui.modal_dialog.load()",0)})},create:function(){if(!this.is_loaded)return this.load().done(c.proxy(this,"create"));var a=this.options,b;if(this.loaded_markup){var d=c(this.loaded_markup);d.is(".nc-modal-dialog")?b=d:(d=d.find(".nc-modal-dialog"),
d.length&&(b=d))}b||(b=c(a.full_markup),this.loaded_markup&&b.find(".nc-modal-dialog-body").append(this.loaded_markup));a=b.find("script").remove();h=this;this.dialog_container=b.hide().data("modal_dialog",this).appendTo("body");this.get_part("header").length||(this.dialog_container.addClass("nc-modal-dialog-without-header"),this.has_header=!1);this.init_options();this.init_close_button();this.init_tabs();this.init_forms();this.init_buttons();b.append(a);return c.Deferred().resolve()},init_options:function(){var a=
this.options,b=this.dialog_container,d;for(d in a){var e=b.data(d.replace(/_/g,"-"));void 0!==e&&e.toString().length&&(a[d]=e)}b=this.options.hidden_tabs;null===b?a.hidden_tabs=[]:c.isArray(b)||(a.hidden_tabs=[],c.each(b.match(/[\w-]+/g),function(b,c){a.hidden_tabs.push(c)}));for(var g in{confirm_close:1,show_close_button:1})a[g]=n(a[g])},init_close_button:function(){this.options.show_close_button&&c('<a class="nc-modal-dialog-header-close-button" title="'+ncLang.Close+'" />').click(c.proxy(this,
"close")).appendTo(this.get_part("header"))},init_buttons:function(){var a=this,b=this.get_part("footer").find("button").off("click.modal_dialog");b.filter("[data-action=close]").on("click.modal_dialog",c.proxy(this,"close"));b.filter("[data-action=submit]").on("click.modal_dialog",function(){c(this).hasClass("nc--loading")||(nc.process_start("nc.ui.modal_dialog.submit_form()",this),a.submit_form())});if("undefined"!==typeof nc_autosave_use&&1==nc_autosave_use&&(InitAutosave("adminForm"),null!==autosave&&
"undefined"!==typeof autosave))b.filter("[data-action=save-draft]").on("click.modal_dialog",function(a){a.preventDefault();c(this).addClass("nc--loading");autosave.saveAllData(autosave)})},init_tabs:function(){if(!this.are_tabs_initialized){this.are_tabs_initialized=!0;var a=this,b=this.get_part("body").find("[data-tab-caption]");a.dialog_container.toggleClass("nc-modal-dialog-without-tabs",0==b.length);if(b.length){var d=this.get_part("header_tabs");d.length||(d=c('<div class="nc-modal-dialog-header-tabs"/>').appendTo(this.get_part("header")));
var e=d.children("ul"),g=1;e.length||(e=c("<ul/>").appendTo(d));b.addClass("nc-modal-dialog-body-tab").hide().each(function(){var b=c(this).data("tab-id")||"tab"+g++,d=c(this).attr("data-tab-id",b);c("<li>",{"data-tab-id":b,html:d.data("tab-caption")}).appendTo(e).click(function(b){a.change_tab(c(b.target).data("tab-id"))})});c.each(this.options.hidden_tabs,function(b,c){a.hide_tab(c)});this.change_tab(b.eq(0).data("tab-id"))}}},get_form:function(){var a=this.find("#adminForm");a.length||(a=this.find("form").first());
return a},init_forms:function(){InitTransliterate();var a=c.proxy(this,"process_form_submit_response");this.find("form").each(function(){var b=c(this);b.ajaxForm({beforeSerialize:nc_save_editor_values,success:a,iframe:!0});var d=b.attr("action"),d=l(d,"isNaked",1),d=l(d,"admin_modal",1);b.attr("action",d)})},submit_form:function(a){c.modal.nc_modal_confirm=!1;c.modal.confirmed=!0;a=a?c(a):this.get_form();a.submit()},process_form_submit_response:function(a,b,d,e){nc.process_stop("nc.ui.modal_dialog.submit_form()");
return(c.isFunction(this.options.on_submit_response)?this.options.on_submit_response:this.default_form_submit_response_handler).call(this,a,b,d,e)},default_form_submit_response_handler:function(a,b,d,e){if(b=nc_check_error(a))this.show_error(b);else{b=e.find("input[name=cc]").val()||e.find("input[name=infoblock_id]").val();e=window.location;d=(d=/^NewHiddenURL=(.+?)$/m.exec(a))?c.trim(d[1]):null;var g=/^SetLocationHash=(.*?)$/m.exec(a);g&&(window.location.hash=g[1]);/^ReloadPage=1$/m.test(a)?d&&!/\.php/.test(window.location.pathname)?
((a=/\/([^\/]+)$/.exec(e.pathname))&&(d+=a[1]),e.pathname=d):e.reload(!0):b&&nc_update_admin_mode_infoblock(b,c.proxy(this,"destroy"))}},show_error:function(a){var b=this.get_part("footer"),d=c("<div class='nc-alert nc--red' />").append(c("<div class='nc-alert-close nc-icon-s nc--remove'></div>").click(function(){d.remove()})).append("<i class='nc-icon-l nc--status-error'></i>").append(a).appendTo(b)},change_tab:function(a){a=k(a);this.get_part("header_tabs").find("li").removeClass("nc--active").filter(a).addClass("nc--active").show();
this.get_part("body_tabs").hide().filter(a).show();return this},hide_tab:function(a){a=k(a);this.get_part("header_tabs").find("li"+a).hide();this.get_part("body_tabs").filter(a).hide();return this},get_tab:function(a){return this.get_part("body").find(k(a))},get_current_tab:function(){var a=this.get_part("body_tabs");return a.length?a.filter(":visible"):this.get_part("body")},hide_header_tabs:function(){this.dialog_container.addClass("nc-modal-dialog-without-tabs");return this},show_header_tabs:function(){this.dialog_container.removeClass("nc-modal-dialog-without-tabs");
return this},open:function(){var a=f.get_opened_dialog();a&&a.close();this.dialog_container?this.when_ready_to_open():this.create().done(c.proxy(this,"when_ready_to_open"));return this},when_ready_to_open:function(){c.modal(this.dialog_container,{onShow:c.proxy(this,"on_show"),onClose:m,autoPosition:!1,persist:this.options.persist,closeHTML:"",nc_confirm_close:this.options.confirm_close});this.is_open=!0;this.resize()},on_show:function(){this.options.on_show(this)},close:function(){if(this.is_open){if(!1===
c.modal.onCloseCheck())return!1;c.modal.close();this.is_open=!1}},resize:function(){if(!this.is_open)return this;var a=c(window.top.window),b=this.options,d=a.width(),e=window.innerHeight||window.clientHeight||a.height(),g=e-200,f=b.width||d-200,h=b.height||g,k="auto"==h,a=c("#simplemodal-container"),l=Math.ceil;f>b.max_width&&(f=b.max_width);!b.width&&f<b.min_width&&(f=b.min_width);a.css({width:f+"px",height:h+(k?"":"px"),left:l((d-f)/2-10)+"px",top:"120px"}).find(".simplemodal-wrap").css("overflow",
"auto");k&&(a.height()>g&&a.css("height",g+"px"),a.css("top",Math.max(l((e-a.height())/2),100)+"px"));d=this.get_part("body").find(".nc--fill");d.length&&d.css("height",a.height()+"px");b.on_resize();return this},destroy:function(){this.close();window.CKEDITOR&&this.dialog_container.find("textarea").each(function(){c(this).siblings(".cke_editor_"+this.name).length&&CKEDITOR.remove(CKEDITOR.instances[this.name])});this.dialog_container.remove()},clear_all:function(){for(var a in this.parts)this.clear(a)},
clear_part:function(a){this.get_part(a).empty()},find:function(a){this.dialog_container||this.create();return this.dialog_container.find(a)},get_part:function(a){return this.find(this.parts[a])}};nc.ext("modal_dialog",f,"ui")}})();

!function(t,$){var n=0,e=300,a=function(t){var a=t.data("content"),r;if(a){var i=t.data("id");if(i){if(r=$("#"+i),"none"===r.css("display"))return r.fadeIn(e),!0;if(r.length)return!1}var d=20,c={t:"b",b:"t",r:"l",l:"r"},l=t.data("style"),u=t.data("z-index")||1,f=t.data("width"),s=o(t.data("placement"),"right-center"),p=t.offset();r=$(document.createElement("DIV")).addClass("nc-popover"+(l?" nc--"+l:"")).html(a).css({"z-index":u,position:"absolute",display:"none"}),f&&r.width(f),n++,i="nc_popover_"+n,r.attr("id",i),t.attr("data-id",i),$("body").append(r);var v=s[0],h=s[1],b=t.outerWidth(),g=t.outerHeight(),m=r.outerWidth(),y=r.outerHeight();return"r"===v&&(p.left+=b+d),"l"===v&&(p.left-=m+d),"t"===v&&(p.top-=y+d),"b"===v&&(p.top+=g+d),("rc"===s||"lc"===s)&&(p.top-=y/2-g/2),("rb"===s||"lb"===s)&&(p.top-=y-g),("tc"===s||"bc"===s)&&(p.left-=m/2-b/2),("tr"===s||"br"===s)&&(p.left-=m-b),r.addClass("nc--"+c[v]+h).css(p).fadeIn(e),r}},r=function(t){var n=t.data("id");n&&$("#"+n).fadeOut(e)},o=function(t,n){t||(t=n);var e=t.split(/[- .]/);for(var a in e)e[a]=e[a][0];return e=e.join(""),1===e.length&&(e+="c"),e},i=function(t){$(t).each(function(){var t=$(this),n=t.data("trigger")||"click";"load"===n&&(n+=" click"),t.on(n,function(){return a(t)===!1&&r(t),!1}).load(),"mouseover"===n&&t.mouseout(function(){r(t)})})};t.ext("popover",i,"ui")}(nc,nc.$);
!function(t,$){var e=0,i={padding:10},o=function(t,e){var i={},o;for(o in t)i[o]=t[o];for(o in e)i[o]=e[o];return i},a=function(t,e){var i,o=t.padding;if(t.axis)i={left:t.axis[0]-o,top:t.axis[1]-o},i.width=t.axis[2]+2*o,i.height=t.axis[3]+2*o;else if(e){var a=$(e);i=a.offset(),i.top-=o,i.left-=o,i.width=a.outerWidth()+2*o,i.height=a.outerHeight()+2*o}i.position="absolute",i["z-index"]=999,n.ctx.clearRect(i.left,i.top,i.width,i.height);var r=$(document.createElement("div")).css(i);r.data("z-index",t["z-index"]||999);for(var s in t)r.data(s,t[s]);n.$overlay_objet.append(r),n.popovers.push(r)},n={};n.overlay_id=0,n.$overlay_objet=!1,n.$canvas=!1,n.ctx=!1,n.popovers=[],n.init=function(t){this.settings=o(i,t),e++;var a=$("html"),n=$(document.createElement("canvas")),r=n[0].getContext("2d");return this.$canvas=n,this.ctx=r,this.overlay_id="nc_help_overlay_"+e,this.$overlay_objet=$(document.createElement("div")).attr("id",this.overlay_id).hide(),this.$overlay_objet.append(this.$canvas),n.css({position:"absolute",top:0,left:0,"z-index":999}).attr("width",a.outerWidth()).attr("height",a.outerHeight()),r.fillStyle="rgba(0, 0, 0, 0.25)",r.fillRect(0,0,n[0].width,n[0].height),$("body").append(this.$overlay_objet),this},n.add=function(t){return t=o(this.settings,t),t.target?$(t.target).each(function(){a(t,this)}):t.axis&&a(t),this},n.show=function(){return this.$overlay_objet.show(function(){for(var e in n.popovers)t.ui.popover(n.popovers[e])}),this},n.hide=function(){for(var t in n.popovers)$("#"+n.popovers[t].data("id")).hide();return this.$overlay_objet.hide(),this},t.ext("help_overlay",function(t){return n.init(t)},"ui")}(nc,nc.$);


function transliterate(word, isUrl) {

    var tr = {"А": "A", "а": "a", "Б": "B", "б": "b",
        "В": "V", "в": "v", "Г": "G", "г": "g",
        "Д": "D", "д": "d", "Е": "E", "е": "e",
        "Ё": "E", "ё": "e", "Ж": "Zh", "ж": "zh",
        "З": "Z", "з": "z", "И": "I", "и": "i",
        "Й": "Y", "й": "y", "КС": "X", "кс": "x",
        "К": "K", "к": "k", "Л": "L", "л": "l",
        "М": "M", "м": "m", "Н": "N", "н": "n",
        "О": "O", "о": "o", "П": "P", "п": "p",
        "Р": "R", "р": "r", "С": "S", "с": "s",
        "Т": "T", "т": "t", "У": "U", "у": "u",
        "Ф": "F", "ф": "f", "Х": "H", "х": "h",
        "Ц": "Ts", "ц": "ts", "Ч": "Ch", "ч": "ch",
        "Ш": "Sh", "ш": "sh", "Щ": "Sch", "щ": "sch",
        "Ы": "Y", "ы": "y", "Ь": "'", "ь": "'",
        "Э": "E", "э": "e", "Ъ": "'", "ъ": "'",
        "Ю": "Yu", "ю": "yu", "Я": "Ya", "я": "ya"};


    var result = "";

    result = word.split('').map(function(char) {
        return tr[char] || char;
    }).join("");

    if (isUrl == 'yes') {
        result = result
                .toLowerCase() // change everything to lowercase
                .replace(/^\s+|\s+$/g, "") // trim leading and trailing spaces
                .replace(/[_|\s]+/g, "-") // change all spaces and underscores to a hyphen
                .replace(/[^a-z\u0400-\u04FF0-9-]+/g, "") // remove all non-cyrillic, non-numeric characters except the hyphen
                .replace(/[-]+/g, "-") // replace multiple instances of the hyphen with a single instance
                .replace(/^-+|-+$/g, "") // trim leading and trailing hyphens
                .replace(/[-]+/g, "-")
    }
    return result;
}

function InitTransliterate() {
    if ($nc("[data-type='transliterate']").length) {
        $nc.each($nc("[data-type='transliterate']"), function() {
            $nc(this).after('<span class="nc-transliterate-action nc-icon nc--refresh" title="Транслитерация названия"></span>');
            $nc(this).next('.nc-transliterate-action').click(function(e) {
                e.preventDefault();
                elemName = $nc(this).prev().attr('data-from');
                isUrl = $nc(this).prev().attr('data-is-url');
                $nc(this).prev().val(transliterate($nc('[name="' + elemName + '"]').val(), isUrl));
            });
        });
    }
}
$nc(document).ready(function() {
    InitTransliterate();
});
/**
 * Original PHP Engine: http://rmcreative.ru/blog/post/tipograf
 * JS Lite Version
 */

//typographus object
var Typographus_Lite = new Object();
//special characters
Typographus_Lite.sp_chars = {
  nbsp     : '&nbsp;',
  lnowrap  : '<span style="white-space:nowrap">',
  rnowrap  : '</span>',
  lquote   : '«',
  rquote   : '»',
  lquote2  : '„',
  rquote2  : '“',
  mdash    : '—',
  ndash    : '–',
  minus    : '–', // width equals to +, present in every font
  hellip   : '…',
  copy     : '©',
  trade    : '™',
  apos     : '&#39;',   // см. http://fishbowl.pastiche.org/2003/07/01/the_curse_of_apos
  reg      : '®',
  multiply : '&times;',
  frac_12  : '&frac12;',
  frac_14  : '&frac14;',
  frac_34  : '&frac34;',
  plusmn   : '±',
  rarr     : '→',
  larr     : '←',
  rsquo    : '&rsquo;'
};

//safeblocks (as parts of regular expressions)
//ADD YOUR SAFEBLOCKS HERE AS 'start' : 'end' PAIR
Typographus_Lite.safeblocks = {
  '<safeblock>' : '<\\/safeblock>',
  '<pre[^>]*>' : '<\\/pre>',
  '<style[^>]*>' : '<\\/style>',
  '<script[^>]*>' : '<\\/script>',
  '<code[^>]*>' : '<\\/code>',
  '<!--' : '-->',
  '<\\?php' : '\\?>',
  '<drupal6>' : '<\\/drupal6>',
  '<php>' : '<\\/php>',
  '<cpp>' : '<\\/cpp>',
  '<object>' : '<\\/object>',
  '<javascript>' : '<\\/javascript>',
  '<qt>' : '<\\/qt>'
};


Typographus_Lite.safeblock_storage = [];

//safeblock stacking
__stack = function (match) {
  //get length
  var i = Typographus_Lite.safeblock_storage.length;
  //add match
  Typographus_Lite.safeblock_storage[i] = match;
  //return replacement
  return "<" + i + ">";
}

//safeblock processing
Typographus_Lite.remove_safeblocks = function(str) {
  //empty storage
  this.safeblock_storage = [];
  var pattern = '(';
  for (var key in this.safeblocks) {
    pattern += "(" + key + "(.|\\n)*?" + this.safeblocks[key] + ")|";
  }
  pattern += '<[^>]*[\\s][^>]*>)';
  str = str.replace(RegExp(pattern, "gim"), __stack);
  return str;
}

//safeblock returning
Typographus_Lite.return_safeblocks = function(str) {
  for (var i=0; i<this.safeblock_storage.length; i++) {
    var block = "<" + i + ">";
    str = str.replace(block, this.safeblock_storage[i]);
  }
  return str;
}


/**
 *
 *  This function calls typo_text to process string str
 *
 */
Typographus_Lite.process = function(str) {
  str = this.remove_safeblocks(str);
  str = this.typo_text(str);
  str = this.return_safeblocks(str);
  return str;
}


/**
 *
 * This function applies array of rules to string str
 *
 */
Typographus_Lite.apply_rules = function(rules, str) {
  for (var key in rules) {
    var rule = new RegExp(key, "gim"); //with global, case-insensitive, multiline flags
    var newstr = rules[key];
    str = str.replace(rule, newstr);
  }
  return str;
}	


/**
 *
 * The main typographus function
 *
 */
Typographus_Lite.typo_text = function(str) {
  var sym = this.sp_chars;
  var html_tag = '(?:<.*?>)';
  var hellip = '\\.{3,5}';
  var word = '[a-zA-Z_абвгдеёжзийклмнопрстуфхцчшщьыъэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯ0123456789]';
  var phrase_begin = "(?:" + hellip + "|" + word + '|\\n)';
  var phrase_end = '(?:[)!?.:;#*\\\]|$|'+ word + '|' + sym['rquote'] + '|' + sym['rquote2'] + '|&quot;|"|' + sym['hellip'] + '|' + sym['copy'] + '|' + sym['trade'] + '|' + sym['apos'] + '|' + sym['reg'] + '|\\\')';
  var any_quote = "(?:" + sym['lquote'] + "|" + sym['rquote'] + "|" + sym['lquote2'] + "|" + sym['rquote2'] + "|&quot;|\\\")";
  //symbols
  var rules_symbols = {};
  //(c)
  rules_symbols['\\((c|с)\\)'] = sym['copy'];
  //(r)
  rules_symbols['\\(r\\)'] = sym['reg'];
  //tm
  rules_symbols['\\(tm\\)'] = sym['trade'];
  //hellip
  rules_symbols[hellip] = sym['hellip'];
  //+-
  rules_symbols['([^\\+]|^)\\+-'] = '$1' + sym['plusmn'];
  //->
  rules_symbols['([^-]|^)-(>|&gt;)'] = '$1' + sym['rarr'];
  //<-
  rules_symbols['([^<]|^)(<|&lt;)-'] = '$1' + sym['larr'];
  //quotes
  var rules_quotes = {};
  rules_quotes['([^"]\\w+)"(\\w+)"'] = '$1 "$2"';
  rules_quotes['"(\\w+)"(\\w+)'] = '"$1" $2';
  rules_quotes["(" + html_tag + "*?)(" + any_quote + ")(" + html_tag + "*" + phrase_begin + html_tag + "*)"] = '$1' + sym['lquote'] + '$3';
  rules_quotes["(" + html_tag + "*(?:" + phrase_end + "|[0-9]+)" + html_tag + "*)(" + any_quote + ")(" + html_tag + "*" + phrase_end + html_tag + "*|\\s|$$|\\n|[,<-])"] = '$1' + sym['rquote'] + '$3';

  //main rules
  var rules_main = {};
  //fix dashes
  rules_main[' +(?:--?|—|&mdash;)(?=\\s)'] = sym['nbsp'] + sym['mdash'];
  rules_main['^(?:--?|—|&mdash;)(?=\\s)'] = sym['mdash'];
  rules_main['(?:^|\\s+)(?:--?|—|&mdash;)(?=\\s)'] = "\n" + sym['nbsp'] + sym['mdash'];
  //fix digit-dash
  rules_main['(\\d{1,})(-)(?=\\d{1,})'] = '$1' + sym['ndash'];
  //glue percent
  rules_main['([0-9]+)\\s+%'] = '$1%';

  //apply different rules
  str = this.apply_rules(rules_quotes, str);
  str = this.apply_rules(rules_main, str);
  str = this.apply_rules(rules_symbols, str);

  return str;
}

// Resize modal on window.resize
//
// Если у элемента, из которого был создан modal, в качестве data-свойства onResize
// установлена функция [.data('onResize', someFunction)], она будет выполнена при
// событии resize
function nc_register_modal_resize_handler() {
    if (!$nc._resize_modal_event) {
        $nc(window).resize(function() {
            var modal = $nc('#simplemodal-container').not(".simplemodal-container-fixed-size");
            if (modal.length !== 0 && !modal.find('.nc-modal-dialog-body').length) {
                var w = $nc(window).width() - 100 * 2;
                var h = $nc(window).height() - 100 * 2;
                w = w > 1200 ? 1200 : (w < 600 ? 600 : w);

                modal.css({width: w, height: h});

                var modalResizeHandler = modal.find(".simplemodal-data").data("onResize");
                if (modalResizeHandler && typeof modalResizeHandler === "function") {
                    modalResizeHandler(modal);
                }
            }
        });

        $nc._resize_modal_event = true;
    }
}

function nc_save_editor_values() {
    // в случае удаления nc_form() перенести эту функцию в nc.ui.modal_dialog (?)

    if (typeof CKEDITOR !== 'undefined' && CKEDITOR.instances) {
        for (var instance_name in CKEDITOR.instances) {
            var editor = CKEDITOR.instances[instance_name],
                $textarea = $nc(editor.element.$),
                value = editor.getData();

            if ($textarea.length) {
                // CKEditor не фильтрует контент, если редактор находится не в режиме
                // WYSIWIG (as of version 4.4.1)
                if (editor.mode !== 'wysiwyg' && (!('allowedContent' in editor.config) || editor.config.allowedContent !== true)) {
                    var fragment = CKEDITOR.htmlParser.fragment.fromHtml(value),
                        writer = new CKEDITOR.htmlParser.basicWriter();

                    editor.filter.applyTo(fragment);
                    fragment.writeHtml(writer);
                    value = writer.getHtml();
                }
                $textarea.val(value);
            }
        }
    }

    if (window.FCKeditorAPI) {
        for (fckeditorName in FCKeditorAPI.Instances) {
            var editor = FCKeditorAPI.GetInstance(fckeditorName);
            if (editor.IsDirty()) {
                $nc('#' + fckeditorName).val(editor.GetHTML());
            }
        }
    }

    CMSaveAll();
}

function nc_form(url, backurl, target, modalWindowSize, httpMethod, httpData) {
    var path_re = new RegExp("^\\w+://[^/]+" + NETCAT_PATH + "(add|message)\\.php");
    if (path_re.test(url)) {
        return nc.load_dialog(url);
    }

    if (!target && window.event) {
        target = window.event.target || window.event.srcElement;
    }

    if (!modalWindowSize) {
        modalWindowSize = null;
    }

    nc_register_modal_resize_handler();

    var $target = target ? $nc(target) : false;
    if ($target) {
        if ($target.hasClass('nc--disabled')) {
            return;
        }
        $target.addClass('nc--disabled');
    }

    if (!backurl) {
        backurl = '';
    }

    nc.process_start('nc_form()');

    if (!httpMethod) {
        httpMethod = 'GET';
    }

    if (!httpData) {
        httpData = {};
    }

    $nc.ajax({
        'type': httpMethod,
        'url': url + '&isNaked=1',
        'data': httpData,
        'success': function(response) {

            nc.process_stop('nc_form()');
            if ($target) {
                $target.removeClass('nc--disabled');
            }

            nc_remove_content_for_modal();
            $nc('body').append('<div style="display: none;" id="nc_form_result"></div>');
            $nc('#nc_form_result').html(response).modal({
                position: [120, null],
                onShow: function(dialog) {
                    $nc('#nc_form_result').children().not('.nc_admin_form_menu, .nc_admin_form_body, .nc_admin_form_buttons').hide();

                    var container = dialog.container;

                    if (modalWindowSize) {
                        var currentLeft = parseInt(container.css('left'));
                        var currentWidth = container.width();

                        var currentTop = parseInt(container.css('top'));
                        var currentHeight = container.height();

                        container.css({
                            width: modalWindowSize.width,
                            height: modalWindowSize.height,
                            left: currentLeft + (currentWidth - modalWindowSize.width) / 2,
                            top: currentTop + (currentHeight - modalWindowSize.height) / 2
                        }).addClass('simplemodal-container-fixed-size');
                    } else {
                        container.removeClass('simplemodal-container-fixed-size');
                        $nc(window).resize();
                    }

                    $nc('#nc_form_result #adminForm').append("<input type='hidden' name='nc_token' value='" + nc_token + "' />");
                },
                closeHTML: "<a class='modalCloseImg'></a>",
                onClose: function(e) {
                    if (typeof CKEDITOR !== 'undefined' && CKEDITOR.instances) {
                        for (var instance_name in CKEDITOR.instances) {
                            if (!/_edit_inline$/i.test(instance_name)) {
                                CKEDITOR.instances[instance_name].destroy();
                            } else {
                                var $element = $nc('#' + instance_name);
                                var oldValue = $element.attr('data-oldvalue');
                                $element.html(oldValue);
                            }
                        }
                    }
                    $nc.modal.close();
                    if (typeof nc_autosave_use !== "undefined" && nc_autosave_use == 1 && autosave !== null && typeof autosave !== "undefined" && autosave.timeout != 0) {
                        autosave.stopTimer();
                    }
                    $nc(document).unbind('keydown.simplemodal');
                    nc_remove_content_for_modal();
                }
            });

            $nc('#nc_form_result #adminForm').ajaxForm({
                beforeSerialize: nc_save_editor_values,

                // modal layer button submit
                success: function(response, status, event, form) {

                    nc.process_stop('nc_form()');
                    var error = nc_check_error(response);
                    if (error) {
                        var $form_buttons = $nc('.nc_admin_form_buttons');
                        $form_buttons.append(
                            "<div id='nc_modal_error' class='nc-alert nc--red' style='position:absolute; z-index:3000; width:" + ($form_buttons.width() - 55) + "px; bottom:70px; text-align:left; line-height:20px '>"
                            + "<div class='simplemodal_error_close'></div>"
                            + "<i class='nc-icon-l nc--status-error'></i>"
                            + error
                            + "</div>");
                        $nc('.simplemodal_error_close').click(function() {
                            $nc('#nc_modal_error').remove();
                        });
                        return false;
                    }

                    // if (response == 'OK') {
                    //     window.location.reload(true);
                    //     return false;
                    // }

                    var cc = form.find('input[name=cc]').val();

                    var loc = window.location,
                        newUrlMatch = (/^NewHiddenURL=(.+?)$/m).exec(response), // в ответе есть строка "NewHiddenUrl=something"
                        newUrl = newUrlMatch ? $nc.trim(newUrlMatch[1]) : null; // новый HiddenURL страницы

                    if ((/^ReloadPage=1$/m).test(response)) { // в ответе есть строка "ReloadPage=1"
                        // не режим "редактирование", изменился путь страницы
                        if (newUrl && !(/\.php/.test(window.location.pathname))) {
                            // сохранить имя страницы, если оно было (изменение свойств раздела со страницы объекта)
                            var pageNameMatch = /\/([^\/]+)$/.exec(loc.pathname);
                            if (pageNameMatch) {
                                newUrl += pageNameMatch[1];
                            }
                            loc.pathname = newUrl;
                        } else {
                            loc.reload(true);
                        }
                        return false;
                    } else {
                        $nc.ajax({
                            'type': 'GET',
                            'url': (backurl ? backurl : nc_page_url()) + '&isNaked=1&admin_modal=1&cc_only=' + cc,
                            success: function(response) {
                                nc_update_admin_mode_content(response, null, cc);
                                $nc.modal.close();
                            }
                        });
                    }
                }
            });
            return false;
        }
    });
}

function nc_action_message(url, httpMethod, httpData) {
    var ajax_url = url + '&isNaked=1&posting=1' + '&nc_token=' + nc_token,
        cc_match = url.match(/\bcc=(\d+)/),
        cc = cc_match[1];

    if (!httpMethod) {
        httpMethod = 'GET';
    }

    if (!httpData) {
        httpData = {};
    }

    $nc.ajax({
        'type': httpMethod,
        'data': httpData,
        'url': ajax_url,
        'success': function(response) {
            response = $nc.trim(response);
            if (response === 'deleted') {
                $nc('body', nc_get_current_document()).append("<div id='formAsyncSaveStatus'>Объект помещен в корзину</div>");
                $nc('div#formAsyncSaveStatus', nc_get_current_document()).css({
                    backgroundColor: '#39B54A'
                });
                setTimeout(function() {
                        $nc('div#formAsyncSaveStatus', nc_get_current_document()).remove();
                    },
                    1000);
            }

            if (response.indexOf('trashbin_disabled') > -1) {

                nc_print_custom_modal();

                $nc('div#nc_cart_confirm_footer button.nc_admin_metro_button').click(function() {
                    $nc.modal.close();
                    nc_action_message(url + '&force_delete=1')
                });

                return null;
            }

            var $status_message = $nc('<div />').html(response).find('#statusMessage');

            $nc.ajax({
                'type': 'GET',
                'url': nc_page_url() + '&isNaked=1',
                'success': function(response) {
                    response ? nc_update_admin_mode_content(response, $status_message, cc)
                        : nc_page_url(nc_get_back_page_url());
                }
            });
        }
    });
}

function nc_is_frame() {
    return typeof mainView !== "undefined";
}

function nc_has_frame() {
    return 'mainView' in top.window && top.window.mainView.oIframe;
}

function nc_get_back_page_url() {
    return NETCAT_PATH + '?' + nc_page_url().match(/sub=[0-9]+/) + (nc_is_frame() ? '&inside_admin=1' : '');
}

function nc_page_url(url) {
    return nc_correct_page_url(url ? nc_get_location().href = url : nc_get_location().href);
}

function nc_correct_page_url(url) {
    url = url.replace(/#.*$/, '');
    return url.indexOf('?') == -1 ? url + '?' : url;
}

function nc_update_admin_mode_infoblock(infoblock_id, callback) {
    $nc.ajax({
        'type': 'GET',
        'url': nc_page_url() + '&isNaked=1&admin_modal=1&cc_only=' + infoblock_id,
        success: function(response) {
            nc_update_admin_mode_content(response, null, infoblock_id);
            if ($nc.isFunction(callback)) {
                callback();
            }
        }
    });
}

function nc_update_admin_mode_content(content, $status_message, cc) {
    var scope = nc_has_frame() ? top.window.mainView.oIframe.contentDocument : document,
        block_id_selector = '#nc_admin_mode_content' + (cc || ''),
        $nc_admin_mode_content = $nc(block_id_selector, scope),
        new_content_block_by_id = $nc(content).filter(block_id_selector);

    if ($nc_admin_mode_content.length && new_content_block_by_id.length) {
        $nc_admin_mode_content.replaceWith(new_content_block_by_id);
        $nc_admin_mode_content = new_content_block_by_id;
    } else {
        if (!$nc_admin_mode_content.length) {
            $nc_admin_mode_content = $nc('div.nc_admin_mode_content', scope);
        }
        $nc_admin_mode_content.html(content);
    }

    $nc_admin_mode_content.find('LINK[rel=stylesheet]').appendTo($nc('HEAD', scope));

    $nc_admin_mode_content.prev('#statusMessage').remove();

    if (typeof($status_message) !== 'undefined' && $status_message) {
        $nc_admin_mode_content.before($status_message);
    }

    if ($nc.fn.addImageEditing) {
        $nc(".cropable").addImageEditing();
    }
}

function nc_get_current_document() {
    return nc_is_frame() ? mainView.oIframe.contentDocument : document;
}

function nc_get_location() {
    return nc_is_frame() ? mainView.oIframe.contentWindow.location : location;
}

function nc_remove_content_for_modal() {
    $nc('#nc_form_result').remove();
    if (typeof(resize_layout) !== 'undefined') {
        resize_layout();
    }
}

function nc_password_change() {
    var $password_change = $nc('#nc_password_change');
    $password_change.modal({
        closeHTML: "",
        containerId: 'nc_small_modal_container',
        onShow: function() {
            $nc('div.simplemodal-wrap').css({padding: 0, overflow: 'inherit'});
            var $form = $password_change.find('form');
            $nc('#nc_small_modal_container').addClass('nc-shadow-large').css({
                width: $form.width(),
                height: $form.height()
            });
            $nc(window).resize();
        }
    });

    // $nc('.password_change_simplemodal_container').css({
    //       backgroundColor: 'white',
    // });

    //FIXME: проверка формы изменения пароля перед отправкой
    if (false) {
        var $submit = $password_change.find('button[type=submit]');
        // var button = $nc('div#nc_password_change_footer button.nc_admin_metro_button');
        $submit.unbind();
        $submit.click(function() {
            if ($nc('input[name=Password1]').val() !== $nc('input[name=Password2]').val()) {
                $nc('div#nc_password_change_footer').append(
                    "<div id='nc_modal_error' style='position: absolute; z-index: 3000; width: 200px; border: 2px solid red;background-color: white; bottom: 190px; text-align: left; padding: 10px;'>"
                    + "<div class='simplemodal_error_close'></div>"
                    + ncLang.UserPasswordsMismatch
                    + "</div>");
                return false;
            }
            $nc('div#nc_password_change_body form').submit();
        });
    }

    $nc('div#nc_password_change form').ajaxForm({
        success: function() {
            $nc.modal.close();
        }
    });
}

$nc('button.nc_admin_metro_button_cancel').click(function() {
    $nc.modal.close();
});

function nc_check_error(response) {
    var div = document.createElement('div');
    div.innerHTML = response;
    return $nc(div).find('#nc_error').html();
}

$nc('.simplemodal_error_close').click(function() {
    $nc('#nc_modal_error').remove();
});

function CMSaveAll() {
    /* // pre method
    var editors = null;

    if ( nc_is_frame() ) {
        editors = mainView.oIframe.contentWindow.CMEditors;
    } else {
        editors = window.CMEditors;
    }
    if ( typeof(editors) != 'undefined' ) {
        for(var key in editors) {
            editors[key].save();
        }
    }*/

    $nc('textarea.has_codemirror').each(function() {
        $nc(this).data('codemirror').save();
    });
}

function nc_print_custom_modal() {
    $nc('body').append("<div id='nc_cart_confirm' style='display: none;'></div>");

    var cart_confirm = $nc('#nc_cart_confirm');

    cart_confirm.append("<div id='nc_cart_confirm_header'></div>");
    cart_confirm.append("<div id='nc_cart_confirm_body'></div>");
    cart_confirm.append("<div id='nc_cart_confirm_footer'></div>");

    $nc('#nc_cart_confirm_header').append("<div><h2 style='padding: 0px;'>" + ncLang.DropHard + "</h2></div>");
    $nc('#nc_cart_confirm_footer').append("<button type='button' class='nc_admin_metro_button nc-btn nc--blue'>" + ncLang.Drop + "</button>");
    $nc('#nc_cart_confirm_footer').append("<button type='button' class='nc_admin_metro_button_cancel nc-btn nc--red nc--bordered nc--right'>" + ncLang.Cancel + "</button>");

    cart_confirm.modal({
        closeHTML: "",
        containerId: 'cart_confirm_simplemodal_container',
        onShow: function() {
            $nc('.simplemodal-wrap').css({
                backgroundColor: 'white'
            });
        },
        onClose: function() {
            $nc.modal.close();
            $nc('#nc_cart_confirm').remove();
        }
    });

    $nc('div#nc_cart_confirm_footer button.nc_admin_metro_button_cancel').click(function() {
        $nc.modal.close();
    });

    $nc('div#nc_cart_confirm_footer button.nc_admin_metro_button').click(function() {
        if (typeof callback_on_confirm === 'function') {
            callback_on_confirm();
            $nc.modal.close();
        }
    });

}


function nc_print_custom_modal_callback(callback) {
    $nc('body').append("<div id='nc_cart_confirm' style='display: none;'></div>");

    var cart_confirm = $nc('#nc_cart_confirm');

    cart_confirm.append("<div id='nc_cart_confirm_header'></div>");
    cart_confirm.append("<div id='nc_cart_confirm_body'></div>");
    cart_confirm.append("<div id='nc_cart_confirm_footer'></div>");

    $nc('#nc_cart_confirm_header').append("<div><h2 style='padding: 0px;'>" + ncLang.DropHard + "</h2></div>");
    $nc('#nc_cart_confirm_footer').append("<button type='button' class='nc_admin_metro_button_cancel nc-btn nc--bordered nc--blue'>" + ncLang.Cancel + "</button>");
    $nc('#nc_cart_confirm_footer').append("<button type='button' class='nc_admin_metro_button nc-btn nc--red nc--bordered nc--right'>" + ncLang.Drop + "</button>");

    cart_confirm.modal({
        closeHTML: "",
        containerId: 'cart_confirm_simplemodal_container',
        onShow: function() {
            $nc('.simplemodal-wrap').css({
                backgroundColor: 'white'
            });
        },
        onClose: function() {
            $nc.modal.close();
            $nc('#nc_cart_confirm').remove();
        }
    });

    $nc('div#nc_cart_confirm_footer button.nc_admin_metro_button_cancel').click(function() {
        $nc.modal.close();
    });

    $nc('div#nc_cart_confirm_footer button.nc_admin_metro_button').click(function() {
        if (typeof callback === 'function') {
            callback();
            $nc.modal.close();
        }
    });
}

function prepare_message_form() {
    $nc(function() {
        $nc('#adminForm').wrapInner('<div class="nc_admin_form_main">');
        $nc('#adminForm').append($nc('#nc_seo_append').html());
        $nc('#adminForm').append('<input type="hidden" name="isNaked" value="1" />');
        $nc('#nc_seo_append').remove();
    });

    //var nc_admin_form_values = $nc('#adminForm').serialize();

    $nc('#nc_show_main').click(function() {
        $nc('.nc_admin_form_main').show();
        $nc('.nc_admin_form_seo').hide();
    });

    $nc('#nc_show_seo').click(function() {
        $nc('.nc_admin_form_main').hide();
        $nc('.nc_admin_form_seo').show();
    });

    $nc('#nc_object_slider_menu li').click(function() {
        $nc('#nc_object_slider_menu li').removeClass('button_on');
        $nc(this).addClass('button_on');
    });

    $nc('.nc_admin_metro_button_cancel').click(function() {
        $nc.modal.close();
    });

    $nc('.nc_admin_metro_button').click(function() {
        if ($nc(this).hasClass('nc--loading')) {
            return;
        }
        nc.process_start('nc_form()', this);
        $nc('#adminForm').submit();
    });
    InitTransliterate();
    if (typeof nc_autosave_use !== "undefined" && nc_autosave_use == 1) {
        InitAutosave('adminForm');
        if (autosave !== null && typeof autosave !== "undefined") {
            $nc('.nc_draft_btn').click(function(e) {
                e.preventDefault();
                $nc(this).addClass('nc--loading');
                autosave.saveAllData(autosave);
            });
        }
    }
}

function nc_typo_field(field) {
    var string;
    if (typeof CKEDITOR !== 'undefined' && CKEDITOR.instances && typeof(CKEDITOR.instances[field]) !== 'undefined') {
        string = CKEDITOR.instances[field].getData();
        string = Typographus_Lite.process(string);
        CKEDITOR.instances[field].setData(string);
    } else if (typeof FCKeditorAPI !== 'undefined' && FCKeditorAPI.Instances && typeof(FCKeditorAPI.Instances[field]) !== 'undefined') {
        var editor = FCKeditorAPI.GetInstance(field);
        string = editor.GetHTML();
        string = Typographus_Lite.process(string);
        editor.SetHTML(string);
    } else {
        var $textarea = $nc('TEXTAREA[name=' + field + ']');
        string = $textarea.val();
        string = Typographus_Lite.process(string);
        $textarea.val(string);
    }
}

function nc_infoblock_controller_request(el, action, params) {
    return $nc.post(
        NETCAT_PATH + 'action.php',
        $nc.extend(
            {
                ctrl: 'admin.infoblock',
                action: action,
                infoblock_id: $nc(el).closest('.nc-infoblock-toolbar').data('infoblockId')
            },
            params
        )
    );
}

function nc_infoblock_toggle(el) {
    nc_infoblock_controller_request(el, 'toggle')
        .success(function(response) {
            if (response === 'OK') {
                $nc(el).children().toggle();
            } else {
                // todo: request: process errors
                alert(response);
            }
        });

    return false;
}

function nc_infoblock_place_before(el, other_infoblock_id) {
    return nc_infoblock_change_order(el, 'before', other_infoblock_id);
}

function nc_infoblock_place_after(el, other_infoblock_id) {
    return nc_infoblock_change_order(el, 'after', other_infoblock_id);
}

function nc_infoblock_change_order(el, position, other_infoblock_id) {
    nc_infoblock_controller_request(el, 'change_order', {
        position: position,
        other_infoblock_id: other_infoblock_id
    })
        .success(function(response) {
            if (response === 'OK') {
                window.location.hash = el.href.split('#')[1];
                window.location.reload(true);
            } else {
                // todo: request: process errors
                alert(response);
            }
        });

    return false;
}

function nc_infoblock_set_template(infoblock_id, template_id) {
    nc_infoblock_controller_request(null, 'set_component_template', {
        infoblock_id: infoblock_id,
        template_id: template_id
    }).success(function(response) {
        nc_update_admin_mode_content(response, '', infoblock_id);
    });
    return false;
}

function nc_infoblock_buffer_get_id() {
    return $nc.cookie('nc_admin_buffer_infoblock_id');
}

function nc_infoblock_buffer_update_page() {
    $nc('body').toggleClass('nc-page-buffer-has-infoblock', !!nc_infoblock_buffer_get_id());
}

$nc(function() {
    nc_infoblock_buffer_update_page();
    $nc('body').on('mouseenter.nc_infoblock_paste', '.nc-infoblock', nc_infoblock_buffer_update_page);
});


function nc_infoblock_buffer_copy(infoblock_id) {
    $nc.cookie('nc_admin_buffer_infoblock_id', infoblock_id);
    nc_infoblock_buffer_update_page();
}

function nc_infoblock_buffer_paste(controller_link) {
    var infoblock_id = nc_infoblock_buffer_get_id();
    if (!infoblock_id) {
        return null;
    }

    $nc.ajax({
        method: 'POST',
        url: NETCAT_PATH + 'action.php',
        data: controller_link.substr(controller_link.indexOf('?') + 1) + '&copied_infoblock_id=' + infoblock_id,
        success: function(response) {
            if (response === 'OK') {
                location.reload();
            } else if (response) {
                // todo: request: process errors
                alert(response);
            }
        }
    });
}

function nc_init_toolbar_dropdowns() {
    // dropdown inside nc-toolbar: open on click, close on mouseleave or click inside the dropdown
    var event_ns = '.nc_toolbar_dropdown',
        toolbar_class = '.nc6-toolbar',
        close_timeout_id,
        clear_close_timeout = function() {
            clearTimeout(close_timeout_id);
        };

    $nc('body').on('click' + event_ns, toolbar_class + ' .nc--dropdown', function(e) {
        e.preventDefault();
        var el = $nc(this),
            close = function() {
                el.removeClass('nc--clicked');
                clear_close_timeout();
            };

        if (el.hasClass('nc--clicked')) {
            close();
        } else {
            el.siblings().removeClass('nc--clicked');
            clearTimeout(close_timeout_id);

            var body_width = $nc('body').innerWidth();

            el.addClass('nc--clicked')
                .off(event_ns)
                .on('mouseenter' + event_ns, clear_close_timeout)
                .on('mouseleave' + event_ns, function() {
                    close_timeout_id = setTimeout(close, 1000);
                });

            // проверяем, чтобы выпадающее меню не попадало за пределы экрана по горизонтали
            var dropdown = el.children('ul'),
                dropdown_left = dropdown.offset().left,
                toolbar_right = parseInt(el.parents('ul' + toolbar_class).css('right'), 10);
            if (dropdown_left + dropdown.outerWidth() > body_width - toolbar_right) {
                dropdown.css('width', (body_width - dropdown_left - toolbar_right) + 'px');
            }
        }
    });
}

$nc(nc_init_toolbar_dropdowns);

/**
 *
 */
function nc_editable_image_init(c) {
    c = $nc(c);
    c.find('input[type=file]').change(nc_editable_image_upload);
    c.find('.nc-editable-image-remove').click(nc_editable_image_remove);
    c.parents('a').prop('href', '#____'); // не получилось остановить переход по ссылке в FF
    c.find('form').mouseover(function() {
        c.addClass('nc--hover');
    });
    c.mouseleave(function() {
        c.removeClass('nc--hover');
    });
}

/**
 * Удаление изображения при in-place редактировании
 */
function nc_editable_image_remove(event) {
    event.stopPropagation();
    var c = $nc(event.target).closest('.nc-editable-image-container').addClass('nc--empty'),
        form = c.find('form');
    c.find('img').prop('src', nc_edit_no_image);
    form.find('input[name^=f_KILL]').val(1);
    nc.process_start('nc_editable_image_remove');

    function done() {
        nc.process_stop('nc_editable_image_remove');
    }

    form.ajaxSubmit({success: done, error: done});
}

/**
 * Замена изображения при in-place редактировании
 */
function nc_editable_image_upload(event) {
    var filereader_max_size = 2 * 1024 * 1024,
        input = event.target,
        need_to_reload = true,
        form = $nc(input).closest('form'),
        c = form.closest('.nc-editable-image-container').removeClass('nc--empty');

    if ('FileReader' in window && !c.hasClass('nc--always-reload')) {
        if (input.files[0].size < filereader_max_size) {
            need_to_reload = false;
            var reader = new FileReader();
            reader.onload = function(e) {
                form.find('img').prop('src', e.target.result);
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    nc.process_start('nc_editable_image_upload');

    function stop() {
        nc.process_stop('nc_editable_image_upload');
    }

    function done() {
        if (need_to_reload) {
            var cc = form.find('input[name=cc]').val();
            $nc.ajax({
                'type': 'GET',
                'url': nc_page_url() + '&isNaked=1&admin_modal=1&cc_only=' + cc,
                success: function(response) {
                    nc_update_admin_mode_content(response, null, cc);
                    stop();
                }
            });
        } else {
            stop();
        }
    }

    form.ajaxSubmit({success: done, error: done});
    return false;
}
/* $Id: lib.js 8189 2012-10-11 15:43:20Z vadim $ */

// EVENT BINDING *****************************************************************
var _eventRegistry = [];
var _lastEventId = 0;
/**
 * Добавление обработчика события к объекту
 * @param {Object} object
 * @param {String} eventName без 'on'
 * @param {Object} eventHandler
 * @param {Boolean} НЕ использовать конструкцию eventHandler.apply(object) в IE
 *  использование apply позволяет в IE обращаться к object в eventHandler как
 *  к this (т.е. как в Mozilla)
 * @return {Number} eventId
 */
function bindEvent(object, eventName, eventHandler, dontAddApplyInExplorer) {

    var fn = eventHandler;
    if (object.addEventListener) {
        object.addEventListener(eventName, fn, false);
    }
    else if (object.attachEvent) {
        if (!dontAddApplyInExplorer) fn = function() {
            eventHandler.apply(object);
        }
        object.attachEvent("on" + eventName, fn);
    }
    // добавлен "event": чтобы не "съезжали" id при удалении события из реестра
    var eventId = "event" + _lastEventId++;
    _eventRegistry[eventId] = {
        object: object,
        eventName: eventName,
        eventHandler: fn
    };
    return eventId;
}

/**
 * Удаление обработчика события eventId, добавленного через bindEvent()
 * @param {Object} eventId
 * @return {Boolean}
 */
function unbindEvent(eventId) {

    if (!_eventRegistry[eventId] || typeof _eventRegistry[eventId] != 'object') return false;

    var object = _eventRegistry[eventId].object;
    var eventName = _eventRegistry[eventId].eventName;
    var eventHandler = _eventRegistry[eventId].eventHandler;

    if (object.removeEventListener) {
        object.removeEventListener(eventName, eventHandler, false);
    }
    else if (object.detachEvent) {
        object.detachEvent("on" + eventName, eventHandler);
    }

    _eventRegistry.splice(eventId, 1);

    return true;
}

/**
  * отвязка всех событий
  */
function unbindAllEvents() {
    for (var i in _eventRegistry) {
        try {
            unbindEvent(i);
        } catch(e) {}
    }
}

// remove all events on page unload to prevent memory leaks
bindEvent(window, 'unload', unbindAllEvents);


/**
 * Позиция объекта относительно BODY или объекта с id=STOPID
 * @param {Object} object
 * @param {String} stopObjectId
 * @param {Boolean} addFrameOffset

 * @return {Object} {left: x, top: y}
 */
function getOffset(object, stopObjectId, addFrameOffset) {

    var pos = {
        top: 0,
        left: 0
    };

    // weak chain
    if (addFrameOffset) {
        if (object.ownerDocument.defaultView) {
            pos.top  = object.ownerDocument.defaultView.frameOffset.top -
            object.ownerDocument.body.scrollTop;
            pos.left = object.ownerDocument.defaultView.frameOffset.left -
            object.ownerDocument.body.scrollLeft;
        }
        else {
            pos.top = object.ownerDocument.parentWindow.frameOffset.top -
            object.ownerDocument.body.scrollTop;
            pos.left = object.ownerDocument.parentWindow.frameOffset.left -
            object.ownerDocument.body.scrollLeft;
        }
    }

    var isIE = (document.all ? true : false); // weak chain

    /*
  if (isIE) {
    // баг IE? если высота объекта не задана и он находится внутри
    // iframe, то offset - значение относительно BODY!
    if (ieOffsetBugX) { pos.left += object.offsetLeft; }
    if (ieOffsetBugY) { pos.top  += object.offsetTop; }
    if (ieOffsetBugX && ieOffsetBugY) { return pos; }
  }
*/
    //var str = "";
    while (object && object.tagName!="BODY") {
        if (!isIE || (isIE && object.id != "siteTreeContainer")) {
            pos.left += object.offsetLeft;
        }
        pos.top += object.offsetTop;

        object = object.offsetParent;
        if (stopObjectId && object.id == stopObjectId) break;
    }
    //alert(str);
    return pos;
}


/**
 * Create element
 * @param {String} tagName
 * @param {Object} attributes hash [optional]
 * @param {Object} oParent [optional]
 */
function createElement(tagName, attributes, oParent) {
    var obj = document.createElement(tagName);
    for (var i in attributes) {
        if (i.indexOf('.')) { // e.g. 'style.display'
            eval('obj.'+i+'=attributes[i]');
        } else {
            obj[i] = attributes[i];
        }
    }
    if (oParent) {
        oParent.appendChild(obj);
    }
    return obj;
}

// FADE OUT FUNCTIONS
var fadeIntervals = [];

/**
  * FADE OUT
  * @param {String} ID объекта
  */
function fadeOut(id)
{
    var dst = document.getElementById(id);

    if (dst.filters)
    {
        dst.style.filter="blendTrans(duration=1)";

        if (dst.filters.blendTrans.status != 2)
        {
            dst.filters.blendTrans.apply();
            dst.style.visibility="hidden";
            dst.filters.blendTrans.play();
        }
        return;
    }

    if (dst.style.opacity == 0)
    {
        clearInterval(fadeIntervals[id]);
        fadeIntervals[id] = null;
        dst.style.visibility='hidden';
        dst.style.opacity = 1;
        return;
    }

    dst.style.opacity = (Number(dst.style.opacity) - 0.05);

    // setup interval
    if (!fadeIntervals[id]) fadeIntervals[id] = setInterval("fadeOut('"+id+"')",40);
}



// returns all object property values as a STRING
function dump(object, regexpFilter) {
    var str = '';
    for (i in object) {
        if (!regexpFilter || i.match(regexpFilter)) {
            str += i+' = ' + object[i]+"<br>\n";
        }
    }
    return str;
}


function nc_dump (x,  l) {
    l = l || 0;
    var i, r = '', t = typeof x, tab = '';

    if (x === null) {
        r += "(null)\n";
    }
    else if (t == 'object') {
        l++;
        for (i = 0; i < l; i++) tab += ' ';

        if (x && x.length) t = 'array';

        r += '(' + t + ") :\n";

        for (i in x) {
            try {
                r += tab + '[' + i + '] : ' + nc_dump(x[i], (l + 1));
            } catch(e) {
                return "[error: " + e + "]\n";
            }
        }
    }
    else {
        if (t == 'string') {
            if (x == '') {
                x = '(empty)';
            }
        }

        r += '(' + t + ') ' + x + "\n";

    }

    return r;
}

/* для задания соответсвия полей пользователя */
nc_mapping_fields = function ( fields1, fields2, parent_div, name, data_from ) {
    this.nums = 0; // количеcтво соответсвий
    this.fields1 = fields1;
    this.fields2 = fields2;
    this.parent_div = parent_div || 'field_div';
    this.name = name;
    this.data_from = data_from;

}
nc_mapping_fields.prototype = {
    add: function ( val1, val2 ) {
        this.nums++;
        var con_id = this.parent_div+"_con_"+this.nums;

        if ( this.nums == 1 ) {
            $nc('#' + this.parent_div).append("<div id='"+con_id+"title'></div>");
            $nc('#' + con_id + 'title').append("<div  class='mf_fl1'>"+ncLang.FieldFromUser+":</div>");
            $nc('#' + con_id+ 'title').append("<div class='s_img s_img_darrow mf_arrow' style='visibility: hidden; height: 0px;'></div>");
            $nc('#' + con_id+ 'title').append("<div  class='mf_fl2'>"+this.data_from+":</div>");
            $nc('#' + con_id+ 'title').append("<div id='"+this.parent_div+"clear_"+this.nums+"' style='clear:both'></div>");
        }

        $nc('#' + this.parent_div).append("<div id='"+con_id+"'></div>");

        $nc('#' + con_id).append("<div id='"+this.parent_div+"_field1_"+this.nums+"' class='mf_fl1'></div>");
        $nc('#' + con_id).append("<div class='s_img s_img_darrow mf_arrow'></div>");
        $nc('#' + con_id).append("<div id='"+this.parent_div+"_field2_"+this.nums+"' class='mf_fl2'></div>");
        $nc('#' + con_id).append("<div id='"+this.parent_div+"_drop_"+this.nums+"' class='mf_drop' onclick='"+this.name+".drop("+this.nums+")'><div class='icons icon_delete' title='"+ncLang.Drop+"' style='margin-top:-3px'></div> "+ncLang.Drop+"</div>");
        $nc('#' + con_id).append("<div id='"+this.parent_div+"_clear_"+this.nums+"' style='clear:both'></div>");

        $nc("#"+this.parent_div+"_field1_"+this.nums).html("<select id='"+this.parent_div+"_field1_value_"+this.nums+"' name='"+this.parent_div+"_field1_value_"+this.nums+"'></select>");
        $nc("#"+this.parent_div+"_field2_"+this.nums).html("<select id='"+this.parent_div+"_field2_value_"+this.nums+"' name='"+this.parent_div+"_field2_value_"+this.nums+"'></select>");

        for (i in this.fields1) {
            $nc("#"+this.parent_div+"_field1_value_"+this.nums).append("<option value='"+i+"'>" + this.fields1[i] + "</option>");
        }
        if ( val1 ) $nc("#"+this.parent_div+"_field1_value_"+this.nums+" [value='"+val1+"']").attr("selected", "selected");

        for (i in this.fields2) {
            $nc("#"+this.parent_div+"_field2_value_"+this.nums).append("<option value='"+i+"'>" + this.fields2[i] + "</option>");
        }
        if ( val2 ) $nc("#"+this.parent_div+"_field2_value_"+this.nums+" [value='"+val2+"']").attr("selected", "selected");
    },

    drop: function ( id ) {
        $nc("#"+this.parent_div+"_con_"+id).remove();
    }
}

nc_openidproviders = function () {
    this.nums = 0;
    this.div_id = 'openid_providers';
}
nc_oauthproviders = function () {
    this.nums = 0;
    this.div_id = 'oauth_providers';
}
nc_openidproviders.prototype = {
    add: function ( name, url, imglink ) {
        this.nums++;
        if ( !imglink ) imglink = MODULE_AUTH_OPENID_ICON_PATH;
        if ( !name ) name ='';
        if ( !url ) url = '';
        var con_id = this.div_id+"_con_"+this.nums;
        $nc('#' + this.div_id).append("<div id='"+con_id+"'></div>");

        $nc('#' + con_id).append("<div class='img'><img id='openid_providers_img_"+this.nums+"' src='"+imglink+"' alt='' /></div>");
        $nc('#' + con_id).append("<div class='name'><input name='openid_providers_name_"+this.nums+"' type='text' value='"+name+"' /></div>");
        $nc('#' + con_id).append("<div class='imglink'><input id='openid_providers_imglink_"+this.nums+"'  name='openid_providers_imglink_"+this.nums+"' type='text' value='"+imglink+"' /></div>");
        $nc('#' + con_id).append("<div class='url'><input name='openid_providers_url_"+this.nums+"' type='text' value='"+url+"' /></div>");
        $nc('#' + con_id).append("<div class='drop' onclick='op.drop("+this.nums+")'><i class='nc-icon nc--remove'></i> "+ncLang.Drop+"</div>");
        $nc('#' + con_id).append("<div style='clear:both;'></div>");

        $nc('#openid_providers_imglink_'+this.nums).change (
            function() {
                $nc('#' + $nc(this).attr('id').replace('imglink','img') ).attr('src', $nc(this).val());
            }
            );
    },

    drop: function ( id ) {
        $nc("#"+this.div_id+"_con_"+id).remove();
    }
}

nc_oauthproviders.prototype = {
    add: function (imglink, name, provider, appid, pubkey, seckey ) {
        this.nums++;
        if ( !imglink ) imglink = MODULE_AUTH_OAUTH_ICON_PATH;
        if ( !provider ) provider ='';
        if ( !name ) name ='';
        if ( !appid ) appid = '';
        if ( !seckey ) seckey = '';
        if ( !pubkey ) pubkey = '';

        var con_id = this.div_id+"_con_"+this.nums;
        $nc('#' + this.div_id).append("<div id='"+con_id+"'></div>");

        $nc('#' + con_id).append("<div class='img'><img id='oauth_providers_img_"+this.nums+"' src='"+imglink+"' alt='' /></div>");
        $nc('#' + con_id).append("<div class='name'><input name='oauth_providers_name_"+this.nums+"' type='text' value='"+name+"' /></div>");
        $nc('#' + con_id).append("<div class='provider'><input name='oauth_providers_provider_"+this.nums+"' type='text' value='"+provider+"' /></div>");
        $nc('#' + con_id).append("<div class='imglink'><input id='oauth_providers_imglink_"+this.nums+"'  name='oauth_providers_imglink_"+this.nums+"' type='text' value='"+imglink+"' /></div>");
        $nc('#' + con_id).append("<div class='appid'><input id='oauth_providers_appid_"+this.nums+"'  name='oauth_providers_appid_"+this.nums+"' type='text' value='"+appid+"' /></div>");
        $nc('#' + con_id).append("<div class='pubkey'><input id='oauth_providers_pubkey_"+this.nums+"'  name='oauth_providers_pubkey_"+this.nums+"' type='text' value='"+pubkey+"' /></div>");
        $nc('#' + con_id).append("<div class='seckey'><input id='oauth_providers_seckey_"+this.nums+"'  name='oauth_providers_seckey_"+this.nums+"' type='text' value='"+seckey+"' /></div>");
        $nc('#' + con_id).append("<div class='drop' onclick='oap.drop("+this.nums+")'><i class='nc-icon nc--remove'></i> "+ncLang.Drop+"</div>");
        $nc('#' + con_id).append("<div style='clear:both;'></div>");

        $nc('#oauth_providers_imglink_'+this.nums).change (
            function() {
                $nc('#' + $nc(this).attr('id').replace('imglink','img') ).attr('src', $nc(this).val());
            }
        );
    },

    drop: function ( id ) {
        $nc("#"+this.div_id+"_con_"+id).remove();
    }
}


/* создание/редактирование параметра визуальных настроек */
nc_customsettings = function (type, subtype, subtypes, hasdefault, can_have_initial_value) {
    this.subtypes = subtypes;
    this.subtype = subtype || '';
    this.type = type || '';
    this.hasdefault = hasdefault;
    this.can_have_initial_value = can_have_initial_value;
};

nc_customsettings.prototype = {

    changetype: function () {
        this.type = $nc("#type :selected").val();
        $nc('#cs_subtypes').html('');
        $nc('#cs_subtypes_caption').hide();
        var st = this.subtypes[this.type];
        // показать или скрыть "значние по умолчанию"
        if (this.hasdefault[this.type]) {
            $nc('#def').show();
        }
        else {
            $nc('#def').hide();
        }

        $nc('#initial_value').toggle(this.can_have_initial_value[this.type]);

        var k, s_v, s_n;
        if (st.length) {
            $nc('#cs_subtypes_caption').show();
            $nc('#cs_subtypes').html("<select style='width: 100%;' id='subtype' name='subtype' onchange='nc_cs.changesubtype()'></select>");
            for (var i = 0; i < st.length; i++) {
                for (k in st[i]) {
                    s_v = k;
                    s_n = st[i][k];
                }
                $nc('#subtype').append("<option value='" + s_v + "'>" + s_n + "</option>");
            }
            if (this.subtype) {
                $nc("#subtype [value='" + this.subtype + "']").attr("selected", "selected");
            }
            else {
                $nc("#subtype :first").attr("selected", "selected");
            }
        }

        this.show_extends();
        this.changesubtype();
    },

    changesubtype: function () {
        this.subtype = $nc("#subtype :selected").val();
        this.show_extends();
    },

    show_extends: function () {
        var t = this.type;
        if (this.subtype) {
            t += '_' + this.subtype;
        }
        $nc(".cs_extends").hide();
        $nc(".cs_extends :input").attr('disabled', true);
        $nc("#extend_" + t).show();
        $nc("#extend_" + t + " :input").removeAttr('disabled');
    }
};

// ---------------------------------------------------------------------------
// HTTP REQUEST
// ---------------------------------------------------------------------------
// Create XMLHttpRequest object

/**
 * This XMLHttpRequest is NOT ASYNCHRONOUS by default
 * @param {Boolean} isAsync
 */
function httpRequest(isAsync) {
    this.xhr = null;

    try {
        this.xhr = new XMLHttpRequest();
    } catch(e) { // Mozilla, IE7
        try {
            this.xhr = new ActiveXObject("Msxml2.XMLHTTP");
        } catch(e) {
            try {
                this.xhr = new ActiveXObject("Microsoft.XMLHTTP");
            } catch(e) {
                return false;
            }
        }
    }

this.isAsync = isAsync ? true : false;
this.statusHandlers = {};
}

// ----------------------------------------------------------------------------
/**
 * Make request
 * @param {String} method GET|POST
 * @param {String} url
 * @param {Object|String} urlParams { hash }
 * @param {Object} statusHandlers  e.g. { '200': 'alert(200)'. '403': 'alert("NO RIGHTS") }
 *    { '*': 'alert("Обработчик всех ответов - с любым статусом")' }
 * @return {String} status ('200', '404' etc) -- only if isAsync==false
 */
httpRequest.prototype.request = function(method, url, urlParams, statusHandlers) {
    this.statusHandlers = statusHandlers;
    if (method!='POST') method = 'GET';

    var encParams = (typeof urlParams == 'string') ? urlParams : urlEncodeArray(urlParams);

    if (encParams && method=='GET') {
        url += (url.match(/\?/) ?  "&" : "?") + encParams;
    }

    this.xhr.open(method, url, this.isAsync);
    if (method=='POST') {
        this.xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded, charset=utf-8");
    }
    this.xhr.send(encParams);

    if (this.isAsync) {
        var oXhr = this;
        this.xhr.onreadystatechange = function() {
            oXhr.trackStatus();
        };
    }
    else {
        this.trackStatus();
        return this.xhr.status;
    }
}

httpRequest.prototype.trackStatus = function() {

    try {
        if (!this.statusHandlers) return;

        var handler = this.statusHandlers[this.xhr.status];

        // DEFAULT STATUS HANDLER (fires on all status codes)
        if (!handler && this.statusHandlers['*']) {
            handler = this.statusHandlers['*'];
        }

        if (handler) {
            try {
                eval(handler);
            }
            catch(e) {
                alert('Failed ['+this.xhr.status+']: '+handler);
            }
        }
    } catch (outerException) {}
}

// getJson requests are always synchronous
httpRequest.prototype.getJson = function(url, urlParams, statusHandlers) {
    var isAsync = this.isAsync;
    this.isAsync = false;
    this.request('GET', url, urlParams, statusHandlers);
    this.isAsync = isAsync;

    if (this.xhr.status!='200' || !this.xhr.responseText.length) {
        return null;
    }
    try {
        return eval(this.xhr.responseText.replace("while(1);", ""));
    }
    catch (e) {
        return null;
    }
}

httpRequest.prototype.getResponseText = function() {
    return this.xhr.responseText;
}

// ----------------------------------------------------------------------------
// string to use with POST requests (recursive!)
function urlEncodeArray(data, parent)
{
    if (data==null) return '';

    if (!parent) parent = "";
    var query = [];

    if (data instanceof Object) {
        for (var k in data) {
            var key = parent ? parent+"["+k+"]" : k;

            query.push( data[k] instanceof Object
                ? urlEncodeArray(data[k], key)
                : encodeURIComponent(key) + "=" + encodeURIComponent(data[k]));
        }
        return query.join('&');
    }
    else {
        return encodeURIComponent(data);
    }
}

// Скроллер: прокручивает экран при приближении курсора мыши к краю экрана
var scroller = {
    scrollInterval: null, // для хранения ID интервала (setInterval)
    scrollDelay: 15,
    scrollAmount: 5,
    scrollAreaHeight: 60,
    scrollBottomK: 150, // ??? неправильно определяет body.scrollHeight?

    scroll: function(e) {
        if (!e) e = event;

        // высота окна
        var windowHeight = document.body.clientHeight;
        // место положения мыши
        var mouseY = e.clientY ? e.clientY : e.y;

        if (mouseY < scroller.scrollAreaHeight && scroller.canScrollUp()) {
            if (!scroller.scrollInterval) {
                scroller.scrollInterval = setInterval(scroller.scrollUp, scroller.scrollDelay);
            }
        }
        else if (mouseY > (windowHeight - scroller.scrollAreaHeight) && scroller.canScrollDown()) {
            if (!scroller.scrollInterval) {
                scroller.scrollInterval = setInterval(scroller.scrollDown, scroller.scrollDelay);
            }
        }
        else {
            scroller.scrollStop();
        }
    },

    canScrollUp: function() {
        return (document.body.scrollTop > 0);
    },

    canScrollDown: function() {
        return ((document.body.scrollHeight) > (document.body.scrollTop + document.body.clientHeight));
    },

    scrollUp: function() {
        if (scroller.canScrollUp()) {
            document.body.scrollTop -= scroller.scrollAmount;
        }
        else {
            scroller.scrollStop();
        }
    },

    scrollDown: function() {
        if (scroller.canScrollDown()) {
            document.body.scrollTop += scroller.scrollAmount;
        }
        else {
            scroller.scrollStop();
        }
    },

    scrollStop: function() {
        if (scroller.scrollInterval) {
            clearInterval(scroller.scrollInterval);
            scroller.scrollInterval = null;
        }
    }
}


/**
  * Add new parameter for module settings
  */
function ModulesAddNewParam () {
    var oIframe = top.frames['mainViewIframe'];

    var docum = (oIframe.contentWindow || oIframe.contentDocument || oIframe.document);
    if (docum.document) docum = docum.document;

    var tbody = docum.getElementById('tableParam').getElementsByTagName('TBODY')[0];
    var row = docum.createElement("TR");
    var tdName = docum.createElement("TD");
    var tdValue = docum.createElement("TD");
    var tdDelete = docum.createElement("TD");

    tdName.style.background = "#FFF";
    tdValue.style.background = "#FFF";
    tdDelete.style.background = "#FFF";

    var dat = new Date();
    var id = dat.getMinutes() + '' + dat.getSeconds() + '' + Math.floor(Math.random()*51174);

    tbody.appendChild(row);
    row.appendChild(tdName);
    row.appendChild(tdValue);
    row.appendChild(tdDelete);

    tdName.innerHTML  = '<textarea rows="1" style = "width:100%" name="Name_' + id + '"></textarea>';
    tdValue.innerHTML = '<textarea rows="1" style = "width:100%" name="Value_' + id + '"></textarea>';
    tdDelete.align = 'center';
    tdDelete.innerHTML = '<input type="checkbox" name="Delete_' + id + '" />';
    return;
}

// срабатывает при выборе объекта при пакетной обработке
function nc_message_select ( id ) {
    var frm = document.getElementById('nc_delete_selected');

    if ( !frm ) return false;

    if ( nc_message_selected[id] ) {
        nc_message_selected[id] = 0;
        frm.removeChild(document.getElementById('nc_hidden_'+id));
    }
    else {
        nc_message_selected[id] = id;
        frm.innerHTML += "<input id='nc_hidden_"+id+"'type='hidden' name='message["+id+"]' value='"+id+"' />";
    }

    return false;
}

// Пакетная обработка объектов
// Добавить скрытые поля и отправить форму при непосредственном нажатии "Удалить" или "включить\выключить"
function nc_package_click ( action ) {
    // id формы
    var frm = document.getElementById('nc_delete_selected');

    if ( !frm ) return false;

    if ( action == 'delete') { // delete
        frm.innerHTML += "<input type='hidden' name='delete' value='1' />";
    }
    else { //checked
        frm.innerHTML += "<input type='hidden' name='checked' value='1' />";
        frm.innerHTML += "<input type='hidden' name='posting' value='1' />"
    }

    frm.submit();
    return false;
}

function toggle(Obj) {
    if(Obj){
        Obj.style.display = (Obj.style.display != 'none') ? 'none':'block';
        return true;
    }
    return false;
}

function nc_toggle ( obj ) {
    var l = document.getElementById(obj);
    if ( l ) toggle(l);

}

function nc_trash_get_objects(cc, date_b, date_e, type_id) {
    if(!cc) return false;
    type_id = type_id || 0;

    var values = [];
    var res;
    var url = SUB_FOLDER + NETCAT_PATH + 'admin/trash/get_trash.php';
    // var needTextArea = document.getElementById(act);

    values["NC_HTTP_REQUEST"] = 1;
    var cc_div = document.getElementById('cc_'+cc+'_'+type_id);
    console.log(cc_div);

    if(cc_div.rel != 'updated'){
        cc_div.rel = 'updated';

        cc_div.innerHTML = "<img src='"+ICON_PATH+"trash-loader.gif' alt='' />";
        var xhr = new httpRequest();


        req = xhr.request('POST', url, {
            'cc':      cc,
            'date_b':  date_b,
            'date_e':  date_e,
            'type_id': type_id
        });

        res = xhr.getResponseText();

        // needTextArea.value = res;
        if(res){
            cc_div.innerHTML = res;
        }
    }
    else{
        toggle(cc_div);
    }

    return false;
}

/**
 * Отмечает все элементы типа checkbox в форме
 */
function nc_check_all() {
    var oIframe = top.frames['mainViewIframe'];
    var docum = (oIframe.contentWindow || oIframe.contentDocument || oIframe.document);

    if ( !docum.forms.length ) return true;
    var f = ( docum.forms.length == 1 ) ? docum.forms[0] : docum.forms['mainForm'];

    for (var i=0; i < f.length; i++) {
        var el = f.elements[i];
        if (el.tagName == "INPUT" && el.type=="checkbox") {
            el.checked = 'checked';
        }
    }

    return true;
}


nc_selectstatic = function () {
    this.nums = 0;
    this.div_id = 'select_static';
}
nc_selectstatic.prototype = {
    add: function (key, value) {
        this.nums++;
        if (key === undefined || key === null) { key = ''; }
        if (value === undefined || value === null) { value = ''; }

        if (this.nums == 1) { $nc('#select_static_head').show(); }

        var con_id = this.div_id + "_con_" + this.nums;
        $nc('#' + this.div_id).append("<div id='"+con_id+"'></div>");

        $nc('#' + con_id).append("<div class='key'><input name='select_static_key[" + this.nums + "]' type='text' value='" + key + "' /></div>");
        $nc('#' + con_id).append("<div class='value'><input name='select_static_value[" + this.nums + "]' type='text' value='" + value + "' /></div>");
        $nc('#' + con_id).append("<div class='drop' onclick='nc_s.drop(" + this.nums + ")'><div class='icons icon_delete' title='" + ncLang.Drop + "' style='margin-top:-3px'></div> " + ncLang.Drop + "</div>");
        $nc('#' + con_id).append("<div style='clear:both;'></div>");
    },

    drop: function ( id ) {
        $nc("#"+this.div_id+"_con_"+id).remove();
        this.nums--;
        if ( !this.nums  ) $nc('#select_static_head').hide();
    }
}
/**
 *
 * - Обработчики нажатий в формах внутри основного фрейма.
 * - messageInitDrag
 *
 */

/**
 * Обработка нажатия на элементы с атрибутом data-submit="1":
 * — если установлен атрибут data-confirm-message, будет создан запрос
 *   на подтверждение действия с указанным текстом;
 * — будет создана форма (метод POST) со значениями, перечисленными
 *   в параметре data-post в формате JSON
 */
$nc(function() {
    var buttons = $nc('[data-submit=1]');
    buttons.click(function(e) {
        var button = $nc(this),
            data = button.data('post'),
            message = button.data('confirmMessage');
        if (!message || confirm(message)) {
            var form = $nc('<form/>', {
                method: 'post',
                action: '?'
            }).hide().appendTo('body');
            for (var k in data) {
                form.append($nc('<input/>', {
                    type: 'hidden',
                    name: k,
                    value: data[k]
                }));
            }
            form.submit();
        }
    });
    // prevent middle click on these "buttons":
    $nc(document).on('click', buttons, function(e) {  // other ways do not work (jQ 1.10)
        if ($nc(e.target).closest('a').data('submit')) {
            e.preventDefault();
        }
    });

    var hide_aux_checkbox = $nc('#hide_aux');
    if (hide_aux_checkbox.length) {
        hide_aux_checkbox.change(function() {
            nc_component_reload_options($nc('select[name="Class_Groups"]').val());
        });

        nc_component_reload_options(null, false);
    }

    $nc(document).on('change', 'select[name="Class_Groups"]', function() {
        nc_component_reload_options($nc(this).val());
    });

    $nc(document).on('change', 'select[name="Class_ID"]', function() {
        nc_infoblock_on_component_change(this.options[this.selectedIndex], $nc(this).data('catalogue-id'));
    });
});

if (typeof formAsyncSaveEnabled === 'undefined') {
    formAsyncSaveEnabled = false;
}

$nc(function() {
    if ('nc_save_keycode' in window) {
        var e = 'keydown.nc_admin_form_save';
        $nc(document.body).on(e, formKeyHandler);
        // remove in NetCat 6 if that handler is still used
        if (window != top) {
            $nc(top.document.body).off(e).on(e, formKeyHandler);
        }
    }
});

/**
 * Form keyhandler (submits on enter, saves with XHR on Ctrl+Shift+S
 * @global {Boolean} formAsyncSaveEnabled
 */
function formKeyHandler(e) {
    //var kEnter = (e.keyCode==13),  // Enter pressed

    // Ctrl + (Shift +) S
    var bAutosave = (typeof nc_autosave_use !== "undefined" && nc_autosave_use == 1 && typeof nc_autosave_type !== "undefined" && nc_autosave_type === 'keyboard' && typeof autosave !== "undefined" && autosave !== null),
        kSave = (
            /* e.shiftKey && */
            e.ctrlKey &&
            e.keyCode == (nc_save_keycode ? Math.round(nc_save_keycode) : 83)
        );

    // SUBMIT on <ENTER>
    /*if (kEnter) {
     if (srcElement.tagName == 'INPUT' && srcElement.type=='text' && !srcElement.getAttribute('nosubmit')) {
     srcElement.form.submit();
     return;
     }
     else {
     return;
     }
     }*/

    if (!(kSave && (formAsyncSaveEnabled || bAutosave))) {
        return;
    }

    // SAVE on <CTRL+(SHIFT+)S>
    if (bAutosave) {
        autosave.saveAllData(autosave);
    } else {
        // update CodeMirror layers
        CMSaveAll();

        var iframe = false;
        $nc('iframe', parent.document).each(function() {
            if ($nc(this).attr('id') === 'mainViewIframe') {
                iframe = true;
            }
        });

        var $form = $nc(e.target).closest('form');
        if (!$form.length) {
            $form = top.$nc('form', nc_get_current_document());
        }
        if (!$form.length) {
            return;
        }

        formAsyncSave($form.eq(0), 0, 'formSaveStatus(1);');

        // inside_admin
        if (iframe) {
            parent.mainView.chan = 0;
            parent.mainView.displayStar(0);
        }
    }

    var originalEvent = e.originalEvent;
    if (originalEvent.stopPropagation) {
        originalEvent.stopPropagation();
        originalEvent.preventDefault();
    } else {
        try {
            originalEvent.keyCode = 0;
        } catch (exception) {}
        originalEvent.cancelBubble = true;
        originalEvent.returnValue = false;
    }

    return false;
}

/**
 * Form ajax saver
 * @param,String or object
 */
function formAsyncSave(form, statusHandlers, posteval) {
    if (!formAsyncSaveEnabled) {
        return;
    }

    var oForm;

    // object
    if (typeof form === 'object' && form.tagName === 'FORM') {
        oForm = form;
    }
    // get the form by ID
    if (typeof form === 'string') {
        oForm = document.getElementById(form);
    }
    // if it is not clear yet - save the FIRST form
    if (typeof oForm !== 'object') {
        oForm = document.getElementsByTagName("FORM")[0];
    }
    // no form!
    if (typeof oForm !== 'object') {
        return false;
    }

    if (oForm.onsubmit) {
        oForm.onsubmit();
    }

    var $form = $nc(oForm),
        flag = $nc('<input type="hidden" name="NC_HTTP_REQUEST" value="1">').appendTo($form),
        statusCode = {};

    // Эмуляция statusHandlers старого httpRequest, нужно будет убрать,
    // когда старые классы/функции будут убраны везде
    if ($nc.isEmptyObject(statusHandlers)) {
        statusHandlers = {
            '*': 'formSaveStatus(xhr);'
        };
    } else {
        for (var i in statusHandlers) {
            var body = statusHandlers[i].replace(/\bthis\b/, 'xhr');
            statusCode[i] = new Function('xhr', body);
        }
    }

    $form.ajaxSubmit({
        statusCode: statusCode,
        complete: new Function('xhr', statusHandlers['*'])
    });
    flag.remove();

    if (posteval) {
        eval(posteval);
    }
}

/**
 * Показать результат сохранения при помощи XHR
 * @param {Object} xhr   XHR object
 */
function formSaveStatus(xhr) {
    var dst = document.getElementById("formAsyncSaveStatus");
    if (!dst) {
        dst = createElement("DIV", {
            "id": "formAsyncSaveStatus"
        }, document.body);
    }

    dst.style.visibility = 'visible';
    dst.style.opacity = 1;
    dst.style.zIndex = 20000;

    dst.className = 'form_save_in_progress';
    dst.innerHTML = NETCAT_HTTP_REQUEST_SAVING;

    dst.style.top = Math.round(($nc('body').height() - $nc(dst).height()) / 2) + 'px';

    if (xhr.readyState && xhr.readyState > 3) {
        var errorMessage = "";

        var iframe = false;
        $nc('iframe', parent.document).each(function() {
            if ($nc(this).attr('id') === 'mainViewIframe') {
                iframe = true;
            }
        });

        // modal layer update
        if (!iframe) {
            $nc.ajax({
                'type': 'GET',
                'url': nc_page_url() + '&isNaked=1',
                success: function(response) {
                    nc_update_admin_mode_content(response);
                    $nc.modal.close();
                }
            });
        }

        if (xhr.status == "200") {
            var result = {};

            try {
                eval("var result = " + xhr.responseText);
            } catch (e) {
                if (xhr.responseText) {
                    errorMessage = xhr.responseText;
                }
            }

            if (result.error) {
                alert(result.error);
                errorMessage = result.error;
            } else {
                if (typeof(result.ui_config) !== 'undefined' && typeof(parent.mainView) !== 'undefined') {
                    var newSettings = result.ui_config;
                    parent.mainView.setHeader(newSettings.headerText, newSettings.subheaderText);

                    var tree;
                    if (newSettings.treeChanges && (tree = parent.document.getElementById('treeIframe').contentWindow.tree)) {
                        for (var method in newSettings.treeChanges) {
                            if (typeof tree[method] === 'function' && newSettings.treeChanges[method].length) {
                                for (var i = 0; i < newSettings.treeChanges[method].length; i++) {
                                    // call method in the tree
                                    tree[method](newSettings.treeChanges[method][i]);
                                }
                            }
                        }
                    }
                }

                dst.className = 'form_save_ok';
                dst.innerHTML = NETCAT_HTTP_REQUEST_SAVED;
                setTimeout(function() {
                    $nc(dst).remove();
                }, 2500);
            }

            if (result.update_html) {
                if (result.update_html) {
                    for (var selector in result.update_html) {
                        $nc(selector).html(result.update_html[selector]);
                    }
                }
            }

        } else {
            errorMessage = xhr.status + ". " + xhr.statusText;
        }

        if (errorMessage) {
            dst.className = 'form_save_error';
            dst.innerHTML = NETCAT_HTTP_REQUEST_ERROR;
            dst.error = errorMessage;
            setTimeout(function() {
                $nc(dst).remove();
            }, 5000);
        }
    }
}

function showFormSaveError() {
    alert(document.getElementById('formAsyncSaveStatus').error);
}

function loadCustomTplSettings(catalogueId, subdivisionId, templateId, parentSubdivisionId) {
    var is_parent_template = $nc('select[name=Template_ID] option:first').html() === $nc('select[name=Template_ID] option').filter(':selected').html();
    $nc('input[name=is_parent_template]').val(is_parent_template);
    $nc("#customTplSettings").html("");
    $nc("#loadTplWait").show();
    var xhr = new httpRequest;
    xhr.request('GET', top.ADMIN_PATH + 'template/custom_settings.php', {
        catalogue_id: catalogueId,
        sub_id: subdivisionId,
        parent_sub_id: parentSubdivisionId,
        template_id: templateId,
        is_parent_template: is_parent_template
    });
    // synchronous HTML-HTTP-request:
    document.getElementById('customTplSettings').innerHTML = xhr.getResponseText();
    if (templateId != 0) {
        document.getElementById('templateEditLink').onclick = function() {
            var suffix = File_Mode_IDs.indexOf('|' + templateId + '|') != -1 ? '_fs' : '';
            window.open(top.ADMIN_PATH + '#template' + suffix + '.edit(' + templateId + ')', 1)
        };
        $nc("#templateEditLink").removeAttr("disabled");
    }
    $nc(document).trigger("apply-upload");

    $nc("#loadTplWait").hide();
}

/**
 * ?
 * @param classId
 * @see /files/netcat/admin/subdivision/function.inc.php
 */
function loadClassDescription(classId) {
    var loadClassDescription = $nc('#loadClassDescription');
    if (classId && classId != '0') {
        $nc.ajax({
            url: top.ADMIN_PATH + 'class/get_class_description.php',
            method: 'GET',
            data: {
                class_id: classId
            },
            success: function(data) {
                loadClassDescription
                    .html(data);
            },
            error: function(error) {
                console.error(error);
            }

        });
    } else {
        loadClassDescription.empty();
    }
}

/**
 * Подгружает шаблон
 * @param classId
 * @param selectedId
 * @param catalogueId
 * @param is_mirror
 * @param source
 * @see /files/netcat/admin/subdivision/function.inc.php
 */
function loadClassTemplates(classId, selectedId, catalogueId, is_mirror, source) {
    var loadClassTemplates = $nc('#loadClassTemplates');

    if (source == undefined) {
        source = 'class';
    }
    if (classId && classId != '0') {
        $nc.ajax({
            url: top.ADMIN_PATH + source + '/get_class_templates.php',
            method: 'GET',
            data: {
                class_id: classId,
                selected_id: selectedId,
                catalogue_id: catalogueId,
                is_mirror: is_mirror
            },
            success: function(data) {
                loadClassTemplates
                    .html(data);
            },
            error: function(error) {
                console.error(error);
            }
        });
    } else {
        loadClassTemplates.empty();
    }
}

/***
 * Отображать "пользовательские настройки", которые были указаны при создании компонента
 * @param classId Class ID
 * @param infoblockId
 * @see /files/netcat/admin/subdivision/function.inc.php
 */
function loadClassCustomSettings(classId, infoblockId) {
    var loadClassCustomSettings = $nc('#loadClassCustomSettings');
    if (classId && classId != '0') {
        $nc.ajax({
            url: top.ADMIN_PATH + 'class/get_class_custom_settings.php',
            method: 'GET',
            data: {
                class_id: classId,
                infoblock_id: infoblockId || ''
            },
            success: function(data) {
                loadClassCustomSettings
                    .html(data);
            },
            error: function(error) {
                console.error(error);
            }
        });
    } else {
        loadClassCustomSettings.empty();
    }
}

function setInfoblockName(infoblockItem) {
    var ClassName = $nc('input[name="SubClassName"]'),
        EnglishName = $nc('input[name="EnglishName"][data-from="SubClassName"]'),
        toRemove = $nc(infoblockItem).val() + '. ';

    if (!ClassName.val() || (ClassName.attr('data-changed') !== 'yes')) {
        ClassName.val($nc(infoblockItem).text().replace(toRemove, ''));
    }

    if (!EnglishName.val() || (EnglishName.attr('data-changed') !== 'yes')) {
        EnglishName.val(transliterate($nc(infoblockItem).text().replace(toRemove, ''), 'yes'));
    }
}

function inputTextClassName() {
    var optionFirstSelect = 'select[name="Class_ID"] > option:visible:first',
        listInput = [
            'input[name="SubClassName"]',
            'input[name="EnglishName"][data-from="SubClassName"]'
        ],
        textFirst = $nc(optionFirstSelect)
            .text()
            .replace($nc(optionFirstSelect).val() + '.', '')
            .trim();

    listInput.forEach(function(val) {
        $nc(val).on('input', function() {
            var self = $nc(this);
            if (!self.val()) {
                self.attr('data-changed', 'no');
            } else {
                self.attr('data-changed', 'yes');
            }
        });
    });

    if (!$nc(listInput[0]).val() || ($nc(listInput[0]).attr('data-changed') !== 'yes')) {
        $nc(listInput[0]).val(textFirst);
    }

    if (!$nc(listInput[1]).val() || ($nc(listInput[1]).attr('data-changed') !== 'yes')) {
        $nc(listInput[1]).val(transliterate(textFirst, 'yes'));
    }
}

function onchageSubClassType(conditions) {
    if (conditions) {
        $nc("#nc_class_select").hide();
        $nc("#loadClassCustomSettings").hide();
        $nc("#nc_infoblock_select").hide();
        $nc("#nc_mirror_select").show();
        $nc("#loadClassTemplates").html("");
        $nc('.tableComponent').hide();
        $nc('input[name="EnglishName"][data-from="SubClassName"]').val('');
        $nc('input[name="SubClassName"]').val('');
    } else {
        $nc("#nc_class_select").show();
        $nc("#nc_infoblock_select").show();
        $nc("#nc_mirror_select").hide();
        $nc("#loadClassTemplates").html("");
        $nc('.tableComponent').show();
    }
}

function loadSubdivisionAddForm(catalogueId, subId) {
    var oFormDiv;
    if (subId) {
        oFormDiv = document.getElementById('sub-' + subId);
    } else {
        oFormDiv = document.getElementById('site-' + catalogueId);
    }

    if (oFormDiv.innerHTML) {
        oFormDiv.innerHTML = '';
    } else {
        var xhr = new httpRequest;
        xhr.request('GET', top.ADMIN_PATH + 'wizard/subdivision_add_form.php', {
            catalogue_id: catalogueId,
            sub_id: subId
        });
        // synchronous HTML-HTTP-request:
        var oForm = document.createElement("form");
        oForm.id = 'ajaxSubdivisionAdd';
        oForm.name = 'ajaxSubdivisionAdd';
        oForm.innerHTML = xhr.getResponseText();
        oFormDiv.appendChild(oForm);
    }
}

//Subdivision_Name, EnglishName, TemplateID, ClassID
function saveSubdivisionAddForm() {
    var oSubdivisionForm = document.getElementById('ajaxSubdivisionAdd');

    var subdivisionName = oSubdivisionForm.Subdivision_Name.value,
        englishName = oSubdivisionForm.EnglishName.value,
        templateId = oSubdivisionForm.TemplateID.value,
        classId = oSubdivisionForm.ClassID.value,
        catalogueId = oSubdivisionForm.CatalogueID.value,
        subId = oSubdivisionForm.SubdivisionID.value,
        token = oSubdivisionForm.nc_token.value;

    var xhr = new httpRequest;
    xhr.request('GET', top.ADMIN_PATH + 'wizard/subdivision_add.php', {
        subdivision_name: subdivisionName,
        english_name: englishName,
        template_id: templateId,
        class_id: classId,
        catalogue_id: catalogueId,
        sub_id: subId,
        nc_token: token
    });
    // synchronous HTML-HTTP-request:

    var result = xhr.getResponseText();
    if (isNaN(result)) {
        var dst = document.getElementById("formAsyncSaveStatus");
        if (!dst) {
            dst = createElement("DIV", {
                "id": "formAsyncSaveStatus"
            }, document.body);
        }
        dst.style.visibility = 'visible';
        dst.style.opacity = 1;
        dst.className = 'form_save_error';
        dst.innerHTML = result;
        setTimeout("fadeOut('formAsyncSaveStatus')", 5000);
        return;
    }

    var oFormDiv, oInsertBeforeTr;

    if (subId != 0) {
        oFormDiv = document.getElementById('sub-' + subId);
        oInsertBeforeTr = document.getElementById('tr-' + subId);
    } else {
        oFormDiv = document.getElementById('site-' + catalogueId);
        oInsertBeforeTr = document.getElementById('site_tr-' + catalogueId);
    }

    var oTr1 = document.createElement('tr');
    oTr1.id = 'tr-' + result;
    oTr1.setAttribute('parentsub', subId);

    var oTr2 = document.createElement('tr');

    var oTd1 = document.createElement('td');
    oTd1.className = 'name active';

    var oTd2 = document.createElement('td');
    oTd2.className = 'button';

    var oTd3 = document.createElement('td');
    oTd3.colSpan = 2;
    oTd3.style.backgroundColor = '#FFFFFF';

    if (isNaN(parseInt(oInsertBeforeTr.firstChild.style.paddingLeft))) {
        oTd1.style.paddingLeft = 16;
        oTd3.style.padding = '0 0 0 16';
    } else {
        oTd1.style.paddingLeft = parseInt(oInsertBeforeTr.firstChild.style.paddingLeft) + 20;
        oTd3.style.paddingLeft = parseInt(oInsertBeforeTr.firstChild.style.paddingLeft) + 20;
        oTd3.style.paddingRight = 0;
        oTd3.style.paddingTop = 0;
        oTd3.style.paddingBottom = 0;
    }

    var oA1 = document.createElement('a');
    oA1.href = 'index.php?phase=4&SubdivisionID=' + result;
    oA1.innerHTML = subdivisionName;

    var oA2 = document.createElement('a');
    oA2.href = '#';
    oA2.onclick = function() {
        loadSubdivisionAddForm(catalogueId, result);
    };

    var oImg1 = document.createElement('img');
    oImg1.src = ADMIN_PATH + 'images/arrow_sec.gif';
    oImg1.width = '14';
    oImg1.height = '10';
    oImg1.alt = '';
    oImg1.title = '';

    var oImg2 = document.createElement('img');
    oImg2.src = ICON_PATH + 'i_folder_add.gif';
    oImg2.alt = ncLang.addSubsection;
    oImg2.title = ncLang.addSubsection;

    var oSpan = document.createElement('span');
    oSpan.innerHTML = result + '. ';

    oTd1.appendChild(oImg1);
    oTd1.appendChild(oSpan);
    oTd1.appendChild(oA1);

    oA2.appendChild(oImg2);

    oTd2.appendChild(oA2);

    oTr1.appendChild(oTd1);
    oTr1.appendChild(oTd2);

    var oDiv = document.createElement('div');
    oDiv.id = 'sub-' + result;

    oTr2.appendChild(oTd3);
    oTd3.appendChild(oDiv);

    bindEvent(oTr1, 'mouseover', siteMapMouseOver);
    bindEvent(oTr1, 'mouseout', siteMapMouseOut);

    bindEvent(oTr2, 'mouseover', siteMapMouseOver);
    bindEvent(oTr2, 'mouseout', siteMapMouseOut);

    oInsertBeforeTr.parentNode.insertBefore(oTr2, oInsertBeforeTr.nextSibling.nextSibling);
    oInsertBeforeTr.parentNode.insertBefore(oTr1, oInsertBeforeTr.nextSibling.nextSibling);
    oForm.parentNode.removeChild(oForm);
}

/**
 * привязать драг-дроп к s_list_class
 */
function messageInitDrag(messageList, allowChangePriority) {
    if (!messageList) {
        return;
    }

    var current_document = nc_get_current_document();

    for (var classId in messageList) {
        for (var i = 0; i < messageList[classId].length; i++) {
            var messageId = messageList[classId][i];
            var container = current_document.getElementById('message' + classId + '-' + messageId),
                handler = current_document.getElementById('message' + classId + '-' + messageId + '_handler');

            if (!container || !handler || !top.dragManager) {
                continue;
            }

            top.dragManager.addDraggable(handler, container);

            if (allowChangePriority) {
                top.dragManager.addDroppable(container, messageAcceptDrop, messageOnDrop, {
                    name: 'arrowRight',
                    bottom: 2,
                    left: 0
                });
            }

            // убрать selectstart с плашки с ID и кнопками (IE)
            handler.parentNode.onselectstart = top.dragManager.cancelEvent;
        }
    }
}

/**
 *
 */
function messageAcceptDrop(e) {
    var //dragged = top.dragManager.draggedInstance,
        target = top.dragManager.droppedInstance;

    // объект можно бросить на другой объект (если это не родительский) - сменить проритет
    // перемещать только в пределах того же родителя
    if (target.type === 'message' && this.getAttribute('messageParent') === top.dragManager.draggedObject.getAttribute('messageParent')) {
        return true;
    }

    return false;
}

function messageOnDrop(e) {
    var dragged = top.dragManager.draggedInstance,
        target = top.dragManager.droppedInstance,
        xhr = new httpRequest();

    var res = xhr.getJson(top.ADMIN_PATH + 'subdivision/drag_manager_message.php',
        {
            'dragged_type': dragged.type,
            'dragged_class': dragged.typeNum,
            'dragged_id': dragged.id,
            'target_type': target.type,
            'target_class': target.typeNum,
            'target_id': target.id
        });

    // (смена проритета)
    if (res && target.type === 'message') {
        var oParent = top.dragManager.draggedObject.parentNode;

        oParent.removeChild(top.dragManager.draggedObject);
        // если this.nextSibling не определен, то insertBefore вставляет в конец родительского элемента
        oParent.insertBefore(top.dragManager.draggedObject, this.nextSibling);
    }
}

function SendClassPreview(form, oTarget) {
    var oForm;
    // object
    if (typeof form === 'object' && form.tagName === 'FORM') {
        oForm = form;
    }
    // get the form by ID
    if (typeof form === 'string') {
        oForm = document.getElementById(form);
    }
    // if it is not clear yet - save the FIRST form
    if (typeof oForm !== 'object' || oForm == null) {
        oForm = document.getElementsByTagName("FORM")[0];
    }
    // no form!
    if (typeof oForm !== 'object') {
        return false;
    }

    if (typeof oTarget === 'undefined' || oTarget == null) {
        oTarget = '';
    }
    if (typeof oTarget !== 'string') {
        oTarget = oTarget.toString();
    }

    if (isFinite(oForm.ClassID.value)) {
        var old_action = oForm.getAttribute("action");
        var old_target = oForm.getAttribute("target");
        oForm.setAttribute("action", oTarget + "?classPreview=" + oForm.ClassID.value);
        oForm.setAttribute("target", "_blank");
        oForm.submit();
        oForm.setAttribute("action", old_action);
        oForm.setAttribute("target", old_target);
    }
}

function SendTemplatePreview(form, oTarget) {
    var oForm;
    // object
    if (typeof form === 'object' && form.tagName === 'FORM') {
        oForm = form;
    }
    // get the form by ID
    if (typeof form === 'string') {
        oForm = document.getElementById(form);
    }
    // if it is not clear yet - save the FIRST form
    if (typeof oForm !== 'object' || oForm == null) {
        oForm = document.getElementsByTagName("FORM")[0];
    }
    // no form!
    if (typeof oForm !== 'object') {
        return false;
    }

    if (typeof oTarget === 'undefined' || oTarget == null) {
        oTarget = '';
    }
    if (typeof oTarget !== 'string') {
        oTarget = oTarget.toString();
    }

    if (isFinite(oForm.TemplateID.value)) {
        var old_action = oForm.getAttribute("action");
        var old_target = oForm.getAttribute("target");
        oForm.setAttribute("action", oTarget + "?templatePreview=" + oForm.TemplateID.value);
        oForm.setAttribute("target", "_blank");
        oForm.submit();
        oForm.setAttribute("action", old_action);
        oForm.setAttribute("target", old_target);
    }
}

function generateForm(classID, sysTable, act, confirmation) {
    if (!classID || !act) {
        return false;
    }

    var values = [];
    var res, confirmText;
    var url = NETCAT_PATH + 'alter_form.php';
    var needTextArea = document.getElementById(act);

    // выгружаем данные из редактора
    if (typeof $nc(needTextArea).codemirror === 'function') {
        $nc(needTextArea).codemirror('save');
    }

    // если поле не пустое - вызываем диалог
    if (needTextArea.value && !confirmation) {
        var dlgValue = confirm(ncLang["Warn" + act]);

        if (dlgValue) {
            generateForm(classID, sysTable, act, 1);
        }
        return false;
    }

    // предупредить сервер, что данные переданы через Ajax в кодировке utf8
    values["NC_HTTP_REQUEST"] = 1;

    // инициализируем
    var xhr = new httpRequest();

    xhr.request('POST', url, {
        'classID': classID,
        'act': act,
        'systemTableID': sysTable,
        'fs': $nc('input[name=fs]', nc_get_current_document()).val()
    });

    res = xhr.getResponseText();

    needTextArea.value = res;
    if (typeof $nc(needTextArea).codemirror === 'function') {
        $nc(needTextArea).codemirror('setValue');
    }

    return false;
}

function generate_widget_form(widgetclass_id, action, confirm) {
    var textarea = document.getElementById(action);
    var url = NETCAT_PATH + 'admin/widget/index.php?phase=90';

    var xhr = new httpRequest(false);
    xhr.request('POST', url, {
        'Widget_Class_ID': widgetclass_id,
        'action': action
    });
    textarea.value = xhr.getResponseText();
    if (typeof $nc(textarea).codemirror === 'function') {
        $nc(textarea).codemirror('setValue');
    }

    return false;
}

/**
 * Привязать к textarea кнопки изменения размера
 */
function bindTextareaResizeButtons() {
    $nc('TEXTAREA').each(function() {
        var $this = $nc(this);
        if (!$this.prev().is('.resize_block')) {
            $nc('<div class="resize_block"><a class="textarea_shrink nc-label nc--lighten" href="#" >&#x25B2;</a> <a class="textarea_grow nc-label nc--lighten" href="#">&#x25BC;</a></div>').insertBefore($this);
        }
        return true;
    });

    $nc('.resize_block A.textarea_shrink, .resize_block A.textarea_grow').bind('click', function() {
        var $this = $nc(this);
        var $textarea = $this.closest('.resize_block').next();
        var height;
        var heightModifier = $this.hasClass('textarea_shrink') ? -50 : 50;
        if (!$textarea.is('TEXTAREA')) {
            $textarea = $textarea.find('TEXTAREA');
        }

        if ($textarea.is('TEXTAREA')) {
            if ($textarea.hasClass('has_codemirror')) {
                var cmEditor = $textarea.data('codemirror');
                if (cmEditor) {
                    var $scrollElement = $nc(cmEditor.getScrollerElement());
                    height = $scrollElement.height() + heightModifier;
                    if (height >= 100) {
                        cmEditor.setSize(null, height);
                    }
                }
            } else {
                height = $textarea.height() + heightModifier;
                if (height >= 100) {
                    $textarea.height(height);
                }
            }
        }
        return false;
    });
}

/**
 * Блок выбора компонента и шаблона компонента (диалог добавления инфоблока;
 * может использоваться и на других страницах)
 */
function nc_component_select_init(form) {
    var component_select = form.find('select.nc-infoblock-component-select'),
        template_select_div = form.find('.nc-infoblock-template-select'),
        template_select_buttons = form.find('.nc-infoblock-template-list-buttons .nc-btn'),
        custom_settings_div = form.find('.nc-infoblock-template-custom-settings'),
        preview_div = form.find('.nc-infoblock-template-preview'),
        show_all_components_checkbox = form.find('input.nc-infoblock-show-all-components'),
        current_component_id,
        component_filter_input = form.find('.nc-infoblock-component-filter input');

    // выбор первого видимого компонента
    function select_first_component() {
        component_select.find('option').first().prop('selected', true);
        component_select.change();
    }

    // Нажатие ↑↓ в поле фильтра
    function on_component_filter_arrows(keycode) {
        var options = component_select.find('option'),
            selected_index = options.index(component_select.find('option:selected')),
            new_selected_option;

        if (keycode == 38 && selected_index > 0) { // up key
            new_selected_option = -1;
        }
        if (keycode == 40 && selected_index != options.length - 1) { // down key
            new_selected_option = +1;
        }
        if (new_selected_option) {
            options.eq(selected_index + new_selected_option).prop('selected', true);
            component_select.change();
        }
    }

    // Загрузка информации о компоненте
    var last_template_data_request;

    function request_template_data(component_id) {
        if (last_template_data_request) {
            last_template_data_request.abort();
        }

        preview_div.css('background-image', '').find('.nc--loading').show();
        preview_div.find('span').hide();

        last_template_data_request = $nc.getJSON(NETCAT_PATH + 'action.php', {
            ctrl: 'admin.infoblock',
            action: 'get_component_template_settings',
            component_id: component_id
        }, function(result) {
            if (!result || !result.length) {
                return;
            }

            if (!show_all_components_checkbox.is(':checked')) {
                result = $nc.grep(result, function(item) {
                    return item.multiple_mode == '1';
                });
            }

            if (result.length < 2) {
                set_single_template(result[0]);
            } else {
                set_templates(result);
            }
        });

        return last_template_data_request;
    }

    // Обновление данных, когда нет выбора шаблона компонента
    function set_single_template(template_data) {
        template_select_div.html(
            template_data.name +
            '<input type="hidden" name="data[Class_Template_ID]" value="' + template_data.id + '">'
        );
        template_select_buttons.hide();
        set_current_template_data(template_data);
    }

    // Обновление данных о шаблонах компонента
    function set_templates(templates) {
        // <select>
        var select = $nc('<select name="data[Class_Template_ID]" />').change(on_template_select_change);
        $nc.each(templates, function(i, template_data) {
            $nc('<option />')
                .val(template_data.id)
                .html(template_data.name)
                .data('template_data', template_data)
                .appendTo(select);
        });
        template_select_div.empty().append(select);

        // кнопки
        template_select_buttons.show();
        template_select_buttons.eq(0).addClass('nc--disabled');
        template_select_buttons.eq(1).removeClass('nc--disabled');

        // скриншот и настройки
        set_current_template_data(templates[0]);
    }

    // Установка данных шаблона компонента
    function set_current_template_data(template_data) {
        // сохранение существующих настроек шаблона
        var values = {};
        custom_settings_div.find('input,select,textarea').each(function() {
            values[this.name] = $nc(this).val();
        });

        preview_div.find('span').toggle(!template_data.preview);
        if (template_data.preview) {
            preview_div.css('background-image', 'url(' + template_data.preview + ')');
        }
        preview_div.find('.nc--loading').hide();
        custom_settings_div.html(template_data.settings);

        // восстановление настроек шаблона
        for (var k in values) {
            custom_settings_div.find('[name="' + k + '"]').val(values[k]);
        }
    }

    // Событие при изменении шаблона компонента в списке (this == select)
    function on_template_select_change() {
        var options = $nc(this).find('option'),
            selected_option = options.filter(':selected'),
            selected_index = options.index(selected_option);

        set_current_template_data(selected_option.data('template_data'));
        // обновить состояние кнопок
        template_select_buttons.eq(0).toggleClass('nc--disabled', selected_index == 0);
        template_select_buttons.eq(1).toggleClass('nc--disabled', selected_index == options.length - 1);
    }

    // Вспомогательная функция для кнопок «предыдущий/следующий шаблон»
    function set_template_select_index(shift) {
        var select = template_select_div.find('select'),
            options = select.find('option'),
            selected_option = options.filter(':selected'),
            new_index = options.index(selected_option) + shift;
        if (new_index >= 0 && new_index < options.length) {
            options.eq(new_index).prop('selected', true);
            select.change();
        }
    }

    // В IE нельзя спрятать <option> стилями, в Chrome есть отдельные проблемы
    // с этим (не работает option:visible).
    // Для переключения списков компонентов придётся манипулировать DOM’ом
    function update_component_select() {
        var show_all = show_all_components_checkbox.is(':checked'),
            name_filter = component_filter_input.val(),
            selected_option_value = component_select.val();

        if (!component_select.data('all_options')) {
            component_select.data('all_options', component_select.html());
        }

        component_select.html(component_select.data('all_options')).val(selected_option_value);

        if (!show_all || name_filter) {
            var name_regexp = name_filter && name_filter.length ? new RegExp(name_filter, 'i') : null;
            // remove <option>s that do not match criteria
            component_select.find('option').each(function() {
                var option = $nc(this),
                    remove =
                        (!show_all && !option.hasClass('nc--component-multiple')) ||
                        (name_regexp && !name_regexp.test(option.html()));
                if (remove) {
                    option.remove();
                }
            });
            // remove empty <optgroup>s
            component_select.find('optgroup:not(:has(option))').remove();
        }

        if (!component_select.find('option[value="' + selected_option_value + '"]').length) {
            select_first_component();
        }
    }

    // --- Инициализация обработчиков событий ---

    // обработка нажатий в поле фильтра
    component_filter_input.on('keyup', function(e) {
        if (e.which == 38 || e.which == 40) { // up & down
            on_component_filter_arrows(e.which);
        } else {
            update_component_select();
        }
    });

    // Нажатие на × в поле фильтра
    form.find('.nc-infoblock-component-filter .nc--remove').click(function() {
        if (component_filter_input.val() != '') {
            component_filter_input.val('');
            update_component_select();
        }
    });

    // Выбор компонента в списке
    component_select.change(function() {
        var component_id = component_select.val();

        if (current_component_id == component_id) {
            return;
        }

        current_component_id = component_id;

        // Название для инфоблока по умолчанию возьмём из названия компонента
        var infoblock_name = component_select.find('option:selected').html().replace(/^\d+\. /, '');
        form.find('input[name="data[Sub_Class_Name]"]').val(infoblock_name);

        request_template_data(component_id);
    });

    // Кнопка «предыдущий шаблон»
    template_select_buttons.eq(0).click(function() {
        set_template_select_index(-1);
    });

    // Кнопка «следующий шаблон»
    template_select_buttons.eq(1).click(function() {
        set_template_select_index(+1);
    });

    // Чекбокс «показать все»
    show_all_components_checkbox.change(function() {
        update_component_select();
        request_template_data(component_select.val()); // reload to update template list
    });

    // Фильтрация списка компонентов
    update_component_select();

    // Выбор первой позиции (после выполнения прочих действий — например, после открытия диалога)
    setTimeout(select_first_component, 1);
}

function nc_infoblock_on_component_change(option, catalogue_id) {
    catalogue_id = catalogue_id || 0;

    if (option) {
        var class_id = option.value;
        loadClassCustomSettings(class_id);
        loadClassDescription(class_id);
        loadClassTemplates(class_id, 0, catalogue_id);
        setInfoblockName(option);
    }
}

function nc_component_reload_options(selected_group) {
    var show_all = $nc('#hide_aux').is(':checked');
    var catalogue_id = $nc('#Class_ID').data('catalogue-id');
    var action = 'subdivision.add';

    if (/^#subclass\.add/.test(parent.location.hash)) {
        action = 'subclass.add';
    }
    var query_string = '?catalogue_id=' + catalogue_id + '&action=' + action;
    $nc.getJSON(ADMIN_PATH + 'class/get_class_list.php' + query_string, {}, function(class_list) {
        var class_groups_select = $nc('select[name=Class_Groups]');
        var class_select = $nc('select[name=Class_ID]');
        class_groups_select.html('');

        for (var group in class_list['groups']) {
            var group_info = class_list['groups'][group];
            var is_skippable_auxiliary_group = group_info['is_auxiliary'] && !group_info['selected'] && !show_all;
            if (is_skippable_auxiliary_group) {
                continue;
            }
            var group_option;

            if (group_info['is_delimiter']) {
                group_option = $nc("<option disabled='disabled' data-delimiter='true'>" + group_info['text'] + "</option>");
            } else {
                var is_preselected = !selected_group && group_info['selected'];
                var is_matched_with_selected_group = selected_group && (group_info['value'] === selected_group);

                group_option = $nc("<option/>")
                    .attr('value', group_info['value'])
                    .attr('class', group_info['is_dummy'] || group_info['is_auxiliary'] ? 'nc-text-grey' : '')
                    .attr('data-property', true)
                    .attr('data-group-name', group_info['name'])
                    .html(group_info['text']);

                if (is_preselected || is_matched_with_selected_group) {
                    group_option.prop('selected', 'selected');
                }
            }

            if (group_option) {
                class_groups_select.append(group_option);
            }
        }

        if (class_groups_select.find('option[data-property="true"]:checked').length === 0) {
            class_groups_select.find('option[data-property="true"]:first').prop('selected', 'selected');
            class_groups_select.val(class_groups_select.find('option[data-property="true"]:first').val());
        }

        class_select.html('');

        class_list['components'].forEach(function(component_info) {
            var target_group = class_groups_select.find('option:checked').attr('data-group-name');
            var is_skippable_auxiliary_class = component_info['is_auxiliary'] && !component_info['selected'] && !show_all;

            if (is_skippable_auxiliary_class || component_info['group'] !== target_group) {
                return;
            }

            var component_option = $nc("<option/>")
                .attr('value', component_info['value'])
                .attr('class', component_info['is_dummy'] || component_info['is_auxiliary'] ? 'nc-text-grey' : '')
                .text(component_info['text']);
            if (component_info['selected']) {
                component_option.prop('selected', 'selected');
            }
            class_select.append(component_option);
        });

        if (class_select.find('option:checked').length === 0) {
            class_select.find('option:first').prop('selected', 'selected');
            class_select.val(class_select.find('option:first').val());
        }

        class_select.change();
        inputTextClassName();
    });
}


var dragLabel = null;

dragManager = {
    dragInProgress: false,
    dragLabel: null,
    draggedObject: null,
    dropTargetObject: null,
    dropPositionIndicator: null,
    dropPositionImages: {},

    // координаты начала перетаскивания
    dragEventX: 0,
    dragEventY: 0,
    // флаг видимости dragLabel (метка видна только если курсор при перетаскивании отклонился на определенное расстояние)
    dragLabelVisible: false,

    // тип и ID перетаскиваемого объекта в netcat
    draggedInstance: {}, // { type: x, id: n }
    // то же для объекта, на который перетаскиваем
    droppedInstance: {},

    init: function() {
        this.dragLabel = createElement('DIV', {
            id: 'dragLabel',
            'style.display': 'none'
        }, document.body);
        this.dropPositionIndicator = createElement('IMG', {
            id: 'dropPositionIndicator',
            'style.display': 'none',
            'style.position': 'absolute',
            'style.zIndex': 5000
        }, document.body);

        // preload drop position indicators
        this.dropPositionImages.arrowRight = new Image();
        this.dropPositionImages.arrowRight.src = ICON_PATH + 'drop_arrow_right.gif';

        this.dropPositionImages.arrowTop = new Image();
        this.dropPositionImages.arrowTop.src = ICON_PATH + 'drop_arrow_top.gif';

        this.dropPositionImages.line = new Image();
        this.dropPositionImages.line.src = ICON_PATH + 'drop_line.gif';

    }, // end of dragManager.init ------

    // init event listeners on drag start
    initHandlers: function() {
        dragManager.initHandlersInWindow(window);

        var frames = document.getElementsByTagName('IFRAME');
        for (var i=0; i<frames.length; i++) {
            if (frames[i].src.search(/^chrome-/) === -1) {
                dragManager.initHandlersInWindow(frames[i].contentWindow);
            }
        }
    },  // end of initHandlers

    initHandlersInWindow: function(targetWindow) {
        // store frame coords
        if (targetWindow.frameElement) {
            targetWindow.frameOffset = getOffset(targetWindow.frameElement);
        }
        else {
            targetWindow.frameOffset = {
                left: 0,
                top: 0
            };
        }

        // (1) onmousemove
        targetWindow.document.onmousemove = function(e) {
            if (targetWindow != top) targetWindow.scroller.scroll(e);

            if (targetWindow.event) { // IE
                e = targetWindow.event;
            }

            var x = e.clientX + targetWindow.frameOffset.left;
            var y = e.clientY + targetWindow.frameOffset.top;
            dragManager.labelMove(x, y);
        };

        targetWindow.document.onmouseout = function(e) {
            targetWindow.scroller.scrollStop(e);
        };

        // (2) onmouseup
        targetWindow.mouseUpEventId = bindEvent(targetWindow.document, 'mouseup', dragManager.dragEnd);
    },

    removeHandlers: function() {
        dragManager.removeHandlersInWindow(window);

        var frames = document.getElementsByTagName('IFRAME');
        for (var i=0; i<frames.length; i++) {
            if (frames[i].src.search(/^chrome-/) === -1) {
                dragManager.removeHandlersInWindow(frames[i].contentWindow);
            }
        }
    },

    removeHandlersInWindow: function(targetWindow) {
        // (1) onmousemove
        targetWindow.document.onmousemove = null;
        targetWindow.document.onmouseout = null;
        if (targetWindow.scroller) targetWindow.scroller.scrollStop();
        // (2) onmouseup
        unbindEvent(targetWindow.mouseUpEventId);
    },


    idRegexp: /_?([a-z]+)(\d+)?\-([a-f\d]+)$/i, // class-123, message12-345

    // получить тип и ID сущности netcat из ID html-элемента
    // напр., "siteTree_sub-348") -> { type: 'sub', id: '348' }
    // "mainViewToolbar_subclass-223" -> { type: 'subclass', id: '223' }
    // в случае message - еще параметр typeNum
    // "message12-345 -> { type : 'message', typeNum: 12, id: 345 }
    /**
     * Получить параметры перетаскиваемого объекта, необходимые для обработки
     * перетаскивания
     * @param object
     * @returns {*}
     */
    getInstanceData: function(object) {
        var result = this.getInstanceDataFromID(object.id);
        if (result.type && object.treeInstanceName) {
            result.treeInstanceName = object.treeInstanceName;
        }
        return result;
    },

    /**
     * Получить тип и ID сущности netcat из ID html-элемента
     * напр., "siteTree_sub-348" → { type: 'sub', id: '348' }
     * "mainViewToolbar_subclass-223" -> { type: 'subclass', id: '223' }
     * в случае message - еще параметр typeNum
     * "message12-345 -> { type : 'message', typeNum: 12, id: 345 }
     */
    getInstanceDataFromID: function(objectId) {
        var matches = objectId.match(dragManager.idRegexp);
        if (matches) {
            return {
                type: matches[1],
                typeNum: matches[2],
                id: matches[3]
            };
        }
        else {
            return {};
        }
    },

    /**
    * Функция-обработчик для объектов, которые объявлены как droppable
    * - определяет, может ли объект выступать в качестве цели для перетаскивания
    * - если да, перемещает индикаторы перетаскивания
    *
    * Должна быть *применена* (applied) к объекту (нужно использовать bindEvent)
    */
    dropTargetMouseOver: function(e) {
        if (!dragManager.dragInProgress) {
            return false;
        }

        if (!this.acceptsDrop) {
            return false;
        }

        if (dragManager.draggedObject == this) {
            return false;
        }

        var parentObject = this.parentNode;

        while (parentObject) {
            if (parentObject == dragManager.draggedObject) {
                return false;
            }
            parentObject = parentObject.parentNode;
        }

        dragManager.droppedInstance = dragManager.getInstanceData(this.id ? this : this.parentNode);

        if (this.acceptsDrop(this)) {
            // save the object as current target for the drop
            dragManager.dropTargetObject = this;
            if (this.dropIndicator && dragManager.dropPositionImages[this.dropIndicator.name]) {
                var ind = dragManager.dropPositionIndicator;
				if (this.ownerDocument != ind.ownerDocument) {
					var local_ind = $nc(this.ownerDocument.body).data('dropPositionIndicator');
					if (!local_ind) {
						local_ind = $nc(ind).clone(true);
						$nc(this.ownerDocument.body).append(local_ind);
						local_ind = local_ind.get(0);
						$nc(this.ownerDocument.body).data('dropPositionIndicator', local_ind);
					}
					ind  = local_ind;
					dragManager.dropPositionIndicator = ind;
				}
                ind.src = dragManager.dropPositionImages[this.dropIndicator.name].src;
                var pos = getOffset(this, false, false),
                    top = this.dropIndicator.top ? this.dropIndicator.top
                                                 : this.offsetHeight + this.dropIndicator.bottom;
                // положение «индикатора» настраивается в параметрах dropIndicator —
                // см. соответствующие вызовы addDroppable()
                ind.style.top = pos.top + top + 'px';
                ind.style.left = pos.left + this.dropIndicator.left + 'px';
                ind.style.display = '';
            }
        } // of accepts drop

        // stop event propagation
        if (e && e.stopPropagation) {
            e.stopPropagation();
        }
        else {
            if (this.document.parentWindow.event) {
                this.document.parentWindow.event.cancelBubble = true;
            }
        }
    },

    dropTargetMouseOut: function(e) {
        if (!dragManager.dragInProgress) {
            return;
        }
        dragManager.dropTargetObject = null;
        dragManager.droppedInstance = {};
        dragManager.dropPositionIndicator.style.display = 'none';
    },


    labelSetHTML: function(html) {
        this.dragLabel.innerHTML = html;
    },

    //
    labelMove: function(x, y, frameId) {
        // show only if mouse moved already for more than 12px
        if (!this.dragLabelVisible) {
            if (Math.abs(x - this.dragEventX) > 12 || Math.abs(y - this.dragEventY) > 12) {
                this.dragLabelVisible = true;
                this.dragLabel.style.display = '';
            }
        }
        if (!this.dragLabelVisible) return;

        this.dragLabel.style.top = y + 10 + 'px';
        this.dragLabel.style.left = x + 10 + 'px';

    }, // end of dragManager.labelMove


    /**
    * Сделать объект перетаскиваемым
    * @param {Object} handlerObject объект-обработчик перетаскивания ("ручка", за
    *   которую можно "тащить" объект draggedObject)
    * @param {Object} draggedObject объект, который собственно перетаскивается
    *   (если не указан, то это собственно handlerObject)
    */
    addDraggable: function(handlerObject, draggedObject) {
        handlerObject.ondragstart = dragManager.cancelEvent;
        if (!draggedObject) draggedObject = handlerObject;

        if (
            typeof(handlerObject['tagName']) != 'undefined' &&
                typeof(handlerObject['className']) != 'undefined' &&
                handlerObject.tagName == 'I' &&
                handlerObject.className
        ) {
            var classNames = handlerObject.className.split(' ');
            for (var i in classNames) {
                var className = classNames[i];
                if (className.replace(/\s/g, '') == 'nc-icon') {
                    handlerObject.style.cursor = 'move';
                }
            }
        }

        bindEvent(handlerObject, 'mousedown',
            function(e) {
                dragManager.dragStart(e ? e : window.event, draggedObject);
            }, true);
    },

    cancelEvent: function() {
        return false;
    },

    // начало перетаскивания
    // IE: window.event тоже передается первым параметром!
    dragStart: function(e, draggedObject) {
        if (nc.config('drag_mode') == 'disabled') {
            return;
        }

        // check if left button was pressed
        if ((e.stopPropagation && e.button != 0) ||    // DOM (Mozilla)
            (!e.stopPropagation && e.button != 1)      // IE
            ) {
            return;
        } // not a left mouse button

        dragManager.initHandlers();

        dragManager.draggedObject = draggedObject;
        dragManager.dragInProgress = true;

        var dragLabel = draggedObject.dragLabel;
        if (!dragLabel) {
            if (draggedObject.getAttribute('dragLabel')) {
                dragLabel = draggedObject.getAttribute('dragLabel');
            }
            else {
                dragLabel = draggedObject.innerHTML;
            }
        }

        dragManager.labelSetHTML(dragLabel);

        dragManager.draggedInstance = dragManager.getInstanceData(draggedObject);
        // store drag event coordinates
        var windowOffset = draggedObject.ownerDocument.defaultView ?
        draggedObject.ownerDocument.defaultView.frameOffset :  // moz
        draggedObject.ownerDocument.parentWindow.frameOffset;   // IE
        dragManager.dragEventX = e.clientX + windowOffset.left;
        dragManager.dragEventY = e.clientY + windowOffset.top;

        if (e.stopPropagation) {
            e.stopPropagation();
            e.preventDefault();
        }
        else if (e) {
            e.cancelBubble = true;
        }
    },

    // окончание перетаскивания
    dragEnd: function(e) {
        if (dragManager.dropTargetObject) {
            var processDrop = function() {
                dragManager.dropTargetObject.dropHandler();
                dragManager.removeDragData();
            };

            var confirmation = dragManager.getConfirmationMessages();

            if (confirmation) {
                dragManager.showConfirmationDialog(confirmation.title, confirmation.text, confirmation.button, processDrop);
            }
            else {
                processDrop();
            }
        }
        else {
            dragManager.removeDragData();
        }

        dragManager.dragInProgress = false;
        dragManager.dragLabelVisible = false;
        dragManager.dragLabel.style.display = 'none';
        dragManager.dropPositionIndicator.style.display = 'none';
        dragManager.removeHandlers();
    },

    removeDragData: function() {
        dragManager.draggedObject = null;
        dragManager.dropTargetObject = null;
        dragManager.draggedInstance = {};
        dragManager.droppedInstance = {};
    },

    /**
 * сделать объект принимающим перетаскиваемые объекты
 * @param {Object} object объект, который будет принимать перетаскиваемый объект(drop)
 * @param {Function} acceptFn функция проверки возможности сбрасывания объекта на object
 * @param {Function} onDropFn функция, выполняемая при сбрасывании объекта на object
 * @param {Object} dropIndicator см. dragManager.init() - position indicators. Объект со свойствами
 *   { name, top|bottom, left }
 */
    addDroppable: function(object, acceptFn, onDropFn, dropIndicator) {
        object.acceptsDrop = acceptFn;
        object.dropHandler = onDropFn;
        object.dropIndicator = dropIndicator;

        bindEvent(object, 'mouseover', dragManager.dropTargetMouseOver);
        bindEvent(object, 'mouseout',  dragManager.dropTargetMouseOut);
    },

    /**
     * Формирует хэш с данными для показа диалога. Если диалог не будет показываться,
     * возвращает false
     * @return {false|Object}
     */
    getConfirmationMessages: function() {
        if (nc.config('drag_mode') != 'confirm') {
            return false;
        }

        function formatName(string) {
            // Если есть что-то похожее на ID в начале строки, убрать его
            string = string.replace(/^\d+\.\s+/, '');
            var words = string.split(/\s+/),
                maxNumWords = 8,
                result = words.slice(0, maxNumWords).join(' ');
            return $nc.trim(result) + (words.length > maxNumWords ? '…' : '');
        }

        function getNameFromHTML(html) {
            return getNameFromElement('<div>' + html + '</div>');
        }

        function getNameFromElement(el) {
            var $el = $nc(el);
            // уберём тулбар в объектах (на случай, когда нет заголовков — будет взят весь текст в объекте)
            if ($el.find('.nc-toolbar')) {
                $el = $el.clone();
                $el.find('.nc-toolbar').remove();
            }

            return formatName(
                $el.find('h1,h2,h3,h4,h5,h6').first().text().trim() ||  // объект — взять название из первого заголовка
                $el.closest('li').children('a').text().trim() ||  // дерево — "Идентификатор. Название"
                $el.text().trim() || // например: ярлык вкладки — только название; объект без заголовка — всё, кроме тулбаров
                $el.attr('dragLabel') ||
                ''
            );
        }

        function getTreeFromSameWindow(element, treeInstanceName) {
            var doc = element.ownerDocument,
                elWindow = doc.defaultView || doc.parentWindow /* IE8 */;
            return elWindow[treeInstanceName] instanceof elWindow.dynamicTree ? elWindow[treeInstanceName] : null;
        }

        var position = 'inside',
            dropTargetName = getNameFromElement(dragManager.dropTargetObject),
            dropTargetType = dragManager.droppedInstance.type,
            lang = ncLang.DragAndDropConfirm;

        // определение типа перемещения в дереве: inside — внутрь другого узла дерева,
        // below — смена порядка следования элементов, firstIn — первый дочерний узел
        if (dragManager.draggedInstance.treeInstanceName && dragManager.droppedInstance.treeInstanceName) {
            // для упрощения здесь считается, что оба дерева находятся в одном окне
            var tree = getTreeFromSameWindow(dragManager.dropTargetObject, dragManager.droppedInstance.treeInstanceName);
            if (tree) {
                var draggedNodeData = tree.getNodeData(dragManager.draggedInstance),
                    targetNodeData = tree.getNodeData(dragManager.droppedInstance);

                 position = (dragManager.dropTargetObject.tagName == 'I' ? 'below' : 'inside');

                if (position == 'below') {
                    dropTargetName = getNameFromHTML(tree.getNodeData(targetNodeData.nodeId).name);
                    // изменился родитель — это перетаскивание в указанную позицию в другой узел дерева, а не просто изменение сортировки
                    if (targetNodeData.parentNodeId && draggedNodeData.parentNodeId != targetNodeData.parentNodeId) {
                        position = 'inside';
                        var parentNodeId = targetNodeData.parentNodeId;
                        dropTargetName = getNameFromHTML(tree.getNodeData(parentNodeId).name);
                        dropTargetType = dragManager.getInstanceDataFromID(parentNodeId).type;
                    }
                }
                else if (position == 'inside' && draggedNodeData.parentNodeId && draggedNodeData.parentNodeId == targetNodeData.nodeId) {
                    // перетаскивание внутри одного родительского узла на первое место
                    position = 'firstIn';
                }
            }
        }

        var dragType = dragManager.draggedInstance.type + '_' + position + '_' + dropTargetType;

        // Нет языковых констант для этого типа перетаскивания — не будет и диалога
        if (!dragType in lang) {
            return false;
        }

        var messages = lang[dragType];

        return {
            title: messages.title,
            text: messages.text.replace('%1', getNameFromElement(dragManager.draggedObject))
                               .replace('%2', dropTargetName),
            button: messages.button || lang.buttons[position] || lang.buttons.default
        };
    },

    /**
     * Показать диалог подтверждения перетаскивания
     * @param {String} headerText
     * @param {String} messageText
     * @param {String} buttonText
     * @param {Function} onConfirm
     */
    showConfirmationDialog: function(headerText, messageText, buttonText, onConfirm) {
        var dialog = new nc.ui.modal_dialog({ width: 400, height: 'auto', confirm_close: false });
        dialog.get_part('title').html(headerText);
        dialog.get_part('body').html('<div class="nc-drop-confirmation-dialog-body">' + messageText + '</div>');
        dialog.get_part('footer').append(
            $nc('<button>', { html: buttonText }).click(function() {
                onConfirm(); dialog.close();
            }),
            $nc('<button>', { html: ncLang.Cancel, 'data-action': 'close' }).click(function() {
                dragManager.removeDragData(); dialog.close();
            })
        );
        dialog.open();
    }

};

bindEvent(window, 'load', function() {
    dragManager.init();
});

(function(d){function p(){return new Date(Date.UTC.apply(Date,arguments))}function t(a,b){var c=d(a).data(),f={},h,g=RegExp("^"+b.toLowerCase()+"([A-Z])"),b=RegExp("^"+b.toLowerCase()),e;for(e in c)b.test(e)&&(h=e.replace(g,function(a,b){return b.toLowerCase()}),f[h]=c[e]);return f}function u(a){var b={};if(!l[a]&&(a=a.split("-")[0],!l[a]))return;var c=l[a];d.each(v,function(a,d){d in c&&(b[d]=c[d])});return b}var q=d(window),o=function(a,b){this._process_options(b);this.element=d(a);this.isInline=
!1;this.isInput=this.element.is("input");this.hasInput=(this.component=this.element.is(".date")?this.element.find(".add-on, .btn"):!1)&&this.element.find("input").length;if(this.component&&0===this.component.length)this.component=!1;this.picker=d(k.template);this._buildEvents();this._attachEvents();this.isInline?this.picker.addClass("datepicker-inline").appendTo(this.element):this.picker.addClass("datepicker-dropdown dropdown-menu");this.o.rtl&&(this.picker.addClass("datepicker-rtl"),this.picker.find(".prev i, .next i").toggleClass("icon-arrow-left icon-arrow-right"));
this.viewMode=this.o.startView;this.o.calendarWeeks&&this.picker.find("tfoot th.today").attr("colspan",function(a,b){return parseInt(b)+1});this._allow_update=!1;this.setStartDate(this._o.startDate);this.setEndDate(this._o.endDate);this.setDaysOfWeekDisabled(this.o.daysOfWeekDisabled);this.fillDow();this.fillMonths();this._allow_update=!0;this.update();this.showMode();this.element.val()&&this.setValue();this.isInline&&this.show()};o.prototype={constructor:o,_process_options:function(a){this._o=d.extend({},
this._o,a);var a=this.o=d.extend({},this._o),b=a.language;if(!l[b]&&(b=b.split("-")[0],!l[b]))b=r.language;a.language=b;switch(a.startView){case 2:case "decade":a.startView=2;break;case 1:case "year":a.startView=1;break;default:a.startView=0}switch(a.minViewMode){case 1:case "months":a.minViewMode=1;break;case 2:case "years":a.minViewMode=2;break;default:a.minViewMode=0}a.startView=Math.max(a.startView,a.minViewMode);a.weekStart%=7;a.weekEnd=(a.weekStart+6)%7;b=k.parseFormat(a.format);if(-Infinity!==
a.startDate)a.startDate=a.startDate?a.startDate instanceof Date?this._local_to_utc(this._zero_time(a.startDate)):k.parseDate(a.startDate,b,a.language):-Infinity;if(Infinity!==a.endDate)a.endDate=a.endDate?a.endDate instanceof Date?this._local_to_utc(this._zero_time(a.endDate)):k.parseDate(a.endDate,b,a.language):Infinity;a.daysOfWeekDisabled=a.daysOfWeekDisabled||[];if(!d.isArray(a.daysOfWeekDisabled))a.daysOfWeekDisabled=a.daysOfWeekDisabled.split(/[,\s]*/);a.daysOfWeekDisabled=d.map(a.daysOfWeekDisabled,
function(a){return parseInt(a,10)});var b=(""+a.orientation).toLowerCase().split(/\s+/g),c=a.orientation.toLowerCase(),b=d.grep(b,function(a){return/^auto|left|right|top|bottom$/.test(a)});a.orientation={x:"auto",y:"auto"};if(c&&"auto"!==c)if(1===b.length)switch(b[0]){case "top":case "bottom":a.orientation.y=b[0];break;case "left":case "right":a.orientation.x=b[0]}else c=d.grep(b,function(a){return/^left|right$/.test(a)}),a.orientation.x=c[0]||"auto",c=d.grep(b,function(a){return/^top|bottom$/.test(a)}),
a.orientation.y=c[0]||"auto"},_events:[],_secondaryEvents:[],_applyEvents:function(a){for(var b=0,c,d;b<a.length;b++)c=a[b][0],d=a[b][1],c.on(d)},_unapplyEvents:function(a){for(var b=0,c,d;b<a.length;b++)c=a[b][0],d=a[b][1],c.off(d)},_buildEvents:function(){this.isInput?this._events=[[this.element,{focus:d.proxy(this.show,this),keyup:d.proxy(this.update,this),keydown:d.proxy(this.keydown,this)}]]:this.component&&this.hasInput?this._events=[[this.element.find("input"),{focus:d.proxy(this.show,this),
keyup:d.proxy(this.update,this),keydown:d.proxy(this.keydown,this)}],[this.component,{click:d.proxy(this.show,this)}]]:this.element.is("div")?this.isInline=!0:this._events=[[this.element,{click:d.proxy(this.show,this)}]];this._secondaryEvents=[[this.picker,{click:d.proxy(this.click,this)}],[d(window),{resize:d.proxy(this.place,this)}],[d("body"),{scroll:d.proxy(this.place,this)}],[d(document),{"mousedown touchstart":d.proxy(function(a){!this.element.is(a.target)&&!this.element.find(a.target).length&&
!this.picker.is(a.target)&&!this.picker.find(a.target).length&&this.hide()},this)}]]},_attachEvents:function(){this._detachEvents();this._applyEvents(this._events)},_detachEvents:function(){this._unapplyEvents(this._events)},_attachSecondaryEvents:function(){this._detachSecondaryEvents();this._applyEvents(this._secondaryEvents)},_detachSecondaryEvents:function(){this._unapplyEvents(this._secondaryEvents)},_trigger:function(a,b){var c=b||this.date,f=this._utc_to_local(c);this.element.trigger({type:a,
date:f,format:d.proxy(function(a){return k.formatDate(c,a||this.o.format,this.o.language)},this)})},show:function(a){this.isInline||this.picker.appendTo("body");this.picker.show();this.height=this.component?this.component.outerHeight():this.element.outerHeight();this.place();this._attachSecondaryEvents();a&&a.preventDefault();this._trigger("show")},hide:function(){if(!this.isInline&&this.picker.is(":visible"))this.picker.hide().detach(),this._detachSecondaryEvents(),this.viewMode=this.o.startView,
this.showMode(),this.o.forceParse&&(this.isInput&&this.element.val()||this.hasInput&&this.element.find("input").val())&&this.setValue(),this._trigger("hide")},remove:function(){this.hide();this._detachEvents();this._detachSecondaryEvents();this.picker.remove();delete this.element.data().datepicker;this.isInput||delete this.element.data().date},_utc_to_local:function(a){return new Date(a.getTime()+6E4*a.getTimezoneOffset())},_local_to_utc:function(a){return new Date(a.getTime()-6E4*a.getTimezoneOffset())},
_zero_time:function(a){return new Date(a.getFullYear(),a.getMonth(),a.getDate())},_zero_utc_time:function(a){return new Date(Date.UTC(a.getUTCFullYear(),a.getUTCMonth(),a.getUTCDate()))},getDate:function(){return this._utc_to_local(this.getUTCDate())},getUTCDate:function(){return this.date},isoDateFormat:{separators:["","-","-",""],parts:["yyyy","mm","dd"]},getISODate:function(){return this.element.val()?this.getFormattedDate(this.isoDateFormat):null},setDate:function(a){this.setUTCDate(this._local_to_utc(a))},
setUTCDate:function(a){this.date=a;this.setValue()},setValue:function(){var a=this.getFormattedDate();this.isInput?this.element.val(a).change():this.component&&this.element.find("input").val(a).change()},getFormattedDate:function(a){if(void 0===a)a=this.o.format;return k.formatDate(this.date,a,this.o.language)},setStartDate:function(a){this._process_options({startDate:a});this.update();this.updateNavArrows()},setEndDate:function(a){this._process_options({endDate:a});this.update();this.updateNavArrows()},
setDaysOfWeekDisabled:function(a){this._process_options({daysOfWeekDisabled:a});this.update();this.updateNavArrows()},place:function(){if(!this.isInline){var a=this.picker.outerWidth(),b=this.picker.outerHeight(),c=q.width(),f=q.height(),h=q.scrollTop(),g=parseInt(this.element.parents().filter(function(){return"auto"!=d(this).css("z-index")}).first().css("z-index"))+10,e=this.component?this.component.parent().offset():this.element.offset(),j=this.component?this.component.outerHeight(!0):this.element.outerHeight(!1),
k=this.component?this.component.outerWidth(!0):this.element.outerWidth(!1),i=e.left,l=e.top;this.picker.removeClass("datepicker-orient-top datepicker-orient-bottom datepicker-orient-right datepicker-orient-left");"auto"!==this.o.orientation.x?(this.picker.addClass("datepicker-orient-"+this.o.orientation.x),"right"===this.o.orientation.x&&(i-=a-k)):(this.picker.addClass("datepicker-orient-left"),0>e.left?i-=e.left-10:e.left+a>c&&(i=c-a-10));a=this.o.orientation.y;"auto"===a&&(a=-h+e.top-b,f=h+f-(e.top+
j+b),a=Math.max(a,f)===f?"top":"bottom");this.picker.addClass("datepicker-orient-"+a);l="top"===a?l+j:l-(b+parseInt(this.picker.css("padding-top")));this.picker.css({top:l,left:i,zIndex:g})}},_allow_update:!0,update:function(){if(this._allow_update){var a=new Date(this.date),b,c=!1;arguments&&arguments.length&&("string"===typeof arguments[0]||arguments[0]instanceof Date)?(b=arguments[0],b instanceof Date&&(b=this._local_to_utc(b)),c=!0):(b=this.isInput?this.element.val():this.element.data("date")||
this.element.find("input").val(),delete this.element.data().date);this.date=k.parseDate(b,this.o.format,this.o.language);c?this.setValue():b?a.getTime()!==this.date.getTime()&&this._trigger("changeDate"):this._trigger("clearDate");this.date<this.o.startDate?(this.viewDate=new Date(this.o.startDate),this.date=new Date(this.o.startDate)):this.date>this.o.endDate?(this.viewDate=new Date(this.o.endDate),this.date=new Date(this.o.endDate)):(this.viewDate=new Date(this.date),this.date=new Date(this.date));
this.fill()}},fillDow:function(){var a=this.o.weekStart,b="<tr>";this.o.calendarWeeks&&(b+='<th class="cw">&nbsp;</th>',this.picker.find(".datepicker-days thead tr:first-child").prepend('<th class="cw">&nbsp;</th>'));for(;a<this.o.weekStart+7;)b+='<th class="dow">'+l[this.o.language].daysMin[a++%7]+"</th>";this.picker.find(".datepicker-days thead").append(b+"</tr>")},fillMonths:function(){for(var a="",b=0;12>b;)a+='<span class="month">'+l[this.o.language].monthsShort[b++]+"</span>";this.picker.find(".datepicker-months td").html(a)},
setRange:function(a){!a||!a.length?delete this.range:this.range=d.map(a,function(a){return a.valueOf()});this.fill()},getClassNames:function(a){var b=[],c=this.viewDate.getUTCFullYear(),f=this.viewDate.getUTCMonth(),h=this.date.valueOf(),g=new Date;a.getUTCFullYear()<c||a.getUTCFullYear()==c&&a.getUTCMonth()<f?b.push("old"):(a.getUTCFullYear()>c||a.getUTCFullYear()==c&&a.getUTCMonth()>f)&&b.push("new");this.o.todayHighlight&&a.getUTCFullYear()==g.getFullYear()&&a.getUTCMonth()==g.getMonth()&&a.getUTCDate()==
g.getDate()&&b.push("today");a.valueOf()==h&&b.push("active");(a.valueOf()<this.o.startDate||a.valueOf()>this.o.endDate||-1!==d.inArray(a.getUTCDay(),this.o.daysOfWeekDisabled))&&b.push("disabled");this.range&&(a>this.range[0]&&a<this.range[this.range.length-1]&&b.push("range"),-1!=d.inArray(a.valueOf(),this.range)&&b.push("selected"));return b},fill:function(){var a=new Date(this.viewDate),b=a.getUTCFullYear(),c=a.getUTCMonth(),a=-Infinity!==this.o.startDate?this.o.startDate.getUTCFullYear():-Infinity,
f=-Infinity!==this.o.startDate?this.o.startDate.getUTCMonth():-Infinity,h=Infinity!==this.o.endDate?this.o.endDate.getUTCFullYear():Infinity,g=Infinity!==this.o.endDate?this.o.endDate.getUTCMonth():Infinity,e;this.picker.find(".datepicker-days thead th.datepicker-switch").text(l[this.o.language].months[c]+" "+b);this.picker.find("tfoot th.today").text(l[this.o.language].today).toggle(!1!==this.o.todayBtn);this.picker.find("tfoot th.clear").text(l[this.o.language].clear).toggle(!1!==this.o.clearBtn);
this.updateNavArrows();this.fillMonths();var j=p(b,c-1,28,0,0,0,0),c=k.getDaysInMonth(j.getUTCFullYear(),j.getUTCMonth());j.setUTCDate(c);j.setUTCDate(c-(j.getUTCDay()-this.o.weekStart+7)%7);var m=new Date(j);m.setUTCDate(m.getUTCDate()+42);for(var m=m.valueOf(),c=[],i;j.valueOf()<m;){if(j.getUTCDay()==this.o.weekStart&&(c.push("<tr>"),this.o.calendarWeeks)){i=new Date(+j+864E5*((this.o.weekStart-j.getUTCDay()-7)%7));i=new Date(+i+864E5*((11-i.getUTCDay())%7));var o=new Date(+(o=p(i.getUTCFullYear(),
0,1))+864E5*((11-o.getUTCDay())%7));c.push('<td class="cw">'+((i-o)/864E5/7+1)+"</td>")}i=this.getClassNames(j);i.push("day");if(this.o.beforeShowDay!==d.noop){var n=this.o.beforeShowDay(this._utc_to_local(j));void 0===n?n={}:"boolean"===typeof n?n={enabled:n}:"string"===typeof n&&(n={classes:n});!1===n.enabled&&i.push("disabled");n.classes&&(i=i.concat(n.classes.split(/\s+/)));if(n.tooltip)e=n.tooltip}i=d.unique(i);c.push('<td class="'+i.join(" ")+'"'+(e?' title="'+e+'"':"")+">"+j.getUTCDate()+"</td>");
j.getUTCDay()==this.o.weekEnd&&c.push("</tr>");j.setUTCDate(j.getUTCDate()+1)}this.picker.find(".datepicker-days tbody").empty().append(c.join(""));e=this.date&&this.date.getUTCFullYear();c=this.picker.find(".datepicker-months").find("th:eq(1)").text(b).end().find("span").removeClass("active");e&&e==b&&c.eq(this.date.getUTCMonth()).addClass("active");(b<a||b>h)&&c.addClass("disabled");b==a&&c.slice(0,f).addClass("disabled");b==h&&c.slice(g+1).addClass("disabled");c="";b=10*parseInt(b/10,10);f=this.picker.find(".datepicker-years").find("th:eq(1)").text(b+
"-"+(b+9)).end().find("td");b-=1;for(g=-1;11>g;g++)c+='<span class="year'+(-1==g?" old":10==g?" new":"")+(e==b?" active":"")+(b<a||b>h?" disabled":"")+'">'+b+"</span>",b+=1;f.html(c)},updateNavArrows:function(){if(this._allow_update){var a=new Date(this.viewDate),b=a.getUTCFullYear(),a=a.getUTCMonth();switch(this.viewMode){case 0:-Infinity!==this.o.startDate&&b<=this.o.startDate.getUTCFullYear()&&a<=this.o.startDate.getUTCMonth()?this.picker.find(".prev").css({visibility:"hidden"}):this.picker.find(".prev").css({visibility:"visible"});
Infinity!==this.o.endDate&&b>=this.o.endDate.getUTCFullYear()&&a>=this.o.endDate.getUTCMonth()?this.picker.find(".next").css({visibility:"hidden"}):this.picker.find(".next").css({visibility:"visible"});break;case 1:case 2:-Infinity!==this.o.startDate&&b<=this.o.startDate.getUTCFullYear()?this.picker.find(".prev").css({visibility:"hidden"}):this.picker.find(".prev").css({visibility:"visible"}),Infinity!==this.o.endDate&&b>=this.o.endDate.getUTCFullYear()?this.picker.find(".next").css({visibility:"hidden"}):
this.picker.find(".next").css({visibility:"visible"})}}},click:function(a){a.preventDefault();a=d(a.target).closest("span, td, th");if(1==a.length)switch(a[0].nodeName.toLowerCase()){case "th":switch(a[0].className){case "datepicker-switch":this.showMode(1);break;case "prev":case "next":a=k.modes[this.viewMode].navStep*("prev"==a[0].className?-1:1);switch(this.viewMode){case 0:this.viewDate=this.moveMonth(this.viewDate,a);this._trigger("changeMonth",this.viewDate);break;case 1:case 2:this.viewDate=
this.moveYear(this.viewDate,a),1===this.viewMode&&this._trigger("changeYear",this.viewDate)}this.fill();break;case "today":a=new Date;a=p(a.getFullYear(),a.getMonth(),a.getDate(),0,0,0);this.showMode(-2);this._setDate(a,"linked"==this.o.todayBtn?null:"view");break;case "clear":var b;this.isInput?b=this.element:this.component&&(b=this.element.find("input"));b&&b.val("").change();this._trigger("changeDate");this.update();this.o.autoclose&&this.hide()}break;case "span":if(!a.is(".disabled")){this.viewDate.setUTCDate(1);
if(a.is(".month")){b=1;var c=a.parent().find("span").index(a),f=this.viewDate.getUTCFullYear();this.viewDate.setUTCMonth(c);this._trigger("changeMonth",this.viewDate);1===this.o.minViewMode&&this._setDate(p(f,c,b,0,0,0,0))}else f=parseInt(a.text(),10)||0,b=1,c=0,this.viewDate.setUTCFullYear(f),this._trigger("changeYear",this.viewDate),2===this.o.minViewMode&&this._setDate(p(f,c,b,0,0,0,0));this.showMode(-1);this.fill()}break;case "td":a.is(".day")&&!a.is(".disabled")&&(b=parseInt(a.text(),10)||1,
f=this.viewDate.getUTCFullYear(),c=this.viewDate.getUTCMonth(),a.is(".old")?0===c?(c=11,f-=1):c-=1:a.is(".new")&&(11==c?(c=0,f+=1):c+=1),this._setDate(p(f,c,b,0,0,0,0)))}},_setDate:function(a,b){if(!b||"date"==b)this.date=new Date(a);if(!b||"view"==b)this.viewDate=new Date(a);this.fill();this.setValue();this._trigger("changeDate");var c;this.isInput?c=this.element:this.component&&(c=this.element.find("input"));c&&c.change();this.o.autoclose&&(!b||"date"==b)&&this.hide()},moveMonth:function(a,b){if(!b)return a;
var c=new Date(a.valueOf()),d=c.getUTCDate(),h=c.getUTCMonth(),g=Math.abs(b),e,b=0<b?1:-1;if(1==g){if(g=-1==b?function(){return c.getUTCMonth()==h}:function(){return c.getUTCMonth()!=e},e=h+b,c.setUTCMonth(e),0>e||11<e)e=(e+12)%12}else{for(var j=0;j<g;j++)c=this.moveMonth(c,b);e=c.getUTCMonth();c.setUTCDate(d);g=function(){return e!=c.getUTCMonth()}}for(;g();)c.setUTCDate(--d),c.setUTCMonth(e);return c},moveYear:function(a,b){return this.moveMonth(a,12*b)},dateWithinRange:function(a){return a>=this.o.startDate&&
a<=this.o.endDate},keydown:function(a){if(this.picker.is(":not(:visible)"))27==a.keyCode&&this.show();else{var b=!1,c,d,h;switch(a.keyCode){case 27:this.hide();a.preventDefault();break;case 37:case 39:if(!this.o.keyboardNavigation)break;c=37==a.keyCode?-1:1;a.ctrlKey?(d=this.moveYear(this.date,c),h=this.moveYear(this.viewDate,c),this._trigger("changeYear",this.viewDate)):a.shiftKey?(d=this.moveMonth(this.date,c),h=this.moveMonth(this.viewDate,c),this._trigger("changeMonth",this.viewDate)):(d=new Date(this.date),
d.setUTCDate(this.date.getUTCDate()+c),h=new Date(this.viewDate),h.setUTCDate(this.viewDate.getUTCDate()+c));if(this.dateWithinRange(d))this.date=d,this.viewDate=h,this.setValue(),this.update(),a.preventDefault(),b=!0;break;case 38:case 40:if(!this.o.keyboardNavigation)break;c=38==a.keyCode?-1:1;a.ctrlKey?(d=this.moveYear(this.date,c),h=this.moveYear(this.viewDate,c),this._trigger("changeYear",this.viewDate)):a.shiftKey?(d=this.moveMonth(this.date,c),h=this.moveMonth(this.viewDate,c),this._trigger("changeMonth",
this.viewDate)):(d=new Date(this.date),d.setUTCDate(this.date.getUTCDate()+7*c),h=new Date(this.viewDate),h.setUTCDate(this.viewDate.getUTCDate()+7*c));if(this.dateWithinRange(d))this.date=d,this.viewDate=h,this.setValue(),this.update(),a.preventDefault(),b=!0;break;case 13:this.hide();a.preventDefault();break;case 9:this.hide()}if(b){this._trigger("changeDate");var g;this.isInput?g=this.element:this.component&&(g=this.element.find("input"));g&&g.change()}}},showMode:function(a){if(a)this.viewMode=
Math.max(this.o.minViewMode,Math.min(2,this.viewMode+a));this.picker.find(">div").hide().filter(".datepicker-"+k.modes[this.viewMode].clsName).css("display","block");this.updateNavArrows()}};var s=function(a,b){this.element=d(a);this.inputs=d.map(b.inputs,function(a){return a.jquery?a[0]:a});delete b.inputs;d(this.inputs).datepicker(b).bind("changeDate",d.proxy(this.dateUpdated,this));this.pickers=d.map(this.inputs,function(a){return d(a).data("datepicker")});this.updateDates()};s.prototype={updateDates:function(){this.dates=
d.map(this.pickers,function(a){return a.date});this.updateRanges()},updateRanges:function(){var a=d.map(this.dates,function(a){return a.valueOf()});d.each(this.pickers,function(b,c){c.setRange(a)})},dateUpdated:function(a){var b=d(a.target).data("datepicker").getUTCDate(),a=d.inArray(a.target,this.inputs),c=this.inputs.length;if(-1!=a){if(b<this.dates[a])for(;0<=a&&b<this.dates[a];)this.pickers[a--].setUTCDate(b);else if(b>this.dates[a])for(;a<c&&b>this.dates[a];)this.pickers[a++].setUTCDate(b);this.updateDates()}},
remove:function(){d.map(this.pickers,function(a){a.remove()});delete this.element.data().datepicker}};var w=d.fn.datepicker;d.fn.datepicker=function(a){var b=Array.apply(null,arguments);b.shift();var c;this.each(function(){var f=d(this),h=f.data("datepicker"),g="object"==typeof a&&a;if(!h){var h=t(this,"date"),e=d.extend({},r,h,g),e=u(e.language),g=d.extend({},r,e,h,g);f.is(".input-daterange")||g.inputs?(h={inputs:g.inputs||f.find("input").toArray()},f.data("datepicker",h=new s(this,d.extend(g,h)))):
f.data("datepicker",h=new o(this,g))}if("string"==typeof a&&"function"==typeof h[a]&&(c=h[a].apply(h,b),void 0!==c))return!1});return void 0!==c?c:this};var r=d.fn.datepicker.defaults={autoclose:!1,beforeShowDay:d.noop,calendarWeeks:!1,clearBtn:!1,daysOfWeekDisabled:[],endDate:Infinity,forceParse:!0,format:"mm/dd/yyyy",keyboardNavigation:!0,language:"en",minViewMode:0,orientation:"auto",rtl:!1,startDate:-Infinity,startView:0,todayBtn:!1,todayHighlight:!1,weekStart:0},v=d.fn.datepicker.locale_opts=
["format","rtl","weekStart"];d.fn.datepicker.Constructor=o;var l=d.fn.datepicker.dates={en:{days:"Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday".split(","),daysShort:"Sun,Mon,Tue,Wed,Thu,Fri,Sat,Sun".split(","),daysMin:"Su,Mo,Tu,We,Th,Fr,Sa,Su".split(","),months:"January,February,March,April,May,June,July,August,September,October,November,December".split(","),monthsShort:"Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec".split(","),today:"Today",clear:"Clear"}},k={modes:[{clsName:"days",
navFnc:"Month",navStep:1},{clsName:"months",navFnc:"FullYear",navStep:1},{clsName:"years",navFnc:"FullYear",navStep:10}],isLeapYear:function(a){return 0===a%4&&0!==a%100||0===a%400},getDaysInMonth:function(a,b){return[31,k.isLeapYear(a)?29:28,31,30,31,30,31,31,30,31,30,31][b]},validParts:/dd?|DD?|mm?|MM?|yy(?:yy)?/g,nonpunctuation:/[^ -\/:-@\[\u3400-\u9fff-`{-~\t\n\r]+/g,parseFormat:function(a){var b=a.replace(this.validParts,"\x00").split("\x00"),a=a.match(this.validParts);if(!b||!b.length||!a||
0===a.length)throw Error("Invalid date format.");return{separators:b,parts:a}},parseDate:function(a,b,c){if(a instanceof Date)return a;"string"===typeof b&&(b=k.parseFormat(b));if(/^\d{4}-\d{2}-\d{2}$/.test(a)){var f=a.split("-");return p(f[0],parseInt(f[1],10)-1,f[2],0,0,0)}if(/^[\-+]\d+[dmwy]([\s,]+[\-+]\d+[dmwy])*$/.test(a)){for(var h=/([\-+]\d+)([dmwy])/,f=a.match(/([\-+]\d+)([dmwy])/g),g,a=new Date,e=0;e<f.length;e++)switch(b=h.exec(f[e]),g=parseInt(b[1]),b[2]){case "d":a.setUTCDate(a.getUTCDate()+
g);break;case "m":a=o.prototype.moveMonth.call(o.prototype,a,g);break;case "w":a.setUTCDate(a.getUTCDate()+7*g);break;case "y":a=o.prototype.moveYear.call(o.prototype,a,g)}return p(a.getUTCFullYear(),a.getUTCMonth(),a.getUTCDate(),0,0,0)}var f=a&&a.match(this.nonpunctuation)||[],a=new Date,h={},j="yyyy,yy,M,MM,m,mm,d,dd".split(",");g={yyyy:function(a,b){return a.setUTCFullYear(70>b?2E3+b:b)},yy:function(a,b){return a.setUTCFullYear(2E3+b)},m:function(a,b){if(isNaN(a))return a;for(b-=1;0>b;)b+=12;
b%=12;for(a.setUTCMonth(b);a.getUTCMonth()!=b;)a.setUTCDate(a.getUTCDate()-1);return a},d:function(a,b){return a.setUTCDate(b)}};var m;g.M=g.MM=g.mm=g.m;g.dd=g.d;var a=p(a.getFullYear(),a.getMonth(),a.getDate(),0,0,0),i=b.parts.slice();f.length!=i.length&&(i=d(i).filter(function(a,b){return-1!==d.inArray(b,j)}).toArray());if(f.length==i.length){for(var e=0,q=i.length;e<q;e++){m=parseInt(f[e],10);b=i[e];if(isNaN(m))switch(b){case "MM":m=d(l[c].months).filter(function(){var a=this.slice(0,f[e].length),
b=f[e].slice(0,a.length);return a==b});m=d.inArray(m[0],l[c].months)+1;break;case "M":m=d(l[c].monthsShort).filter(function(){var a=this.slice(0,f[e].length),b=f[e].slice(0,a.length);return a==b}),m=d.inArray(m[0],l[c].monthsShort)+1}h[b]=m}for(e=0;e<j.length;e++)c=j[e],c in h&&!isNaN(h[c])&&(b=new Date(a),g[c](b,h[c]),isNaN(b)||(a=b))}return a},formatDate:function(a,b,c){"string"===typeof b&&(b=k.parseFormat(b));c={d:a.getUTCDate(),D:l[c].daysShort[a.getUTCDay()],DD:l[c].days[a.getUTCDay()],m:a.getUTCMonth()+
1,M:l[c].monthsShort[a.getUTCMonth()],MM:l[c].months[a.getUTCMonth()],yy:a.getUTCFullYear().toString().substring(2),yyyy:a.getUTCFullYear()};c.dd=(10>c.d?"0":"")+c.d;c.mm=(10>c.m?"0":"")+c.m;for(var a=[],f=d.extend([],b.separators),h=0,g=b.parts.length;h<=g;h++)f.length&&a.push(f.shift()),a.push(c[b.parts[h]]);return a.join("")},headTemplate:'<thead><tr><th class="prev">&laquo;</th><th colspan="5" class="datepicker-switch"></th><th class="next">&raquo;</th></tr></thead>',contTemplate:'<tbody><tr><td colspan="7"></td></tr></tbody>',
footTemplate:'<tfoot><tr><th colspan="7" class="today"></th></tr><tr><th colspan="7" class="clear"></th></tr></tfoot>'};k.template='<div class="datepicker"><div class="datepicker-days"><table class=" table-condensed">'+k.headTemplate+"<tbody></tbody>"+k.footTemplate+'</table></div><div class="datepicker-months"><table class="table-condensed">'+k.headTemplate+k.contTemplate+k.footTemplate+'</table></div><div class="datepicker-years"><table class="table-condensed">'+k.headTemplate+k.contTemplate+k.footTemplate+
"</table></div></div>";d.fn.datepicker.DPGlobal=k;d.fn.datepicker.noConflict=function(){d.fn.datepicker=w;return this};d(document).on("focus.datepicker.data-api click.datepicker.data-api",'[data-provide="datepicker"]',function(a){var b=d(this);b.data("datepicker")||(a.preventDefault(),b.datepicker("show"))});d(function(){d('[data-provide="datepicker-inline"]').datepicker()})})(window.jQuery);

var autosave = null;

function InitAutosave(form_id) {

    var restore = false;
    var fields_to_restore = null;
    if (typeof restoredFields !== 'undefined' && restoredFields !== null) { 
        restore = true;
        fields_to_restore = restoredFields;
        restoredFields = null;
    }
    autosave = $nc("#" + form_id).autosave({
        timeout: ((nc_autosave_type === 'timer' && nc_autosave_period > 0) ? nc_autosave_period : 0),
        noactive: ((typeof nc_autosave_noactive !== 'undefined') ? nc_autosave_noactive : 0),
        restore: restore,
        fields_to_restore: fields_to_restore,
        customKeySuffix: 'nc_',
        // чтобы избежать автозаполнения черновыми данными
        onBeforeRestore: function() {
            return false;
        },
        onSave: function(obj) {
            var self = this;
            var post_data = {};
            self.targets.each(function() {
                var targetId = $nc(this).attr("id");
                var multiCheckboxCache = {};

                self.findFieldsToProtect($nc('#' + targetId)).each(function() {
                    var field = $nc(this);
                    if ($nc.inArray(this, self.options.excludeFields) !== -1 || field.attr("name") === undefined) {
                        // Returning non-false is the same as a continue statement in a for loop; it will skip immediately to the next iteration.
                        return true;
                    }
                    var value = field.val();

                    if (field.is(":checkbox")) {
                        if (field.attr("name").indexOf("[") !== -1) {
                            if (multiCheckboxCache[ field.attr("name") ] === true) {
                                return;
                            }
                            value = [];
                            $nc("[name='" + field.attr("name") + "']:checked").each(function() {
                                value.push($nc(this).val());
                            });
                            multiCheckboxCache[ field.attr("name") ] = true;
                        } else {
                            value = field.is(":checked");
                        }
                        post_data[field.attr("name")] = value;
                    } else if (field.is(":radio")) {
                        if (field.is(":checked")) {
                            value = field.val();
                            post_data[field.attr("name")] = value;
                        }
                    } else {
                        if (self.isCKEditorExists()) {
                            var editor;
                            if (editor = CKEDITOR.instances[ field.attr("name") ] || CKEDITOR.instances[ field.attr("id") ]) {
                                editor.updateElement();
                                post_data[field.attr("name")] = field.val();
                            } else {
                                post_data[field.attr("name")] = value;
                            }
                        } else {
                            post_data[field.attr("name")] = value;
                        }
                    }
                });
            });
            $nc.ajax({
                'type': 'POST',
                'url': NETCAT_PATH + 'message.php?isVersion=1&cc=' + post_data.cc,
                'data': post_data,
                success: function(response) {
                    if ($nc('.nc_draft_btn').length) {
                        $nc('.nc_draft_btn').removeClass('nc--loading');
                    }
                }
            });
        }
    });

}

(function(e){function z(a){var c=e(a),b=k(c),d=b.data("maxFiles"),f=b.data("fieldName"),g=function(a){return"multifile_"+a+"["+f+"][]"},t=r(a);c.hide().clone().val("").appendTo(b).show();c.removeClass("nc-upload-input").appendTo(b.find(".nc-upload-new-files"));e.each(t,function(f){var h=b.data("nextUploadIndex")||0;b.data("nextUploadIndex",h+1);1==t.length&&c.addClass("nc-upload-file-index--"+h);f=u(a,f).hide().data("uploadIndex",h).append(l(g("id")),l(g("upload_index"),h),l(g("delete"),0).addClass("nc-upload-file-remove-hidden"));
b.data("customName")&&(h=b.data("customNameCaption"),h=v("text",g("name"),"",h),e('<div class="nc-upload-file-custom-name"/>').append(h).appendTo(f));d&&"0"!=d&&b.find(".nc-upload-file:visible").length>=d?w(f):f.slideDown(100)});m(b)}function u(a,c){var b=r(a)[c],d=e('<div class="nc-upload-file"><div class="nc-upload-file-info"><span class="nc-upload-file-name">'+b.name+'</span> <a href="#" class="nc-upload-file-remove" tabindex="-1">\u00d7</a></div></div>'),f=k(a).find(".nc-upload-files");if(n&&
5242880>b.size&&x(b.type)){var g=new FileReader;g.onload=function(a){p(d,b.type,b.name,a.target.result,!0)};g.readAsDataURL(b)}else p(d,b.type,b.name,null,!0);d.appendTo(f);y(d);return d}function p(a,c,b,d,f){var g=e("<div/>").addClass("nc-upload-file-preview nc-upload-file-drag-handle");(c=d&&x(c))&&n?(g.addClass("nc-upload-file-preview-image").append('<img src="'+d+'" />'),k(a).addClass("nc-upload-with-preview")):(d=b.lastIndexOf("."),g.addClass("nc-upload-file-preview-other"),0<d&&g.append('<span class="nc-upload-file-extension">'+
b.substr(d+1)+"</span>"));a.prepend('<div class="nc-upload-file-drag-icon nc-upload-file-drag-handle"><i class="nc-icon nc--file-text"></i></div>',g);(c||a.closest(".nc-upload-with-preview").length)&&n&&(f?g.slideDown(100):g.show());return g}function x(a){return /^image\/(jpe?g|png|gif|bmp|svg([+-]xml)?)$/i.test(a)}function r(a){return n?a.files:[{name:a.value.substr(a.value.lastIndexOf("\\")+1),type:"",size:0}]}function q(a){return a.hasClass("nc-upload-multifile")}function k(a){return e(a).closest(".nc-upload")}
function m(a){var c=q(a)?a.data("maxFiles"):1;c&&a.find(".nc-upload-input").toggle(a.find(".nc-upload-file:visible").length<c)}function l(a,c){return v("hidden",a,c)}function v(a,c,b,d){return e("<input />",{type:a,name:c,value:void 0===b?"":b,placeholder:d||""})}function A(a){a.preventDefault();a.stopPropagation();a=e(a.target).closest(".nc-upload-file");var c=k(a),b=c.find(".nc-upload-input"),d=b;w(a);q(c)?c.find(".nc-upload-file-index--"+a.data("uploadIndex")).val(""):(d=b.clone().val("").show(),
b.replaceWith(d));a.slideUp(100,function(){c.hasClass("nc-upload-with-preview")&&0==c.find(".nc-upload-file:visible .nc-upload-file-preview-image").length&&c.removeClass("nc-upload-with-preview");var a=e.Event("change");a.target=d[0];e(document).trigger(a);m(c)});return!1}function w(a){a.find(".nc-upload-file-remove-hidden").val(1)}function y(a){a.find(".nc-upload-file-remove").off("click.nc-upload").on("click.nc-upload",A)}if(e){var n="FileReader"in window;e.fn.upload=function(){return this.each(function(){var a=
e(this);if(!a.hasClass("nc-upload-applied")){a.addClass("nc-upload-applied");var c=q(a),b=a.find(".nc-upload-files"),d=b.find(".nc-upload-file");0<d.length&&!c&&a.find(".nc-upload-input").hide();d.each(function(){var a=e(this),b=a.data("type"),c=a.find(".nc-upload-file-name"),d=c.html(),c=c.prop("href");p(a,b,d,c,!1)});setTimeout(function(){m(a)},10);a.on("change",".nc-upload-input",function(){c?z(this):this.value&&(u(this,0).hide().slideDown(100).find(".nc-upload-file-custom-name input:text").focus(),
m(k(this)))});b.find(".nc-upload-file-remove").attr("onclick","");y(b);c&&a.append(l("multifile_js["+a.data("fieldName")+"]",1));if(c){var f;b.on("mousedown",".nc-upload-file-drag-handle",function(a){a.preventDefault();b.addClass("nc--dragging");f=e(this).closest(".nc-upload-file").addClass("nc--dragged");e(window).on("mouseup.nc-upload",function(){b.removeClass("nc--dragging");f.removeClass("nc--dragged");e(window).off("mouseup.nc-upload");f=null})});b.on("mousemove",".nc-upload-file",function(a){var b=
e(this);if(f&&!b.hasClass("nc--dragged")){if("none"==b.css("float")){a=a.pageY-b.offset().top;var c=b.height()}else a=a.pageX-b.offset().left,c=b.width();(a=a<c/2)?f.insertBefore(b):f.insertAfter(b)}})}}})};e(document).on("apply-upload",function(a){e(".nc-upload").upload()})}})(window.$nc||window.jQuery);

if (typeof(lsDisplayLibLoaded) == 'undefined') {
    var lsDisplayLibLoaded = true;
    var E_CLICK  = 0,
        E_SUBMIT = 1;

    jQuery(function(){
        var bindEvents = function($container){
            jQuery('[data-nc-ls-display-link]', $container).click(function(){
                eventHandler(this, true, E_CLICK);
                return false;
            });
            jQuery('form[data-nc-ls-display-form]', $container).submit(function(){
                eventHandler(this, true, E_SUBMIT);
                return false;
            });
        }

        var eventHandler = function(element, callBindEvents, event_type){

            switch (event_type) {

                case E_SUBMIT:
                    var url_attr  = 'action';
                    var data_attr = 'data-nc-ls-display-form';
                    break;

                case E_CLICK:
                default:
                    var url_attr  = 'href';
                    var data_attr = 'data-nc-ls-display-link';
                    break;
            }

            var $this    = jQuery(element);
            var url      = $this.attr(url_attr);
            var obj_data = $this.attr(data_attr);

            if (obj_data) {
                obj_data = jQuery.parseJSON(obj_data);
            }
            else {
                return false;
            }

            var replace_content = obj_data.subdivisionId !== false;

            if (url) {
                if (obj_data.displayType == 'shortpage' || (obj_data.displayType == 'longpage_vertical' && typeof(obj_data.subdivisionId) == 'undefined')) {

                    var send_as_post = event_type === E_SUBMIT && $this.attr('method').toLowerCase() === 'post';
                    var send_data    = jQuery.extend({}, obj_data.query); // clone

                    send_data.isNaked       = parseInt(typeof send_data.isNaked !== 'undefined' ? send_data.isNaked : 1);
                    send_data.lsDisplayType = obj_data.displayType;
                    send_data.skipTemplate  = parseInt(send_data.skipTemplate ? send_data.skipTemplate : obj_data.displayType == 'shortpage' && typeof(obj_data.subdivisionId) != 'undefined' ? 1 : 0);

                    if (send_as_post) {
                        url += (url.indexOf('?') >= 0 ? '&' : '?') + jQuery.param(send_data);
                        send_data = $this.serialize();
                    }

                    jQuery.ajax({
                        type:    send_as_post ? 'POST' : 'GET',
                        url:     url,
                        data:    send_data,
                        success: function(data){
                            var $container = [];

                            if (typeof(obj_data.onSubmit) !== 'undefined') {
                                if (data[0] == '{' || data[0] == '[') {
                                    data = jQuery.parseJSON(data);
                                }

                                if ((eval(obj_data.onSubmit)).call($this.get(0), data) === false) {
                                    replace_content = false;
                                }
                            }

                            if ( ! replace_content) {
                                return false;
                            }

                            if (typeof(obj_data.subdivisionId) == 'undefined') {
                                $container = $this.closest('[data-nc-ls-display-container]');
                            } else {
                                jQuery('[data-nc-ls-display-container]').each(function(){
                                    var $element = jQuery(this);
                                    var containerData = $element.attr('data-nc-ls-display-container');
                                    if (containerData) {
                                        containerData = jQuery.parseJSON(containerData);
                                        if (containerData.subdivisionId == obj_data.subdivisionId) {
                                            $container = $element;
                                            return false;
                                        }
                                    }

                                    return true;
                                });
                            }

                            if (!$container.length) {
                                $container = jQuery('[data-nc-ls-display-container]');
                            }

                            $container.html(data);

                            if (callBindEvents) {
                                bindEvents($container);
                            }

                            if (typeof(parent.nc_ls_quickbar) != 'undefined') {
                                var quickbar = parent.nc_ls_quickbar;
                                if (quickbar) {
                                    var $quickbar = jQuery('.nc-navbar').first();
                                    $quickbar.find('.nc-quick-menu LI:eq(0) A').attr('href', quickbar.view_link);
                                    $quickbar.find('.nc-quick-menu LI:eq(1) A').attr('href', quickbar.edit_link);
                                    $quickbar.find('.nc-menu UL LI:eq(0) A').attr('href', quickbar.sub_admin_link);
                                    $quickbar.find('.nc-menu UL LI:eq(1) A').attr('href', quickbar.template_admin_link);
                                    $quickbar.find('.nc-menu UL LI:eq(2) A').attr('href', quickbar.admin_link);
                                }
                            }
                        }
                    });

                } else if (obj_data.displayType == 'longpage_vertical') {
                    var scrolled = false;

                    var scrollToContainer = function(containerData, $element){
                        if (containerData) {
                            containerData = jQuery.parseJSON(containerData);
                            if (containerData.subdivisionId == obj_data.subdivisionId) {
                                jQuery('HTML,BODY').animate({
                                    scrollTop: $element.offset().top - jQuery('BODY').offset().top
                                }, containerData.animationSpeed);
                                return true;
                            }
                        }

                        return false;
                    };

                    jQuery('[data-nc-ls-display-pointer]').each(function(){
                        var $element = jQuery(this);
                        if (scrollToContainer($element.attr('data-nc-ls-display-pointer'), $element)) {
                            scrolled = true;
                            return false;
                        }

                        return true;
                    });

                    if (!scrolled) {
                        jQuery('[data-nc-ls-display-container]').each(function(){
                            var $element = jQuery(this);

                            if (scrollToContainer($element.attr('data-nc-ls-display-container'), $element)) {
                                return false;
                            }

                            return true;
                        });
                    }
                }

                if (replace_content) {
                    if (!!(window.history && history.pushState)) {
                        window.history.pushState({}, '', url);
                    }
                }

                if (event_type === E_CLICK) {
                    if (typeof(obj_data.onClick) == 'undefined') {
                        $this.addClass('active').siblings().removeClass('active');
                    } else {
                        eval('var callback = ' + obj_data.onClick);
                        callback.call($this.get(0));
                    }
                }

                return false;
            }
        }

        jQuery('[data-nc-ls-display-link]').click(function(){
            eventHandler(this, true, E_CLICK);
            return false;
        });

        jQuery('form[data-nc-ls-display-form]').submit(function(){
            eventHandler(this, true, E_SUBMIT);
            return false;
        });

        jQuery('[data-nc-ls-display-pointer]').each(function(){
            var $this = jQuery(this);
            var data = jQuery.parseJSON($this.attr('data-nc-ls-display-pointer'));
            if (data.onReadyScroll) {
                setTimeout(function(){
                    jQuery('HTML,BODY').scrollTop($this.offset().top);
                }, 1000);
                return false;
            }

            return true;
        });
    });
}
