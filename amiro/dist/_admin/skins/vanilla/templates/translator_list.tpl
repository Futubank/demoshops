##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/translator.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="icons_grp_publish_on" value="&nbsp;&nbsp;&nbsp;&nbsp;<span onClick="if (grpCheckSelection() && confirm('%%grp_public_on_warn%%')) {grpAction('publish_on');}" class="smallButton">%%icon_grp_publish_on%%</span>"-->

<!--#set var="icons_grp_publish_backdated_on" value="&nbsp;&nbsp;&nbsp;&nbsp;<span onClick="if (grpCheckSelection() && confirm('%%grp_public_backdated_on_warn%%')) {grpAction('publish_backdated_on');}" class="smallButton">%%icon_grp_publish_backdated_on%%</span>"-->

<!--#set var="published_on" value="<img title="%%icon_public_on%%" class=icon src="skins/vanilla/icons/icon-published.gif" border="0" helpId="btn_public">"-->
<!--#set var="published_off" value="<img title="%%icon_public_off%%" class=icon src="skins/vanilla/icons/icon-notpublished.gif" border="0" helpId="btn_public">"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  ##_group_operations_col##
  <td width="30" align=center>##published##</td>
  <td width="60">##fdate##&nbsp;<br />##ftime##&nbsp;</td>
  <td width="140"><nobr>##header##&nbsp;<nobr></td>
  <td>##announce##&nbsp;</td>
  ##_id_page_row_col##
</tr>
"-->

<!--#set var="list_body" value="

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                <td class="first_row_all" align="center" valign="middle" width="30">
                 ##sort_published##
                </td>
                <td class="first_row_all" width="60">
                 %%date%%
                 ##sort_date##
                </td>
                <td class="first_row_all list_name_col">
                 %%header%%
                  ##sort_header##
                </td>
                <td class="first_row_all">
                 %%announce%%
                  ##sort_announce##
                </td>
##_id_page_header##
              </tr>
              ##list##
            </table>
##_group_operations_footer##
</form>
<a name="anchor"></a>
"-->

<!--#set var="plugin_body" value="
<table width=100% cellspacing=0 cellpadding=0>
  <tr>
    <td width="100%" valign="top" class="center_area">
<div>
##filter##
</div>
<center>
##if(config_is_empty == '1')##
      <div style="width:90%;">
      <br/><br/><br/>
            <div align=center style="display:;" id="div_properties_form">
             <table border="0" cellpadding="0" cellspacing="0" width= height= >
             <tr><td valign=top>
              <table border="0" cellpadding="0" cellspacing="0" width=100% height=100%>
                <tr>
                  <td>
                    <img src="skins/vanilla/images/st_c_lt.gif" width="7" height="28"></td>
                  <td background="skins/vanilla/images/st_h_bg.gif" height="28" nowrap>
                    <h3 id="form_title">
                    %%plugin_name%%
                    </h3></td>
                  <td nowrap background="skins/vanilla/images/st_h_bg.gif" height="28" align=right></td>
                  <td><img src="skins/vanilla/images/st_c_rt.gif" width="7" height="28"></td>
                </tr>
                <tr>
                  <td background="skins/vanilla/images/st_l.gif" width="7">
                  <img src="skins/vanilla/images/spacer.gif" width="1" height="1"></td>
                  <td  colspan=2 class="table_sticker" valign="top" >
                    <br>
                      <table cellspacing="0" cellpadding="0" border="0" class="frm">
                        <tr>
                        <td>%%plugin_config_err%%</td>
                        </tr>
                      </table>
                   </td>
                  <td background="skins/vanilla/images/st_r.gif" width="7">
                  <img src="skins/vanilla/images/spacer.gif" width="1" height="1"></td>
                </tr>
                <tr>
                  <td>
                    <img src="skins/vanilla/images/st_c_lb.gif" width="7" height="7"></td>
                  <td colspan=2 background="skins/vanilla/images/st_b_l.gif" height="7">
                    <img src="skins/vanilla/images/spacer.gif" width="1" height="1"></td>
                  <td>
                    <img src="skins/vanilla/images/st_c_rb.gif" width="7" height="7"></td>
                </tr>
              </table>
              </td></tr>
              </table>
      </div>
##else##

      <div id="status-block" class="status-block"##if (status=='')## style="display:none" ##endif##>
        <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div>
          <div id="status-msgs" class="status-msgs">##status##</div>
      </div>
##list_table##
##form##
##endif##
      </center>
      </td></tr>
      </table>
    </td>
  </tr>
</table>
"-->