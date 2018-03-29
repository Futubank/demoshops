// user's functions

function isIE5() { return (navigator.userAgent.indexOf("MSIE 5") > -1); }
function isIE6() { return ((navigator.userAgent.indexOf("MSIE 6") > -1) && (navigator.userAgent.indexOf("Opera") == -1)); }
function isIE() { return (isIE5() || isIE6());}

function fixpng()
{
 for (var i = 0; i < document.images.length; i++)
 {
  var img = document.images[i];
  imgSrc = img.src;
  if (imgSrc.substr(imgSrc.length-3).toLowerCase() == "png")
  {
   var w, h;
   w = img.width, h = img.height;
   img.src = "_mod_files/ce_images/spacer.gif";
   img.width = w, img.height = h;
   img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src=\'" + imgSrc + "\', sizingMethod='scale');";
  }
 }
}

var isIE = isIE();
if (isIE) window.attachEvent("onload", fixpng); 






var oAlertWindow;
var oAlertWindowTimer;

function showInitAlert(){
    oAlertWindow = document.getElementById('status_message');
    if (oAlertWindow){
      var oLocalMessage = document.getElementById('status_message_local');
      if(oLocalMessage && (oAlertWindow.className == 'status_error')){
          oLocalMessage.style.display = 'none';
      }
      alert(oAlertWindow.innerHTML);
    }
}


function alert(message){
    if(!message || (message == '')){
        return false;
    }
    oAlertWindow = document.getElementById('status_message');
    if (!oAlertWindow){
        oAlertWindow = AMI.Browser.DOM.create('DIV', 'status_message', 'status_notice', '', document.body);
    }
    if((oAlertWindow.innerHTML != '') && (oAlertWindow.style.visibility == 'visible')){
        if(oAlertWindow.innerHTML != message){
          oAlertWindow.innerHTML += '<br>' + message;
        }
    }else{
        oAlertWindow.innerHTML = message;

        if(!oAlertWindow.onmouseover) oAlertWindow.onmouseover = function(){
            window.clearTimeout(oAlertWindowTimer);
        }
        if(!oAlertWindow.onmouseout) oAlertWindow.onmouseout = function(){
            window.setTimeout(function(oObj){return function(){fadeOut(oObj, 1000)}}(oAlertWindow), 1000);
        }
				if (navigator.userAgent.indexOf("MSIE") >= 0) {
				}
				else {
				oAlertWindow.style.left = parseInt((AMI.Browser.getWindowWidth() - oAlertWindow.offsetWidth) / 2);				
				}	
		fadeIn(oAlertWindow, 300);					
    }
    window.clearTimeout(oAlertWindowTimer);
    oAlertWindowTimer = window.setTimeout(function(oObj){return function(){fadeOut(oObj, 1000)}}(oAlertWindow), 4000);
}

function fadeOut(oObj, time){     
    var delay = 50;
    if(time==null){
        var time = 500;
    }
        alert( parseFloat(oObj.style.opacity) + ' - ' + parseFloat(oObj.style.opacity) +' / ' + (time / delay) + ' = ' + parseFloat(oObj.style.opacity) - (parseFloat(oObj.style.opacity) / (time / delay)));
    if(time > 0){
        time -= delay;
        oObj.style.opacity = parseFloat(oObj.style.opacity) - ( parseFloat(oObj.style.opacity) / (time / delay) );
        window.setTimeout(function(_oObj, _time ){return function(){fadeOut(_oObj, _time)}}(oObj, time), delay);
    }else{
        oObj.style.opacity = '1';
        oObj.style.visibility = 'hidden';
    }
}

function fadeIn(oObj, time){
    var delay = 50;
    if(oObj.style.visibility != 'visible'){
        oObj.style.visibility = 'visible';
        oObj.style.opacity = '0';
    }
    if(time==null){
        var time = 500;
    }
    if(time > 0){
        time -= delay;
        oObj.style.opacity = parseFloat(oObj.style.opacity) + (1 - parseFloat(oObj.style.opacity)) / (time / delay);
        window.setTimeout(function(_oObj, _time){return function(){fadeIn(_oObj, _time)}}(oObj, time), delay);
    }
}

