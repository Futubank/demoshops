##--!ver=0200 rules="-SETVAR"--##

<script type="text/javascript">
<!--
var _cms_document_form = 'auditPopupForm';
var _cms_script_link = '##script_link##?';

-->
</script>

   <form action="##script_link##" method=post enctype="multipart/form-data" name="auditPopupForm">
     <input type="hidden" name="action" value="##action##">
     <input type="hidden" name="id" value="##id##">
     ##filter_hidden_fields##
    </form>
<div align="center">
  <input type="button" name="close" value="  %%close_btn%%  " class="but" OnClick="closeDialogWindow();">
</div>