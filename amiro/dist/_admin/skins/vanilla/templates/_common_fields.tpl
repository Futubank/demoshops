%%include_language "templates/lang/_common_fields.lng"%%
%%include_language "templates/lang/_common_form_fields.lng"%%

<!--#set var="_id_page_header" value="
<td class="first_row_all" width="90">
 %%page%%
</td>
"-->

<!--#set var="_id_page_row_col" value="
<td width="90"  class="td_small_text">##_page_name##&nbsp;</td>
"-->

<!--#set var="_picture_header" value="
<td class="first_row_all" align=center valign="middle">##--%%picture%%--####_picture_title##</td>
"-->

<!--#set var="_picture_no_col" value="
    <td align=center><img src="skins/vanilla/icons/icon-no_image.gif" width=13 height=11 border=0 title="%%picture_no%%"></td>
"-->
<!--#set var="_picture_col" value="
    <td align=center><div class="list-image"><img src="##img_url##" border=0></div></td>
"-->

<!--#set var="_positions_col" value="
    <td align=center><img src="##img_url##" border=0></td>
"-->

<!--#set var="_positions_header" value="
    <td class="first_row_all" align="center" valign="middle" width="30">
     ##sort_position##&nbsp;
    </td>
"-->

<!--#set var="_positions_col" value="
  <td class="pos" nowrap>
    ##abs_row_index_m##
    <div class="posItem" onClick="onPositionCtrlClick(event, '##id##', '##is_top##', '##is_bottom##')">
        <img src="skins/vanilla/images/spacer.gif" class="posLeftTop" title="%%position_move_top%%"><img src="skins/vanilla/images/spacer.gif" class="posRightTop" title="%%position_move_up%%"><br>
        <img src="skins/vanilla/images/spacer.gif" class="posLeftBottom" title="%%position_move_bottom%%"><img src="skins/vanilla/images/spacer.gif" class="posRightBottom" title="%%position_move_down%%">
    </div>
  </td>
"-->
<!--#set var="_positions_col_disabled" value="
  <td width="30" align=center>&nbsp;<img src="skins/vanilla/icons/icon-pos_control_dis.gif" width=19 height=19 style="cursor:pointer" onClick="posShowWarn('disabled')"></td>
"-->
<!--#set var="_positions_script" value="
<script>
var posMessages = {
    'top' : '%%position_move_top_warn%%',
    'up' : '%%position_move_up_warn%%',
    'bottom' : '%%position_move_bottom_warn%%',
    'down' : '%%position_move_down_warn%%',
    'disabled' : '%%position_warn%%'
};

function posShowWarn(msgId){
    if(typeof(posMessages[msgId]) != 'undefined'){
        alert(posMessages[msgId]);
    }
}
</script>
"-->
<!--#set var="_positions_map" value="##-- No more MAP here --##"-->
<!--#set var="_positions_map_disabled" value="##-- No more MAP here --##"-->

<!--#set var="list_add_btn" value="
<form>
<input type="button" name="add" value="%%add_btn%%" class="but" onClick="this.form.action.value='add'">
</form>
"-->

<!--#set var="system_popup" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
<TITLE>%%site_title%% - ##popup_title##</TITLE>
<link rel="stylesheet" href="##skin_path##_css/style.css" type="text/css">
##scripts##
</HEAD>
<BODY id=bdy leftmargin="0" topmargin="0" bgcolor="#FFFFFF">
##form##
</BODY>
</HTML>
"-->

