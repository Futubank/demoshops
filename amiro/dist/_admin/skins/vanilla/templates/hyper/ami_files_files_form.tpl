##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="input_field(caption=num_downloaded)" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:</td>
    <td>##value##</td>
</tr>
"-->

<!--#set var="input_field(caption=js_file_types)" value="
<script type="text/javascript">
var aExtXFileType = {##value##};
</script>
"-->