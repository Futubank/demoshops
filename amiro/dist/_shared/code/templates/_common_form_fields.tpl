%%include_language "_shared/code/templates/lang/_buttons.lng"%%
%%include_language "_shared/code/templates/lang/_common_form_fields.lng"%%

<!--#set var="form_common_hidden_fields" value="
<input type="hidden" name="id" value="##id##">
<input type="hidden" name="action" value="##action##">
<input type="hidden" name="action_original" value="##action##">
"-->

<!--#set var="form_buttons_position" value="
##form_add_btn## ##form_apply_btn## ##form_cancel_btn## ##form_save_btn##
"-->

<!--#set var="form_add_btn" value="
<input type="submit" name="add" value="%%add_btn%%" class="btn" ##add## onClick="this.form.action.value='add'">
"-->

<!--#set var="form_apply_btn" value="
<input type="submit" name="apply" value="%%ok_btn%%" class="btn" ##apply## onClick="this.form.action.value='apply'">
"-->

<!--#set var="form_save_btn" value="
##-- Button is disabled for a while --##
##--
<input type="submit" name="save" value="%%apply_btn%%" class="btn" ##save## onClick="this.form.action.value='save'" style="width:100px">--##
"-->

<!--#set var="form_cancel_btn" value="
<input type="button" name="cancel" value="%%cancel_btn%%" class="btn" OnClick="this.form.action.value = 'none';document.location='##www_root####front_script_link##?'+collect_link(this.form);">
"-->

<!--#set var="form_add_btn_disabled;form_apply_btn_disabled;form_save_btn_disabled;form_cancel_btn_disabled" value=""-->

<!--#set var="field_html_title" value="
<tr>
  <td>%%html_title%%##if(is_required=="1")##<sup>*</sup>##endif##:</td>
  <td><input type=text name=html_title class=field value="##html_title##" maxlength="30" /></td>
</tr>
"-->

<!--#set var="field_picture" value="
<tr>
  <td colspan=2>
    %%field_picture%%##if(is_required=="1")##<sup>*</sup>##endif##:
    <input type=hidden name=picture value=##picture##>
  </td>
</tr>
##if(picture!="")##
<tr>
  <td>&nbsp;</td>
  <td>%%current_picture%% <a href="##picture##" target="_blank">(%%show_picture%%)</a></td>
</tr>
##endif##
##if(!empty(GENERATED_PICTURE_URL))##
<tr>
  <td>&nbsp;</td>
  <td><a href="##GENERATED_PICTURE_URL##" target="_blank">%%picture_generated%%</a></td>
</tr>
##endif##
<tr>
  <td>&nbsp;</td>
  <td>%%upload%%:<input type=file name=file_picture value=""></td>
</tr>
##if(picture!="")##
<tr>
  <td>&nbsp;</td>
  <td><input type=checkbox class=check value=1 name="delete_picture">%%delete_picture%%</td>
</tr>
##endif##
"-->

<!--#set var="field_popup_picture" value="
<tr>
  <td colspan=2>
    %%field_popup_picture%%##if(is_required=="1")##<sup>*</sup>##endif##:
    <input type=hidden name=popup_picture value=##popup_picture##>
  </td>
</tr>
##if(popup_picture!="")##
<tr>
  <td>&nbsp;</td>
  <td>%%current_picture%% <a href="##popup_picture##" target="_blank">(%%show_picture%%)</a></td>
</tr>
##endif##
##if(!empty(GENERATED_POPUP_PICTURE_URL))##
<tr>
  <td>&nbsp;</td>
  <td><a href="##GENERATED_POPUP_PICTURE_URL##" target="_blank">%%picture_generated%%</a></td>
</tr>
##endif##
<tr>
  <td>&nbsp;</td>
  <td>%%upload%%:<input type=file name=file_popup_picture value=""></td>
</tr>
##if(popup_picture!="")##
<tr>
  <td>&nbsp;</td>
  <td><input type=checkbox class=check value=1 name="delete_popup_picture">%%delete_picture%%</td>
</tr>
##endif##
"-->

<!--#set var="field_small_picture" value="
<tr>
  <td colspan=2>
    %%field_small_picture%%##if(is_required=="1")##<sup>*</sup>##endif##:
    <input type=hidden name=small_picture value=##small_picture##>
  </td>
</tr>
##if(small_picture!="")##
<tr>
  <td>&nbsp;</td>
  <td>%%current_picture%% <a href="##small_picture##" target="_blank">(%%show_picture%%)</a></td>
</tr>
##endif##
##if(!empty(GENERATED_SMALL_PICTURE_URL))##
<tr>
  <td>&nbsp;</td>
  <td><a href="##GENERATED_SMALL_PICTURE_URL##" target="_blank">%%picture_generated%%</a></td>
</tr>
##endif##
<tr>
  <td>&nbsp;</td>
  <td>%%upload%%:<input type=file name=file_small_picture value=""></td>
</tr>
##if(small_picture!="")##
<tr>
  <td>&nbsp;</td>
  <td><input type=checkbox class=check value=1 name="delete_small_picture">%%delete_picture%%</td>
</tr>
##endif##
"-->

