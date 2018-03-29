%%include_language "templates/lang/modules/_filter.lng"%%

<!--#set var="hidden_field" value="<input name="##name##" value="##value##" type="hidden">"-->
<!--#set var="input_field" value="<span class="flt_element">##element_caption## <input class="filter_field" name="##name##" value="##value##" /></span>"-->
<!--#set var="checkbox_field" value="<input name="##name##" value="0" type="hidden"><span class="flt_element"><label><input name="##name##" value="1" type="checkbox" ##if(isset(checked) && checked)##checked##endif##> ##element_caption##</label></span>"-->
<!--#set var="radio_field" value="<span class="flt_element">%%filter_field_##name##%%: ##select##</span>"-->
<!--#set var="radio_field_row" value="<label><input name="##name##" value="##value##" type="radio" ##if(isset(checked) && checked)##checked##endif##> %%filter_field_##name##_##value##%%</label>"-->
<!--#set var="select_field" value="<span class="flt_element">##element_caption## <select name="##name##">##select##</select></span>"-->
<!--#set var="select_field_row" value="<option value="##value##" ##selected##>##caption##</option>"-->

<!--#set var="datefrom_field" value="
<span class="flt_element">
##element_caption##
<input type="text" name="##name##" class="filter_field fieldDate" style="width: 70px;" value="##value##" />
<a href="javascript: void(0);" onclick="return getCalendar(event, document.getElementById('flt_form').elements['##name##'], 'MIN');">
    <img class="clnd_img" src="/_mod_files/60/images/spacer.gif" />
</a>
</span>
"-->

<!--#set var="dateto_field" value="
<span class="flt_element">
##element_caption##
<input type="text" name="##name##" class="filter_field fieldDate" style="width: 70px;" value="##value##" />
<a href="javascript: void(0);" onclick="return getCalendar(event, document.getElementById('flt_form').elements['##name##'], 'MAX');">
    <img class="clnd_img" src="/_mod_files/60/images/spacer.gif" />
</a>
</span>
"-->

<!--#set var="section_filter" value="
<div class="filter-block" id="filter-box">
    <div class="l-lt-c"></div><div class="l-rt-c"></div><div class="l-lb-c"></div><div class="l-rb-c"></div>
    <div class="filter-panel">
        <div class="l-lb-c"></div><div class="l-lt-c"></div><div class="l-rt-c"></div><div class="l-rb-c"></div>
			<div style="padding-left:15px;">
				<button id="icon_filter" onclick="document.getElementById('flt_form').onsubmit();return false;" onmouseover="document.getElementById('icon_filter').id = 'icon_filter_over'" onmouseout="document.getElementById('icon_filter_over').id = 'icon_filter'">%%apply%%</button>
				<button id="icon_cancel" onclick="AMI.Page.doModuleAction('##_mod_id##', '##_component_id##', 'filter_reset', this);" onmouseover="document.getElementById('icon_cancel').id = 'icon_cancel_over'" onmouseout="document.getElementById('icon_cancel_over').id = 'icon_cancel'">%%reset%%</button>
			</div>
    </div>
    <div class="filter_box">
        <div class="flt-block">
            <form id="flt_form" class="flt_form" style="margin: 0px;" action="##action##" method="post" enctype="multipart/form-data" name="##name##"
                onsubmit="AMI.Page.doModuleAction('##_mod_id##', '##_component_id##', 'filter', this); return false;"
                onkeydown="var evt = AMI.Browser.Event.validate(event);if(evt.keyCode == 13){this.onsubmit();return false;}"
            >
            ##section_html##
            </form>
        </div>
    </div>
</div>"-->
