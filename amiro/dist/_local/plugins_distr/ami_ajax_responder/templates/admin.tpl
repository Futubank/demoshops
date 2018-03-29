%%include_language "_local/plugins_distr/ami_ajax_responder/templates/admin.lng"%%

<!--#set var="option_row" value="<option value="##value##"##if(selected)## selected="selected"##endif##>##caption##</option>
"-->

<!--#set var="body" value="
<style>
.main-form{
    position: relative;
    display: -moz-inline-stack;
    display: inline-block; zoom: 1;
    *display: inline;
    margin: 10px;
}

.main-form-header{
    height:27px; background: url(skins/vanilla/images/st_h_bg.gif) repeat-x;
    margin:0px 11px 0px 11px;
    padding-top: 8px;
}

.form-title{
    color: #bc4702;
    font-size: 13px;
    font-weight: bold;
    text-align: left;
}

.main-form-body{
    padding: 10px;
    border-left: 1px #c7c7c7 solid;
    border-right: 1px #c7c7c7 solid;
    text-align: left;
}

.tooltip{
    font-size: 10px;
    padding: 8px 8px 8px 30px;
    margin: 10px 10px 10px 0px;
    background: #DDE7F8 url(skins/vanilla/images/tooltip-bg.gif) no-repeat 2px 2px;
    -moz-border-radius: 10px;
    border-radius: 10px;
}

.button{
    color: #bc4702;
    font-weight: bold;
    font-size: 11px;
    border: 0px;
    background: url(skins/vanilla/images/button_bg_120.gif);
    width: 120px;
    height: 25px;
    margin-bottom: 1px;
}

.mfrm-lt-c{
    position: absolute;
    left: 0;
    top: 0;
    width: 11px;
    height: 35px;
    background: url(skins/vanilla/images/st_c_lt.gif) no-repeat;
}

.mfrm-rt-c{
    position: absolute;
    right: 0;
    top: 0;
    width: 11px;
    height: 35px;
    background: url(skins/vanilla/images/st_c_rt.gif) no-repeat;
}

.mfrm-lb-c{
    position: absolute;
    left: 0;
    bottom: 0;
    width: 11px;
    height: 11px;
    background: url(skins/vanilla/images/st_c_lb.gif) no-repeat;
}

.mfrm-rb-c{
    position: absolute;
    right: 0;
    bottom: 0;
    width: 11px;
    height: 11px;
    background: url(skins/vanilla/images/st_c_rb.gif) no-repeat;
}

.main-form-footer{
    height: 11px;
    background: url(skins/vanilla/images/st_b_l.gif) repeat-x;
    margin: 0px 11px 0px 11px;
}
</style>

<div style="text-align: center;">
<div class="main-form">
  <div class="main-form-header">
    <div class="form-title">%%alloved_modules%%</div>
  </div>
  <div class="main-form-body">
    <form action="" method="post" enctype="multipart/form-data">
    <input type="hidden" name="save" value="1" />
    <center><table cellspacing="5">
    <tbody>
    <tr><td><select multiple="multiple" name="alloved_modules[]" size="10" id="idAllowedModules">##alloved_modules##</select></td></tr>
    <tr><td></tr>
    <tr><td><input class="but" type="submit" value="%%apply%%" /></td></tr>
    </form>
    </tbody>
    </table></center>
    <div class="tooltip">%%tooltip_other_parameters%%</div>
  </div>

  <div class="mfrm-lt-c"></div>
  <div class="mfrm-rt-c"></div>
  <div class="mfrm-lb-c"></div>
  <div class="mfrm-rb-c"></div>
  <div class="main-form-footer"></div>
</div>
</div>
<script type="text/javascript">var oAllowedModules = new AMI.UI.Multiselect('idAllowedModules', 140)</script>
"-->

<!--#set var="status_messages" value="
<div id="status-block" class="status-block">
    <div class="l-rt-c"></div>
    <div class="l-rb-c"></div>
    <div class="l-lb-c"></div>
    <div id="status-msgs" class="status-msgs">##messages##</div>
</div>
"-->

<!--#set var="status_error" value="
<div class="status-red">##message##</div>
"-->

<!--#set var="status_notice" value="
<div class="status-none">##message##</div>
"-->