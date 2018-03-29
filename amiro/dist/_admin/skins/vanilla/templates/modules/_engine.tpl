##--system info: module_owner="" module="" system="1"--##
<div id="Module60Content" class="ModuleContentLoading"></div>
<script type="text/javascript">
function place60ModuleContent(status, content){
    if(status == 1){
        AMI.Browser.DOM.setInnerHTML(AMI.find('#Module60Content'), content);
    }
}

var
    amiModuleLink = '##subfolder##/_admin/##code_postfix##60.mod.php',
    amiModId = '##mod_id##',
    params = '##if(mod_id)##mod_id=##mod_id##&##endif####if(partial_async)##partial_async=1##endif##';

AMI.HTTPRequest.getContent('GET', amiModuleLink + (document.location.search.length ? (document.location.search + '&' + params) : ('?' + params)), '', place60ModuleContent);
</script>