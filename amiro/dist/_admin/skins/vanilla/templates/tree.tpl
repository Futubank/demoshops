%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/tree.lng"%%

   <table data-helpid="sm_toolbar" id=tree_tool_bar border=0 cellspacing=0 cellpadding=0 style="background: url(skins/vanilla/images/sm-tb-bg.gif) repeat-x #FFCA68;" width=100% ##-- onmouseover="treeToolBarOver(event)" onmouseout="treeToolBarOut(event)" --##  helpId="sm_toolbar" height=30>
    <tr>
        <td colspan="2" align=center valign=middle nowrap height=18 class=tree_tool_bar>
            <span align="right" id="loading_msg"></span>
            <nobr>
                <span id="sm_tool_bar" style="display:none" >
                    <a hidefocus id="sm_add" href="javascript: void(0);" onclick="javascript:if (!this.disabled) treeFrameFunc().tree_add(0);return false;" title="%%add_page%%" >
                        <img class=smtb_btn  src="skins/vanilla/images/sm_add.gif"  width=12 helpId="sm_smtb_add_sib" >
                    </a>
                    <a hidefocus id="sm_addsub" href="javascript: void(0);" onclick="javascript:if (!this.disabled) treeFrameFunc().tree_add(1);return false;" title="%%addsub_page%%" >
                        <img class=smtb_btn  src="skins/vanilla/images/sm_addsub.gif"  width=12 helpId="sm_smtb_add_sib" >
                    </a>
                    <a hidefocus id="sm_del" href="javascript: void(0);" onclick="javascript:if (!this.disabled) treeFrameFunc().tree_del(document.forms[_cms_document_form]['name'].oldValue, 0 , group_mode);return false;" title="%%del_page%%">
                        <img class=smtb_btn   src="skins/vanilla/images/sm_del.gif"  width=12 helpId="sm_smtb_del">
                    </a>
                    <a hidefocus id="sm_top" href="javascript: void(0);" onclick="javascript:if (!this.disabled) treeFrameFunc().tree_change_order('top');return false;" title="%%move_top%%" >
                        <img class=smtb_btn   src="skins/vanilla/images/sm_top.gif"  width=12 helpId="sm_smtb_move_top">
                    </a>
                    <a hidefocus id="sm_up" href="javascript: void(0);" onclick="javascript:if (!this.disabled) treeFrameFunc().tree_change_order('up');return false;" title="%%move_up%%" >
                        <img class=smtb_btn   src="skins/vanilla/images/sm_up.gif"  width=12 helpId="sm_smtb_move_up">
                    </a>
                    <a hidefocus id="sm_down" href="javascript: void(0);" onclick="javascript:if (!this.disabled) treeFrameFunc().tree_change_order('down');return false;" title="%%move_down%%" >
                        <img class=smtb_btn   src="skins/vanilla/images/sm_down.gif"  width=12 helpId="sm_smtb_move_down">
                    </a>
                    <a hidefocus id="sm_bottom" href="javascript: void(0);" onclick="javascript:if (!this.disabled) treeFrameFunc().tree_change_order('bottom');return false;" title="%%move_bottom%%" >
                        <img class=smtb_btn   src="skins/vanilla/images/sm_bottom.gif"  width=12 helpId="sm_smtb_move_bottom">
                    </a>
                    <a hidefocus id="sm_group" href="javascript: void(0);" onclick="javascript: if (!this.disabled) treeFrameFunc().group_switch();return false;" title="%%group%%" >
                        <img class=smtb_btn src="skins/vanilla/images/sm_group.gif"  width=12 helpId="sm_smtb_group">
                    </a>
                    <a id="sm_reload" href="javascript: void(0);" onclick="javascript:tree_reload();return false;" title="%%reload%%" >
                        <img class=smtb_btn   src="skins/vanilla/images/sm_reload.gif" width=12 border=0  helpId="sm_toolbar_reload">
                    </a>
                </span>
            </nobr>
        </td>
     ##--td align=right valign=middle nowrap height=18 class=tree_tool_bar>
     <a hidefocus id="sm_remove" href="javascript: void(0);"
      ondrop="tbDrop()" ondragenter="tbDragEnter(event)" ondragover="tbDragOver(event)" onclick="return false;"><img class=smtb_btn   src="skins/vanilla/images/sm_remove.gif" width=12 border=0  helpId="sm_smtb_bin"></a></td
      --##
    </tr>
   </table>
   <iframe data-helpid="tree_frame" name="treeframe" id="treeframe" scrolling="auto" frameborder="0" class="tree_frame" topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="2" height="##window_height##" style="width: 220px;" src="gettree.php?##params##"></iframe>
   <div class="tree-block" style="position:relative;">
   <table width=100% border=0 cellspacing=0 cellpadding=0 style="background:url(skins/vanilla/images/sm-btb-bg.gif) repeat-x bottom;height:100px;border-bottom:1px #e0e0e0 solid;">
    <tr>
     <td class=tree_title nowrap helpId="sm_smtb_search" style="padding-left:3px;vertical-align:middle">
       <form name="formPageSearch" onsubmit="return false;">
       <input type="hidden" name="sm_search_string" value="" />
       <input type=text class=field style="width:170px;font-size:11px;font-family:Tahoma;padding-left:3px;"; name=sm_search_string1 onkeydown="if (event.keyCode==13) { if (this.value.length > 2) {document.forms['formPageSearchByType']['sm_module_name'].selectedIndex=0;this.form.sm_search_string.value=this.value;treeFrameFunc().FindPage(this.value);}else{alert('%%warn_search_len%%');}}" onChange="treeframe.document.forms['ftree'].previousQuery.value='';treeframe.document.forms['ftree'].foundPagesIds.value=''" value="%%search_page_msg%%" onfocus='if (this.value=="%%search_page_msg%%") this.value=""' onblur='if (this.value=="") this.value="%%search_page_msg%%"'>
       <span onclick="if ( document.forms['formPageSearch']['sm_search_string1'].value.length > 2) {document.forms['formPageSearchByType']['sm_module_name'].selectedIndex=0;document.forms['formPageSearch']['sm_search_string'].value=document.forms['formPageSearch']['sm_search_string1'].value;treeFrameFunc().FindPage(document.forms['formPageSearch']['sm_search_string'].value);}else{alert('%%warn_search_len%%');}" style="font-size:14px;cursor:pointer;font-weight:bold;color:#000;">&raquo;</span>
       </form></td>
    </tr>
    <tr>
     <td class=tree_title nowrap helpId="sm_smtb_search_by_type" style="padding-left:3px;vertical-align:middle">
       <form name="formPageSearchByType" onsubmit="return false;">
       <select name="sm_module_name" helpId="sm_form_module_name" style="width:172px"><option value="">%%search_page_by_type%%</option></select>
       <span onclick="if (document.forms['formPageSearchByType']['sm_module_name'].selectedIndex > 0) {document.forms['formPageSearch']['sm_search_string1'].value='';document.forms['formPageSearch']['sm_search_string'].value=document.forms['formPageSearchByType']['sm_module_name'].value;treeFrameFunc().FindPage(document.forms['formPageSearchByType']['sm_module_name'].value)}" style="font-size:14px;cursor:pointer;font-weight:bold;color:#000;">&raquo;</span>
       </form>
       </td>
    </tr>
    <tr>
      <td style="border-bottom:1px #fff solid;">
        <div style="position: relative;">
          <form name="tnavform">
            <input type="checkbox" name="expand" id=chk_expand ##expand## value="1" onClick="javascript:reexpand(this.checked)"  helpId="sm_smtb_expand">&nbsp;<label for="chk_expand">%%expand_all%%</label>
          </form>
          <div id="resize-sitemap" data-helpid="menu_resize" style="position:absolute;right:0px;bottom:-10px;cursor:nw-resize;" onmousedown="startSmResize(event)" style="cursor:nw-resize" valign=bottom align=right helpId="sm_smtb_resize"><img src="skins/vanilla/images/sm_corner.gif" width=14 height=14></div>
        </div>
       </td>
     </tr>
   </table>
   </div>

