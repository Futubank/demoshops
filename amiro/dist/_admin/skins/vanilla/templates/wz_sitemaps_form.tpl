%%include_language "templates/lang/wz_sitemaps.lng"%%
<!--#set var="tariff_option" value="
<option value = "##id_tariff##:##id_period##"##if(selected)## selected##endif##>##name## (##period## %%mon%%)</option>
"-->

<script type="text/javascript">
<!--

var editor_enable = '##editor_enable##';
var _cms_document_form = 'wzsmform';
var _cms_script_link = '##script_link##?';

var arrTabs = Array('description', 'license', 'parameters');

function CheckForm(form) {
   var errmsg = "";

   editor_updateHiddenField("description");

   if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
   }

   if (form.sys_name.value=="") {
       return focusedAlert(form.sys_name, '%%sys_name_warn%%');
   }

##if(BUILDER_VERSION > 1)##
   if (form.tariff.value=="") {
       return focusedAlert(form.tariff, '%%tariff_warn%%');
   }
##endif##

   return true;
}

-->
</script>


  <br>
   <form action="##script_link##" method="post" enctype="multipart/form-data" name="wzsmform" onSubmit="return CheckForm(this);">
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="action" value="##action##">
     <input type="hidden" name="public" value="##public##">
     <input type="hidden" name="publish" value="">
##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     <tr>
       <td>%%name%%*:</td>
       <td>
         <input type=text name=name class="field field60" value="##name##" >
       </td>
     </tr>
     <tr>
       <td>%%sys_name%%*:</td>
       <td>
         <input type=text name=sys_name class="field field40" value="##sys_name##" >
       </td>
     </tr>
     <tr>
       <td>%%type%%:</td>
       <td>
         <select name=type>
				 <option value=trial ##if(type=="trial")## selected ##endif##>%%trial%%</option>
				 <option value=free ##if(type=="free")## selected ##endif##>%%free%%</option>
				 </select>
       </td>
     </tr>
##if(BUILDER_VERSION > 1)##
     <tr>
       <td>%%tariff%%:</td>
       <td>
         <select name=tariff>
             <option value="" >%%select_tariff%%</option>##tariff_options##
         </select>
       </td>
     </tr>
##endif##
</table>
<table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     <tr>
       <td colspan="2">
        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-description">
              <textarea class="field" style="width:100%" rows="14" name=description id="description">##description##</textarea>
               <script type="text/javascript">
                 if(editor_enable) // generates div with div_'name' and places editor in it.
                   editor_generate('description', cmD_STB , true); // field, width, height
               </script>
            </div>
            <div class="tab-page" id="tab-page-license">
              <b>%%license%%</b><br>
              <textarea wrap="soft" class="gray_field"
              style="margin-left:3px;margin-right:2px;width:680px;height:200px;padding:3px;font-size:11px;font-family:Courier New;border:2px #e0e0e0 inset;line-height:160%" 
              name="license" id=license>##license##</textarea>
              <br><br>&nbsp;<b>%%packages%%</b><br>
              <textarea wrap="soft" class="gray_field"
              style="margin-left:3px;margin-right:2px;width:680px;height:200px;padding:3px;font-size:11px;font-family:Courier New;border:2px #e0e0e0 inset;line-height:160%" 
              name="packages" id=packages>##packages##</textarea>
            </div>
            <div class="tab-page" id="tab-page-parameters">
              <table cellspacing="5" cellpadding="0" border="0">
                 <tr>
                   <td colspan=2><b>%%quotas%%</b></td>
                 </tr>
                 <tr>
                   <td>&nbsp;&nbsp;%%max_mboxes%%:</td>
                   <td>
                     <input type=text name=quotas_max_mboxes class="field field5" value="##quotas_max_mboxes##" >
                   </td>
                 </tr>
                 <tr>
                   <td>&nbsp;&nbsp;%%email_quota%%:</td>
                   <td>
                     <input type=text name=quotas_email_quota class="field field10" value="##quotas_email_quota##" >
                   </td>
                 </tr>
                 <tr>
                   <td>&nbsp;&nbsp;%%disk_quota%%:</td>
                   <td>
                     <input type=text name=quotas_disk_quota class="field field10" value="##quotas_disk_quota##" >
                   </td>
                 </tr>
                 <tr>
                   <td>&nbsp;&nbsp;%%traf_quota%%:</td>
                   <td>
                     <input type=text name=quotas_traf_quota class="field field10" value="##quotas_traf_quota##" >
                   </td>
                 </tr>
                 <tr>
                   <td colspan=2><br><b>%%pricing%%</b></td>
                 </tr>
                 <tr>
                   <td>&nbsp;&nbsp;%%pricing_amount_buy%%:</td>
                   <td>
                     <input type=text name=pricing_amount_buy class="field field10" value="##pricing_amount_buy##" >
                   </td>
                 </tr>
                 <tr>
                   <td>&nbsp;&nbsp;%%pricing_buy_bonus%%:</td>
                   <td>
                     <input type=text name=pricing_buy_bonus class="field field10" value="##pricing_buy_bonus##" >
                   </td>
                 </tr>
                 <tr>
                   <td>&nbsp;&nbsp;%%pricing_amount_rent%%:</td>
                   <td>
                     <input type=text name=pricing_amount_rent class="field field10" value="##pricing_amount_rent##" >
                   </td>
                 </tr>
                 <tr>
                   <td>&nbsp;&nbsp;%%pricing_amount_month%%:</td>
                   <td>
                     <input type=text name=pricing_amount_month class="field field10" value="##pricing_amount_month##" >
                   </td>
                 </tr>
                 <tr>
                   <td>&nbsp;&nbsp;%%pricing_traf_price%%:</td>
                   <td>
                     <input type=text name=pricing_traf_price class="field field10" value="##pricing_traf_price##" >
                   </td>
                 </tr>
                 <tr>
                   <td>&nbsp;&nbsp;%%pricing_traf_amount%%:</td>
                   <td>
                     <input type=text name=pricing_traf_amount class="field field10" value="##pricing_traf_amount##" >
                   </td>
                 </tr>
              </table>
            </div>
          </div>


        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'description' : ['%%description%%', 'active', '', false],
              'license' : ['%%license%%', 'normal', '', false],
              'parameters' : ['%%parameters%%', 'normal', '', false],

          '':''});
          
        </script>

       </td>
     </tr>
     </table>
    <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     <tr>
       <td colspan="2" align="right">
			 <br>
				 ##form_buttons##
			 <br>
       </td>
     </tr>
     <tr>
       <td colspan="2">
           <sub>%%required_fields%%</sub>
       </td>
     </tr>
     </table>

    </form>
