##--!ver=0200 rules="-SETVAR"--##
%%include_template "_shared/code/templates/common_form.tpl"%%
%%include_template "_shared/code/templates/_common_form_fields.tpl"%%
%%include_language "_shared/code/templates/lang/blog.lng"%%

<!--#set var="field_date" value="
<tr>
  <td>%%date%%##if(is_required=="1")##<sup>*</sup>##endif##:</td>
  <td><input type=text name=date class=field value="##fdate##" maxlength="30" /></td>
</tr>
"-->

<!--#set var="field_header" value="
<tr>
  <td>%%header%%##if(is_required=="1")##<sup>*</sup>##endif##:</td>
  <td><input type=text name=header class=field value="##header##" size=50 maxlength="255"></td>
</tr>
"-->

<!--#set var="field_announce" value="
<tr>
  <td valign=top>%%announce%%##if(is_required=="1")##<sup>*</sup>##endif##:</td>
  <td><textarea class="field" cols="40" rows="8" name="announce">##announce##</textarea></td>
</tr>
"-->

<!--#set var="field_body" value="
<tr>
  <td valign=top>%%body%%##if(is_required=="1")##<sup>*</sup>##endif##:</td>
  <td><textarea class="field" rows="8" cols="40" name="body">##body##</textarea></td>
</tr>
"-->
