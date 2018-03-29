%%include_language "templates/lang/_buttons.lng"%%

<!--#set var="progress_indicator" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<!-- -->
  <head>
    ##metas##
    <link rel="stylesheet" href="##skin_path##_css/style.css?_cv=##cms_version##" type="text/css">
    <script src="jsapi.php" type="text/javascript"></script>
    <script type="text/javascript" src="##admin_root####skin_path##_js/ami.jquery.js"></script>
    <script src="##skin_path##_js/ami.admin.js" type="text/javascript"></script>
  </head>
  <body leftmargin="0" topmargin="0" bgcolor="#FFFFFF">
  <br>
  <form>
  <table align="center" width="70%" border="0" cellpadding="0" cellspacing="0">
  <tr><td colspan="2" id="prgHeader" class="prgHeader"></td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2" id="prgStatus" class="prgStatusOk"></td></tr>
  <tr id="prgTickRow" style="display:none"><td colspan="2" id="prgTick" class="prgTick">|</td></tr>
  <tr id="prgCounter" style="display:none">
  <td colspan="2" align="center">
    <table align="center" border="0" cellpadding="0" cellspacing="0">
    <tr><td id="prgCntLabel"></td><td id="prgCount"></td></tr>
    </table>
  </td>
  </tr>
  <tr id="prgBar" style="display:none">
    <td colspan="2">
    <div width="100%" class="prgOuter">
        <div class="prgInner" id="prgInner">0%</div>
    </div>
    </td>
  </tr>
  <tr>
    <td colspan="2" align="center"><br><br>
        <input type="button" class="but" id="prgCloseBtn" value="%%close_btn%%" onclick="closeDialogWindow()" disabled>
    </td>
  </tr>
  </table>
  </form>
  
<script type="text/javascript">

if(document.swapNode){
    var tableRowShowStyle = 'block';
}else{
    var tableRowShowStyle = 'table-row';
}

var warnOnClose = true;

var PIND_BAR      = 0x01;
var PIND_COUNTER  = 0x02;
var PIND_TICK     = 0x04;
var PIND_MAXCODE  = 0x04;

function ProgressIndicator() {

    this.visibleControls = 0;
    this.header = '';
    this.statusMsg = '';
    this.percent = 0;
    this.cntLabel = '';
    this.count = '0';
    this.tickSym = ['|','/','-',"\\"];
    this.tickCount = 0;

    this._correctPercent = function() {
        if(this.percent<0) this.percent = 0;
        if(this.percent>100) this.percent = 100;
    };

	this._domId = function(bit) {
		switch(bit) {
			case PIND_BAR: return 'prgBar';
			case PIND_COUNTER: return 'prgCounter';
			case PIND_TICK: return 'prgTick';
		}
	}

    // Set status message
    this.setHeader = function(msg) {

        var hdrEl = document.getElementById('prgHeader');
        hdrEl.innerHTML = this.header = msg;
    };

    // Set status message
    this.setStatusMsg = function(msg,err) {

        var statEl = document.getElementById('prgStatus');
        if(err==undefined) err = false;

        statEl.innerHTML = this.statusMsg = msg;
        statEl.className = err ? 'prgStatusErr' : 'prgStatusOk';
    };

    // Set counter (and label if defined)
    this.setCounter = function(count,label) {
        if(!(this.visibleControls & PIND_COUNTER)){
            this.showControls(PIND_COUNTER, true);
        }

        if(count!=undefined) this.count = count;
        if(label!=undefined) this.cntLabel = label;
        document.getElementById('prgCntLabel').innerHTML = '<nobr>'+this.cntLabel+'&nbsp;&nbsp;</nobr>';
        document.getElementById('prgCount').innerHTML = this.count;
    };

    // Set progress bar percentage
    this.setBar = function(percent) {
        if(!(this.visibleControls & PIND_BAR)){
            this.showControls(PIND_BAR, true);
        }
    
        if(percent!=undefined) this.percent = percent;
        this._correctPercent();
        document.getElementById('prgInner').innerHTML = this.percent+'%';
        document.getElementById('prgInner').style.width = this.percent+'%';
    };


    // Rotate tick dash
    this.tick = function() {
        if(!(this.visibleControls & PIND_TICK)){
            this.showControls(PIND_TICK, true);
        }

        this.tickCount = (this.tickCount+1)%4;
        document.getElementById('prgTick').innerHTML = this.tickSym[this.tickCount];
    };


    this.enableCloseButton = function(yes) {
        if(yes==undefined) yes = true;
        document.getElementById('prgCloseBtn').disabled = !yes;
        window.warnOnClose = !yes;
    };


    this.showControls = function(mask,show) {
        var i;
        for(i=1; i<=PIND_MAXCODE; i=i<<1) {
			if(mask & i){
                document.getElementById(this._domId(i)).style.display = show ? tableRowShowStyle : 'none';
            }
        }
        if(show)
            this.visibleControls |= mask;
        else
            this.visibleControls &= ~mask;
    };

}

pi = new ProgressIndicator();

/* Synchronizer */

function setProgressData(receivedData){
    stopProgressDownloader();
    
    var aData = receivedData.split('|');
    var doNextDownload = true;
    if(aData.length == 10){
        // Enable controls
        pi.showControls(aData[0], aData[1] == '1' ? true : false);
        // Set header
        pi.setHeader(aData[2]);
        // Set status message
        pi.setStatusMsg(aData[3], aData[4] == '1' ? true : false);
        // Set counter
        if(aData[6] != ''){
            pi.setCounter(aData[5], aData[6]);
        }else{
            pi.setCounter(aData[5]);
        }
        // Bar percent
        pi.setBar(parseInt(aData[7]));
        // Tick
        if(aData[8] == '1'){
            pi.tick();
        }
        // Enable close button or continue download
        if(aData[9] != '1'){
            pi.enableCloseButton(false);
        }else{
            doNextDownload = false;
            pi.enableCloseButton(true);
        }
    }
    if(doNextDownload){
        startProgressDownloader('##progress_id##');
    }
}

var idProgress = '##progress_id##';
startProgressDownloader('##progress_id##');
</script>

</body>
</html>
"-->

<!--#set var="pi_show_controls" value="
<script>resetProgressDownloader(idProgress); pi.showControls('##mask##',##show##);</script>
"-->

<!--#set var="pi_set_header" value="
<script>resetProgressDownloader(idProgress); pi.setHeader("##message##");</script>
"-->

<!--#set var="pi_set_status_msg" value="
<script>resetProgressDownloader(idProgress); pi.setStatusMsg("##message##",##error##);</script>
"-->

<!--#set var="pi_set_counter" value="
<script>resetProgressDownloader(idProgress); pi.setCounter("##count##"##label##);</script>
"-->

<!--#set var="pi_set_bar" value="
<script>resetProgressDownloader(idProgress); pi.setBar(##percent##);</script>
"-->

<!--#set var="pi_tick" value="
<script>resetProgressDownloader(idProgress); pi.tick();</script>
"-->

<!--#set var="pi_enable_close_button" value="
<script>stopProgressDownloader(idProgress); pi.enableCloseButton(##enable##);</script>
"-->
