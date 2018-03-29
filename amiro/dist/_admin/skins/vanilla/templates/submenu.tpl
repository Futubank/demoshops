##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/_buttons.lng"%%


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
##styles##
<script>
var editorBaseHref = '##root_path_www##';
function rollDown(tableHeight){
    var linksHeight = parseInt(document.getElementById('resultTable').offsetHeight);
    if ((tableHeight < linksHeight) &&
      ( parseInt(top.document.getElementById('submenu_block').style.top) + tableHeight + 60  <  top.getScrollTop() + parseInt(top.document.body.clientHeight))){
      tableHeight += 30;
      top.document.getElementById('submenu_block').style.height = tableHeight + 2 + 'px';
      window.setTimeout(function(){rollDown(tableHeight)}, 10);
    }else{
      document.getElementById('links').style.height = tableHeight + 'px';
    }
}

function Init(){
  document.getElementById('loading').style.display='none';
  document.getElementById('submenu').style.display='block';
  
  
  var tableHeight = Math.min(115, parseInt(document.getElementById('resultTable').offsetHeight));


  if(tableHeight < parseInt(top.document.getElementById('submenu_block').style.height)){
    top.document.getElementById('submenu_block').style.height = parseInt(document.getElementById('resultTable').offsetHeight) + 2 + 'px';
  }else{
    //document.getElementById('links').style.height = maxMenuHeight - 20 + 'px';
    document.getElementById('links').style.overflow = 'auto';
    rollDown(tableHeight);
  }

  
  document.onkeydown = _CloseOnEsc;
  
  if (parent.document.getElementById('submenu_block').style.display=='block'){
    document.body.focus();
  }
  
  setTimeout(function(){
        if(top.module_name != 'start'){
              if(document.getElementsByClassName('submenu_' + top.module_name).length){
                  var el = document.getElementsByClassName('submenu_' + top.module_name)[0];
                  var topPos = el.offsetTop;
                  el.childNodes[0].childNodes[0].style.fontWeight = 'bold';
                  document.getElementById('links').scrollTop = topPos;
              }
        }
    }, 300);
  
  
  ##--
  //var bNW = parent.getCookie('smnw') == 'false' ? false : true;
  //document.getElementById('smOpenAtNewWindow').checked = bNW;
  //setTarget(bNW);
  --##
}

##--
function setTarget(bInNewWindow){
    var elems = document.getElementById('links').getElementsByTagName('A');
    var target = bInNewWindow ? '_blank' : '_top';
    for (var i = 0; i < elems.length; i++) {
        elems[i].setAttribute('target', target);
    }
    parent.setCookie('smnw', bInNewWindow);
}
--##
function _CloseOnEsc(evt) {
  evt = evt ? evt : window.event;
  if (evt.keyCode == 27) {
    parent.document.getElementById('submenu_block').style.display='none';
    return false;
  }
}
</script>
</HEAD>

<BODY id=bdy bgcolor="#ffffff"  style="margin: 0px; padding: 0px;" onLoad="Init()">
<div id="loading" style="width:100%;height:100%;text-align:center;padding-top:30px;">
<img src="images/custom_/loading.gif">
</div>
<div id="submenu">
<table id="resultTable" cellpadding=0 cellspacing=0 border=0 style="width: 100%">
<tr><td class="submenu-table__td" valign=top colspan=4>
<div id="links">
<table width=100% border=0 cellpadding=0 cellspacing=0 style="margin-bottom: 7px">
##submenu##
</table>
</div>
</td>
</tr>
</table>
</div>
</BODY>
</HTML>