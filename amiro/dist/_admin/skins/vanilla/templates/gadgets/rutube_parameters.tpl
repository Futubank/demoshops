<table width="100%" border="0">
    <tr><td align="left" valign="middle">
        <span class="tooltip" style="left-margin: 20px; margin: 5px 0px; display: block; width: auto;">%%rutube_disclaimer%%</span>
    </td></tr>
</table>
<br>
<center>
<table border="0" width="95%">
    <tr>
        <td>%%player_code%%:</td>
        <td><textarea id="video_link" name="video_link" class="field" required="yes" getter="url_get" setter="url_set" cols="50" rows="4" errmessage="%%field_is_required%%: %%player_code%%"></textarea></td>
    </tr>
    <tr>
        <td>%%video_width%%:</td>
        <td><input type="text" name="video_width" value="470" class="field" required="yes" fieldtype="int" size="5" errmessage="%%field_is_required%%: %%video_width%%"/></td>
    </tr>
    <tr>
        <td>%%video_height%%:</td>
        <td><input type="text" name="video_height" value="353" class="field" required="yes" fieldtype="int" size="5" errmessage="%%field_is_required%%: %%video_height%%"/></td>
    </tr>
</table>
</center>
<br />
<script type="text/javascript">
function url_get(val) {
    var ret = {};
    var r = /.*"\/\/rutube\.ru\/play\/embed\/([\w\d]+)".*/i;

    var result = r.exec(val);
    if(result != null) {
        ret['video_id'] = result[1];
        ret['original_url'] = result[0];
        return ret;
    } else {
        r = /http\:\/\/rutube\.ru\/tracks\/[0-9]+\.html\?v=(\w*)[\b&\s]?/i;
        if(result != null){
            alert('%%rutube_obsolete_video_link%%');
        }
        return false;
    }
}

function url_set(arr) {
    var elm = document.getElementById('video_link');
    if(arr['original_url']) {
        elm.value = arr['original_url'];
    }
}
</script>
