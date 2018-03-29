%%include_language "templates/lang/ce_url_proc.lng"%%
%%include_language "templates/lang/main.lng"%%

<!--#set var="self_url" value="ce_url_proc.php?obj=##obj_name##&cat=##cat##&type=##type##&mode=##mode##"-->

<!--#set var="form" value="
<!-- -->
<table width="100%" border="0" cellpadding="5" cellspacing="0">
  <tr>
    <td>%%ref_type%%:</td>
    <td colspan="2">
    <SELECT size=1 ID=selType tabIndex=5 onchange="set_type(this.value)">
    <OPTION value="">%%type_other%%</OPTION>
    <OPTION value="mailto:">%%type_mail%%</OPTION>
    <OPTION value="javascript:">%%type_script%%</OPTION>
    </SELECT>
  </tr>
  <tr>
    <td>%%ref_url%%:</td>
    <td colspan="2">
    <INPUT ID=txtURL type=text class=field tabIndex=10 onfocus="select()" size=120 value="##curr_ref_url##"></td>
  </tr>
  <tr>
    <td>%%ref_target%%:</td>
    <td colspan="2">
    <SELECT size=1 ID=selTarget tabIndex=20  helpId="4">
    <OPTION value="_self">%%trgt_self%%</OPTION>
    <OPTION value="_blank">%%trgt_blank%%</OPTION>
    </SELECT>
  </tr>
  <tr>
    <td>%%title_text%%:</td>
    <td colspan="2"><INPUT type=text class=field ID=txtTitle tabIndex=25  onfocus="select()" size=120></td>
  </tr>
  <tr>
    <td height="*" colspan=2>
    <nobr>
    <BUTTON class="but" ID=btnOK onClick="btnOKClick(event)" type=submit tabIndex=40>&nbsp;&nbsp;&nbsp;%%apply_btn%%&nbsp;&nbsp;&nbsp;</BUTTON>
    &nbsp;
    <BUTTON class="but" ID=btnCancel tabIndex=45 onClick="closeDialogWindow();">%%cancel_btn%%</BUTTON>
    </nobr>
    </td>
  </tr>
</table>
"-->

<!--#set var="js" value="
<!-- -->

var ref_type="##type##";
var init_ref_type="##type##";
var imgWidth, imgHeight;
var prev_sel_type;

var _cms_document_form = 'pagersform';
var _cms_script_link = '##script_link##?';


function set_type(sType){
    document.getElementById('selType').value=sType;
	prev_sel_type = sType;

	switch (sType){
		case ""  :
		case "#"  :
		case "https://"  :
		case "http://"  :
					document.getElementById('selTarget').disabled=false;
        break;
		default :
					document.getElementById('selTarget').disabled=true;
        break;
  }

}

function show_picture(src, alt, width, height) {
    // alt must be escaped or empty because escape(str) doesn't work with russian symbols
    window.open("show_pic.php?src=" + encodeURIComponent(src) + "&alt=" + alt, "pic", "resizable=yes, status=yes, scrollbars=yes, width=" + width + ", height=" + height);
}

function set_url(itemid, link, title, width, height, alt){
  if(typeof(itemid) != 'undefined'){
    if(itemid != '0'){
      window.scrollTo(0,0);
      switch (ref_type){
        case "pages"  :
          document.getElementById('selType').value = "";
          document.getElementById('txtURL').value = link;
          document.getElementById('txtTitle').value = fromHTMLToText(document.getElementById("tree_it_"+itemid).innerHTML);
          document.getElementById('selTarget').value='_self';
          document.getElementById('selTarget').disabled=false;
        break;
        case "files"  :
          document.getElementById('selType').value = "";
          document.getElementById('txtURL').value = link;
          document.getElementById('txtTitle').value = title;
          document.getElementById('selTarget').value='_blank';
          document.getElementById('selTarget').disabled=false;
        break;
        case "images" :
          document.getElementById('selType').value = "javascript:";
          document.getElementById('txtURL').value = "show_picture('show_pic.php','"+link+"','"+ alt+"',"+ width+","+ height+");";
          document.getElementById('txtTitle').value = title;
          document.getElementById('selTarget').value="_self";
          document.getElementById('selTarget').disabled=true;
        break;
      }
    }
  }
}

var editorBaseHref
var htmlText             = "Text";
var htmlNone             = "None";

textareaObject = null;
editorObject = null;
nearestA = null;

