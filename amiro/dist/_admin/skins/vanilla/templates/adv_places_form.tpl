%%include_language "templates/lang/adv_places.lng"%%

<!--#set var="module_option;select_option" value="<option value="##value##" ##selected##>##name##</option>"-->

<script type="text/javascript">
<!--
var _cms_document_form = 'advplacesform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function onSourceTypeChange(){
    if(document.advplacesform.source_type.value == 'banner'){
        document.getElementById('tr_module_name').style.display = 'none';
        document.getElementById('tr_browse_mode').style.display = 'none';
        document.getElementById('tr_place_type').style.display = tableRowShowStyle;
        document.getElementById('tr_place_width').style.display = tableRowShowStyle;
        document.getElementById('tr_place_height').style.display = tableRowShowStyle;
        document.getElementById('tr_is_topline').style.display = tableRowShowStyle;
        document.getElementById('tr_default_banner').style.display = tableRowShowStyle;
    }else if(document.advplacesform.source_type.value == 'module'){
        document.getElementById('tr_module_name').style.display = tableRowShowStyle;
        document.getElementById('tr_browse_mode').style.display = tableRowShowStyle;
        document.getElementById('tr_place_type').style.display = 'none';
        document.getElementById('tr_place_width').style.display = 'none';
        document.getElementById('tr_place_height').style.display = 'none';
        document.getElementById('tr_is_topline').style.display = 'none';
        document.getElementById('tr_default_banner').style.display = 'none';
    }else{
        document.getElementById('tr_module_name').style.display = tableRowShowStyle;
        document.getElementById('tr_browse_mode').style.display = 'none';
        document.getElementById('tr_place_type').style.display = tableRowShowStyle;
        document.getElementById('tr_place_width').style.display = tableRowShowStyle;
        document.getElementById('tr_place_height').style.display = tableRowShowStyle;
        document.getElementById('tr_is_topline').style.display = tableRowShowStyle;
        document.getElementById('tr_default_banner').style.display = tableRowShowStyle;
    }
}

function onPlaceTypeChange(){
    if(document.advplacesform.place_type.value != 1){
        document.advplacesform.place_width.disabled = false;
        document.advplacesform.place_height.disabled = false;
        document.advplacesform.is_topline.disabled = false;
    }else{
        document.advplacesform.place_width.disabled = true;
        document.advplacesform.place_height.disabled = true;
        document.advplacesform.is_topline.disabled = true;
    }
}

function CheckForm(form) {
   var errmsg = "";

   if (form.name.value == "") {
       return focusedAlert(form.name, '%%name_warn%%');
   }
   
   if(form.source_type.value != "banner"){
       msobj = form.elements('module_name[]');
       hasMS = false;
       for(i = 0; i < msobj.options.length; i++){
        if(msobj.options[i].selected){
            hasMS = true;
            break;
        }
       }
       if(!hasMS) {
           return focusedAlert(msobj, '%%module_name_warn%%');
       }
       
       if(form.source_type.value == "module"){
           msobj = form.elements('browse_mode[]');
           hasMS = false;
           for(i = 0; i < msobj.options.length; i++){
            if(msobj.options[i].selected){
                hasMS = true;
                break;
            }
           }
           if(!hasMS) {
               return focusedAlert(msobj, '%%browse_mode_warn%%');
           }
       }
   }
   
   ##if(FORM_MODE != "EDIT")##
   if(form.create_campaign.checked && form.start_date.value == ""){
       return focusedAlert(form.start_date, '%%start_date_warn%%');
   }
   ##endif##

   return true;
}

function OnObjectChanged_adv_places_form(name, first_change, evt){
    if(name == "create_campaign"){
        onChangeCC(document.advplacesform.create_campaign);
    }
    return true;
}
addFormChangedHandler(OnObjectChanged_adv_places_form);

