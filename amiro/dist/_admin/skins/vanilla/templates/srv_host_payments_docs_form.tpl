%%include_language "templates/lang/_currency.lng"%%
%%include_language "templates/lang/srv_host_payments.lng"%%
%%include_language "templates/lang/srv_host_payments_docs.lng"%%
%%include_template "templates/_payments_docs.tpl"%%

<!--#set var="doc_item" value="
<tr>
<td valign=top><input type=hidden name="doc_id[]" value="##id##">
<input class="field field10" style="text-align:right" type=text name="amount[]" value="##amount##" ></td>
<td valign=top><input class="field field10" style="text-align:right" type=text name="amount_tax[]" value="##amount_tax##" ></td>
<td><textarea class=txt name="note[]" rows=2 cols=60>##note##</textarea></td>
</tr>
"-->


<script>
var _cms_document_form = 'docsform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function CheckForm(form) {

/*
    if(typeof(form.date)=='object' && !isValidDate(form.date,'%%invalid_date%%'))
        return false;

    if(!isValidFloat(form.amount,'%%amount_warn%%'))
        return false;
*/
    return true;
}

</script>

	<form action=##script_link## method=post enctype="multipart/form-data" name="docsform" onSubmit="return CheckForm(this);">
		<input type="hidden" name="id" value="##id##">
		<input type="hidden" name="type">
		<input type="hidden" name="action" value="##action##">
		##filter_hidden_fields##
		<table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
		<tr>
		  <td>
		  %%document%%:
		  </td>
			<td>
			##document##
		  </td>
		</tr>
		<tr>
		  <td>
		  %%payment_type%%:
		  </td>
			<td>
			##payment_type##
		  </td>
		</tr>
		<tr>
		  <td>
		  %%status%%:
		  </td>
			<td>
			##status##
		  </td>
		</tr>
		<tr>
		  <td>
		  %%doc_num%%:
		  </td>
			<td>
			##doc_num##
		  </td>
		</tr>
		<tr>
		  <td>
		  %%date%%:
		  </td>
			<td>
			##date##
		  </td>
		</tr>
		<tr>
 	    <td>
		  %%contractor_name%%:
		  </td>
		  <td>
			##contractor_name##
		  </td>
		</tr>
		<tr>
		  <td>
		  %%client_name%%:
		  </td>
			<td>
			##client_name##
		  </td>
		</tr>
		<tr>
		  <td>
		  %%payment_docs%%:
		  </td>
			<td>
			##payment_docs##
		  </td>
		</tr>


		</table>
		<table cellspacing="5" cellpadding="0" border="0" class="frm">
		<tr>
		<th align=left>%%amount%%</th>
		<th align=left>%%amount_tax%%</th>
		<th align=left>%%note%%</th>
		</tr>
 	  ##doc_list##
    </table>
		<br>
		<div align=right>
		##form_buttons##
		</div>
	</form>