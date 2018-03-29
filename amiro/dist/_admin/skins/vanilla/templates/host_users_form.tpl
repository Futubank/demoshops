%%include_language "templates/lang/srv_host_payments.lng"%%
%%include_template "templates/_icons.tpl"%%

   <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
   <tr>
     <td>
     %%username%%:
     </td>
       <td colspan="2">
     ##username##
     </td>
   </tr>
   <tr>
     <td>
     %%domain%%:
     </td>
       <td colspan="2">
     ##domain##
     </td>
   </tr>
   <tr>
     <td>
     %%status%%:
     </td>
       <td colspan="2">
     ##status##
     </td>
   </tr>
   <tr>
     <td>
     %%balance%%:
     </td>
     <td>
     ##balance##&nbsp;
   </td>
   <td align="right"><!--
         <table width=150 class="graph" height=10 cellspacing=0>
           <tr><td width=##width##% class="##style##" nowrap>
           </td>
##if(show_full=="0")##<td></td>##endif##
           </tr>
         </table>-->
   </td>
   </tr>
   <tr>
     <td>
     %%min_balance%%:
     </td>
       <td colspan="2">
     ##balance##
     </td>
   </tr>
   <tr>
       <td>
     %%sum_payments%%:
     </td>
       <td colspan="2">
     ##sum_payments##
     </td>
   </tr>
   <tr>
       <td>
     %%first_payment%%:
     </td>
       <td colspan="2">
     ##first_payment##
     </td>
   </tr>
   <tr>
       <td>
     %%last_payment%%:
     </td>
       <td colspan="2">
     ##last_payment##
     </td>
   </tr>
   <tr>
       <td>
     %%num_payments%%:
     </td>
       <td colspan="2">
     ##num_payments##
     </td>
   </tr>
   <tr>
       <td>
     %%date_registered%%:
     </td>
       <td colspan="2">
     ##date_registered##
     </td>
   </tr>
   </table>
