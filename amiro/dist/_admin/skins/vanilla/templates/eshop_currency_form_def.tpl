<!--#set var="option_row" value="<option value="##code_digit##" code_digit="##code_digit##" code_alpha="##code_alphabetical##" currency_name="##name_full##" ##option_selected##>##name##</option>"-->
<!--#set var="option_source_row" value="<option value="##name##" ##selected##>##name##</option>"-->

<script type="text/javascript">
<!--
//var editor_enable = '##editor_enable##';
var _cms_document_form = 'currform2';
//var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function CurrencyChange() {
    var index = document.currform2.currencies_list.selectedIndex;
    if (document.currform2.currencies_list.value != -1) {
        document.currform2.code.value = document.currform2.currencies_list.options[index].getAttribute('code_alpha');
        document.currform2.name.value = document.currform2.currencies_list.options[index].getAttribute('currency_name');
        document.currform2.code_digit.value = document.currform2.currencies_list.value;
    }
}

function OnObjectChanged_eshop_currency_form_def(name, first_change, evt){
    switch(name){
        case 'is_base':
            if(
                document.currform2.is_base.checked &&
                !confirm('%%change_base_warn%%')
            ) {
                document.currform2.is_base.checked = false;
                return false;
            }
            break;
##--
        case 'code':
            var oInput = document.forms['currform2'].elements['code'];
            if(!oInput.value.match(/^[A-Z]{3}$/)){
                return focusedAlert(oInput, 'dasfsdfsd');
                return true;
            }
            break;
--##
    }
    return true;
}
addFormChangedHandler(OnObjectChanged_eshop_currency_form_def);

function CheckForm(form) {
   var errmsg = "";
   for(var i=0;i<form.elements.length;i++) {
     name = form.elements[i].name;
     if(name.indexOf('exchange') > -1) {
       if(!checkMoneyValue(form.elements[i].value, true)) {
         return focusedAlert(form.elements[i], '%%exchange_warn%%');
       } else {
          if(1*parseFloat(form.elements[i].value)==0) {
            return focusedAlert(form.elements[i], '%%exchange_warn%%');
          }
        }
     }
   }
   return true;
}

function CheckForm2(form) {
   var errmsg = "";
   if (form.date.value=="") {
       return focusedAlert(form.date, '%%date_warn%%');
   }
   if(!form.elements['code'].value.match(/^[A-Z]{3}$/)){
       return focusedAlert(form.elements['code'], '%%code_warn%%');
   }
   if (!checkMoneyValue(form.exchange.value, true)) {
       return focusedAlert(form.exchange, '%%exchange_warn%%');
   } else {
      if(1*parseFloat(form.exchange.value)==0) {
         return focusedAlert(form.exchange, '%%exchange_warn%%');
      }
   }
   return true;
}
-->
</script>

  <form action=##script_link## method=post enctype="multipart/form-data" name="currform2" onSubmit="return CheckForm2(window.document.currform2);">
   <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
   <tr>
     <td colspan="2">
       <input type="checkbox" name="on_small" id="on_small" ##on_small## value="1" helpId= "form_on_small">
       <label for="on_small">%%public%%</label>
     </td>
   </tr>
   <tr>
     <td colspan="2">
       <input type="checkbox" name="is_base" id="is_base" ##is_base## ##is_base_disabled## value="1" helpId= "form_is_base">
       <label for="is_base">%%eshop_base%%</label>
     </td>
   </tr>
   <tr>
     <td colspan="2">
       <input type="checkbox" name="is_base_small" id="is_base_small" ##is_base_small## value="1" helpId= "form_is_base_small">
       <label for="is_base_small">%%small_base%%</label>
     </td>
   </tr>
   <tr>
     <td>
%%date%%:
  </td>
     <td>
       <input type=text name=date class='field fieldDate' value="##date##" maxlength="30" helpId= "form_date" />
       <a href="javascript: void(0);" onclick="return getCalendar(event, document.currform2.date);">
       <img class="clnd_img" src="skins/vanilla/images/spacer.gif" helpId= "clnd_date"/></a>
     </td>
   </tr>
   <tr>
     <td>%%code%%*: </td>
     <td><input type="text" name="code" class="field" value="##code##" maxlength="3" helpId="form_code" /></td>
   </tr>
   <tr><td colspan="2"><div class="tooltip">%%code_tooltip%%</div></td></tr>
   <tr>
     <td>
%%code_digit%%*:
  </td>
     <td>
       <input type=text name=code_digit class=field value="##code_digit##" readonly helpId= "form_code_digit" />
     </td>
   </tr>
   <tr>
     <td>
%%name%%:
  </td>
     <td>
       <input type=text name=name class=field value="##name##" maxlength="64" helpId= "form_name" />
     </td>
   </tr>
   <tr>
     <td>
%%currencies%%:
  </td>
     <td>
       <select name="currencies_list" onChange="javascript: CurrencyChange();" helpId= "form_currency_list">##options_list##</select>
     </td>
   </tr>

   <tr>
     <td>
%%exchange%%*:
  </td>
     <td>
       <input type=text name=exchange class=field value="##exchange##" ##rate_disabled## maxlength="30" helpId= "form_exchange" />
     </td>
   </tr>
   <tr>
     <td>
%%prefix%%:
  </td>
     <td>
       <input type=text name=prefix class=field value="##prefix##" maxlength="16" helpId= "form_prefix" />
     </td>
   </tr>
   <tr>
     <td>
%%postfix%%:
  </td>
     <td>
       <input type=text name=postfix class=field value="##postfix##" maxlength="16" helpId= "form_postfix" />
     </td>
   </tr>
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
 <input type="hidden" name="activate" value="">
 <input type="hidden" name="activate2" value="">
 <input type="hidden" name="publish" value="">
 ##form_common_hidden_fields##

##filter_hidden_fields##
</form>
