##--system info: module_owner="" module="" system="1"--##
%%include_language "templates/lang/modules/_filter.lng"%%

<!--#set var="hint" value="
<a class="icon-template-help-filter" href="javascript:void;" onclick="return false;" id="##tooltip_id##" class="amiTooltip"></a>
<script type="text/javascript">
AMI.$("###tooltip_id##").tooltip({
    bodyHandler: function(){
        return '##value##';
    },
    showURL: false
});
</script>"-->

<!--#set var="default_field" value="<input name="##name##" value="##value##" type="hidden" disabled="disabled"> "-->
<!--#set var="hidden_field" value="<span class="flt_element" style="display:none;"><input name="##name##" value="##value##" type="hidden"></span> "-->
<!--#set var="input_field" value="<span class="flt_element">##element_caption##: <input class="filter_field" name="##name##" value="##value##" />##hint##</span> "-->
<!--#set var="checkbox_field" value="<span class="flt_element" style="display:none;"><input name="##name##" value="0" type="hidden"></span><span class="flt_element"><label helpid="flt_##name##"><input helpid="flt_##name##" name="##name##" value="1" type="checkbox" ##if(isset(checked) && checked)##checked##endif##> ##element_caption##</label>##hint##</span> "-->
<!--#set var="radio_field" value="<span class="flt_element">%%filter_field_##name##%%: ##select####hint##</span> "-->
<!--#set var="radio_field_row" value="<label><input name="##name##" value="##value##" type="radio" ##if(isset(checked) && checked)##checked##endif##> %%filter_field_##name##_##value##%%</label>"-->

<!--#set var="select_field" value="<span class="flt_element">##element_caption##: <select id="id_##name##" name="##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## ##if(multiple==1)##style="display:none;"##endif## onclick="AMI.$('#commonFieldTooltip')[(AMI.$(this).val() > 0) ? 'hide' : 'show']();">##select##</select></span>"-->

<!--#set var="select_field_row" value="<option value="##value##" ##selected##>##caption##</option>"-->

<!--#set var="datefrom_field" value="
<span class="flt_element">
##element_caption##
<input type="text" name="##name##" class="filter_field fieldDate" style="width: 70px;" value="##value##" ##IF(validators)## data-ami-validators="date date_limits stop_on_error"##ENDIF## ##attributes_date##/>
<a href="javascript: void(0);" onclick="return getCalendar(event, document.getElementById('ami_form_filter_##_component_id##').elements['##name##'], 'MIN');"><img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
</span>
"-->

<!--#set var="dateto_field" value="
<span class="flt_element">
##element_caption##
<input type="text" name="##name##" class="filter_field fieldDate" style="width: 70px;" value="##value##" ##IF(validators)## data-ami-validators="date date_limits stop_on_error"##ENDIF## ##attributes_date##/>
<a href="javascript: void(0);" onclick="return getCalendar(event, document.getElementById('ami_form_filter_##_component_id##').elements['##name##'], 'MAX');"><img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
</span>
"-->

<!--#set var="section_filter" value="

    
##IF(scripts)##<script type="text/javascript">
##scripts##
</script>##ENDIF##
<div class="filter-block" id="filter-box" data-helpid="filter">
    <div class="l-lt-c"></div><div class="l-rt-c"></div><div class="l-lb-c"></div><div class="l-rb-c"></div>
    <div class="filter-panel">
        <button class='filter-block-show'>%%adv_search%%</button>
        <div class="l-lb-c"></div><div class="l-lt-c"></div><div class="l-rt-c"></div><div class="l-rb-c"></div>
			<div class="filter-block-buttons" style="padding-left:15px;">
                <button id="icon_cancel" onclick="AMI.Page.doModuleAction('##_mod_id##', '##_component_id##', 'filter_reset', AMI.$('#ami_form_filter_##_component_id##')[0]);">%%reset%%</button>
				<button id="icon_filter" onclick="document.getElementById('ami_form_filter_##_component_id##').onsubmit();return false;">%%apply%%</button>
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
    
</div>##path##


<script type="text/javascript">
        if ($(".flt_form > .flt_element > *:[name!='mod_id']").length < 2) {
            $(".filter-block-show").hide();
        } else {
            $(".flt_form > .flt_element[style!='display: none']").addClass("flt_element_hide");
            $(".flt_element:eq(0), .flt_element:eq(1)").removeClass("flt_element_hide");            
        }
        

        $("#filter-box").addClass("filter-block-small");
    
        (function() {
            var cookieData = AMI.Cookie.get('flt_full') ? JSON.parse(AMI.Cookie.get('flt_full')) : {};
            $(".filter-block-show").click(function() {
                if ($(this).text() == "%%adv_search%%") {
                    $("#filter-box").removeClass("filter-block-small");
                    $(".flt_element").removeClass("flt_element_hide").addClass("flt_element_show");
                    $(this).text("%%collapse_search%%");
                    cookieData[window.module_name] = true;
                } else {
                    $("#filter-box").addClass("filter-block-small");
                    $(".flt_form > .flt_element[style!='display: none']").removeClass("flt_element_show").addClass("flt_element_hide");
                    $(".flt_element:eq(0), .flt_element:eq(1)").removeClass("flt_element_hide");
                    $(this).text("%%adv_search%%");
                    delete cookieData[window.module_name];
                }
                AMI.Cookie.set('flt_full', JSON.stringify(cookieData), 3600 * 24 * 30, AMI.Cookie.getModPath(), true);
            });
            if(!!cookieData[window.module_name]) {
                $(".filter-block-show").click();
            }
        })();
</script>



"-->

<!--#set var="path" value="<div class="cat-path" id="path_##_component_id##">##path##</div>"-->

<!--#set var="path_splitter" value=" |&nbsp;"-->