<script>


function tbDrop(){
    treeframe.dragAction='del';
}

function tbDragOver(evt){
    evt = amiCommon.getValidEvent(evt);
    evt.dataTransfer.effectAllowed = "move";
    evt.dataTransfer.dropEffect = "move";
    amiCommon.stopEvent(evt);
}

function tbDragEnter(evt){
    evt = amiCommon.getValidEvent(evt);

    var elTds = treeframe.document.getElementById("tree").getElementsByTagName("SPAN");
    var itemId = treeframe.itemId;
    treeframe.targetId = itemId;

    for(var i=0; i<elTds.length; i++){
      if (elTds[i].id.substr(0, 8) == "tree_it_" && elTds[i].id != "tree_it_"+itemId){
        if (group_mode && (oForm.elements["_grp_ids"].value.search(';' + elTds[i].id.substr(8) + ';') < 0) ){
          clearRuntimeStyle(elTds[i]);
        }
      }
    }

    evt.dataTransfer.effectAllowed = "move";
    evt.dataTransfer.dropEffect = "move";
    amiCommon.stopEvent(evt);
}


##--

function treeToolBarOut(evt){
  evt = amiCommon.getValidEvent(evt);
  target = amiCommon.getEventTarget(evt);
  if (target.className=='smtb_btn' && !target.disabled){
    if ( target.offsetParent && target.offsetParent.id == 'sm_group' && group_mode ){
      setRuntimeStyle(target, 'border', '1px #ffaaaa inset');
      setRuntimeStyle(target, 'background', '#FFD78C');
    }else{
      clearRuntimeStyle(target);
    }
  }
  amiCommon.stopEvent(evt);
}

