/* Move to common */

function setRuntimeStyle(element, styleName, styleValue){
    if(element.runtimeStyle){
        element.runtimeStyle[styleName] = styleValue;
    }else{
        if(typeof(element.runtimeStyles) == 'undefined'){
            element.backupStyles = new Object();
            element.runtimeStyles = new Object();
        }
        if(styleValue != ''){
            if(!element.runtimeStyles[styleName] || element.runtimeStyles[styleName] == ''){
                element.backupStyles[styleName] = element.style[styleName];
            }
            element.runtimeStyles[styleName] = styleValue;
            element.style[styleName] = styleValue;
        }else if(element.runtimeStyles && element.runtimeStyles[styleName] != ''){
            if(typeof(element.backupStyles[styleName]) != 'undefined'){
                element.style[styleName] = element.backupStyles[styleName];
                element.backupStyles[styleName] = '';
            }
            element.runtimeStyles[styleName] = '';
        }
    }
}

function getRuntimeStyle(element, styleName){
    if(element.runtimeStyle){
        return element.runtimeStyle[styleName];
    }else{
        if(element.runtimeStyles){
            if(styleName == '_count'){
                var num = 0;
                for(styleNameVar in element.runtimeStyles){
                    if(element.runtimeStyles[styleNameVar] != ''){
                        num ++;
                    }
                }
                return num;
            }else{
                if(element.runtimeStyles[styleName]){
                    return element.runtimeStyles[styleName];
                }
            }
        }
    }
    return '';
}

function clearRuntimeStyle(element){
    if(element.runtimeStyle){
        element.runtimeStyle.cssText = '';
    }else{
        if(element.backupStyles){
            for(styleName in element.backupStyles){
                element.style[styleName] = element.backupStyles[styleName];
            }
            element.backupStyles = new Object();
        }
        if(element.runtimeStyles){
            element.runtimeStyles = new Object();
        }
    }
}

/* /Move to common */






function InitiateDrag(cid, pid){
  errFunc = InitiateDrag;  
	  var oForm = parent.document.forms[parent._cms_document_form];
		if (parent.redirect_mode && oForm.elements["redirect_id"].value == 0){
			return;
		}
    itemId = cid;
    oldPid = pid;
    sData = document.getElementById("tree_url_"+itemId).href; 
    sData = sData.replace(parent.editorBaseHref, "");
    event.dataTransfer.setData("Text", document.getElementById("tree_it_"+itemId).innerText);
    event.dataTransfer.setData("URL", sData);
    event.dataTransfer.effectAllowed = "all";
    event.dataTransfer.dropEffect = "move";
    if (document.getElementById("tree_it_"+itemId) && pid > 0){
      if (parent.clipboardItemId > 0){
        clearRuntimeStyle(document.getElementById("tree_it_"+parent.clipboardItemId));
      }
      setRuntimeStyle(document.getElementById("tree_it_"+itemId), 'borderLeft', "2px #990000 solid");
      setRuntimeStyle(document.getElementById("tree_it_"+itemId), 'borderRight', "2px #990000 solid");
    }else{
      itemId = 0;
      oldPid = 0;
    }
}

function selectTargetItem(){
  errFunc = selectTargetItem;  
  var elTds = document.getElementById("tree").getElementsByTagName("SPAN");
  var oForm = parent.document.forms[parent._cms_document_form];
  for(var i=0; i< elTds.length; i++){
    if (elTds[i].id.substr(0, 8) == "tree_it_" && elTds[i].id != "tree_it_"+itemId){
      if (!parent.group_mode || (parent.group_mode && (oForm.elements["_grp_ids"].value.search(';' + elTds[i].id.substr(8) + ';') < 0))){
        clearRuntimeStyle(elTds[i]);
      }
    }
  }
  if (document.getElementById("tree_it_"+targetId)){
    setRuntimeStyle(document.getElementById("tree_it_"+targetId), 'color', "#990000");
  }
}

function DragLeave(cid, pid){
  errFunc = DragLeave;  
		if (document.getElementById("tree_it_"+cid)){
      if (document.getElementById("tree_it_"+targetId)){
        document.getElementById("tree_it_"+targetId).runtimeStyle.color="";
        clearRuntimeStyle(document.getElementById("tree_it_"+targetId));
      }
      targetId = 0;
    }
}

