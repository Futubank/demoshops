%%include_language "templates/lang/votes.lng"%%

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'votesform';
var _cms_script_link = '##script_link##?';
-->
</script>



<!--#set var="answer_line" value="
     <tr>
       <td rowSpan="2">##if(picture)##<img src="##picture##" title="%%picture%%">##endif##&nbsp;</td>
       <td>##if(answer)####answer####endif##&nbsp;</td>
     </tr>
     <tr>
        <td nowrap>
          <img src=skins/vanilla/images/on.gif border=0 height=10 width=##width1##><span style="##hidden##"><img src=skins/vanilla/images/off.gif border=0 height=10 width=##width2##></span>
          <b>-&raquo;</b>
          ##voices##% (##voicesNumeric##)
        </td>
     </tr>
"-->
<!--#set var="no_answers" value="
     <tr>
       <td colspan=2>
         %%no_answers%%
       </td>
     </tr>
"-->
<!--#set var="no_vote" value="
     <tr>
       <td colspan=2>
         %%no_vote%%
       </td>
     </tr>
"-->


  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="votesform">
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="action" value="##action##">
##filter_hidden_fields##
     <input type="hidden" name="publish" value="">
     <table width=300 cellspacing="5" cellpadding="0" border="0" class="frm">
     <tr>
        <td colspan=2>##date##</td>
     </tr>
     <tr>
        <td colspan=2>##question##<br></td>
     </tr>
     <tr>
        <td colspan=2><table width="100%" cellpadding="2" cellspacing="0" border="0" class=frm>
            ##answers##
        </table></td>
     </tr>
     <tr>
        <td colspan=2 align=right>
         %%total%%:
         ##total##
       </td>
     </tr>
     <tr>
        <td colspan="2" align="right">
        <br>
        <input type="reset" name="back" value="%%edit_btn%%" class="but" OnClick="javascript:user_click('edit', '##id##');return false;" />
        <br><br>
        </td>
     </tr>
     </table>

    </form>
