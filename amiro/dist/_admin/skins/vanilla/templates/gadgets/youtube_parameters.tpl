<table width="100%" border="0">
	<tr><td align="left" valign="middle">
		<span class="tooltip" style="left-margin: 20px; margin: 5px 0px; display: block; width: auto;">%%youtube_disclaimer%%</span>
	</td></tr>
</table>
<br>
<center>
<table border="0" width="95%">
	<tr>
		<td>%%video_link%%:</td>
		<td colspan="2"><input type="text" id="video_link" name="video_link" class="field" required="yes" fieldtype="url" getter="url_get" setter="url_set" errmessage="%%field_is_required%%: %%video_link%%" size="50"/></td>
	</tr>
	<tr>
		<td>%%video_width%%:</td>
		<td><input type="text" name="video_width" id="video_width" value="425" class="field" required="yes" fieldtype="int" size="5" errmessage="%%field_is_required%%: %%video_width%%"/></td>
		<td align="left"><a href="javascript:" onclick="setSize(320,265);" style="text-decoration: none; border-bottom: 1px dashed;">320x265</a>&nbsp;&nbsp;<a href="javascript:" onclick="setSize(425,344);" style="text-decoration: none; border-bottom: 1px dashed;">425x344</a>&nbsp;</td>
	</tr>
	<tr>
		<td>%%video_height%%:</td>
		<td><input type="text" name="video_height" id="video_height" value="344" class="field" required="yes" fieldtype="int" size="5" errmessage="%%field_is_required%%: %%video_height%%"/></td>
		<td align="left"><a href="javascript:" onclick="setSize(480,385);" style="text-decoration: none; border-bottom: 1px dashed;">480x385</a>&nbsp;&nbsp;<a href="javascript:" onclick="setSize(640,505);" style="text-decoration: none; border-bottom: 1px dashed;">640x505</a>&nbsp;</td>
	</tr>
</table>
</center>
<br/>
<script>
	function url_get(val) {
		var ret = Array();
		var r = /http\:\/\/www.youtube.com\/watch\?v\=([a-z0-9\_\-]*?)($|[&\s])/i;
		var result = r.exec(val);
		if(result != null) {
            ret['video_id'] = result[1];
			ret['original_url'] = result[0]
			return ret;
		} else {
			return false;
		}
	}

	function url_set(arr) {
		var elm = document.getElementById('video_link');
		if(arr['original_url']) {
			elm.value = arr['original_url'];
		}
	}

	function setSize(width, height) {
		var wel = document.getElementById('video_width');
		var hel = document.getElementById('video_height');
		wel.value = width;
		hel.value = height;
	}
</script>