function DragOver(cid, pid, evt){
  errFunc = DragOver;  
  
    evt = amiCommon.getValidEvent(evt);

		if (document.getElementById("tree_it_"+cid)){
      if (evt.ctrlKey ){
        evt.dataTransfer.effectAllowed = "copy";
        evt.dataTransfer.dropEffect = "copy";
      }
      else{
        evt.dataTransfer.effectAllowed = "move";
        evt.dataTransfer.dropEffect = "move";
      }
      if (itemId > 0 && itemId != cid && ( ( cid != oldPid ) || evt.dataTransfer.dropEffect == "copy" ) && ( itemId != pid )){
        if (targetId != cid){
          oldTargetId = targetId;
          targetId = cid;
          selectTargetItem();
        }
        amiCommon.stopEvent(evt);
      }
    }
}


function DragEnter(cid, pid){
  errFunc = DragEnter;  
  return;

}

function DragEnd(evt, itemId, targetId){
  errFunc = DragEnd;
  
  itemId = itemId.substr(3);
  targetId = targetId.substr(3);
  
  evt = amiCommon.getValidEvent(evt);

    /*if (dragAction=="del"){
      dragAction = "";
      tree_del(document.getElementById('tree_it_'+itemId).innerText, itemId, false);
    }*/

    /*if (document.getElementById("tree_it_"+itemId) && document.getElementById("tree_it_"+targetId)){
      if ((itemId != targetId) && (targetId != 0)) {*/
        if (evt.ctrlKey ){
          var Action = "copy";
        }
        else{
          var Action = "move";
        }
        CopyItem(itemId, targetId, Action);
    /*  }
    }*/

    /*if (document.getElementById("tree_it_"+itemId))
      clearRuntimeStyle(document.getElementById("tree_it_"+itemId));
    if (document.getElementById("tree_it_"+targetId))
      clearRuntimeStyle(document.getElementById("tree_it_"+targetId));*/

    /*if (parent.clipboardItemId > 0){
      setRuntimeStyle(document.getElementById("tree_it_"+parent.clipboardItemId), 'borderLeft', "2px #990000 solid");
      setRuntimeStyle(document.getElementById("tree_it_"+parent.clipboardItemId), 'borderRight', "2px #990000 solid");
    }*/

    itemId = 0;
    targetId = 0;
}




function ChangeLayout(lay_id){
  errFunc = ChangeLayout;  
  if(typeof(lay_id) != 'undefined'){
    if(lay_id != '0'){
      parent.document.getElementById('status-msgs').innerHTML = '';  
      parent.document.getElementById('status-block').style.display = 'none';
      document.forms['ftree'].action.value = 'change_lay';
      document.forms['ftree'].submit();
      parent.enableForm(false);
    }else{
      alert(errmsg);
    }
  }
}


function FindPage(sUrl){
  errFunc = FindPage;
	  parent.document.getElementById('form_title').innerHTML = processing_msg;
    parent.document.getElementById('status-msgs').innerHTML = '';
    parent.document.getElementById('status-block').style.display = 'none';
    document.forms['ftree'].action.value = 'find_page';
    document.forms['ftree'].search_url.value = sUrl;
    document.forms['ftree'].submit();
    parent.enableForm(false);
}

function tree_del(pagename, pageId, group){
  errFunc = tree_del;  

  var oTreeToolBar = parent.document.getElementById('tree_tool_bar');
  var oForm = parent.document.forms[parent._cms_document_form];

	if (typeof(group)=="undefined"){
		group = false;
	}

	if (group && oForm.elements["_grp_ids"].value.length > 0){
		var confirmMsg = parent.pages_del_confirm;
	}else{
		var confirmMsg = '\''+pagename+'\' '+parent.page_del_confirm;
  }

  if(confirm(confirmMsg)){
    if (typeof(pageId)!="undefined" && pageId != 0){
      oForm.elements["selId"].value = oForm.elements["itemid"].value;
      oForm.elements["itemid"].value = pageId;
    }
    parent.clearForm("", true);
	parent.document.getElementById('form_title').innerHTML = processing_msg;
    parent.document.getElementById('status-msgs').innerHTML = '';  
    parent.document.getElementById('status-block').style.display = 'none';
    oForm.elements["action"].value = "del";
    oForm.submit();
    oForm.elements["selId"].value = "";
    parent.document.getElementById("loading_msg").innerHTML = processing_msg;
    parent.document.getElementById("sm_tool_bar").style.display = "none";
    parent.document.getElementById("loading_msg").style.display = "block"; 
    parent.enableForm(false);
  }
}


