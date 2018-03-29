%%include_language "templates/lang/subscribe_topic.lng"%%

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'topic_form';
var _cms_script_link = '##script_link##?';

function CheckForm(form) {
   var errmsg = "";

   if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
   }

##--if(MANUAL_PRICE=="1")##
   var price = parseFloat(form.price.value);
   if (price<0) {
       return focusedAlert(form.price, '%%price_warn%%');
   }
##endif--##

   editor_updateHiddenField("desc");

   return true;
}
-->
</script>

<!--#set var="cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="javascript:user_click('none','');">
"-->

  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="topic_form" onSubmit="return CheckForm(window.document.topic_form);">
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="action" value="##action##">
     <input type=hidden name=price value="0.00">
##filter_hidden_fields##
     <input type="hidden" name="activate" value="">
     <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
     <col width="100">
     <col width="*">
     <tr>
       <td>%%name%%*:</td>
       <td>
         <input type=text name=name class="field field50" value="##name##" maxlength="255">
       </td>
     </tr>
##--if(MANUAL_PRICE=="1")##
     <tr>
       <td>%%price%%:</td>
       <td>
         <input type=text name=price class="field field20" value="##price##" >
       </td>
     </tr>
##endif--##
     </table>
     <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
     <col width="100">
     <col width="*">
     <tr>
       <td colspan="2">

##--
         <!-- ce header-->
         <table border=0 cellspacing=0 cellpadding=0 class=tabs width=100%>
           <tr>
            <td class=sel_><img src="skins/vanilla/images/spacer.gif" width=1 height=1></td>
            <td height=2 width=100%><img src="skins/vanilla/images/spacer.gif" width=1 height=1></td>
           </tr>
           <tr>
            <td class=sel nowrap>%%description%%</td>
            <td height=16 width=100% class=bempty><img src="skins/vanilla/images/spacer.gif" width=1 height=1></td>
           </tr>
         </table>
         <!-- /ce header-->
         <div id="div_desc" class="tab">
         <textarea class="field" style="width:100%" rows="14" name=desc id="desc">##desc##</textarea>
         <script type="text/javascript">
           if(editor_enable)
             editor_generate('desc', cmD_STB); // field, width, height
         </script>
         </div>
         <br>
--##

        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-desc">
              <textarea class="field" style="width:100%" rows="14" name="desc" id="desc">##desc##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('desc', cmD_STB);}
              </script>
            </div>
          </div>
        </div>

        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'desc' : ['%%description%%', 'active', '', false],
          '':''});
          
        </script>

        
        </td>
     </tr>
     </table>
     <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
     <col width="100">
     <col width="*">
     <tr>
        <td colspan="2" align="right">
        <br>
        <input type="submit" name="add" value="  %%add_btn%%  " class="but" ##add##>
        <input type="submit" name="apply" value="  %%apply_btn%%  " class="but" ##apply##>
        ##cancel##
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

