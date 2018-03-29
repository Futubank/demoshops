##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="javascript" value="
    AMI.Message.addListener('ON_COMPONENT_CONTENT_PLACED', function(oComponent){
        if(oComponent.componentType == 'form'){
            if(document.getElementById('country').value != 'us'){
                document.getElementById('state').options.length = 1;
                document.getElementById('state').options[0] = new Option('##all_states##', '');
            }
        }
        return true;
    },
    true);
"-->

<!--#set var="set_states_js" value="
var usStates = new Object();

function SetStates(){
	var country = document.getElementById('country');
	var state = document.getElementById('state');

	state.options.length = 1;
	state.options[0] = new Option('##all_states##', '');

    if(country.value == "us"){
        var state_ind = 1;
        for(var i in usStates){
            state.options[state_ind] = new Option(usStates[i], i);
            state_ind += 1;
        }
    }
}
"-->

<!--#set var="select_field(name=country)" value="
<tr>
    <td>##element_caption##:&nbsp;</td>
    <td><select id="country" name="##name##"##attributes## onChange="SetStates()">##select##</select></td>
</tr>
"-->

<!--#set var="select_field(name=state)" value="
<tr>
    <td>##element_caption##:&nbsp;</td>
    <td><select id="state" name="##name##"##attributes##>##select##</select></td>
</tr>
"-->

<!--#set var="input_field(name=zip)" value="
<tr>
    <td>##element_caption##:&nbsp;</td>
    <td><input type="text" name="##name##" class="field field150" value="##value##" maxlength="255"##attributes## />
"-->

<!--#set var="input_field(name=tax_rate)" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td><input type="text" name="##name##" class="field field150##IF(is_invalid)## fieldInvalid##ENDIF##" value="##value##" maxlength="255"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
"-->

<!--#set var="select_field(name=tax_type)" value="
    <select name="##name##"##attributes##>##select##</select></td>
</tr>
"-->

<!--#set var="section_tax_rate_fields" value="##section_html##"-->
