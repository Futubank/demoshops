##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/filter.lng"%%
<script type="text/javascript">
<!--

var _cms_filter_form = "fltform";
var _reset_filter = false;
var _filter_anchor = false;

function CheckFilterForm(fform) {
   if(typeof(_cms_document_form) == "string") {
     cform = document.forms[_cms_document_form];

     // collect document form fields
     if(typeof(cform) == "object") {
         cform.elements['action'].value = 'rsrtme';
         if (_reset_filter) {
             for(var i=0; i<fform.length; i++){
                 el = fform.elements[i];
                 if (el.type!='submit'){
                     cname=el.name;
                     if(el.type == 'select-one'){
                        el.selectedIndex = 0;
                     }else if(el.type == 'select-multiple'){
                        for(ii = 0; ii < el.options.length; ii++){
                            if(el.options[ii].value != '0' && el.options[ii].value != ''){
                                if(el.options[ii].selected){
                                    el.options[ii].selected = false;
                                }
                            }else{
                                el.options[ii].selected = true;
                            }
                        }
                     }else{
                         el.value = '';
                     }
                     if(cform.elements[cname] && (cform.elements[cname].type=='hidden')){
                            if(typeof(cform.elements["enc_"+cname])=='object') {
                                 cform.elements["enc_"+cname].value = el.value;
                            }
                            cform.elements[cname].value = el.value;
                   }
               }
             }
             if (typeof(filterOnReset) == 'function') {
                // call custom function
                filterOnReset(fform, cform);
             }
         }else{
            if (typeof(filterOnSubmit) == 'function') {
                // call custom function
                filterOnSubmit(fform, cform);
             }
             // special run over checkbox filter fields
             for(var i=0; i<fform.length; i++){
                 el = fform.elements[i];
                 if(el.type == 'checkbox'){
                     val = (el.checked)?1:0;
                     el.value = val;
                     cname=el.name;
                     if(cform.elements[cname] && (cform.elements[cname].type=='hidden')){
                             if(typeof(cform.elements["enc_"+cname])=='object') {
                                    cform.elements["enc_"+cname].value = val;
                             }
                             cform.elements[cname].value = val;
                     }
                 }
             }
         }
         if(typeof(cform.elements['offset'])=='object') {
           cform.elements['offset'].value = 0;
         }

         if(typeof(cform.elements['enc_offset'])=='object') {
           cform.elements['enc_offset'].value = 0;
         }

         // collect common fields
         fform.action += '?' + collect_link(cform) + '&flt_apply=1' + (_filter_anchor ? _filter_anchor : '');
         return true;
     }
   }
   return false;
}
//-->
</script>

<!--#set var="field_Vsplitter" value=""-->

<!--#set var="field_Hsplitter" value="<br>
"-->

<!--#set var="field_row" value="##field_data##"-->

<!--#set var="field_hidden" value="
<input type="hidden" enc_type="encoded" name="##name##" flt_field=1 value="##value##">
<input type="hidden" enc_type="encoded" name="enc_##name##" flt_field=1 value="##end_value##">
"-->

<!--#set var="field_text" value="<span class="flt_element">##caption## <input helpId="##name##" class="filter_field" type="text" name="##name##" flt_field=1 value="##value##"></span>
"-->

<!--#set var="field_checkbox" value="<span class="flt_element"><label helpId="##name##"><input helpId="##name##" class="filter_check" type="checkbox" name="##name##" id="_flt_##name##" ##checked## flt_field=1 value="##value##"> ##caption##</label></span>
"-->

<!--#set var="field_date;field_timestamp" value="
     <span class="flt_element">
     ##caption##
     <input helpId="##name##" type="text" name="##name##" class="filter_field fieldDate" style="width:70px" flt_field=1 value="##value##"/>
##if(NO_CALENDAR!="1")##
     <a href="javascript: void(0);" onclick="return getCalendar(event, document.fltform.##name##, '##min_max##');">
      <img class="clnd_img" src="skins/vanilla/images/spacer.gif" helpId="clnd_date"/></a>
##endif##
     </span>
"-->

<!--#set var="field_submit" value="##--<span class="flt_element"><input class="filter_but" type="submit" name="##name##" value=" ##caption## "> </span>--##
"-->

<!--#set var="field_select" value="
     <span class="flt_element">
     ##caption##&nbsp;<select ##if (multiple!='')## align=top##endif##  helpId="##name##" name="##name##" ##multiple## size="##size##" flt_field=1 class="filter">
     ##value##
     </select>
     </span>
"-->

<!--#set var="field_select_row" value="<option value="##value##" ##selected##>##caption##</option>
"-->
    <form onKeyPress="submitFormOnEnter(event, this);" style="margin:0px" action="##script_name##" method="post" class="flt_form" name="fltform" onSubmit="return CheckFilterForm(this);" helpId="filter_block">
		##filter_body##
    </form>
