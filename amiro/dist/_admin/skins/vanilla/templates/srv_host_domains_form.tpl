##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/srv_host_domains.lng"%%
%%include_language "templates/lang/_srv_host_domains_msgs.lng"%%
%%include_template "templates/_icons.tpl"%%


<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'dnsform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
//var _cms_form_changed_alert = "";


function validateAliasDomain(input) {

    if(input.value.match(/^(www\.)?([a-z0-9\-]+)(\.[a-z0-9\-]+)(\.[a-z0-9\-]+)?$/i)==null) {
        alert('%%invalid_domain_warn%%');
        input.focus();
        return false;
    }
//    document.dnsform.submit();
    return true;
}

function removeAlias() {

    if(!confirm('%%alias_remove_warn%%'))
        return false;
//alert(document.getElementById('actField').value);
    document.getElementById('actField').value = 'del';
    document.dnsform.submit();
    return true;
}

function retryCheck() {

    document.location='srv_host_domains.php';
    return true;
}
</script>

##if(FORM_TYPE=="ALIAS_EXISTS")##

		<form name="dnsform" action="##script_link##" method="POST">
			<table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
			<tr>
				<td><b>%%current_alias%%</b>&nbsp;<a href="http://##alias##/" target="_blank">##alias##</a></td>
  			</tr>
			<tr><td align="right"><br><br>
				<input type="submit" class="but" value="%%delete_btn%%" onclick="removeAlias()">
			</td></tr>
            </table>
			<input id='actField' type='hidden' name='action' value='del'>
        </form>

##elseif(FORM_TYPE=="ALIAS_ADD")##

		<form name="dnsform" action="##script_link##" method="POST"
            onsubmit="return validateAliasDomain(dnsform.domain_name)">
			<table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
			<tr>
				<td valign="top"><b>%%none_zone%%</b></td>
			</tr>
			<tr><td colspan="2">
				<div class=tooltip style="width:500px">%%none_dns_instruction%%</div>
			</td></tr>
			<tr>
				<td valign=top nowrap>%%domain_name%%:</td>
				<td align="right"><input type="text" class="field field30" name="domain_name"  value="##alias##"></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<br>
					<input type="submit" class="but" value="%%next_btn%%"
                        onclick="return validateAliasDomain(dnsform.domain_name)">
					<br><br>
				</td>
			</tr>
			</table>
			<input type='hidden' name='action' value='enter_domain'>
		</form>

##elseif(FORM_TYPE=="DNS_TYPE")##

	<form name="dnsform" method="POST">
			<table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
            <tr><td><b>%%select_dns_setup%%</b>&nbsp;##alias##</td></tr>
			<tr>
				<td valign="top"><input type="radio" name="dnstype" value="local">%%local_zone%%<br></td>
            </tr>
			<tr><td><div class=tooltip style="width:500px">%%local_zone_hint%% <b>##nameservers##</b></div></td></tr>
            <tr>
	            <td valign="top"><input type="radio" name="dnstype" value="foreign" checked>%%foreign_zone%%<br></td>
			</tr>
			<tr><td><div class=tooltip style="width:500px">%%foreign_zone_hint%% <b>##site_ip##</b></div></td></tr>
			<tr>
				<td align="right">
					<br>
					<input type="button" class="but" value="%%cancel_btn%%" onclick="removeAlias()">
					<input type="submit" class="but" value="%%next_btn%%">
					<br><br>
				</td>
			</tr>
            </table>
			<input id='actField' type='hidden' name='action' value='dns_type'>
	</form>

##elseif(FORM_TYPE=="ALIAS_CONFIRM")##

		<form name="dnsform" action="##script_link##" method="POST">
			<table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
			<tr>
				<td valign="top"><b>%%reserved_domain%%</b>&nbsp;##alias##</td>
			</tr>
			<tr><td>
				<div class=tooltip style="width:500px">
                ##if(OK_TO_PARK=="1")##
                    %%confirm_park_hint%%
                ##else##
                    ##if(ALIAS_TYPE=="local")##
                        %%local_setup_details%%&nbsp;<b>##nameservers##</b>
                    ##else##
                        %%foreign_setup_details%%&nbsp;<b>##site_ip##</b>
                    ##endif##
                ##endif##
                <br><br>%%cancel_alias_hint%%
                </div>
			</td></tr>
			<tr>
				<td colspan="2" align="right">
					<br>
					##if(OK_TO_PARK!="1")##
					<input type="button" class="but" value="%%retry_btn%%" onclick="retryCheck()">
					##endif##
					<input type="submit" class="but" value="%%confirm_btn%%" ##if(OK_TO_PARK!="1")## disabled ##endif##>
					<input type="button" class="but" value="%%cancel_btn%%" onclick="removeAlias()">
					<br><br>
				</td>
			</tr>
			</table>
			<input id='actField' type='hidden' name='action' value='confirm_alias'>
		</form>

##endif##