// addOnLoadEvent(showInitAlert);
savePreviousOnLoadEvent();

// menu.js

function load(location){
    if(document.images){
        var image = new Image();
        image.src = location;
        return image;
    }
}

function getElementPosition(oElement, oMenu){
    var res = new Array(0, 0);
    // Detect absolute or relative parent offset
    pStopObj = null;
    pObj = oMenu.parentNode;
    while(pObj != null && typeof(pObj.style) != "undefined"){
        if(pObj.style.position == "absolute" || pObj.style.position == "relative"){
            pStopObj = pObj;
            break;
        }
        pObj = pObj.parentNode;
    }
    // Get coordinates
    do{
        if(pStopObj == oElement)
            break;
        res[0] += oElement.offsetLeft;
        res[1] += oElement.offsetTop;
    }while((oElement = oElement.offsetParent) != null);
    return res;
}

function positioningMenu(smNum, relateToParentX, relateToParentY, deltaX, deltaY){
    var menuId = "sub_menu_" + smNum;
    var menuObj = document.getElementById(menuId);
    var parentId = "j" + smNum;
    var parentObj = document.getElementById(parentId);
    
    var parentPosition = getElementPosition(parentObj, menuObj);

    if(typeof(deltaX) == "undefined")
        deltaX = 0;
    if(relateToParentX == "right" || relateToParentX == "center"){
        parentWidth = parentObj.offsetWidth;
        if(relateToParentX == "center")
            parentWidth = parentWidth/2;
        deltaX += parentWidth;
    }
    
    if(typeof(deltaY) == "undefined")
        deltaY = 0;
    if(relateToParentY == "bottom" || relateToParentY == "center"){
        parentHeight = parentObj.offsetHeight;
        if(relateToParentY == "center")
            parentHeight = parentHeight/2;
        deltaY += parentHeight;
    }
    
    menuObj.style.position = 'absolute';
    menuObj.style.left = parentPosition[0] + deltaX + 'px';
    menuObj.style.top = parentPosition[1] + deltaY + 'px';
}

var hTmMenuHide = null;
var hTmSubMenuHide = {"init":0};
var prevImgSrc = Array();
var openedMenusStack = Array();

function showMenu(smNum, parentNum, relateToParentX, relateToParentY, deltaX, deltaY, imgOver){
    var menuObj = document.getElementById("sub_menu_" + smNum);
    if(menuObj != null){
        clearTimeout(hTmMenuHide);
        clearTimeout(hTmSubMenuHide[smNum]);
        
        hideMenuById(parentNum, true, true);
        positioningMenu(smNum, relateToParentX, relateToParentY, deltaX, deltaY);
      
        if(document.images['main_menu_img_'+smNum]){
            prevImgSrc[smNum] = document.images['main_menu_img_'+smNum].src;
            document.images['main_menu_img_'+smNum].src = imgOver;
        }
        
        document.getElementById("sub_menu_" + smNum).style.display = 'block';
        openedMenusStack.push(smNum);
    }
}

function hideMenu(smNum){
    var menuObj = document.getElementById("sub_menu_" + smNum);
    if(menuObj != null){
        menuObj.style.display = 'none';
        images = document.getElementsByTagName("IMG");
        if(document.images && document.images['main_menu_img_'+smNum] && prevImgSrc[smNum] != null){
            document.images['main_menu_img_'+smNum].src = prevImgSrc[smNum];
        }
    }
}

function hideMenuById(smNum, isIdParent, hideAllIfNotFound){
    if(smNum == 0){
        hideMenuAll();
    }else{
        var removeFromPos = -1;
        for(i = 0; i < openedMenusStack.length; i++){
            if(openedMenusStack[i] == 0)
                break;
            if(removeFromPos == -1 && openedMenusStack[i] == smNum){
                removeFromPos = i;
                if(isIdParent){
                    removeFromPos += 1;
                    continue;
                }
            }
            if(removeFromPos > -1){
                hideMenu(openedMenusStack[i]);
            }
        }
        if(hideAllIfNotFound && removeFromPos == -1){
            hideMenuAll();
        }else if(removeFromPos > -1 && removeFromPos < openedMenusStack.length){
            openedMenusStack.splice(removeFromPos, openedMenusStack.length-removeFromPos);
        }
    }
} 

