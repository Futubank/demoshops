##--!ver=0200 rules="-SETVAR"--##

<script type="text/javascript">
<!--
var _cms_document_form = 'externalLinkPopupForm';
var _cms_script_link = '##script_link##?';

-->
</script>

   <form action="##script_link##" method=post enctype="multipart/form-data" name="externalLinkPopupForm">
     <input type="hidden" name="action" value="##action##">
     <input type="hidden" name="id" value="##id##">
     ##filter_hidden_fields##
    </form>

<!--#set var="set_num_external_links" value="
<script type="text/javascript">
<!--
var dest = top.document;
dest.getElementsByName("num_external_links")[0].value = ##num_external_links##;
-->
</script>
"-->