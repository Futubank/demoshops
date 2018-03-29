%%include_language "templates/lang/filter.lng"%%

<!--#set var="options" value="
<option value="##limit##" ##opt##>##limit##</option>
"-->

<!--#set var="select" value="
<select name="limit">
<option value="0">All</option>
   ##options##
</select>
"-->

    <form method="POST" class="flt_form" name="fform" >
     <input type="hidden" name="limit" value="##limit##">
     <input type="hidden" name="sdim" value="##sdim##">
     <input type="hidden" name="sort" value="##sort##">
     <input type="hidden" name="datefrom" class='fieldDate' value="##datefrom##">
     <input type="hidden" name="dateto" class='fieldDate' value="##dateto##">
     <input type="hidden" name="offset" value="##offset##">
     &nbsp;&nbsp; %%limit%%:
     ##select##
     &nbsp;
     <input type="submit" value="%%filter_btn%%" class="but" name="filter">
    </form>