##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_filter.tpl"%%

<!--#set var="select_field(name='modname')" value="
<span class="flt_element">##element_caption##: <select id="id_##name##" name="##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## ##if(multiple==1)##style="display:none;"##endif## onclick="AMI.$('#commonFieldTooltip')[(AMI.$(this).val() > 0) ? 'hide' : 'show']();">##select##</select></span>
<script type="text/javascript">
AMI.$('#id_##name##').chosen({
    search_contains: true,
    disable_search_threshold: 20,
    width: '400px',
    no_results_text: AMI.Template.Locale.get('not_found')
});
AMI.$('#id_##name##').prop('chosen', true);
</script>
"-->