%%include_language "templates/lang/adv_campaign_types.lng"%%

<!--#set var="ids_places_option;types_groups_option" value="<option value="##value##" ##selected##>##name##</option>"-->

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'advcampaigntypesform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function CheckForm(form) {
   var errmsg = "";
   
   editor_updateHiddenField("description");

   if (form.name.value == "") {
       return focusedAlert(form.name, '%%name_warn%%');
   }

   msobj = form.elements('ids_places[]');
   hasMS = false;
   for(i = 0; i < msobj.options.length; i++){
    if(msobj.options[i].selected){
        hasMS = true;
        break;
    }
   }
   if(!hasMS) {
       return focusedAlert(msobj, '%%ids_places_warn%%');
   }
   
   if (form.opt_def_max_views.value != "" && isNaN(form.opt_def_max_views.value)) {
       return focusedAlert(form.opt_def_max_views, '%%opt_def_max_views_warn%%');
   }
   
   if (form.opt_def_max_clicks.value != "" && isNaN(form.opt_def_max_clicks.value)) {
       return focusedAlert(form.opt_def_max_clicks, '%%opt_def_max_clicks_warn%%');
   }
   
   if (form.opt_def_lifetime.value != "" && isNaN(form.opt_def_lifetime.value)) {
       return focusedAlert(form.opt_def_lifetime, '%%opt_def_lifetime_warn%%');
   }
   
   if (form.opt_def_max_views_day.value != "" && isNaN(form.opt_def_max_views_day.value)) {
       return focusedAlert(form.opt_def_max_views_day, '%%opt_def_max_views_day_warn%%');
   }

   return true;
}

function onMaterialTypeChange(form){
    if(form.material_type.value == 'banner'){
        document.getElementById('tr_ids_places').style.display = tableRowShowStyle;
        document.getElementById('tr_opt_def_max_views_day').style.display = tableRowShowStyle;
        document.getElementById('tr_opt_def_priority').style.display = tableRowShowStyle;
        document.getElementById('tr_id_place').style.display = 'none';
        document.getElementById('tr_max_items').style.display = 'none';
    }else{
        document.getElementById('tr_ids_places').style.display = 'none';
        document.getElementById('tr_opt_def_max_views_day').style.display = 'none';
        document.getElementById('tr_opt_def_priority').style.display = 'none';
        document.getElementById('tr_id_place').style.display = tableRowShowStyle;
        document.getElementById('tr_max_items').style.display = tableRowShowStyle;
    }
}
      
-->
</script>

  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="advcampaigntypesform" onSubmit="return CheckForm(this);">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <input type="hidden" name="publish" value="">
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
     <col width="200">
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
     <tr>
       <td>
         %%type_groups%%:
       </td>
       <td>
         <select name=type_group>
            <option value=0>%%type_group_none%%</option>
            ##type_groups##
         </select>
       </td>
     </tr>
     <tr>
       <td width=150>
         %%code%%:
       </td>
       <td>
         <input type=text name=code class="field field25" value="##code##" >
       </td>
     </tr>
     ##ext_images##
     ##if(FORM_MODE == "EDIT")##
     <input type=hidden name=material_type value="##material_type##">
     ##else##
     <tr>
       <td>
         %%material_type%%:
       </td>
       <td>
         <select name=material_type onChange="onMaterialTypeChange(this.form)">
            <option value='banner'>%%material_type_banner%%</option>
            <option value='module'>%%material_type_module%%</option>
         </select>
       </td>
     </tr>
     ##endif##
     <tr id="tr_ids_places">
       <td>
         %%ids_places%%*:
       </td>
       <td>
         <select name=ids_places[] multiple size=5>
            ##ids_places_data##
         </select>
       </td>
     </tr>
     <tr id="tr_id_place">
       <td>
         %%id_place%%*:
       </td>
       <td>
         <select name=id_place>
            ##id_places_data##
         </select>
       </td>
     </tr>
     <tr vAlign=top>
       <td><label for=id_allow_reserve>%%allow_reserve%%:</label></td>
       <td><input type=checkbox name="allow_reserve" value="1" ##allow_reserve## id=id_allow_reserve></td>
     </tr>
     <tr vAlign=top id="tr_max_items">
       <td>
         %%max_items%%:<br>
         <small>%%zero_unlim%%</small>
       </td>
       <td>
         <input type=text name="max_items" value="##max_items##" class=fieldclass="field5">
       </td>
     </tr>
     <tr vAlign=top>
       <td>
         %%opt_def_max_views%%:<br>
         <small>%%zero_unlim%%</small>
       </td>
       <td>
         <input type=text name="opt_def_max_views" value="##opt_def_max_views##" class=fieldclass="field5">
       </td>
     </tr>
     <tr vAlign=top id=tr_opt_def_max_views_day>
       <td>
         %%opt_def_max_views_day%%:<br>
         <small>%%zero_unlim%%</small>
       </td>
       <td>
         <input type=text name="opt_def_max_views_day" value="##opt_def_max_views_day##" class=fieldclass="field5">
       </td>
     </tr>
     <tr vAlign=top>
       <td>
         %%opt_def_max_clicks%%:<br>
         <small>%%zero_unlim%%</small>
       </td>
       <td>
         <input type=text name="opt_def_max_clicks" value="##opt_def_max_clicks##" class=fieldclass="field5">
       </td>
     </tr>
     <tr vAlign=top>
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
     <tr id=tr_opt_def_priority>
       <td>
         %%opt_def_priority%%:
       </td>
       <td>
         <select name="opt_def_priority">
            <option value="0" ##opt_def_priority_0##>%%opt_def_priority_low%%</option>
            <option value="1" ##opt_def_priority_1##>%%opt_def_priority_normal%%</option>
            <option value="2" ##opt_def_priority_2##>%%opt_def_priority_high%%</option>
         </select>
       </td>
     </tr>
     <tr><td colspan=2><hr></td></tr>
     <tr>
       <td>
         %%cost%%:
       </td>
       <td>
            <input type=text name="cost" value="##cost##" class=fieldclass="field5"> ##curr_prefix## ##curr_postfix## 
       </td>
     </tr>
     <tr>
       <td>
         %%cost_view%%:
       </td>
       <td>
            <input type=text name="cost_view" value="##cost_view##" class=fieldclass="field5"> ##curr_prefix## ##curr_postfix## 
       </td>
     </tr>
     <tr>
       <td>
         %%cost_click%%:
       </td>
       <td>
            <input type=text name="cost_click" value="##cost_click##" class=fieldclass="field5"> ##curr_prefix## ##curr_postfix## 
       </td>
     </tr>
     </table>
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
     <col width="200">
     <col width="*">
   <tr>
       <td colspan="2">


        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-description">
              <textarea class="field" style="width:100%" rows="14" name="description" id="description">##description##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('description', cmD_STB, true);}
              </script>
            </div>
          </div>
        </div>

        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'description' : ['%%description%%', 'active', '', false],

          '':''});
          
        </script>
       </td>
     </tr>
     </table>
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
     <col width="200">
     <col width="*">
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
    
    <script>  
        onMaterialTypeChange(document.advcampaigntypesform)
    </script>