function onChangeCC(obj){
    if(obj.checked){
        document.getElementById('tr_start_date').style.display=tableRowShowStyle;
        document.getElementById('tr_lifetime').style.display=tableRowShowStyle;
        document.getElementById('tr_advertiser').style.display=tableRowShowStyle;
    }else{
        document.getElementById('tr_start_date').style.display='none';
        document.getElementById('tr_lifetime').style.display='none';
        document.getElementById('tr_advertiser').style.display='none';
    }
}
-->
</script>


  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="advplacesform" onSubmit="return CheckForm(this);">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <input type="hidden" name="publish" value="">
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
     <col width="280">
     <col width="*">
     <tr>
       <td>
         <input type="checkbox" name="public" ##public## value="1" helpId= "form_public">
         %%public%%
       </td>
       <td align=right></td>
     </tr>
     ##_id_page_field##
     <tr>
       <td width=150>
         %%name%%*:
       </td>
       <td>
         <input type=text name=name class="field field50" value="##name##" >
       </td>
     </tr>
     <tr id=tr_default_banner>
       <td>
         %%show_default%%:
       </td>
       <td>
         <input type=checkbox name="show_default" value="1" ##show_default##>
       </td>
     </tr>
     <tr>
       <td width=150>
         %%description%%:
       </td>
       <td>
         <input type=text name=description class="field field50" value="##description##" >
       </td>
     </tr>
     <tr>
       <td width=150>
         %%postfix%%:
       </td>
       <td>
         <input type=text name=postfix class="field field20" value="##postfix##" >
       </td>
     </tr>
     <tr>
       <td>
         %%source_type%%:
       </td>
       <td>
         <select name=source_type onChange="onSourceTypeChange()">
           <option value=banner ##source_type_banner##>%%source_type_banner%%</option>
           <option value=module ##source_type_module##>%%source_type_module%%</option>
           <option value=modbanner ##source_type_modbanner##>%%source_type_modbanner%%</option>
         </select>
       </td>
     </tr>
     <tr id="tr_module_name">
       <td>
         %%module_name%%*:
       </td>
       <td>
         <select name=module_name[] multiple size=3>
            ##module_name##
         </select>
       </td>
     </tr>
     <tr id="tr_browse_mode">
       <td>
         %%browse_mode%%*:
       </td>
       <td>
         <select name=browse_mode[] multiple size=3>
           <option value=list ##browse_mode_list##>%%browse_mode_list%%</option>
           <option value=details ##browse_mode_details##>%%browse_mode_details%%</option>
           <option value=specblock ##browse_mode_specblock##>%%browse_mode_specblock%%</option>
         </select>
       </td>
     </tr>
     <tr id="tr_place_type">
       <td>
         %%place_type%%:
       </td>
       <td>
         <select name=place_type onChange="onPlaceTypeChange()">
           <option value=0 ##place_type_0##>%%place_type_any%%</option>
           <option value=2 ##place_type_2##>%%place_type_picture%%</option>
           <option value=3 ##place_type_3##>%%place_type_flash%%</option>
           <option value=1 ##place_type_1##>%%place_type_text%%</option>
         </select>
       </td>
     </tr>
     <tr id="tr_place_width" vAlign=top>
       <td>
         %%place_width%%:<br><small>0 = unlimited</small>
       </td>
       <td>
         <input type=text name=place_width value="##place_width##" class="field field8" disabled>
       </td>
     </tr>
     <tr id="tr_place_height">
       <td>
         %%place_height%%:<br><small>0 = unlimited</small>
       </td>
       <td>
         <input type=text name=place_height value="##place_height##" class="field field8" disabled>
       </td>
     </tr>
     <tr id="tr_is_topline">
       <td>
         %%is_topline%%
       </td>
       <td>
         <input type=checkbox name="is_topline" value="1" ##is_topline## disabled>
       </td>
     </tr>
     <tr>
       <td>
         %%show_unique%%:
       </td>
       <td>
         <input type=checkbox name="show_unique" value="1" ##show_unique##>
       </td>
     </tr>
     <tr>
       <td>
         %%click_unique%%:
       </td>
       <td>
         <input type=checkbox name="click_unique" value="1" ##click_unique##>
       </td>
     </tr>
     
     ##if(FORM_MODE != "EDIT")##
     <tr>
       <td colspan=2>
         <input type=checkbox name=create_campaign value=1 id=id_create_campaign> <label for=id_create_campaign>%%do_create_campaign%%</label>
       </td>
     </tr>
     <tr id="tr_start_date" style="display: none">
       <td>
         %%start_date%%*:
       </td>
       <td>
         <input type=text name=start_date class='field fieldDate' value="##start_date##" maxlength="30">
         <a href="javascript: void(0);" onclick="return getCalendar(event, document.advplacesform.start_date);">
         <img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
       </td>
     </tr>
     <tr vAlign=top id="tr_lifetime" style="display: none">
       <td>
         %%opt_def_lifetime%%:<br>
         <small>%%zero_unlim%%</small>
       </td>
       <td>
         <select name="opt_def_lifetime_units">
            <option value=minute ##opt_def_lifetime_units_minute##>%%opt_def_lifetime_minute%%</option>
            <option value=hour ##opt_def_lifetime_units_hour##>%%opt_def_lifetime_hour%%</option>
            <option value=day ##opt_def_lifetime_units_day##>%%opt_def_lifetime_day%%</option>
            <option value=week ##opt_def_lifetime_units_week##>%%opt_def_lifetime_week%%</option>
            <option value=month ##opt_def_lifetime_units_month##>%%opt_def_lifetime_month%%</option>
            <option value=year ##opt_def_lifetime_units_year##>%%opt_def_lifetime_year%%</option>
         </select>:
         <input type=text name="opt_def_lifetime" value="##opt_def_lifetime##" class=fieldclass="field5">
       </td>
     </tr>
     <tr id="tr_advertiser" style="display: none">
       <td>
         %%advertiser%%:
       </td>
       <td>
         <select name=advertiser>
            ##advertisers##
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
onSourceTypeChange();
onPlaceTypeChange();
##if(FORM_MODE != "EDIT" && auto_campaign)##
    document.advplacesform.create_campaign.checked=true;
    onChangeCC(document.advplacesform.create_campaign);
##endif##
</script>