function treeToolBarOver(evt){
  evt = amiCommon.getValidEvent(evt);
  target = amiCommon.getEventTarget(evt);
  if (target.className=='smtb_btn' && !target.disabled){
      setRuntimeStyle(target, 'border', '1px #ffaaaa outset');
      setRuntimeStyle(target, 'background', '#FFD78C');
      amiCommon.stopEvent(evt);
  }
}

--##

var oTreeFrame = document.getElementById('treeframe');
var isSmResizing = false;
var divResizePositionDeltaX = 0;
var divResizePositionDeltaY = 0;

var savedTreeWidth = getCookie ("pm_sitemap_width");
var savedTreeHeight = getCookie ("pm_sitemap_height");
if(savedTreeWidth != null && !isNaN(parseInt(savedTreeWidth))){
  oTreeFrame.style.width = savedTreeWidth;
  AMI.$('#left_area_big').attr('data-width-default', savedTreeWidth);
}
if(savedTreeHeight != null && !isNaN(parseInt(savedTreeHeight))){
  oTreeFrame.style.height = savedTreeHeight;
}

function startSmResize(currentEvent){
    currentEvent = amiCommon.getValidEvent(currentEvent);

    isSmResizing = true;

    var resizeObj = oTreeFrame;
    var positionMouse = amiCommon.getMousePosition(currentEvent);
    var positionFrame = amiCommon.getElementPosition(resizeObj);
    
    divResizePositionDeltaX = positionMouse[0] - positionFrame[0] - resizeObj.offsetWidth;
    divResizePositionDeltaY = positionMouse[1] - positionFrame[1] - resizeObj.offsetHeight;
    
    amiCommon.stopEvent(currentEvent);
}

function smResize(currentEvent){
    if(isSmResizing){
        currentEvent = amiCommon.getValidEvent(currentEvent);

        var positionFrame = amiCommon.getElementPosition(oTreeFrame);
        var positionMouse = amiCommon.getMousePosition(currentEvent);

        var newWidth = Math.max(0, positionMouse[0] - positionFrame[0] - divResizePositionDeltaX);
        if(newWidth > 200){
            oTreeFrame.style.width = newWidth + 'px';
            AMI.$('#left_area_big').attr('data-width-default', newWidth);
            AMI.$('#left_area_big, #left-menu-block, #left-area__block').width(newWidth);
            AMI.$('#left-menu-tab').css({left: parseInt(newWidth)+1});
        }

        var newHeight = Math.max(0, positionMouse[1] - positionFrame[1] - divResizePositionDeltaY);
        if(newHeight > 200){
            oTreeFrame.style.height = newHeight + 'px';
        }
        
        amiCommon.stopEvent(currentEvent);
    }
}

function stopSmResize(currentEvent){
    if(isSmResizing){
        isSmResizing = false;

        if(oTreeFrame.style.width.length > 0){
          setCookie("pm_sitemap_width", oTreeFrame.style.width);
          AMI.$('#left_area_big').attr('data-width-default', oTreeFrame.style.width);
          AMI.$('#left_area_big, #left-menu-block, #left-area__block').width(oTreeFrame.style.width);
          AMI.$('#left-menu-tab').css({left: parseInt(oTreeFrame.style.width)+1});
        }
        if(oTreeFrame.style.height.length > 0){
          setCookie("pm_sitemap_height", oTreeFrame.style.height);
        }
        
        currentEvent = amiCommon.getValidEvent(currentEvent);
        amiCommon.stopEvent(currentEvent);
    }
}

function treeFrameFunc(){
    if(treeframe.contentWindow){
        return treeframe.contentWindow;
    }else{
        return treeframe;
    }
}
</script>
