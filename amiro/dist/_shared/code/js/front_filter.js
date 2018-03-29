var flagNames = [];
var flagMaps = [];

function _dec_to_rgb(value) {
  var hex_string = "";
  for (var hexpair = 0; hexpair < 3; hexpair++) {
    var onebyte = value & 0xFF;            // get low onebyte
    value >>= 8;                        // drop low onebyte
    var nybble2 = onebyte & 0x0F;          // get low nybble (4 bits)
    var nybble1 = (onebyte >> 4) & 0x0F;   // get high nybble
    hex_string += nybble1.toString(16); // convert nybble to hex
    hex_string += nybble2.toString(16); // convert nybble to hex
  }
  return hex_string.toUpperCase();
}


function flagMapAdd(name, num, isCr){
    if(!isNaN(num)){
        mapID = -1;
        for(i = 0; i < flagNames.length; i++){
            if(flagNames[i] == name){
                mapID = i;
                break;
            }
        }
        if(mapID == -1){
            mapID = flagNames.length;
            flagNames[mapID] = name;
            flagMaps[mapID] = [];
        }
        if(flagMaps[mapID].length < num){
            for(i = 0; i < num; i++)
                if(!flagMaps[mapID][i])
                    flagMaps[mapID][i] = 0;
        }
        if(!isCr)
            flagMaps[mapID][num-1] = 1;
    }
}

function arrToHex(arrIn){
    realValTmp = "";
    realVal = "";
    var tmp = "";
    var isLastProcessed = true;
    for(k = 1; k <= arrIn.length; k++){
        isLastProcessed = false;
        tmp = arrIn[k-1]+tmp;
        if(k % 4 == 0){
            realValTmp += parseInt(tmp, 2).toString(16);
            tmp = "";
            isLastProcessed = true;
        }
    }
    if(!isLastProcessed)
        realValTmp += parseInt(tmp, 2).toString(16);
    hexZeroStart = true;
    for(k = realValTmp.length-1; k >= 0; k--){
        if(realValTmp.substr(k, 1) != "0" || !hexZeroStart){
            realVal += realValTmp.substr(k, 1);
            hexZeroStart = false;
        }
    }
    return realVal;
}

function CheckFilterForms(fform, isSearchForm, isOrder, skipOffestSetting) {
    var forceSubmitUrl;
    var _tmpVarName;
    _tmpVarName = fform.name + "_forceSubmitUrl";

    forceSubmitUrl = eval("if(typeof("+_tmpVarName+") != 'undefined') {"+_tmpVarName+"} else {''}");

    if(isOrder != 1)
        isOrder = 0;

  // special run over checkbox filter fields
               //if()
  for(var i=0; i<fform.length; i++){
   el = fform.elements[i];
   if(el.type == 'checkbox' && el.name.indexOf("[]") <= 0){
     val = (el.checked)?1:0;
     el.value = val;
     cname=el.name;

     if(fform.elements[cname] && (fform.elements[cname].type=='hidden')){
         if(typeof(fform.elements["enc_"+cname])=='object') {
            fform.elements["enc_"+cname].value = val;
         }
         fform.elements[cname].value = val;
     }
   }
  }

  if(typeof(skipOffestSetting) == 'undefined'){
      if(typeof(fform.elements['offset'])=='object') {
       fform.elements['offset'].value = 0;
      }
      if(typeof(fform.elements['enc_offset'])=='object') {
       fform.elements['enc_offset'].value = 0;
      }
  }

  // Create the submit URL
  flagNames = [];
  flagMaps = [];
  var submitURL = '';
  if(forceSubmitUrl != '') {
      submitURL = forceSubmitUrl;
  }else{
      submitURL = _cms_script_link;
  }
  for(var i=0; i < fform.length; i++){
   el = fform.elements[i];
   if(typeof(el.name) == 'undefined'){
       continue;
   }
   elName = el.name;
   if(el.name.indexOf("prop_") >= 0 && isOrder){
       if((fpos = el.name.lastIndexOf("_x")) >= 0){
            elName = el.name.substr(0, fpos);
       }
       elName += "[]";
   }
   if(el.type == 'checkbox'){
     if(el.checked){
         if((fpos = el.name.indexOf("_flag_")) >= 0){
            flagMapAdd(el.name.substr(0, fpos), parseInt(el.name.substr(fpos+6)), 0);
         }else if(el.value != ''){
            submitURL += '&'+elName+'='+encodeURIComponent(el.value);
         }
     }else{
         if((fpos = el.name.indexOf("_flag_")) >= 0){
            flagMapAdd(el.name.substr(0, fpos), parseInt(el.name.substr(fpos+6)), 1);
         }else{
             //if(el.name.indexOf("[]") <= 0) /* do not process array items */
             //   submitURL += '&'+elName+'=';
         }
     }
   }else if(el.type == 'select-one'){
     if((fpos = el.name.indexOf("_flag")) >= 0){
        flagMapAdd(el.name.substr(0, fpos), parseInt(el.value), 0);
     }else if(el.value != ''){
         submitURL += '&'+elName+'='+encodeURIComponent(el.value);
     }
   }else if(el.type == 'select-multiple'){
     fpos = el.name.indexOf("_flag");
     for(k = 0; k < el.length; k++){
       if(el.options[k].selected){
          if(fpos >= 0){
            flagMapAdd(el.name.substr(0, fpos), parseInt(el.options[k].value), 0);
          }else{
            submitURL += '&'+encodeURIComponent(elName)+'='+encodeURIComponent(el.options[k].value);
          }
       }
     }
   }else if(el.type == 'radio'){
     if(el.checked){
         if((fpos = el.name.indexOf("_flag")) >= 0){
            flagMapAdd(el.name.substr(0, fpos), parseInt(el.value), 0);
         }else{
             submitURL += '&'+elName+'='+encodeURIComponent(el.value);
         }
     }
   }else{
     if(el.name == "action" && ((!isOrder && fform.search_subcats && fform.search_subcats.checked) || isSearchForm)) {
        submitURL += '&action=search';
     } else if(el.value != '' && elName != 'btnFlt_apply' && (!isOrder || el.name != "action" && el.name != "order")) {
        submitURL += '&'+elName+'='+encodeURIComponent(el.value);
     }
   }
  }
  for(i = 0; i < flagMaps.length; i++){
    if(flagNames[i]){
     submitURL += '&'+flagNames[i]+'=0x'+arrToHex(flagMaps[i]);
    }
  }
  if(isOrder)
    submitURL += '&eshop_special=1&action=add';

  document.location.href=submitURL;
  return false;
}

function checkSearchForms(fform, fltFormName) {
  if(typeof(fltFormName) != 'undefined') {
      _cms_document_form = fltFormName;
  } else if(typeof(_cms_document_form) == 'undefined') {
    _cms_document_form = _cms_filter_form;
  }

  var sform = document.forms[_cms_document_form];
  // special run over checkbox filter fields
  for(var i=0; i<fform.length; i++){
   el = fform.elements[i];
   if(el.type == 'text'){
     cname=el.name;

     if(sform.elements[cname] && (sform.elements[cname].type=='hidden')){
         if(typeof(sform.elements["enc_"+cname])=='object') {
            sform.elements["enc_"+cname].value = el.value;
         }
         sform.elements[cname].value = el.value;
     }
   }
  }
  CheckFilterForms(sform, 1);
  return false;
}