function Init(){
    ref_type = init_ref_type;
    var formWindow = top.currentParentWindow ? top.currentParentWindow : top;
    textareaObject = formWindow.document.getElementById('##obj_name##');
    editorObject = textareaObject.editorObject;

    nearestA = editorObject.sessionData.nearestAnchor;
    
    if(nearestA != null){
        var sURL = nearestA.href.replace(editorBaseHref, "");
		if (sURL.substr(0,1) == "#"){
			set_type("");
			document.getElementById('txtURL').value  = sURL;
		}else if(sURL.substr(0,7) == "http://"){
			set_type("");
			document.getElementById('txtURL').value  = sURL;
		}else if(sURL.substr(0,8) == "https://"){
			set_type("");
			document.getElementById('txtURL').value = sURL;
        }else{
			set_type(sURL.substr(0, sURL.indexOf(":")+1));
			document.getElementById('txtURL').value  = sURL.substr(sURL.indexOf(":")+1);
		}
        document.getElementById('txtTitle').value  = nearestA.title;
        document.getElementById('selTarget').value = nearestA.target;
    }

    if (top.getCookie("url_proc_tab") != null){
        ref_type = top.getCookie("url_proc_tab");
    }
    baseTabs.showTab(ref_type);
}

function _isValidNumber(txtBox) {
  var val = parseInt(txtBox);
  if (isNaN(val) || val < 0 || val > 999) { return false; }
  return true;
}

function btnOKClick(evt) {
  //top.makeUndoStep(objname,'%%un_link%%');

  switch (ref_type){
    case "pages"  : sURL = document.getElementById('txtURL').value.replace(editorBaseHref, ""); break;
    case "files"  : sURL = document.getElementById('txtURL').value.replace(editorBaseHref, ""); break;
    case "images" : sURL = document.getElementById('txtURL').value; break;
  }

  if (nearestA != null){
     nearestA.href = document.getElementById('selType').value + sURL;
     nearestA.removeAttribute("title");
     nearestA.removeAttribute("target");
     if (document.getElementById('txtTitle').value != "") nearestA.title = document.getElementById('txtTitle').value;
     if (document.getElementById('selTarget').value != "") nearestA.target = document.getElementById('selTarget').value;
  }else{
    if(document.getElementById('txtURL').value!=""){
      editorObject.focusWindow();
      editorObject.setEditorSelection(editorObject.sessionData.rgn);
      editorObject.editorDocument.execCommand("CreateLink", false, 'tmpHtmlEditorLink');
      var links = editorObject.editorDocument.body.getElementsByTagName('a');
      for(i = 0; i < links.length; i++){
        if(links[i].href.replace(editorBaseHref, "") == 'tmpHtmlEditorLink'){
            links[i].href = document.getElementById('selType').value + document.getElementById('txtURL').value;
            if(document.getElementById('txtTitle').value > "") links[i].title = document.getElementById('txtTitle').value;
            if(document.getElementById('selTarget').value > "") links[i].target = document.getElementById('selTarget').value;
        }
      }
    }
  }

  editorObject.formChanged(evt);
  editorObject.updateToolBar();
  top.editor_updateHiddenField('##obj_name##');
  
  closeDialogWindow();
}
"-->

<!--#set var="icons_splitter" value="
</tr><tr>
"-->

<!--#set var="icons_item" value="
<td class="ce_images" bgcolor="#FFFFFF" valign="bottom" align="center">
<a id="##img_src##" href="javascript:void(0);" onclick="set_url('1',##onclick##,'',##width##, ##height##,'##img_name##');"><img src="##img_src##" width="##src_width##" height="##src_height##" border="0"></a>
<div title="##img_name##">##img_name_short##</div>
##width## %%size_splitter%% ##height##
</td>
"-->

<!--#set var="list_splitter" value="
</tr><tr>
"-->

<!--#set var="list_item" value="
<td bgcolor="##bgcolor##" align="left">
<a id="##img_src##" href="javascript:void(0);" onclick="set_url('1',##onclick##,'',##width##, ##height##,'##img_name##');" title="##img_name##">##img_name_short##</a></td>
<td bgcolor="##bgcolor##" align=right>##width## %%size_splitter%% ##height##</td>
<td bgcolor="##bgcolor##" align=right>##size## %%kbytes%%</td>
<td bgcolor="##bgcolor##" align=right><div align="right">
<a id="##img_src##" href="javascript:void(0);" onclick="set_url('1',##onclick##,'',##width##, ##height##,'##img_name##');">%%select%%</a>

</td>
"-->

<!--#set var="dir_item" value="<option value="##path##" ##selected## >##name##</option>"-->

<!--#set var="display_yes" value="block"-->
<!--#set var="display_no" value="none"-->

<!--#set var="tab_sel" value="sel"-->
<!--#set var="tab_normal" value="normal"-->

