##--!ver=0200 rules="-SETVAR"--##

<!--#set var="picture;popup_picture;small_picture" value=""-->

<script type="text/javascript">
<!--
var _cms_document_form = 'emptyPagerForm';
var _cms_script_link = '##script_link##?';

var destFieldIdId = '##dest_field_id##';
var destFieldIdName = '##dest_field_name##';

-->
</script>


   <form action="##script_link##" method=post enctype="multipart/form-data" name="emptyPagerForm">
     <input type="hidden" name="action" value="##action##">
     <input type="hidden" name="id" value="##id##">
     ##filter_hidden_fields##

<div align="center">
  <input type="button" name="close" value="  %%close_btn%%  " class="but" OnClick="javascript:top.close();">
</div>

    </form>

