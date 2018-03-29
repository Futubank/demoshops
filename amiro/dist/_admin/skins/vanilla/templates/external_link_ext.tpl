%%include_language "templates/lang/external_link_ext.lng"%%

<!--#set var="del_popup_form" value="
<script type="text/javascript">
<!--

function onBtnExtLink() {
  top.document.forms['eshop_form'].type.value = document.forms['delForm'].type.value;
  top.document.forms['eshop_form'].id_parent.value = document.forms['delForm'].id_parent.value;
  top.user_click('external_link_forward','##id##');
  closeDialogWindow();
  return true;
}
-->
</script>

<form name="delForm" action="##script_link##" enctype="multipart/form-data" method="POST">
<table cellspacing="0" cellpadding="10" align="center" width=100%>
  <tr>
   <td align="center">
    <table cellspacing="0" cellpadding="0" align="center">
     <tr>
      <td><input type="hidden" name="type" value="move">%%forward%%
         <div align="right">
         <select name="id_parent">
         ##cat_select##
         </div>
      </td>
     </tr>
    </table>
   </td>
  </tr>
  <tr>
    <td align="center">
        <input type="hidden" name="action" value="delete_confirm">
        <input type="button" name="add" value="  %%ok_btn%%  " class="but" onClick="return onBtnExtLink();">&nbsp;
        <input type="button" name="close" value="  %%close_btn%%  " class="but" OnClick="closeDialogWindow();">
    </td>
   </tr>
</table>
"-->