%%include_language "templates/lang/rating.lng"%%


<script type="text/javascript">
<!--

function OnObjectChanged_rating(name, first_change, evt) {
    if (name == "allow_ratings") {
        document.getElementById('display_ratings').checked = document.getElementById(name).checked;
        document.getElementById('display_ratings').disabled = !document.getElementById(name).checked;
        document.getElementById('sort_by_ratings').checked = document.getElementById(name).checked;
        document.getElementById('sort_by_ratings').disabled = !document.getElementById(name).checked;
        document.getElementById('display_votes').checked = document.getElementById(name).checked;
        document.getElementById('display_votes').disabled = !document.getElementById(name).checked;
    }
    return true;
}
addFormChangedHandler(OnObjectChanged_rating);

function changeFieldsStatus(newStatus){

   errFunc = changeFieldsStatus;

   document.getElementById('votes_count').disabled = newStatus; 
   document.getElementById('votes_rate').disabled = newStatus; 

   document.getElementById('rewrite_ratings').value = !newStatus;

}


function checkInteger(theID){

   errFunc = checkInteger;

   theVal = document.getElementById(theID).value;

    for (i = 0; i < theVal.length; i++)
    {   
        var c = theVal.charAt(i);
        if (((c < "0") || (c > "9"))) { 
     alert('%%integer_warn%%'); 
     document.getElementById(theID).focus();
     return false; 
    }
    }

    return true;
}


// checks for the number between 1.0000 and 5.0000

function checkRating(theID){

   errFunc = checkRating;

   theVal = parseFloat(document.getElementById(theID).value);

        if ( theVal < 1.00000 || theVal > 5.00000 || !theVal  ) { 
     alert('%%rating_warn%%'); 
     document.getElementById(theID).focus();
     return false; 
    }
    document.getElementById(theID).value = theVal;
    return true;
}


-->
</script>

<table width=100% class=tab_screen>

    <tr>
        <td colspan=6 height=10>&nbsp;</td>
    </tr>

<tr>
    <td width=40 align="right">
      <input type="checkbox" id="rewrite" onClick="changeFieldsStatus(!this.checked);">
      <input type="hidden" name="rewrite_ratings" id="rewrite_ratings" value="false">
        </td>

        <td>
         <label for="rewrite"><nobr>%%rewrite_ratings%%</nobr></label>          
        </td>

        <td align="right">
          %%votes_count%%:
    </td>
        <td>
     <input type="text" name="votes_count" id="votes_count" class="field field6"  
     value="##votes_count##" disabled onBlur="checkInteger(this.id);">
        </td>

        <td align="right">
         %%votes_rate%%:
    </td>
        <td>
     <input type="text" name="votes_rate" id="votes_rate" class="field field6"  
     value="##votes_rate##" disabled  onBlur="checkRating(this.id);">
        </td>

    </tr>

    <tr>
        <td colspan=6 height=10>&nbsp;</td>
    </tr>

    <tr>

    <td width=40 align="right">
      <input type="checkbox" name="allow_ratings" id="allow_ratings" ##allow_ratings##>
        </td>
    <td>
         <label for="allow_ratings">%%allow_ratings%%</label>
    </td>

    <td align="right">
      <input type="checkbox" name="display_ratings" id="display_ratings" ##display_ratings##>
        </td>
    <td>
         <label for="display_ratings">%%display_ratings%%</label>
    </td>
        <td colspan=2> </td>
   </tr>

   <tr>

    <td width=40 align="right">
      <input type="checkbox" name="sort_by_ratings" id="sort_by_ratings" ##sort_by_ratings##>
        </td>
    <td>
         <label for="sort_by_ratings">%%sort_by_ratings%%</label>
    </td>

    <td align="right">
      <input type="checkbox" name="display_votes" id="display_votes" ##display_votes##>
        </td>
    <td>
         <label for="display_votes">%%display_votes%%</label>
    </td>
        <td colspan=2> </td>
   </tr>

    <tr>
        <td colspan=6 height=10>&nbsp;</td>
    </tr>

</table>