<!--#set var="browse_mode" value="<a href="javascript:changeImagesListType('##mode##');"><img src="skins/vanilla/icons/mode_##mode##.gif" width=21 height=20 border=0 title=##mode_descr## style="border:1px #F6F8FF solid"></a>"-->
<!--#set var="browse_mode_active" value="<img src="skins/vanilla/icons/mode_##mode##.gif" width=21 height=20 border=0 title=##mode_descr## style="border:1px #004080 solid">"-->
<!--#set var="browse_mode_splitter" value="&nbsp;"-->


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
<TITLE>%%site_title%% - %%title%%</TITLE>
<link rel="stylesheet" href="##skin_path##_css/style.css" type="text/css">
<link rel="stylesheet" href="##skin_path##_css/tree.css" type="text/css">
<link rel="stylesheet" href="##skin_path##_css/scroll_bars.css" type="text/css">
<script type="text/javascript">
var editorBaseHref = '##root_path_www##';
</script>
##scripts##
<script type="text/javascript">

function HandleError(message, url, line) {
  return true;
}

##js_functions##

function onTabSelectedCustom(idTab, bState) {
  if(bState){
      var sform = document.forms[_cms_document_form];
      if(typeof(sform)!='undefined'){
        sform.type.value = idTab;
        if(typeof(sform.elements[idTab+"_offset"]) != "undefined") {
            sform.offset.value = sform.elements[idTab+"_offset"].value;
            sform.limit.value = sform.elements[idTab+"_limit"].value;
        }
      }

      ref_type = idTab;
  }
  return true;
}

function changeImagesListType(listMode) {
    var sform = document.forms[_cms_document_form];
    sform.mode.value = listMode;
    document.location = _cms_script_link + collect_link(sform);
    return false;
}

function changeImagesCategory(category) {
    var sform = document.forms[_cms_document_form];
    sform.cat.value = category;
    document.location = _cms_script_link + collect_link(sform);
    return false;
}

</SCRIPT>
</HEAD>

<BODY id=body leftmargin="0" topmargin="0" bgcolor="#FFFFFF">

<table cellspacing="0" cellpadding="10" align="center" width=100% id=popup_content height=100% border=0>
  <tr>
    <td valign=top>
      ##form##
      <p>
      ##status##
      </p>

      <span class="tooltip">%%choose_page%%:</span>
      <br><br>
      <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
        <div class="tabs-container">
          <div class="tab-page" id="tab-page-pages" style="padding:5px;">
            ##tree##
          </div>

          <div class="tab-page" id="tab-page-files" style="padding:5px;">
            ##list_table##
          </div>
          <div class="tab-page" id="tab-page-images" style="padding:5px;">
            <table width=100% cellspacing=0 cellpadding=0 border=0>
            <tr><td align=left>
              <select name="dirs" onchange="javascript:changeImagesCategory(this.value);">
              <option name="">%%dir_common%%</option>
              ##dir_items##
              </select>
            </td><td align=right>
              ##browse_mode##
              <a href="javascript:void(0)" onclick="javascript:window.location=top.addParameterToUrl('##self_url##', 'action', 'refresh');return false;"><img src="skins/vanilla/icons/icon_refresh.gif" width=21 height=20 border=0 title="%%refresh%%" style="border:1px #F6F8FF solid"></a>
            </td></tr>
            </table>
            <br>

            <div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            <table border="0" width="100%" cellspacing="0" cellpadding="0">
              <tr>
              ##images##
              </tr>
            </table>

          </div>
        </div>
      </div>

      <script type="text/javascript">
        var baseTabs = new cTabs('tab-control', {
            'pages' : ['%%tab_pages%%', 'active', '', false],
            'files' : ['%%tab_files%%', 'normal', '', false],
            'images' : ['%%tab_images%%', 'normal', '', false],
        '':''}, false);
        
      </script>


    </td>
  </tr>
</table>



  <form action=##script_link## method=get name="pagersform">
  <input type="hidden" name="offset" value="##files_offset##">
  <input type="hidden" name="limit" value="##files_limit##">
  <input type="hidden" name="images_offset" value="##images_offset##">
  <input type="hidden" name="images_limit" value="##images_limit##">
  <input type="hidden" name="files_offset" value="##files_offset##">
  <input type="hidden" name="files_limit" value="##files_limit##">
  <input type="hidden" name="obj" value="##pager_odj##">
  <input type="hidden" name="id" value="##pager_id##">
  <input type="hidden" name="type" value="##pager_type##">
  <input type="hidden" name="old_cat" value="##pager_cat##">
  <input type="hidden" name="cat" value="##pager_cat##">
  <input type="hidden" name="mode" value="##pager_mode##">
  <input type="hidden" name="ref_url" value="##curr_ref_url##">
  </form>

<script type="text/javascript">
     function onWindowShown(){
        Init();
        //UpdateImageField();
    }
//Init();
</script>

</BODY>
</HTML>