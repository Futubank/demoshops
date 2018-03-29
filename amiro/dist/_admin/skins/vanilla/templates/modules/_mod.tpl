##--system info: module_owner="" module="" system="1"--##
%%include_language "templates/lang/modules/_client.lng"%%
%%include_language "templates/lang/modules/_pagination.lng"%%

<div id="module_##mod_id##" class="modPageArea">
    <div style="height: 0px; overflow: hidden">&nbsp;</div><!-- DO NOT REMOVE! IE will not show table without this nbps -->
    <script type="text/amiro-template" id="amiTplList_##mod_id##"><!--
   	<div id="paga">
            <div id="add_new_button" class="icon_button_add" style="visibility: hidden"><a href="#" onClick="AMI.Page.doModuleAction('##mod_id##', '@@componentId@@', 'form_reset', {isListAddButton:true}); return false;"><span class="text_button">##list_add_new_button##</span><img class="icon" align="absmiddle" src="skins/vanilla/icons/icon-add.gif"></a></div>
	        <div class="paginationSize">
            <span>%%page_size%%:</span>
            <select name="limit" class="pagination-select" onChange="AMI.Page.doModuleAction('##mod_id##', '@@componentId@@', 'changePageNumber', this);">
##--                <option value="1">1</option>--##
                <option value="5">5</option>
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
        <span data-ami-action="move_position" data-ami-parameters="id=@@id@@&ami_full=1" class="amiModuleLink posItem">
            <img src="skins/vanilla/images/spacer.gif" @@if(isFirst)@@data-ami-action="positionIsFirst"@@else@@data-ami-action="list_move_top" data-ami-parameters="id=@@id@@&ami_full=1"@@endif@@ class="amiModuleLink posLeftTop" title="%%position_move_top%%"><img src="skins/vanilla/images/spacer.gif" @@if(isFirst)@@data-ami-action="positionIsFirst"@@else@@data-ami-action="list_move_up" data-ami-parameters="id=@@id@@&ami_full=1"@@endif@@ class="amiModuleLink posRightTop" title="%%position_move_up%%"><br>
            <img src="skins/vanilla/images/spacer.gif" @@if(isLast)@@data-ami-action="positionIsLast"@@else@@data-ami-action="list_move_bottom" data-ami-parameters="id=@@id@@&ami_full=1"@@endif@@ class="amiModuleLink posLeftBottom" title="%%position_move_bottom%%"><img src="skins/vanilla/images/spacer.gif" @@if(isLast)@@data-ami-action="positionIsLast"@@else@@data-ami-action="list_move_down" data-ami-parameters="id=@@id@@&ami_full=1"@@endif@@ class="amiModuleLink posRightBottom" title="%%position_move_down%%">
        </span>
        </nobr>
    --></script>

    <script type="text/amiro-template" id="amiTplListPositionInactive"><!--
        <span><img src="skins/vanilla/icons/icon-pos_control_dis.gif" width="19" height="19" style="cursor: pointer;" class="amiModuleLink" data-ami-action="positionInactive" /></span>
    --></script>

    <script type="text/amiro-template" id="amiTplUnsupportedBrowser"><!--
    <p>%%browser_not_valid%%</p>
    ##IF(active_lang=="ru")##
    <p><a href="http://www.amiro.ru/product/amiro.cms/tech-req">%%compatible_browser_list%%</a>.</p>
    ##ENDIF##
    --></script>

    <script type="text/javascript">
        if(browserDetector.isValid){
            // send all modules get params to a component
            AMI.Message.addListener('ON_COMPONENT_GET_REQUEST_DATA', function(oComponent, oParameters){
                var fullQString = window.location.search.substring(1);
                var paramArray = fullQString.split("&");
                for (i=0;i<paramArray.length;i++){
                    var currentParameter = paramArray[i].split("=");
                    if(currentParameter[0] != undefined){
                        if(oParameters[currentParameter[0]] == undefined){
                            oParameters[currentParameter[0]] = currentParameter[1];
                        }
                    }
                }
                return true;
            });

            AMI.Message.addListener('ON_MODULE_ACTION', function(action, oData){
                if(action == 'list_sort' && oData.oParameters.sort_column){
                    oData.oComponent.setGrpPosActionVisibility(oData.oParameters.sort_column == 'position');
                }

                return true;
            });

            AMI.Message.addListener('ON_COMPONENT_CONTENT_PLACED', function(oComponent, oData){
                if(oComponent.componentType == 'list'){
                    var
                        oHashValues = AMI.Page.getHashData(oComponent.getModuleId()),
                        sortColumn = typeof(oHashValues.sort_column) != 'undefined' ? oHashValues.sort_column : '';

                    if(!sortColumn && typeof(serverCookies[oComponent.componentId + '_order_column']) != 'undefined'){
                        sortColumn = serverCookies[oComponent.componentId + '_order_column'];
                    }

                    oComponent.setGrpPosActionVisibility(sortColumn == 'position');
                }
                return true;
            });

            AMI.Template.Locale.init({##js_locales##});
            var oModule = new AMI.Module(
                '##mod_id##',
                {##mod_components##}
            );
            AMI.Page.registerModule(oModule);
        }else{
            AMI.find('#module_##mod_id##').innerHTML = AMI.Template.getTemplate('amiTplUnsupportedBrowser');
        }
    </script>
</div>