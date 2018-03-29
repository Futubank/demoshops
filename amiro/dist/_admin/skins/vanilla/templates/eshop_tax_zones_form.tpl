##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/eshop_tax_zones.lng"%%
%%include_language "templates/lang/_eshop_tax_zones_msgs.lng"%%

<!--#set var="option_row" value="<option value="##id##"##selected##>##name##</option>
"-->

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'tax_zones_form';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function OnObjectChanged_tax_zones_form(name, first_change, evt){
  return true;
}
addFormChangedHandler(OnObjectChanged_tax_zones_form);

function CheckForm(form) {
   var errmsg = "";

   if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
   }

   ##if(TAX_SYSTEM == 'us')##
   if (form.tax_rate.value=="") {
       return focusedAlert(form.tax_rate, '%%tax_rate_warn%%');
   }
   ##endif##

   return true;
}

var zone_country = '##zone_country##';
var zone_state = '##zone_state##';
var usStates = new Object();

##states_js##

function SetStates() {
	var country = document.getElementById('country');
	var state = document.getElementById('state');

	state.options.length = 1;
	state.options[0] = new Option('%%all%%', '');

    if (country.value == "us") {
        var state_ind = 1;
        for(var i in usStates) {
            state.options[state_ind] = new Option(usStates[i], i);
            state_ind += 1;
        }
    }
}

//-->
</script>


  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="tax_zones_form" onSubmit="return CheckForm(window.document.tax_zones_form);">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <input type="hidden" name="ltime" value="##ltime##">
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
	<col width="150">
	<col width="*">
     <!--<tr>
       <td>
         <input type="checkbox" name="is_default" id="is_default" ##is_default## value="1" helpId= "form_public" />
         <label for="is_default">%%is_default%%</label>
       </td>
       <td align=right></td>
     </tr>-->
     ##_id_page_field##
     <tr>
       <td>%%name%%*:</td>
       <td>
         <input type="text" name="name" class="field field50" value="##name##" maxlength="64">
       </td>
     </tr>
     <tr>
       <td>%%country%%:</td>
       <td>
        <select name="country" id="country" onChange="SetStates()" style="width:220px;">
         <option value="">%%all_countries%%</option>
         ##country##
        </select>
       </td>
     </tr>
     <tr>
       <td>%%state%%:</td>
       <td>
        <select name="state" id="state" style="width:220px;">
        ##state##
        </select>
       </td>
     </tr>
     <tr>
       <td>%%zip%%:</td>
       <td>
         <input type="text" name="zip" class="field field15" value="##zip##" maxlength="32">
       </td>
     </tr>
     ##if(TAX_SYSTEM == 'us')##
     <tr>
       <td>%%tax_rate%%*:</td>
       <td>
         <input type="text" name="tax_rate" class="field field15" value="##tax_rate##" maxlength="6">&nbsp;
         <select name="tax_type">
            ##type_options##
         </select>
       </td>
     </tr>
     ##endif##
     <tr>
        <td colspan="2" align="right">
        <br>
        ##form_buttons##
        <br><br>
        </td>
     </tr>
     <tr>
       <td colspan="2">
         <sub>%%required_fields%%</sub>
       </td>
     </tr>
     </table>

    </form>

<script type="text/javascript">
<!--

if(zone_country == '') {
    document.getElementById('country').selectedIndex = 0;
    document.getElementById('state').options.length = 1;
    document.getElementById('state').options[0] = new Option('%%all%%', '');
}

//-->
</script>