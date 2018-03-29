%%include_language "templates/lang/ce_specblocks.lng"%%
%%include_language "templates/lang/main.lng"%%

<!--#set var="tb_group_item" value="
<fieldset style="padding:10px">
<legend><b>##group_name##</b></legend>
<table width=100% cellspacing=0 cellpadding=0 border=0>
<tr>
##spec_blocks##
</tr>
</table>
</fieldset>
"-->
##--#set var="spec_img" value="<span class=spec_##owner## id=##tag## ##disabled## onclick="if (!this.disabled) setBlock(this.id)" onmouseover="this.parentElement.runtimeStyle.cssText='border:1px #c0c0c0 solid;'" onmouseout="this.parentElement.runtimeStyle.cssText=''">##name##</span>"--##
<!--#set var="spec_img" value="<img class="dialogSpecBlock" title="##name##" id="##tag##" src="##if(img_src)####img_src####else####admin_root##skins/vanilla/images/specblocks/##ilang##/##tag_real##.gif##endif##" onclick="onClickSpecblock(event, this.id)" onmouseover="onOverSpecblock(event, this, 1);" onmouseout="onOutSpecblock(event, this, 1);">"-->
<!--#set var="spec_img_disabled" value="<img class="dialogSpecBlock" src="##admin_root##skins/vanilla/images/specblocks/##ilang##/##tag_real##.gif" title="##name##" onmouseover="onOverSpecblock(event, this, 0);" onmouseout="onOutSpecblock(event, this, 0);">"-->

<!--#set var="tb_spec_item" value="<td valign=bottom><table cellspacing=0 cellpadding=0 border=0><tr><td style="border:1px #ffffff solid;">##img_tag##</td></tr></table></td><td width="33%" valign="middle" style="padding-left: 4px">##description##</td>"-->
<!--#set var="tb_spec_item_empty" value="<td><img class="dialogSpecBlock" src="_img/spacer.gif"></td><td width="33%">&nbsp;&nbsp;&nbsp;</td>"-->
<!--#set var="tb_spec_hsplitter" value=""-->
<!--#set var="tb_spec_vsplitter" value="</tr><tr>"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
<TITLE>%%site_title%% - %%title%%</TITLE>
<base href="##www_root##">
<link rel="stylesheet" href="##admin_root####skin_path##_css/style.css" type="text/css">
<link rel="stylesheet" href="##admin_root####skin_path##_css/spec.css" type="text/css">
<link rel="stylesheet" href="##admin_root####skin_path##_css/scroll_bars.css" type="text/css">
##scripts##

<script  type="text/javascript">
var editorBaseHref = '##root_path_www##';

function Init(){
  editorBaseHref = top.editorBaseHref;
}

function btnCANCELClick() {
  closeDialogWindow();
}

function onOverSpecblock(evt, img){
    setRuntimeStyle(img, 'margin', '-1px 1px 1px -1px');
    setRuntimeStyle(img, 'cursor', 'pointer');
}

function onOutSpecblock(evt, img){
    clearRuntimeStyle(img);
}

function onClickSpecblock(evt, name){
    var textareaName = "##obj_name##";
    top.insertSpecBlock(evt, textareaName, name);
    top.editor_updateHiddenField(textareaName);

    closeDialogWindow();
}
</script>
</HEAD>

<BODY onload="Init();" id=bdy style="margin:10px" bgcolor="#FFFFFF">
##spec_blocks_pmanager##
##spec_blocks_modules##
##spec_blocks_eshop##
##spec_blocks_kb##
##spec_blocks_portfolio##
##spec_blocks_services##
##spec_blocks_plugins##
##spec_blocks_custom##
</BODY>
</HTML>