function tree_add(isSubPage){
  errFunc = tree_add;  
  oForm = parent.document.forms[parent._cms_document_form];
  var oTreeToolBar = parent.document.getElementById('tree_tool_bar');

   if ( isSubPage ){
     if(!confirm(parent.add_subpage_confirm+' "' + oForm.name.oldValue+ '"?'))
       return;
   }else{
     if(!confirm(parent.add_page_confirm+' "' + oForm.name.oldValue+ '"?'))
       return;
   }

  
  if (parent._cms_document_form_changed){
    if (!confirm(parent._cms_form_changed_alert)){
      return;
    }
  }
  parent.document.getElementById('form_title').innerHTML = processing_msg;
  parent.document.getElementById('status-msgs').innerHTML = '';  
  parent.document.getElementById('status-block').style.display = 'none';
  parent.clearForm("", false);
  oForm.elements["action"].value = "add";
  if (!isSubPage)
    oForm.elements["itemid"].value = oForm.elements["parentId"].value;

  oForm.show_me_at_parent.disabled = false;
  oForm.show_in_sitemap.disabled = false;
  oForm.show_siblings.disabled = false;
  oForm.module_name.value='pages';
  oForm.submit();
  parent.document.getElementById("loading_msg").innerHTML = processing_msg;
  parent.document.getElementById("sm_tool_bar").style.display = "none";
  parent.document.getElementById("loading_msg").style.display = "block"; 
  parent.enableForm(false);
}


function tree_change_order(action){
  errFunc = tree_change_order;  
  var oTreeToolBar = parent.document.getElementById('tree_tool_bar');
  var oForm = parent.document.forms[parent._cms_document_form];

    document.forms['ftree'].parentId.value = oForm.elements['parentId'].value;
    document.forms['ftree'].position.value = oForm.elements['position'].value;
    parent.document.getElementById('form_title').innerHTML = processing_msg;
    parent.document.getElementById('status-msgs').innerHTML = '';  
    parent.document.getElementById('status-block').style.display = 'none';
    document.forms['ftree'].action.value = action;
    document.forms['ftree'].submit();
    parent.document.getElementById("loading_msg").innerHTML = processing_msg;
    parent.document.getElementById("sm_tool_bar").style.display = "none";
    parent.document.getElementById("loading_msg").style.display = "block"; 

    parent.enableForm(false);
}


function tree_act_version(action){
  errFunc = tree_act_version;  
  var oTreeToolBar = parent.document.getElementById('tree_tool_bar');
  var oForm = parent.document.forms[parent._cms_document_form];
  parent.clearForm("", true);
  parent.document.getElementById('form_title').innerHTML = processing_msg;
  parent.document.getElementById('status-msgs').innerHTML = '';  
  parent.document.getElementById('status-block').style.display = 'none';
  oForm.elements["action"].value = action;
  oForm.submit();
  parent.document.getElementById("loading_msg").innerHTML = processing_msg;
  parent.document.getElementById("sm_tool_bar").style.display = "none";
  parent.document.getElementById("loading_msg").style.display = "block"; 
  parent.enableForm(false);
}

function smEnableButton(name, state, save){
  errFunc = smEnableButton;  
  var oTreeToolBar = parent.document.getElementById('tree_tool_bar');
  var obj = parent.document.getElementById("sm_" + name);
  var subObj = obj.getElementsByTagName('img')[0];
  if (state){
    obj.disabled = false;
    subObj.style.filter = '';;
    subObj.style.opacity = 1;
    subObj.disabled = false;
  }else{
    obj.disabled = true;
    subObj.style.filter = "progid:DXImageTransform.Microsoft.Alpha(Opacity=30)";
    subObj.style.opacity = 0.3;
    subObj.disabled=true;
  }
  if (save){
    obj.originalState = state;
  }
}

function smRestoreButtonState(name){
  errFunc = smRestoreButtonState;  
  var oTreeToolBar = parent.document.getElementById('tree_tool_bar');
  smEnableButton(name, parent.document.getElementById("sm_" + name).originalState);
}

