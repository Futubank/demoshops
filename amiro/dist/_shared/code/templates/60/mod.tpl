%%include_language "templates/lang/60/pagination.lng"%%
%%include_language "templates/lang/60/client.lng"%%
            <div id="status-block" class="status-block"##if (status=='')## style="display:none" ##endif##>
                <div id="status-msgs" class="status-msgs">##status##</div>
            </div>
<div id="calendar_block" style="display:none;position:absolute;background-color:#f8f8f8;width:220px;height:345px;z-index:1000;"><table border="0" cellpadding="0" cellspacing="0" width=100% height=100%><tr><td style="padding:0px;"><iframe id="calendar_block_frm" width=100% height=100% src="calendar.php" frameborder=0 scrolling=no></iframe></td></tr></table></div>
<div id="module_##mod_id##" class="modPageArea">
    <div style="height: 0px; overflow: hidden">&nbsp;</div><!-- DO NOT REMOVE! IE will not show table without this nbps -->
    <script type="text/amiro-template" id="amiTplList_##mod_id##"><!--
	<div id="paga">
	        <div class="paginationSize">
            <span>%%page_size%%:</span>
            <select name="limit" class="pagination-select" onChange="AMI.Page.doModuleAction('##mod_id##', '@@componentId@@', 'changePageNumber', this);">
                <option value="10" selected>10</option>
                <option value="15">15</option>
                <option value="25">25</option>
                <option value="50">50</option>
                <option value="75">75</option>
                <option value="100">100</option>
                <option value="200">200</option>
            </select>
            <div class="refreshListButton" onclick="AMI.Page.getModule('##mod_id##').reloadList(AMI.Page.getComponent('@@componentId@@'));"></div>
        </div>
        <div class="pagination"></div>
	</div>

        <table class="componentList" cellspacing="0" id="moduleList_@@componentId@@"></table>
    --></script>

    <script type="text/amiro-template" id="amiTplListSort_##mod_id##"><!--<a href="" class="list-header-icon sortAsc@@if(selected_asc)@@Sel@@endif@@" title="%%list_icon_sort_asc%%"><div data-ami-action="list_sort" data-ami-parameters="sort_column=@@column@@&sort_dir=asc" class="amiModuleLink"></div></a><a href="" class="list-header-icon sortDesc@@if(selected_desc)@@Sel@@endif@@" title="%%list_icon_sort_desc%%"><div data-ami-action="list_sort" data-ami-parameters="sort_column=@@column@@&sort_dir=desc" class="amiModuleLink"></div></a>--></script>
    <script type="text/amiro-template" id="amiTplListSortPosition_##mod_id##"><!--<a href="" class="list-header-icon sortAsc@@if(selected_asc)@@Sel@@endif@@" title="%%list_icon_sort_asc%%"><div data-ami-action="list_sort" data-ami-parameters="sort_column=@@column@@&sort_dir=asc" class="amiModuleLink"></div></a>--></script>
    <script type="text/amiro-template" id="amiTplListFirst_##mod_id##"><!--<a href="" data-ami-action="gotoPage" data-ami-parameters="offset=0" class="amiModuleLink">1</a> ...--></script>
    <script type="text/amiro-template" id="amiTplListLast_##mod_id##"><!--... <a href="" data-ami-action="gotoPage" data-ami-parameters="offset=@@offset@@" class="amiModuleLink">@@page@@</a>--></script>
    <script type="text/amiro-template" id="amiTplListPrev_##mod_id##"><!--<a href="" data-ami-action="gotoPage" data-ami-parameters="offset=@@offset@@" class="amiModuleLink">&laquo;</a>--></script>
    <script type="text/amiro-template" id="amiTplListNext_##mod_id##"><!--<a href="" data-ami-action="gotoPage" data-ami-parameters="offset=@@offset@@" class="amiModuleLink">&raquo;</a>--></script>
    <script type="text/amiro-template" id="amiTplListActive_##mod_id##"><!--<span title="%%active%%">@@page@@</span>--></script>
    <script type="text/amiro-template" id="amiTplListPage_##mod_id##"><!--<a href="" data-ami-action="gotoPage" data-ami-parameters="offset=@@offset@@" class="amiModuleLink">@@page@@</a>--></script>
    <script type="text/amiro-template" id="amiTplListSplitter_##mod_id##"><!--&nbsp;--></script>

    <script type="text/amiro-template" id="amiTplListActionColumn_##mod_id##"><!--<a href="" class="list-icon icon-@@if(enabled == 0)@@disabled-@@endif@@@@value@@" title="@@title@@"><div data-ami-action="list_@@if(enabled == 1)@@un_@@endif@@@@value@@" data-ami-parameters="id=@@id@@@@if(ami_full)@@&ami_full=1@@endif@@" class="amiModuleLink"@@if(style)@@ style="@@style@@"@@endif@@></div></a>--></script>

    <script type="text/amiro-template" id="amiTplListPosition"><!--
        <nobr>
        @@number@@
        <span data-ami-action="move_position" data-ami-parameters="id=@@id@@" class="amiModuleLink posItem">
            <img src="_mod_files/60/images/spacer.gif" @@if(isFirst)@@data-ami-action="positionIsFirst"@@else@@data-ami-action="list_move_top" data-ami-parameters="id=@@id@@"@@endif@@ class="amiModuleLink posLeftTop" title="%%position_move_top%%"><img src="_mod_files/60/images/spacer.gif" @@if(isFirst)@@data-ami-action="positionIsFirst"@@else@@data-ami-action="list_move_up" data-ami-parameters="id=@@id@@"@@endif@@ class="amiModuleLink posRightTop" title="%%position_move_up%%"><br>
            <img src="_mod_files/60/images/spacer.gif" @@if(isLast)@@data-ami-action="positionIsLast"@@else@@data-ami-action="list_move_bottom" data-ami-parameters="id=@@id@@"@@endif@@ class="amiModuleLink posLeftBottom" title="%%position_move_bottom%%"><img src="_mod_files/60/images/spacer.gif" @@if(isLast)@@data-ami-action="positionIsLast"@@else@@data-ami-action="list_move_down" data-ami-parameters="id=@@id@@"@@endif@@ class="amiModuleLink posRightBottom" title="%%position_move_down%%">
        </span>
        </nobr>
    --></script>

    <script type="text/amiro-template" id="amiTplListPositionInactive"><!--
        <span><img src="_mod_files/60/icons/icon-pos_control_dis.gif" width="19" height="19" style="cursor: pointer;" class="amiModuleLink" data-ami-action="positionInactive" /></span>
    --></script>

    <script type="text/amiro-template" id="amiTplUnsupportedBrowser"><!--
    <p>%%browser_not_valid%%</p>
    ##IF(active_lang=="ru")##
    <p><a href="http://www.amiro.ru/product/amiro.cms/tech-req">%%compatible_browser_list%%</a>.</p>
    ##ENDIF##
    --></script>

    <script type="text/javascript">
        if(browserDetector.isValid){
            AMI.Message.addListener('ON_ADD_NEW_GROUP_CONTROL', function(opeartionName, oCustomData){
                if(opeartionName == 'grp_id_page'){
                    oCustomData.oControl = document.createElement('SPAN');
                    oCustomData.oControl.innerHTML = '\
                        <nobr>\
                        <select name="grp_type">\
                            <option value="move">' + AMI.Template.Locale.get('grp_move_items') + '</option>\
                            <option value="copy">' + AMI.Template.Locale.get('grp_copy_items') + '</option>\
                        </select>\
                        ' + AMI.Template.Locale.get('grp_popup_on_page') + ':&nbsp;\
                    ';

                    var aFilterPages = document.getElementsByName('id_page');
                    if(aFilterPages.length > 0){
                        var oClone = aFilterPages[0].cloneNode(true);
                        oClone.options[1] = null;
                        oClone.options[0].value = 0;
                        oClone.selectedIndex = 0;
                        oClone.name = 'grp_id_page';
                        oCustomData.oControl.appendChild(oClone);
                    }

                    oCustomData.oControl.appendChild(document.createTextNode(' '));

                    var oButton = AMI.Browser.DOM.create('INPUT', '', 'but-short', 'margin-left: 4px;');
                    oButton.type = 'button';
                    oButton.value = 'OK';
                    AMI.Browser.Event.addHandler(oButton, 'click', function(_this, _operationName){return function(evt){if(_this.onGroupOperationClick(evt, _operationName)){alert('Page moving following!')}}}(oCustomData.oComponent, opeartionName));
                    oCustomData.oControl.appendChild(oButton);

                    return false;
                }
                return true;
            });

            AMI.Template.Locale.init({##js_locales##});
            var oModule = new AMI.Module(
                '##mod_id##',
                {##mod_components##}
            );
            AMI.Page.registerModule(oModule);

            if(typeof(moduleInitialization) == 'function'){
                moduleInitialization();
            }

        }else{
            AMI.find('#module_##mod_id##').innerHTML = AMI.Template.getTemplate('amiTplUnsupportedBrowser');
        }
##--
        AMI.Browser.Event.addHandler(window, 'load', function(){
            if(!browserDetector.isValid){
                alert();
            }
        });
--##
    </script>

</div>