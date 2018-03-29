%%include_template "templates/filter_form.tpl"%%
%%include_language "templates/lang/srv_options.lng"%%

<!--#set var="field_select" value="
     <span class="flt_element" >
     &nbsp;&nbsp;##caption##&nbsp;<select helpId="##help_id##" name="##name##" ##multiple## size="##size##" class="filter" onchange="rebuildModList(this);">
     ##value##
     </select>
     </span>
"-->

<!--#set var="field_submit" value="
     <span class="flt_element"  style="background: url(skins/vanilla/images/spacer.gif);">
     <input class="filter_but" type="submit" name="##name##" value=" %%select%% ">
     </span>
"-->