function group_switch(){
  errFunc = group_switch;  
  var oForm = parent.document.forms[parent._cms_document_form];
	if (!parent.group_mode){
		if (parent._cms_document_form_changed){
      if (!confirm(parent._cms_form_changed_alert)){
			  return;
      }
  	  SetPageData();
		}
    for (i=0;i<oForm.elements.length;i++){
      if ( ( oForm.elements[i].tagName == 'INPUT' ) && ( oForm.elements[i].type == 'checkbox' ) && ( oForm.elements[i].name.substr(0, 4) == 'grp_')){
         oForm.elements[i].checked = false;
      }
    }
	}
	enableGrpMode(!parent.group_mode);
}

function enableGrpMode(state){
  errFunc = enableGrpMode;  
  var oTreeToolBar = parent.document.getElementById('tree_tool_bar');
  var oForm = parent.document.forms[parent._cms_document_form];
	var elTds = document.getElementById("tree").getElementsByTagName("INPUT");
	for(var i=0; i<elTds.length; i++){
		if ( ( elTds[i].type == 'checkbox' ) && ( elTds[i].id.substr(0, 8) == 'tree_ch_' ) ){
			elTds[i].style.display = state ? 'inline' : 'none';
		}
	}

	if (state){
    smEnableButton("add", false);
    smEnableButton("addsub", false);

		parent.document.getElementById('single_mode_controls').style.display='none';
		parent.document.getElementById('group_mode_controls').style.display='block';
    oForm.elements['grp_layout_id'].value = '';
    if (oForm.elements['grp_visible_area']){
      oForm.elements['grp_visible_area'].value = '';
    }
    oForm.elements['grp_generate_link'].checked = false;
    oForm.elements['grp_generate_keywords'].checked = false;
    oForm.elements['grp_generate_keywords_auto'].checked = true;
		parent.document.getElementById('form_title').innerHTML = parent.group_mode_title;
    oForm.elements['action'].value = 'grp_apply';
	}else{
		clearGrpIds();
    smRestoreButtonState("add");
    smRestoreButtonState("addsub");

		parent.document.getElementById('single_mode_controls').style.display='block';
		parent.document.getElementById('group_mode_controls').style.display='none';

		parent.document.getElementById('form_title').innerHTML = parentFormTitle;
    oForm.elements['action'].value = 'apply';
	}
	parent.group_mode = state;
}

function addGrpId(oForm, itemid){
    errFunc = addGrpId;
    var tmp = oForm.elements["_grp_ids"].value;
    if (tmp == ""){
		tmp = ';' + itemid + ';';
	}else{
		if (tmp.search(';' + itemid + ';') < 0){
			tmp += itemid + ';';
		}
	}
    oForm.elements["_grp_ids"].value = tmp;
}

function delGrpId(oForm, itemid){
    errFunc = delGrpId;  
	var tmp = oForm.elements["_grp_ids"].value;
    tmp = tmp.replace(itemid + ';', '');

	if (tmp == ';'){
		tmp = "";
	}
    
    oForm.elements["_grp_ids"].value = tmp;
}

function clearGrpIds(){
  errFunc = clearGrpIds;  
	var oForm = parent.document.forms[parent._cms_document_form];
	if (oForm.elements["_grp_ids"].value == ""){
		return;
	}
	parent._prev_grp_ids = oForm.elements["_grp_ids"].value;
	oForm.elements["_grp_ids"].value = "";
	var elTds = document.getElementById("tree").getElementsByTagName("SPAN");
	for(var i=0; i< elTds.length; i++){
		if (elTds[i].id.substr(0, 8) == "tree_it_"){
			var itemId = elTds[i].id.substr(8);
			var oCheck = document.getElementById("tree_ch_" + itemId);
			oCheck.checked = false;
            clearRuntimeStyle(elTds[i]);
		}
	}
}

function selectGrpPages(){
  errFunc = selectGrpPages;  
  var oForm = parent.document.forms[parent._cms_document_form];
	var grpIds = oForm.elements["_grp_ids"].value.split(';');
	for (var i = 0; i < grpIds.length; i++ ){
		if (grpIds[i] == "" ){
			continue;
		}
		var oCheck = document.getElementById("tree_ch_"+ grpIds[i]);
		if (grpIds[i] == oForm.elements["itemid"].value){
			oCheck.checked = true;
			continue;
		}
    var oItem = document.getElementById("tree_it_" + grpIds[i]);
		if ( oItem ){
            setRuntimeStyle(oItem, 'color', '#990000');
            setRuntimeStyle(oItem, 'fontWeight', 'bold');
			oCheck.checked = true;
		}else{
			delGrpId(oForm, grpIds[i]);
		}
	} 
	if (parent.group_mode){
		enableGrpMode(true);
	}else{
		enableGrpMode(false);
	}
}

