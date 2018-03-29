##--system info: module_owner="" module="" system="1"--##
%%include_language "templates/modules/_form.tpl"%%

<!--#set var="section_form" value="
<script type="text/javascript">
##if(id)##
##else##
AMI.Message.removeListener('ON_AMI_LIST_SHOW_ADD_BUTTON');
##endif##
AMI.PartialAsync.init({
    actions: { list_show: 'view', form_reset: function(){AMI.scrollTo(AMI.find('FORM')[AMI.find('FORM').length-1]);} },
    groupActions: [],
    scrollToForm: ['view']
});
</script>
"-->
