%%include_language "templates/lang/shot.lng"%%

<!--#set var="del_shot" value="
<input type="checkbox" name="del_shot" value="1">
%%del_shot%%
"-->

<!--#set var="cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="closeDialogWindow()">
"-->

<!--#set var="shot" value="
<img src="##shot##" border="0" title="##description##">
"-->

<!--#set var="shot_file" value="
<b>%%picture%%</b><br>
<input type="file" name="picture" class="field field100" style="width:120px" value="">
"-->
   <br>
    <form action=shot.php method=post enctype="multipart/form-data" name="shotform">
     <input type="hidden" name="MAX_FILE_SIZE" value="##MAX_FILE_SIZE##">
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="action" value="##action##">
     <input type="hidden" name="public" value="##public##">
     
     ##shot##
     <br>
     ##del_shot##
     <br>     
     ##shot_file##
     <br>
     <b>%%picture_url%%:</b><br>
     <input type=text name="picture_url" class="field" value="##picture_url##">
     <br>
     <b>%%picture_description%%:</b><br>
     <input type=text name="picture_description" class="field" value="##picture_description##">
     <br><br>
     <input type="submit" name="apply" value="%%apply_btn%%" class="but">
     <input type="submit" name="delete" value="%%delete_btn%%" class="but" onClick="return confirm('Are you ready?');">
     ##cancel##
    </form>