function tree_grp_select(itemid, pid, state, child, sibling){
    errFunc = tree_grp_select;
    var aItems = Array();
    aItems[aItems.length] = itemid;
    if(sibling || child){
        var aMap = Array();
        var aLevels = {'baseLevel' : 0};
        var elTds = document.getElementById("tree").getElementsByTagName("SPAN");
        for(var i=0; i < elTds.length; i++){
            if(elTds[i].id.substr(0, 8) == "tree_it_"){
                var el_pid = elTds[i].getAttribute("pid");
                var el_id = elTds[i].id.substr(8);
                aMap[aMap.length] = new Array(el_id, el_pid);
                if(el_pid == 0 || typeof(aLevels[el_pid]) == 'undefined'){
                    aLevels[el_id] = 1;
                }else{
                    aLevels[el_id] = aLevels[el_pid] + 1;
                }
                if(el_id == itemid){
                    aLevels['baseLevel'] = aLevels[el_id];
                }
            }
        }
        var checkChilds = 0;
        for(i = 0; i < aMap.length; i++){
            var isItemSet = false;
            if(sibling && aMap[i][1] == pid && aMap[i][0] != itemid){
                aItems[aItems.length] = aMap[i][0];
                isItemSet = true;
            }
            if(child){
                if(checkChilds == 0 && aMap[i][0] == itemid){
                    checkChilds = 1;
                }else if(checkChilds == 1){
                    if(aLevels[aMap[i][0]] > aLevels['baseLevel']){
                        if(!isItemSet)
                            aItems[aItems.length] = aMap[i][0];
                    }else
                        checkChilds = 2;
                }
            }
        }
    }
    
    var oForm = parent.document.forms[parent._cms_document_form];
	for (var i = 0; i < aItems.length; i++){
		var oItem = document.getElementById("tree_it_"+aItems[i]);
		var oCheck = document.getElementById("tree_ch_"+aItems[i]);
		if (oItem && state){
			addGrpId(oForm, aItems[i]);
			if (aItems[i] != oForm.elements["itemid"].value){
                setRuntimeStyle(oItem, 'color', '#990000');
				setRuntimeStyle(oItem, 'fontWeight', 'bold');
			}
			oCheck.checked = true;
		}else{
			if (aItems[i] != oForm.elements["itemid"].value){
				clearRuntimeStyle(oItem);
			}
			delGrpId(oForm, aItems[i]);
			oCheck.checked = false;
		}
	}
    return;
}

function tree_click(itemid, errmsg){
  errFunc = tree_click;  
  
  top.AMI.Browser.Event.fire(top.document.body, 'click');
  
  var oForm = parent.document.forms[parent._cms_document_form];
  if (parent.redirect_mode && ( oForm.elements["redirect_id"].value == 0) /*&& parent.isURLLocal( oForm.elements["script_link"].value)*/){
		parent.setRedirectPage(itemid);
    return false;
  }

  if (parent._cms_document_form_changed){
    if (!confirm(parent._cms_form_changed_alert)){
      return;
    }
  }

	if(typeof(itemid) != 'undefined'){
    if(itemid != '0'){
      enableGrpMode(false);
      var oTreeToolBar = parent.document.getElementById('tree_tool_bar');
      parent.clearForm("", true);
      parent.document.getElementById('form_title').innerHTML = parent.page_loading;
      parent.document.getElementById('status-msgs').innerHTML = '';  
      parent.document.getElementById('status-block').style.display = 'none';
      document.forms['ftree'].action.value = 'draw_selected';
      document.forms['ftree'].itemid.value = itemid;
      document.forms['ftree'].submit();
      parent.document.getElementById("loading_msg").innerHTML = processing_msg;
      parent.document.getElementById("sm_tool_bar").style.display = "none";
      parent.document.getElementById("loading_msg").style.display = "block"; 
      parent.enableForm(false);
    }else{
      alert(errmsg);
    }
  }
}


