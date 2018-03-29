##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_filter.tpl"%%

<!--#set var="section_filter" value="
##IF(scripts)##<script type="text/javascript">
##scripts##
</script>##ENDIF##

<script type="text/javascript">
function applyForm()
{
    closeDialogWindow();
    return false;
}
</script>
##if(_component_id!='selected_filter')##<button class="but" onclick="applyForm();" tabindex="50">&nbsp;&nbsp;&nbsp;%%btn_close%%&nbsp;&nbsp;&nbsp;</button>##endif##
<div class="filter-block" id="filter-box" style="padding-top:16px;">
    <div class="l-lt-c"></div><div class="l-rt-c"></div><div class="l-lb-c"></div><div class="l-rb-c"></div>
    <div class="filter-panel">
        <div class="l-lb-c"></div><div class="l-lt-c"></div><div class="l-rt-c"></div><div class="l-rb-c"></div>
			<div style="padding-left:15px;">
				<button id="icon_filter" onclick="document.getElementById('ami_form_filter_##_component_id##').onsubmit();return false;">%%apply%%</button>
				<button id="icon_cancel" onclick="AMI.Page.doModuleAction('##_mod_id##', '##_component_id##', 'filter_reset', AMI.$('#ami_form_filter_##_component_id##')[0]);">%%reset%%</button>
			</div>
    </div>
    <div class="filter_box" style="padding: 10px 100px 10px 10px;">
        <div class="flt-block">
            <form data-ami-component-id="##_component_id##" id="ami_form_filter_##_component_id##" class="flt_form" style="margin: 0px;" action="##action##" method="post" enctype="multipart/form-data" name="##name##"
                onsubmit="if(!AMI.Page.getComponent(this.elements.componentName.value).validateForm()){return false};AMI.Page.doModuleAction('##_mod_id##', '##_component_id##', 'filter', this); return false;"
            >
            ##section_html##
			<script type="text/javascript">
				AMI.find('#ami_form_filter_##_component_id##').onkeydown = function keyDown(event) {
					event = event || window.event;
					if (event.keyCode == 13) {
						document.getElementById('ami_form_filter_##_component_id##').onsubmit();return false;
				  }
				}
			</script>
            </form>
        </div>
    </div>
</div>"-->
