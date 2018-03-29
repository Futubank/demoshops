<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
##init##
<div id="calendar_block"  style="display:none; position: absolute; width:220px; height:347px; z-index:10; padding: 15px">
  <div class="popupShadowTopLeft"></div><div class="popupShadowTop" style="width: 220px"></div><div class="popupShadowTopRight"></div>
  <div class="popupShadowLeft" style="height: 347px"></div><div class="popupShadowRight" style="height: 347px"></div>
  <div class="popupShadowBottomLeft"></div><div class="popupShadowBottom" style="width: 220px"></div><div class="popupShadowBottomRight"></div>
  <table border="0" cellpadding="0" cellspacing="0" width=100% height=100% background="#fff">
        <tr><td style="padding:0px;">
        <iframe id="calendar_block_frm" width="220" height="347" src="about:blank" frameborder=0 scrolling=no>
        </iframe>
        </td></tr>
        </table>
</div>
<table width=100% cellspacing=0 cellpadding=0>
  <tr>
    <td width="100%" valign="top" class="center_area" id=body_content style="padding-left:5px;padding-top:10px;">

##filter##

      <div id="status-block" class="status-block"##if (status=='')## style="display:none" ##endif##>
          <div id="status-msgs" class="status-msgs">##status##</div>
      </div>

      ##list_table##
      <div style="width:90%;margin-left:auto;margin-right:auto;">
      ##form##
      </div>

    </td>
  </tr>
</table>
<script>
  if(typeof(BodyOnLoad)=="function"){
    BodyOnLoad();
  }
</script>
</body>
</html>
