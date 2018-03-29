##--!ver=0200 rules="-SETVAR|+IF"--##
%%include_language "templates/lang/filter.lng"%%

<div class="filter-block" id="filter-box">
  <div class="l-lt-c"></div><div class="l-rt-c"></div><div class="l-lb-c"></div><div class="l-rb-c"></div>
  ##IF(script_link!="srv_options.php")##
  <div class="filter-panel">
    <button class='filter-block-show'>%%adv_search%%</button>
    <div class="l-lb-c"></div><div class="l-lt-c"></div><div class="l-rt-c"></div><div class="l-rb-c"></div>
    <div class="filter-block-buttons" style="padding-left:15px;">

      <button id="icon_cancel" onclick="_reset_filter = true; fireEvent2(document.forms[_cms_filter_form], 'submit'); document.forms[_cms_filter_form].submit();">%%rst_filter%%</button>
      <button id="icon_filter" onclick="fireEvent2(document.forms[_cms_filter_form], 'submit'); document.forms[_cms_filter_form].submit();">%%appl_filter%%</button>
      
     </div>
  </div>
  ##ENDIF##
  <div class="filter_box" style="padding: 10px 100px 10px 10px;">
      <div class="flt-block">
      ##content##
      </div>
      ##IF(script_link=="srv_options.php")##
      <div align="right" valign="middle" style="padding-right:12px;" class=flt-block><nobr><span id="common_settings_link"></span></nobr>
      </div>
      ##ENDIF##
  </div>
    
</div>



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


