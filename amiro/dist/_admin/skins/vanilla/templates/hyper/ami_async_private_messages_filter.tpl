##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_filter.tpl"%%

<!--#set var="section_folders" value="
<div id="folders_buttons">
    ##section_html##
    <div class="private_messages_filter" id="pm_flt_inbox" onclick="selectPMFilter('inbox', true);">%%filter_field_inbox%%</div>
    <div class="private_messages_filter" id="pm_flt_sent" onclick="selectPMFilter('sent', true);">%%filter_field_sent%%</div>
    <div class="private_messages_filter" id="pm_flt_deleted" onclick="selectPMFilter('deleted', true);">%%filter_field_deleted%%</div>
</div>
"-->

<!--#set var="hidden_field" value="<input name="##name##" value="##value##" type="hidden">"-->
<!--#set var="input_field" value="<span class="flt_element">##element_caption## <input class="filter_field" name="##name##" value="##value##" /></span>"-->
<!--#set var="checkbox_field" value="
##if(name=='inbox'||name=='sent'||name=='deleted')##
<input id="pmcb_##name##" name="##name##" value="##if(isset(checked) && checked)##1##endif##" type="hidden"/>
##else##
<span class="flt_element"><label><input id="pmcb_##name##" name="##name##" value="##if(value)####value####else##1##endif##" type="checkbox" ##if(isset(checked) && checked)##checked##endif##> ##element_caption##</label></span>
##endif##"-->
<!--#set var="select_field" value="<span class="flt_element">##element_caption## <select name="##name##">##select##</select></span>"-->
<!--#set var="select_field_row" value="<option value="##value##" ##selected##>##caption##</option>"-->

<!--#set var="section_filter" value="
<script type="text/javascript">
function selectPMFilter(filter, autosubmit){
    AMI.find('#pmcb_inbox').value = "";
    AMI.find('#pmcb_sent').value = "";
    AMI.find('#pmcb_deleted').value = "";
    AMI.Page.aModules['##_mod_id##'].mode = filter;
    AMI.find('#pmcb_' + filter).value = "1";

    if(autosubmit){
        AMI.find('#ami_form_filter_private_messages_0').onsubmit();
    }

    setPMFilterColors();
}

function setPMFilterColors(){
    AMI.find('#pm_flt_inbox').className = (AMI.find('#pmcb_inbox').value) ? 'private_messages_filter selected' : 'private_messages_filter';
    AMI.find('#pm_flt_sent').className = (AMI.find('#pmcb_sent').value) ? 'private_messages_filter selected' : 'private_messages_filter';
    AMI.find('#pm_flt_deleted').className = (AMI.find('#pmcb_deleted').value) ? 'private_messages_filter selected' : 'private_messages_filter';
}
</script>
<div class="filter-block" id="filter-box">
    <div class="l-lt-c"></div><div class="l-rt-c"></div><div class="l-lb-c"></div><div class="l-rb-c"></div>
    <div class="filter-panel">
        <div class="l-lb-c"></div><div class="l-lt-c"></div><div class="l-rt-c"></div><div class="l-rb-c"></div>
			<div style="padding-left:15px;">
				<button id="icon_filter" onclick="document.getElementById('ami_form_filter_private_messages_0').onsubmit();return false;" onmouseover="document.getElementById('icon_filter').id = 'icon_filter_over'" onmouseout="document.getElementById('icon_filter_over').id = 'icon_filter'">%%apply%%</button>
				<button id="icon_cancel" onclick="AMI.Page.doModuleAction('##_mod_id##', '##_component_id##', 'filter_reset', this);" onmouseover="document.getElementById('icon_cancel').id = 'icon_cancel_over'" onmouseout="document.getElementById('icon_cancel_over').id = 'icon_cancel'">%%reset%%</button>
			</div>
    </div>
    <div class="filter_box">
        <div class="flt-block">
            <form id="ami_form_filter_private_messages_0" class="flt_form" style="margin: 0px;" action="##action##" method="post" enctype="multipart/form-data" name="##name##"
                onsubmit="AMI.Page.doModuleAction('##_mod_id##', '##_component_id##', 'filter', this); return false;"
                onkeydown="var evt = AMI.Browser.Event.validate(event);if(evt.keyCode == 13){this.onsubmit();return false;}"
            >
            ##section_html##
            </form>
        </div>
    </div>
</div>
<script type="text/javascript">
    setPMFilterColors();
</script>
"-->