function tree_form_mode(form, mode, parentId){
  errFunc = tree_form_mode;  

  ma = false;
  if(parseInt(parentId)>0)
    ma = true;
  if(mode == 'edit'){
    form.action.value = 'apply';
    form.public.disabled = !ma;
    form.show_me_at_parent.disabled = !ma;
    form.show_in_sitemap.disabled = !ma;
    form.show_siblings.disabled = !ma;
    parent.document.forms[parent._cms_document_form].elements["cancel"].disabled = true;
    //form.add.style.display = "none";
    //form.apply.style.display = "block";
  }
  form.grp_generate_keywords_auto.disabled = true;

}

updateEditorTextInterval = null;
function updateEditorText(tagname, text, clear_history){
    var textareaObject = parent.document.forms[parent._cms_document_form].elements[tagname];
    if(textareaObject.editorAttached){
        if(textareaObject.editorInitialized){
            textareaObject.editorObject.setValue(text);
        }else{
            updateEditorTextInterval = setInterval(function(taObject){return function(){
                if(taObject.editorInitialized){
                    taObject.editorObject.setValue(text);
                    clearTimeout(updateEditorTextInterval);
                    updateEditorTextInterval = null;
                }
            }}(textareaObject), 10);
        }
    }
}

function insert_in_editor(tagname, text, clear_history){
  errFunc = insert_in_editor;
  
	if (typeof(clear_history) == undefined){
		clear_history = true;
	}

  var oForm = parent.document.forms[parent._cms_document_form];

  var objname = tagname;

  var text_obj = oForm.elements[tagname];
  var editor_obj = parent.document.getElementById("_"+tagname+"_editor");
  
  parent._smc_log_form_changes =false;
	
	if (clear_history){
		parent.statesStored[objname] = 0;
		parent.currentState[objname] = 0;
		parent.UndoStatesArray[objname] = Array();
		parent.UndoRangesArray[objname] = Array();
	}

  if(editor_obj == null)
    editor_obj = parent.document.getElementById(tagname);

  var tagname = editor_obj.tagName.toLowerCase();

  if (tagname == 'iframe') {
    var editdoc = editor_obj.contentWindow.document;
    var sHTML = parent.showSpec(text, objname);

	  parent.setCEContent(objname, sHTML);

    // update hidden output field
    parent._fix_placeholder_urls(editdoc, objname);
    oForm.elements[objname].value = text;                     // update hidden output field
    parent.ceUpdateToolBar(objname,0,1);
    parent.updateUndoButtons(objname);
  } else {
    editor_obj.value= text;
    //parent.editor_updateUI(objname,0,1);
  }

  text_obj.value = text;  

  if (oForm.elements[parent._cms_selected_layout_block+'_body'])
    oForm.elements[parent._cms_selected_layout_block+'_body'].value = text_obj.value;

  parent._smc_log_form_changes =true;


  return false;
}


function check_in_editor(tagname, tag, set){
  errFunc = check_in_editor;  
  
  var tag_text="##"+tag+"##";

  var objname = tagname;
  var text_obj = top.document.getElementById(tagname);
  var found = ( text_obj.value.search(tag_text) >= 0 );
  if ( (found && set) || (!found && !set)){
    return true;
  }
  var oForm = top.document.forms[top._cms_document_form];

  var textareaObj = top.document.getElementsByName(tagname)[0];
  var editorObj = textareaObj.editorObject;
  
  if (editorObj && editorObj.currentMode == 'editor') {
    var specCode = editorObj.parseHTMLCode(tag_text, false);
    if (!found){
      editorObj.editorDocument.body.innerHTML += specCode;
    }else{
      var oSB = editorObj.editorDocument.body.getElementsByTagName('img');
      for(var i = 0; i < oSB.length; i++){
        if(oSB[i].id == tag){
            oSB[i].parentNode.removeChild(oSB[i]);
            break;
        }
      }
    }
  }else{
    if (!found){
      textareaObj.value += tag_text;
    }else{
      textareaObj.value = textareaObj.value.replace(tag_text, "");
    }
  }

  if (oForm.elements[top._cms_selected_layout_block+'_body'])
    oForm.elements[top._cms_selected_layout_block+'_body'].value = text_obj.value;
    
  editorObj.updateToolBar();
    
  return false;
}


