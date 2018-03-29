##--system info: module_owner="" module="" system="1"--##

<!--#set var="market" value="
<div id="amiMarketInstallDialog" class="amiMarketInstallDialog" style="display:none;">
    <div class="amiMarketText">
        <span id="amiDownloadFilename"></span><span id="amiDownloadStatus"></span>
    </div>
    <div class="amiMarketStatusBarBack"><div id="amiStatusBar"></div></div>
    <div id="amiMarketInstallForm"></div>
</div>
<div style="background: url(images/custom_/loading.gif) 50% 30% no-repeat;">
##if(showIframe=='1')##
<iframe allowtransparency="true" id="market" src="about:blank" width="100%" frameborder=0 border=0 scrolling="no" style="height: 1200px;"></iframe>
##endif##
</div>
<script type="text/javascript">
    ##scripts##
    var amiMarketHash = "##hash##";
    AMI.$('#market').height(AMI.$('#body_content').innerHeight());
    AMI.$('#market').css('min-height', '680px');
    AMI.$('#market').attr('src', '##address####hash##');
</script>
"-->