function hideMenuAll(){
    for(i = openedMenusStack.length-1; i >= 0; i--){
        hideMenu(openedMenusStack[i]);
    }
    openedMenusStack = new Array();
    
    // Switch to next block if you have some problems with div hiding caused special custom processing
    /*oDivs = document.getElementsByTagName("DIV");
    for(i = 0; i < oDivs.length; i++){
        if(oDivs[i].id.substr(0, 9) == "sub_menu_"){
            hideMenu(oDivs[i].id.substr(9));
        }
    }*/
} 

function hideMenuAllByTimeout(){
    hTmMenuHide = setTimeout('hideMenuAll()', 500);
}
function hideMenuIdByTimeout(smNum){
    hTmSubMenuHide[smNum] = setTimeout('hideMenuById('+smNum+', false, false)', 250);
}

/* HTML handlers */
function mon(smNum, smParentId){
    clearTimeout(hTmMenuHide);
    if(typeof(smNum) != "undefined" && smNum > 0){
        clearTimeout(hTmSubMenuHide[smNum]);
    }
    if(typeof(smParentId) != "undefined" && smParentId > 0){
        clearTimeout(hTmSubMenuHide[smParentId]);
    }
}
function moff(smNum, evt){
    hideMenuAllByTimeout();
    if(typeof(smNum) != "undefined"){
        hideMenuIdByTimeout(smNum);
    }
    if(typeof(evt) != "undefined"){
        if(typeof(evt.cancelBubble) != "undefined"){
            evt.cancelBubble = true;
            if(typeof(evt.stopPropagation) == "function")
                evt.stopPropagation();
        }
    }
}
function submoff(menuId){
    hideMenuIdByTimeout(menuId);
}
function ck(num,state){
}
function smclick(){
    hideMenuAll();
}

// preload.js

var clockColor;

nn = (document.getElementById && navigator.appName == "Netscape") ? 1 : 0;
ie = (!nn && document.all) ? 1 : 0;

function getRTime(){


  clockS -= 1;

  if (clockS < 0){

    clockS = 59;
    clockM -= 1;

    if (clockM < 0)
      clockM = 59;
  }

  var sSec = clockS;

  if ( String(clockS).length < 2)
    sSec = "0"+ clockS;

  var sMin = clockM;

  if ( String(clockM).length < 2)
    sMin = "0"+ clockM;

  clockColor = "white";

  if (clockM < 20)
    clockColor="yellow";
  if (clockM < 10)
    clockColor="red";

  return sMin+":"+sSec; 

}


function showTime()
{


  if ((typeof(clockS)=="number") && typeof(clockM)=="number"){  

    STime=getRTime(); 

    if (document.all && document.all["clock"] ){

      var clock = document.all["clock"];
    
      clock.innerHTML=STime;

      clock.style.color=clockColor;

    }
    if ( ie )
      timerId=setTimeout("showTime()",1000);
  }
}

//showTime()



function none(){
  return false;
}

function newImage(arg) {
  if (document.images) {
    rslt = new Image();
    rslt.src = arg;
    return rslt;
  }
}

function changeImages() {
  if (document.images && (preloadFlag == true)) {
    for (var i=0; i<changeImages.arguments.length; i+=2) {
      document[changeImages.arguments[i]].src = changeImages.arguments[i+1];
    }
  }
}

var preloadFlag = false;

function preloadImages() { 
  if(document.images) { 
     if(!preloadFlag) var pImages =new Array();
     var i,j=pImages.length,args=preloadImages.arguments; 
     if (args[0].length)
       args = args[0];
     for(i=0; i<args.length; i++)
     if(args[i].indexOf("#")!=0) { 
        pImages[j]=new Image; 
        pImages[j++].src=args[i];
     }
  preloadFlag = true;
  }
}

if (typeof(arrPreload)!="undefined")
  preloadImages(arrPreload);

function DoPreload(){
}
       
AMI.UI.overloadAlert(true);