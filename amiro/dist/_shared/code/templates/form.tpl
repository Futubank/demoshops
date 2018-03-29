##--!ver=0200 rules="-SETVAR"--##
%%include_language "_shared/code/templates/lang/common.lng"%%

<div style="display:##if(display_form == "none")##none##else##block##endif##;" ##form_align## id="div_properties_form">
<br><br>
 <table border="0" cellpadding="0" cellspacing="0" width=100%>
 <tr><td valign=top align=center>
  <table border="0" cellpadding="0" cellspacing="0" class=tbl>
    <tr>
      <th>
##--        <h3 id="form_title">--##
        ##header##
        ##--</h3>--##</th>
    </tr>
    <tr>
      <td class="table_sticker" valign="top" >

      ##content##

       </td>
    </tr>
    <tr>
      <td></td>
    </tr>
  </table>
  </td></tr>
  </table>
</div>
