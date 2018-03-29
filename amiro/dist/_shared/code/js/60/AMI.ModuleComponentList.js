/**
* @fileOverview File contains AMI.ModuleComponentList class that creates list and manages its actions.
*/

/**
* Class of list component inhertited from AMI.ModuleComponent that contais a set of methods for list creating and reloading. Class contains list highlighting methods as well.
*
* @class List component class.
* @param {AMI.Module} oModule Module object.
* @param {string} componentType Type of component (filter_form, form, list).
* @param {bool} fullEnv  Flag specifying always full environment mode.
* @param {string} componentId Id of current component.
*/
AMI.ModuleComponentList = function(oModule, componentType, fullEnv, componentId){
    AMI.ModuleComponentForm.superclass.constructor.call(this, oModule, componentType, fullEnv, componentId);
    this.componentType = componentType;
    this.defaultEnvMode = fullEnv;
    this.modAction = 'list_view';
    this.itemCount = -1;

    this.oList = null;
    this.oListData = null;
    this.overridenOffset = null;
    this.aColumns = [];
    this.templateListColumns = {};
    this.aRowsToCheckOnLoad = {};

    this.oGroupIdAll = null;
    this.aGroupIdCheckboxes = [];
    this.oGroupBlock = null;
    this.oGroupCounter = null;

    /**
    * Default columns width. Could be overriden in child.
    */
    this.columnsWidthByType = {
        'group_checkboxes': '30px',
        'array_actions':    '30px',
        'action':           '30px'
    }

    this.actionIconCSS = {};

    this.aFullEnvActions = [];
    this.ami_full = false;

    /**
     * LIST ACTIONS
     */

    // Reload list action
    this.addAction('list_view', function(oComponent, oParameters){
        for(var key in oParameters){
            if((typeof(oComponent[key]) == 'undefined') || (typeof(oComponent[key]) != 'function') || (typeof(oComponent[key]) != 'object')){
                oComponent[key] = oParameters[key];
            }
        }
        oComponent.modActionId = '';
        oComponent.modAction = 'list_view';
        oComponent.getContent();
        return true;
    },
    false);

    // Forward action to form
    this.addAction('form_reset', function(oComponent, oParameters){
        var formId = '';
        var forms = oComponent.oModule.getComponentsByType('form');
        if(forms && forms.length){
            formId = forms[0].componentId;
        }
        if(formId){
            AMI.Page.doModuleAction(oComponent.getModuleId(), formId, 'form_reset', oParameters)
        }
        return true;
    },
    false);

    // Prohibit a mouse click between position icons, which causes a bug
    this.addAction('move_position', function(oComponent, oParameters){
        return true;
    },
    false);

    // Change number of items on the list page
    this.addAction('changePageNumber', function(oComponent, oParameters){
        oParameters.offset = 0;
        oComponent.addHashData(oParameters);
        oComponent.modAction = 'list_view';
        oComponent.getContent();
        return true;
    },
    false);

    // Jump to a page number
    this.addAction('gotoPage', function(oComponent, oParameters){
        oParameters.calc_found_rows = 0;
        oComponent.addHashData(oParameters);
        oComponent.modAction = 'list_view';
        oComponent.getContent();
        return true;
    },
    false);

    // Edit item
    this.addAction('list_edit', function(oComponent, oParameters){
        oComponent.setRowClassById(oParameters.id, 'onedit');
        oComponent.modActionId = oParameters.id;
        oParameters.action = 'list_edit';
        oComponent.oModule.openEditForm(oParameters, false, true);
        return true;
    });

    // Show item
    this.addAction('list_show', function(oComponent, oParameters){
        oComponent.setRowClassById(oParameters.id, 'onedit');
        oComponent.modActionId = oParameters.id;
        oParameters.action = 'list_show';
        oComponent.oModule.openEditForm(oParameters, false, false);
        return true;
    });

    // Delete item
    this.addAction('list_delete', function(oComponent, oParameters){
        if(confirm(AMI.Template.Locale.get('list_confirm_deletion'))){
            oComponent.ami_full = 1;
            oComponent.modAction = 'list_delete';
            oComponent.modActionId = oParameters.id;
            oComponent.addHashData(oParameters);
            oComponent.getContent();
            oParameters.id = '';
            oComponent.oModule.openEditForm(oParameters, true);
            oComponent.modAction = 'list_view';
        }
        return true;
    });

    // Copy item
    this.addAction('list_copy', function(oComponent, oParameters){
        if(confirm(AMI.Template.Locale.get('list_confirm_copy'))){
            oComponent.ami_full = 1;
            oComponent.modAction = 'list_copy';
            oComponent.modActionId = oParameters.id;
            oComponent.addHashData(oParameters);
            oComponent.getContent();
            oComponent.modAction = 'list_view';
        }
        return true;
    });

    // Sort list
    this.addAction('list_sort', function(oComponent, oParameters){
        oParameters.calc_found_rows = 0;
        var oSortControl = oComponent.oTarget.parentNode;
        if(oSortControl.className.match(/ sort(Asc|Desc)Sel/)){
            // don't sort by already selected way
            oSortControl.blur();
            return true;
        }
        var aElems = AMI.$('#moduleList_' + oComponent.componentId + ' .sort');
        var aClasses = {'sortAscSel': 'sortAsc', 'sortDescSel': 'sortDesc'};

        for(var i = 0; i < aElems.length; i++){
            AMI.removeClass(aElems[i], 'sort');
        }
        // TH class
        AMI.addClass(oSortControl.parentNode, 'sort');

        for(var className in aClasses){
            var
                newClass = aClasses[className],
                aElems = AMI.$('#moduleList_' + oComponent.componentId + ' .' + className);
            for(var j = 0; j < aElems.length; j++){
                aElems[j].className = aElems[j].className.replace(' ' + className, ' ' + newClass);
            }
        }
        oSortControl.className =
            oSortControl.className.replace(/ sort[\w]+/, '') +
            ' sort' +
            (oParameters.sort_dir == 'asc' ? 'Asc' : 'Desc') +
            'Sel';

        AMI.Page.Status.hide();
        oComponent.oModule.addHashDataAndReloadList(oComponent, oParameters);
        oSortControl.blur();
        return true;
    },
    false);

    // Position warning
    this.addAction('positionInactive', function(oComponent, oParameters){
        alert(AMI.Template.Locale.get('position_warn_positionInactive'));
        return true;
    },
    false);

    // Position warning
    this.addAction('positionIsFirst', function(oComponent, oParameters){
        alert(AMI.Template.Locale.get('position_warn_positionIsFirst'));
        return true;
    },
    false);

    // Position warning
    this.addAction('positionIsLast', function(oComponent, oParameters){
        alert(AMI.Template.Locale.get('position_warn_positionIsLast'));
        return true;
    },
    false);

    // Group action
    this.addAction('group_action', function(oComponent, oParameters){
        switch(oParameters.action){
            case 'grp_move_position':
                oComponent.grp_move_position = oParameters.grp_move_position;
                oComponent.grp_move_position_index = oParameters.grp_move_position_index;
                break;
            case 'grp_id_page':
                oComponent.grp_operation = oParameters.grp_operation;
                oComponent.grp_page = oParameters.grp_page;
                oComponent.calc_found_rows = oParameters.calc_found_rows;
                break;
            case 'grp_id_cat':
                oComponent.grp_operation = oParameters.grp_operation;
                oComponent.grp_id_cat = oParameters.grp_id_cat;
                oComponent.calc_found_rows = oParameters.calc_found_rows;
                break;
        }
        oComponent.ami_full = oParameters.ami_full;
        oComponent.onGroupAction(oComponent.oModule, oParameters);

        if(oParameters.action == 'grp_import'){
            oComponent.skipEditor = true;
        }
        oComponent.getContent();
        if((typeof(oComponent.skipEditor) == 'undefined') || !oComponent.skipEditor){
            if((typeof(oComponent.preserveFormElement) == 'undefined') || !oComponent.preserveFormElement){
                oParameters.id = '';
            }
            setTimeout(function(_oComponent, _oParameters){
                return function(){
                    _oComponent.oModule.openEditForm(_oParameters, true);
                }
            }(oComponent, oParameters), 300);
        }

        return true;
    });


    /**
    * Templates that are used to create list.
    */

    this.templates = {
        'list':     AMI.Template.getTemplate('amiTplList_' + this.getModuleId()),
        'sort':     AMI.Template.getTemplate('amiTplListSort_' + this.getModuleId()),
        'first':    AMI.Template.getTemplate('amiTplListFirst_' + this.getModuleId()),
        'last':     AMI.Template.getTemplate('amiTplListLast_' + this.getModuleId()),
        'prev':     AMI.Template.getTemplate('amiTplListPrev_' + this.getModuleId()),
        'next':     AMI.Template.getTemplate('amiTplListNext_' + this.getModuleId()),
        'active':   AMI.Template.getTemplate('amiTplListActive_' + this.getModuleId()),
        'page':     AMI.Template.getTemplate('amiTplListPage_' + this.getModuleId()),
        'splitter': AMI.Template.getTemplate('amiTplListSplitter_' + this.getModuleId())
    };
    this.templateListSortPosition = AMI.Template.getTemplate('amiTplListSortPosition_' + this.getModuleId());
    this.templateListPosition = AMI.Template.getTemplate('amiTplListPosition');
    this.templateListPositionInactive = AMI.Template.getTemplate('amiTplListPositionInactive');

    // AMI.Message.addListener('ON_AMI_GROUP_ACTION_ACTION', function(_this){return function(oModule, oParameters){_this.onGroupAction(oModule, oParameters)}}(this));

    AMI.Message.addListener('ON_AMI_LIST_SHOW_ADD_BUTTON', function(){
        if(document.getElementById("add_new_button")){
            document.getElementById("add_new_button").style.visibility = "visible";
            document.getElementById("add_new_button").style.display = "block";
        }
        return true;
    });

    /**
    * Create paginator and set its content to DOM element with class = "pagination". There are could be several elements with pagination class.
    *
    * @param {integer} itemCount Total number of items for current filter.
    * @returns {void}
    */
    this.setPaginationContent = function(itemCount){
        var
            maxPageCount = 5, // hardcode
            oHashValues = this.getHashData(),
            pageSize = typeof(oHashValues.limit) != 'undefined' ? parseInt(oHashValues.limit) : parseInt((AMI.Cookie.get(this.componentId + '_limit')) ? AMI.Cookie.get(this.componentId + '_limit') : 10),
            offset = typeof(oHashValues.offset) != 'undefined' ? parseInt(oHashValues.offset) : 0,
            pagination = '';

        if(this.itemCount < 0 || parseInt(itemCount) > 0){
            this.itemCount = itemCount;
        }

        if(typeof(this.overridenOffset) == 'number'){
            if(parseInt(itemCount) > 0){
                this.itemCount = itemCount;
            }

            offset = this.overridenOffset;
            this.overridenOffset = null;

            this.addHashData({'offset': offset});
        }

        itemCount = parseInt(this.itemCount);

        if(pageSize > 0 && itemCount > pageSize){
            var
                pagesCount = Math.ceil(itemCount / pageSize),
                visPagesCount = Math.min(maxPageCount, pagesCount),
                visMiddle = Math.ceil(visPagesCount / 2),
                activePage = Math.ceil(offset / pageSize),
                visStartPage = 0, visEndPage = -1,
                forceViewStartLink = false, forceViewEndLink = false,
                endLinkOffset = Math.min(pagesCount - 1, (pagesCount - 1) * pageSize),
                startOffset;

            if(pagesCount == 0){
                pagesCount = 1;
            }
            if(activePage >= (visStartPage + visMiddle)){
                visStartPage = activePage - visMiddle + 1;
            }
            if(visStartPage + visPagesCount > pagesCount){
                visStartPage = pagesCount - visPagesCount;
            }

            if(forceViewStartLink || (activePage > 0 && visStartPage > 0)){
                pagination +=
                    AMI.Template.parse(this.templates.first, {});
            }
            if(activePage > 0){
                pagination +=
                    AMI.Template.parse(this.templates.splitter, {}) +
                    AMI.Template.parse(this.templates.prev, {'offset': (activePage - 1) * pageSize});
            }
            for(var i = visStartPage; i < (visStartPage + visPagesCount); i++){
                startOffset = Math.min(itemCount - 1, i * pageSize);
                if(i == activePage){
                    pagination +=
                        AMI.Template.parse(this.templates.splitter, {}) +
                        AMI.Template.parse(this.templates.active, {'offset': startOffset, 'page': i + 1});
                }else{
                    pagination +=
                        AMI.Template.parse(this.templates.splitter, {}) +
                        AMI.Template.parse(this.templates.page, {'offset': startOffset, 'page': i + 1});
                }
            }
            visEndPage = i;

            if(activePage != (pagesCount - 1)){
                startOffset = Math.min(itemCount - 1, activePage * pageSize);
                pagination +=
                    AMI.Template.parse(this.templates.splitter, {}) +
                    AMI.Template.parse(this.templates.next, {'offset': startOffset + pageSize});
            }

            if(forceViewEndLink || (activePage < (pagesCount - 1)) && (visEndPage < pagesCount)){
                pagination +=
                    AMI.Template.parse(this.templates.splitter, {}) +
                    AMI.Template.parse(this.templates.last, {'offset': endLinkOffset * pageSize, 'page': pagesCount});
            }
        }

        // @todo: fix this hack
        var aPaginationBlocks = AMI.find('.pagination', this.oContainer);
        for(i = 0; i < aPaginationBlocks.length; i++){
            aPaginationBlocks[i].innerHTML = pagination;
        }

        if(typeof(oHashValues.limit) == 'undefined'){
            this.addHashData({limit: pageSize});
        }

        var aSizeBlocks = AMI.find('.pagination-select', this.oContainer);
        for(i = 0; i < aSizeBlocks.length; i++){
            for(var ii = 0; ii < aSizeBlocks[i].options.length; ii++){
                if(aSizeBlocks[i].options[ii].value == pageSize){
                    aSizeBlocks[i].options[ii].selected = true;
                    break;
                }
            }
        }
    }

    /**
    * Called when the component received data from server. Creates and draws list.
    *
    * @param {object} oData Data that was received from server.
    * @returns {void}
    */
    this.setBlockDataFromObject = function(oData){
        if(typeof(oData.data.listData.dataType) != 'undefined'){
            this.oListData = oData;
            var bInitTable = false;
            var aGroupActons = typeof(this.oListData.data.listGrpActions) != 'undefined' ? this.oListData.data.listGrpActions : [];
            this.aFullEnvActions = typeof(this.oListData.data.listFullEnvActions) != 'undefined' ? this.oListData.data.listFullEnvActions : [];
            if(this.oList == null){
                oTemplateData = {
                    'componentId': this.componentId
                }

                AMI.Browser.DOM.setInnerHTML(
                    this.oContainer,
                    AMI.Template.parse(this.templates.list, oTemplateData)
                );
                this.oList = AMI.find('#moduleList_' + this.componentId);
                AMI.$(this.oList).attr('data-helpid', 'list');
                bInitTable = true;
            }

            var bRedrawTableHeaders = false;
            if(!bInitTable){
                var aListColumns = [];
                for(key in this.oListData.data.listColumns){
                    if(this.oListData.data.listColumns[key].format != 'hidden'){
                        aListColumns[aListColumns.length] = key;
                    }
                }
                if(aListColumns.length && this.aColumns.length){
                    for(var i = 0; i < aListColumns.length; i++){
                        if(this.aColumns[i] != aListColumns[i]){
                            bRedrawTableHeaders = true;
                            break;
                        }
                    }
                }
            }

            if(this.oList != null){
                var
                    oHashValues = this.getHashData(),
                    listOffset = typeof(oHashValues.offset) != 'undefined' ? parseInt(oHashValues.offset) : 0,
                    currentSort = typeof(oHashValues.sort_column) != 'undefined' ? oHashValues.sort_column : '';

                if(!currentSort && typeof(serverCookies) != 'undefined' && typeof(serverCookies[this.componentId + '_order_column']) != 'undefined'){
                    currentSort = serverCookies[this.componentId + '_order_column'];
                }

                if(typeof(this.oListData.data.listData.offset) != 'undefined'){
                    listOffset = parseInt(this.oListData.data.listData.offset);
                    this.overridenOffset = listOffset;
                    delete this.oListData.data.listData.offset;
                }

                // TODO: create own class AMI.ModuleComponentListTable that will allow to set other list types such as DIV as well.

                if(bInitTable || bRedrawTableHeaders){
                    if(!bInitTable){ // drop current rows
                        oTR = this.oList.getElementsByTagName('TR');
                        for(i = oTR.length - 1; i >= 0; i--){
                            oTR.item(i).parentNode.removeChild(oTR.item(i));
                        }
                    }else{ // run plugin scripts
                        if(typeof(this.oListData.data.listData.scripts) != 'undefined'){
                            eval(this.oListData.data.listData.scripts);
                        }
                    }

                    var
                        sortCol = typeof(this.oListData.data.listData.sort) != 'undefined' ? this.oListData.data.listData.sort.col.replace(/^(.+?)\./g, '$1_') : '',
                        sortDir = typeof(this.oListData.data.listData.sort) != 'undefined' ? this.oListData.data.listData.sort.dir : '',
                        oTR = AMI.Browser.DOM.create('TR', '', '', '', this.oList);
                        oTR.setAttribute('id', 'data-ami-row-header');

                    if(aGroupActons.length > 0){
                        this.oGroupIdAll = AMI.Browser.DOM.create('input', '', '', '');
                        this.oGroupIdAll.setAttribute('type', 'checkbox');
                        this.oGroupIdAll = AMI.Browser.DOM.create('TH', '', 'listGroupIdAll', 'width: 30px;', oTR).appendChild(this.oGroupIdAll);

                        var self = this;
                        AMI.Browser.Event.addHandler(this.oGroupIdAll, 'click', function(evt){self.onGroupAllClicked(evt);});

                        if(bInitTable){
                            this.oGroupBlock = this.oList.parentNode.insertBefore(
                                    AMI.Browser.DOM.create('DIV', '', 'group_operations_panel', ''),
                                    this.oList.nextSibling
                            );
                            this.oGroupBlock.innerHTML = '\
                            <b>' + AMI.Template.Locale.get('group_num_checked') + '</b>\
                            <input type="text" name="_grp_num_checked" value="0" readonly style="text-align:right;" class="field field4">&nbsp;\
                            <span class="text_button">' + AMI.Template.Locale.get('grp_reset_all') + '</span> &nbsp;\
                            <span class="text_button">' + AMI.Template.Locale.get('grp_select_all') + '</span><br>\
                            <b>' + AMI.Template.Locale.get('group_operations') + '</b>\
                            ';
                            this.oGroupCounter = this.oGroupBlock.getElementsByTagName('input')[0];
                            AMI.Browser.Event.addHandler(
                                    this.oGroupBlock.getElementsByTagName('span')[0],
                                    'click',
                                    function(_this){return function(){_this.resetGroupRows()}}(this)
                            );
                            AMI.Browser.Event.addHandler(
                                    this.oGroupBlock.getElementsByTagName('span')[1],
                                    'click',
                                    function(_this){return function(){_this.checkGroupRows()}}(this)
                            );
                            
                            for(i = 0; i < aGroupActons.length; i++){
                                oNode = this.getGroupActionControl(aGroupActons[i]);
                                if(oNode != null){
                                    this.oGroupBlock.appendChild(oNode);
                                    this.oGroupBlock.appendChild(document.createTextNode(' '));
                                }
                            }
                        }
                    }

                    // Counting tensile columns width in percents:
                    /*
                    var iTensiles = 0;
                    for(key in this.oListData.data.listColumns){
                        if(this.oListData.data.listColumns[key].bTensile){
                            iTensiles++; // number of tensile columns
                        }
                    }
                    var iTensileWidth = iTensiles > 0 ? Math.ceil(100 / iTensiles) : 100;
                    */

                    this.aColumns = [];
                    for(key in this.oListData.data.listColumns){
                        var inlineStyle = '', columnFormat = null, className = '';

                        if(typeof(this.oListData.data.listColumns[key].format) != 'undefined'){
                            columnFormat = this.oListData.data.listColumns[key].format;
                        }

                        if(columnFormat == 'hidden') continue;

                        var
                            columnWidth = typeof(this.oListData.data.listColumns[key].bTensile) == 'undefined' || !this.oListData.data.listColumns[key].bTensile ? false : '*',
                            type = columnFormat != 'array' ? columnFormat : 'array_' + key;

                        if(key == 'position'){
                            columnWidth = this.columnsWidthByType['action'];
                        }
                        if(typeof(this.columnsWidthByType[type]) != 'undefined'){
                            columnWidth = this.columnsWidthByType[type];
                        }
                        if(key == 'actions'){
                            columnWidth = this.columnsWidthByType.array_actions;
                        }

                        this.aColumns.push(key);

                        className = 'listHeader_' + key;

                        if(columnFormat){
                            className += (' columnType-' + type);
                        }


                        var bTensile = false;
                        if(this.oListData.data.listColumns[key].bTensile){
                            className += ' columnLayout-width-auto';
                            bTensile = true;
                        }else{
                            if(columnWidth){
                                inlineStyle += 'min-width: ' + columnWidth + '; width: ' + columnWidth + ';';
                            }
                        }

                        var columnHeader = this.oListData.data.listColumns[key].caption == null ? key + ':undefined' : this.oListData.data.listColumns[key].caption;
                        if(typeof(this.oListData.data.listColumns[key].bSortable) != 'undefined' && this.oListData.data.listColumns[key].bSortable){
                            var isSortCol = (key == sortCol);
                            oTemplateData = {
                                    'column':        key,
                                    'selected_asc':  isSortCol && sortDir == 'asc',
                                    'selected_desc': isSortCol && sortDir == 'desc'
                            };
                            columnHeader += (columnHeader.length > 0 ? ' ' : '') + AMI.Template.parse(key == 'position' ? this.templateListSortPosition : this.templates.sort, oTemplateData);
                            //columnHeader += (columnHeader.length > 0 ? ' ' : '') + AMI.Template.parse(this.templates.sort, oTemplateData);
                            if(isSortCol){
                                className += ' sort';
                            }
                        }

                        if((typeof(this.oListData.data.listData.columnLayout[key]) != 'undefined') && !bTensile){
                            var aLayout = this.oListData.data.listData.columnLayout[key];
                            if(typeof(aLayout['width']) != 'undefined'){
                                className += (' columnLayout-width-' + aLayout['width']);
                            }
                        }

                        AMI.Browser.DOM.create('TH', '', className, inlineStyle, oTR).innerHTML = columnHeader;
                    }
                }else{
                    oTR = this.oList.getElementsByTagName('TR');
                    for(i = oTR.length - 1; i >= 1; i--){
                        oTR.item(i).parentNode.removeChild(oTR.item(i));
                    }
                }

                var totalNumberOfItems = this.oListData.data.listData.dataCount;
                this.setPaginationContent(totalNumberOfItems);

                if(!this.oListData.data.list.length){
                    oTR = AMI.Browser.DOM.create('TR', '', 'empty', '', this.oList);
                    oTD = AMI.Browser.DOM.create('TD', '', '', '', oTR);
                    oTD.style.height = "100px";
                    oTD.setAttribute('colspan', typeof(oTR.parentNode.rows[0]) != 'undefined' ? oTR.parentNode.rows[0].cells.length : 5);
                    oTD.innerHTML = AMI.Template.Locale.get('filter_is_empty');
                }
                this.aGroupIdCheckboxes = [];
                for(i = 0; i < this.oListData.data.list.length; i++){
                    var rowId = typeof(this.oListData.data.list[i].id) != 'undefined' ? this.oListData.data.list[i].id : 0;

                    // className = (i + 1) % 2 == 0 ? 'even' : 'odd';
                    // oTR = AMI.Browser.DOM.create('TR', '', className, '', this.oList);
                    oTR = AMI.Browser.DOM.create('TR', '', '', '', this.oList);
                    var oParameters = {
                        'row'  : oTR,
                        'data' : this.oListData.data.list[i]
                    };
                    AMI.Message.send('ON_AMI_LIST_ROW', this, oParameters);
                    oTR.setAttribute('data-ami-original-class', oTR.className);
                    oTR.setAttribute('data-ami-row-id', rowId);

                    if(aGroupActons.length > 0){
                        var oCheckbox = AMI.Browser.DOM.create('input', '', '', '');
                        oCheckbox.setAttribute('type', 'checkbox');
                        oCheckbox.setAttribute('value', rowId);
                        oCheckbox = AMI.Browser.DOM.create('TD', '', 'listGroupId', '', oTR).appendChild(oCheckbox);

                        AMI.Browser.Event.addHandler(oTR, 'click', function(_this, _oCheckbox){return function(evt){
                            var oTarget = AMI.Browser.Event.getTarget(evt);
                            if(oTarget == _oCheckbox || oTarget.tagName && oTarget.tagName != 'A' && !(oTarget.tagName == 'DIV' && oTarget.className != 'columnLayout-height-fixed') && oTarget.tagName != 'IMG'){
                                var bState = _oCheckbox == oTarget ? _oCheckbox.checked : !_oCheckbox.checked;
                                _this.checkRow(_oCheckbox, bState);
                            }
                        }}(this, oCheckbox));

                        if(typeof(this.aRowsToCheckOnLoad[rowId]) != 'undefined'){
                            oCheckbox.checked = true;
                            this.setRowClassById(rowId, 'onchecked', false);
                        }

                        this.aGroupIdCheckboxes.push(oCheckbox);
                    }

                    for(var ii = 0; ii < this.aColumns.length; ii++){
                        var value = this.oListData.data.list[i][this.aColumns[ii]];
                        inlineStyle = '';
                        var
                            oColStruct = this.oListData.data.listColumns[this.aColumns[ii]],
                            bColHasFormat = typeof(oColStruct.format) != 'undefined',
                            oTemplateData = {id: this.oListData.data.list[i]['id']};

                        if(bColHasFormat){
                            oTemplateData.value = oTemplateData.enabled = value;
                            if(value){
                                if(typeof(value.enabled) != 'undefined'){
                                    oTemplateData.enabled = value.enabled;
                                }
                                if(typeof(value.title) != 'undefined'){
                                    oTemplateData.title = value.title;
                                }
                            }
                            value = {
                                format: oColStruct.format,
                                value: value
                            };
                            if(this.aColumns[ii] == 'position'){
                                inlineStyle = 'text-align: center';
                            }
                        }
                        if(this.aColumns[ii] == 'actions' || (bColHasFormat && oColStruct.format == 'action')){
                            inlineStyle += ' white-space: nowrap; width: 0px;';
                        }
                        if(this.aColumns[ii] == 'position'){
                            oTemplateData.number = listOffset + i + 1;
                            oTemplateData.active = currentSort == 'position';
                            oTemplateData.isFirst = oTemplateData.number == 1;
                            oTemplateData.isLast = oTemplateData.number == totalNumberOfItems;
                        }
                        var columnName = this.aColumns[ii];
                        var className = 'listColumn_' + columnName;
                        if(bColHasFormat){
                            className += (' columnType-' + oColStruct.format);
                        }
                        if(typeof(this.oListData.data.listData.columnLayout[columnName]) != 'undefined'){
                            var aLayout = this.oListData.data.listData.columnLayout[columnName];
                            if(typeof(aLayout['align']) != 'undefined'){
                                className += (' columnLayout-align-' + aLayout['align']);
                            }
                            if(typeof(aLayout['class']) != 'undefined'){
                                className += (' ' + aLayout['class']);
                            }
                        }

                        var oTD = AMI.Browser.DOM.create('TD', '', className, inlineStyle, oTR);
                        if(bColHasFormat && (oColStruct.format == 'longtext')){
                             var oDIV = AMI.Browser.DOM.create('DIV', '', 'columnLayout-height-fixed', '', oTD);
                             oDIV.innerHTML = this.formatColumnContent(this.aColumns[ii], value, oTemplateData);
                        }else{
                            oTD.innerHTML = this.formatColumnContent(this.aColumns[ii], value, oTemplateData);
                        }
                    }
                }
                var hasFooter = false;
                for(var key in this.oListData.data.listFooter){
                    hasFooter = true;
                    break;
                }
                if(hasFooter){
                    var oTR = AMI.Browser.DOM.create('TR', '', '', '', this.oList);
                    oTR.setAttribute('id', 'data-ami-row-footer');
                    var oParameters = {
                        'row'  : oTR,
                        'data' : this.oListData.data.listFooter
                    };
                    AMI.Message.send('ON_AMI_LIST_ROW_FOOTER', this, oParameters);
                    if(aGroupActons.length > 0){
                        var oTD = AMI.Browser.DOM.create('TD', '', '', '', oTR);
                    }
                    var aListData = this.oListData.data.listColumns;
                    for(var col in aListData){
                        if((typeof(aListData[col].format) != 'undefined') && (aListData[col].format != 'hidden')){
                            var oTD = AMI.Browser.DOM.create('TD', '', '', '', oTR);
                            if(typeof(this.oListData.data.listFooter[col]) != 'undefined' && typeof(this.oListData.data.listFooter[col].caption) != 'undefined'){
                                oTD.innerHTML = this.oListData.data.listFooter[col].caption;
                            }
                        }
                    }
                }

                if(aGroupActons.length > 0){
                    this.updateCheckedRowsCounter();
                    this.oGroupBlock.style.display = this.oListData.data.list.length > 0 ? 'block' : 'none';
                }else if(this.oGroupBlock != null){
                    this.oGroupBlock.style.display = 'none';
                }
                if(this.oGroupIdAll != null){
                    this.oGroupIdAll.checked = false;
                }
                this.aRowsToCheckOnLoad = {};
            }
        }else if(oData.data.listData.dataType == 'html'){
            AMI.Browser.DOM.setInnerHTML(this.oContainer, oData.data.listHTML);
        }else{
            AMI.Browser.DOM.setInnerHTML(this.oContainer, '');
        }

        AMI.Message.send('ON_PAGES_ELEMENT_NEEDED', this, {});
        AMI.Message.send('ON_CATS_ELEMENT_NEEDED', this, {});
    }

    /**
    * Get template for cell by column name and column type.
    *
    * @param {string} columnName Name of the column, parameter of array returned from server.
    * @param {string} columnType Type (format) of the column.
    * @returns {string} Template for requested cell.
    */
    this.getColumnTemplate = function(columnName, columnType){

        var templateName = 'amiTplListColumn_' + columnName + '_' + this.getModuleId();
        if(typeof(this.templateListColumns[templateName]) == 'undefined'){
            if(columnType){
                columnType = columnType.slice(0,1).toUpperCase() + columnType.slice(1);
                templateName = 'amiTplList' + columnType + 'Column_' + this.getModuleId();
            }
            this.templateListColumns[templateName] = AMI.Template.getTemplate(templateName);
        }
        return this.templateListColumns[templateName];
    }

    /**
    * Formats cell content by field type.
    *
    * @param {string} columnName Name of column for current cell.
    * @param {mixed} content Object or string with cell content. If it is object content.format should be exist.
    * @param {object} oTemplateData current data for cell template. Custom variables should be added to this object.
    * @returns {string} Content of the cell.
    */
    this.formatColumnContent = function(columnName, content, oTemplateData){

        if(typeof(content) != 'undefined' && typeof(content.format) != 'undefined'){
            // Prepare special cells
            switch(content.format){
                case 'action':
                    if(typeof(this.actionIconCSS[columnName]) == 'undefined'){
                        this.actionIconCSS[columnName] = null;
                        var aClasses = AMI.Browser.DOM.findCSSClass('icon-' + columnName);
                        if(aClasses.length == 0){
                            this.actionIconCSS[columnName] = 'background: url(' + editorBaseHref  + '_local/_admin/images/' + this.getModuleId() + '/icon-' + columnName + '.png) no-repeat';
                        }
                    }
                    oTemplateData.style = this.actionIconCSS[columnName];
                    oTemplateData.value = columnName;
                    oTemplateData.ami_full = this.aFullEnvActions.indexOf(columnName) >= 0;
                    if((columnName == 'archive') && !oTemplateData.ami_full){
                        oTemplateData.title = AMI.Template.Locale.get('archive_' + (oTemplateData.enabled ? 'on' : 'off'));
                        oTemplateData.style = 'cursor: auto;';
                    }
                    content = AMI.Template.parse(this.getColumnTemplate(columnName, content.format), oTemplateData);
                    break;
                case 'object':
                    var tmpContent = '';
                    for(var k in content.value){
                        oTemplateData.title = content.value[k].title ? content.value[k].title : '';
                        tmpContent += this.formatColumnContent(content.value[k].value, content.value[k], oTemplateData);
                    }
                    content = tmpContent;
                    break;
                case 'array':
                    var tmpContent = '';
                    for(var k = 0; k < content.value.length; k++){
                        oTemplateData.title = content.value[k].title ? content.value[k].title : '';
                        tmpContent += this.formatColumnContent(content.value[k].value, content.value[k], oTemplateData);
                    }
                    content = tmpContent;
                    break;
                default:
                    if(columnName == 'position'){
                        content = AMI.Template.parse(oTemplateData.active ? this.templateListPosition : this.templateListPositionInactive, oTemplateData);
                    }else{
                        content = typeof(content.value) != 'undefined'? content.value : '';
                    }
                    break;
            }
        }else{
            content = content == null ? '' : content;
        }

        return content;
    }

    /**
    * Returns the control object that will be appended to group operations block.
    *
    * @param {string} oprationName  Name of group operation, group action will be called with the same name.
    * @returns {object} DOM object with group operation control that will be appended to group block or null if append nothing.
    */
    this.getGroupActionControl = function(operationName){
        var oControl = null;
        if(AMI.Message.send('ON_ADD_NEW_GROUP_CONTROL', operationName, oCustomData = {'oComponent': this})){
            if(operationName == 'grp_|'){
                oControl = AMI.Browser.DOM.create('SPAN', '', 'list-group-delimiter');
                oControl.innerHTML = '&nbsp;|&nbsp;';
            }else if(operationName != 'grp_repair' && operationName != 'grp_move_position' && operationName != 'grp_id_page' && operationName != 'grp_id_cat' && operationName != 'grp_import'){
                var buttonStyle = '';
                var aClasses = AMI.Browser.DOM.findCSSClass('icon-' + operationName);
                if(aClasses.length == 0){
                    buttonStyle = 'background: url(' + editorBaseHref  + '_local/_admin/images/' + this.getModuleId() + '/icon-' + operationName + '.png) no-repeat';
                }
                oControl = AMI.Browser.DOM.create('A', '', 'list-icon list-icon-group icon-' + operationName, '');
                oControl.setAttribute('href', 'javascript:void(0)');
                oControl.innerHTML = '<div title="' + AMI.Template.Locale.get('list_action_' + operationName) + '" class="amiModuleLink"' + (buttonStyle != '' ? ' style="' + buttonStyle + '"' : '') + ' data-ami-action="group_action" data-ami-parameters="action=' + operationName + (this.aFullEnvActions.indexOf(operationName) >= 0 ? '&ami_full=1' : '') + '"></div>';
                AMI.Browser.Event.addHandler(oControl, 'click', function(_this, _operationName){return function(evt){_this.onGroupOperationClick(evt, _operationName)}}(this, operationName));
            }else if(operationName == 'grp_move_position'){
                oControl = document.createElement('SPAN');
                oControl.id = 'span_grp_move_position_' + this.componentId;
                oControl.innerHTML = '\
                    <nobr>\
                    ' + AMI.Template.Locale.get('grp_move_position') + '&nbsp;\
                    <select id="grpMovePosition" name="grp_move_position" onChange="var oMovePositionDiv = AMI.find(\'#move_position_div\'); if(this.selectedIndex == 2){oMovePositionDiv.style.display=\'inline\'}else{oMovePositionDiv.style.display=\'none\'}">\
                        <option value="move_top">' + AMI.Template.Locale.get('grp_move_position_top') + '</option>\
                        <option value="move_bottom">' + AMI.Template.Locale.get('grp_move_position_bottom') + '</option>\
                        <option value="move_after">' + AMI.Template.Locale.get('grp_move_position_custom') + '</option>\
                    </select>\
                    <div id="move_position_div" style="display: none;">\
                        &nbsp;<input class="field field3" type="text" name="grp_move_position_index">\
                    </div>\
                ';
                var oButton = AMI.Browser.DOM.create('INPUT', '', 'amiModuleLink but-short', 'margin-left: 4px;');
                oButton.type = 'button';
                oButton.value = 'OK';
                oButton.setAttribute('data-ami-action', 'group_action');
                oButton.setAttribute('data-ami-parameters', 'action=' + operationName + (this.aFullEnvActions.indexOf(operationName) >= 0 ? '&ami_full=1' : ''));
                AMI.Browser.Event.addHandler(oButton, 'click', function(_this, _operationName, _oButton){return function(evt){
                    var oSelect = AMI.find('#grpMovePosition');
                    if(AMI.$(oSelect).attr('disabled')){
                        alert(AMI.Template.Locale.get('position_warn_positionInactive'));
                        evt.stopPropagation();
                        return true;
                    }
                    var oInput = AMI.find('#move_position_div').getElementsByTagName('INPUT')[0];
                    var parameters = _oButton.getAttribute('data-ami-parameters');
                    parameters += '&ami_full=1&grp_move_position=' + oSelect.value;
                    parameters += '&grp_move_position_index=' + oInput.value;
                    _oButton.setAttribute('data-ami-parameters', parameters);
                    _this.onGroupOperationClick(evt, _operationName);
                }}(this, operationName, oButton));
                AMI.Message.addListener('ON_AMI_GROUP_OPERATION', function(oComponent, oParameters){
                    var oSelect = AMI.find('#grpMovePosition');
                    var oInput = AMI.find('#move_position_div').getElementsByTagName('INPUT')[0];
                    if(oSelect.selectedIndex == 2 && (isNaN(parseInt(oInput.value)) || oInput.value <= 0)){
                        oInput.focus();
                        alert(AMI.Template.Locale.get('grp_move_position_custom_wrong'));
                        oInput.focus();
                        return false;
                    }
                    return true;
                });
                oControl.appendChild(oButton);
            }else if(operationName == 'grp_id_page'){
                oControl = document.createElement('SPAN');
                oControl.id = 'span_grp_id_page_' + this.componentId;
                oControl.innerHTML = '\
                    <nobr>\
                    <select id="grpType" name="grp_type">\
                        <option value="move">' + AMI.Template.Locale.get('grp_move_items') + '</option>\
                        <option value="copy">' + AMI.Template.Locale.get('grp_copy_items') + '</option>\
                    </select>\
                    ' + AMI.Template.Locale.get('grp_popup_on_page') + ':&nbsp;\
                ';
                var oSelect = document.createElement('SELECT');
                oSelect.id = 'grpIdPage';
                oSelect.name = 'grp_id_page';
                oSelect.selectedIndex = 0;
                oControl.appendChild(oSelect);
                oControl.appendChild(document.createTextNode(' '));
                var oButton = AMI.Browser.DOM.create('INPUT', '', 'amiModuleLink but-short', 'margin-left: 4px;');
                oButton.type = 'button';
                oButton.value = 'OK';
                oButton.setAttribute('data-ami-action', 'group_action');
                oButton.setAttribute('data-ami-parameters', 'action=' + operationName + (this.aFullEnvActions.indexOf(operationName) >= 0 ? '&ami_full=1' : ''));
                AMI.Browser.Event.addHandler(oButton, 'click', function(_this, _operationName, _oButton){return function(evt){
                    var operation = document.getElementsByName('grp_type')[0].value;
                    var id_page = document.getElementsByName('grp_id_page')[0].value;

                    var parameters = _oButton.getAttribute('data-ami-parameters');
                    parameters += '&grp_operation=' + operation;
                    parameters += '&grp_page=' + id_page;
                    _oButton.setAttribute('data-ami-parameters', parameters);
                    _this.onGroupOperationClick(evt, _operationName);

                }}(this, operationName, oButton));
                oControl.appendChild(oButton);
            }else if(operationName == 'grp_id_cat'){
                oControl = document.createElement('SPAN');
                oControl.id = 'span_grp_id_cat_' + this.componentId;
                oControl.innerHTML = '\
                    <nobr>\
                    <select id="grpType" name="grp_type">\
                        <option value="move">' + AMI.Template.Locale.get('grp_move_items') + '</option>\
                        <option value="copy">' + AMI.Template.Locale.get('grp_copy_items') + '</option>\
                    </select>\
                    ' + AMI.Template.Locale.get('grp_popup_to_cat') + ':&nbsp;\
                ';
                var oSelect = document.createElement('SELECT');
                oSelect.id = 'grpIdCat';
                oSelect.name = 'grp_id_cat';
                oSelect.selectedIndex = 0;

                /*
                var oCatField = $('#ami_form_filter_' + this.oModule.moduleId + '_0')[0].elements['category'];
                for(var i = 0, q = oCatField.options.length; i < q; i++){
                    oSelect.options[i] = new Option(
                        oCatField.options[i].text,
                        oCatField.options[i].value,
                        false,
                        false
                    );
                }
                */

                oControl.appendChild(oSelect);
                oControl.appendChild(document.createTextNode(' '));
                var oButton = AMI.Browser.DOM.create('INPUT', '', 'amiModuleLink but-short', 'margin-left: 4px;');
                oButton.type = 'button';
                oButton.value = 'OK';
                oButton.setAttribute('data-ami-action', 'group_action');
                oButton.setAttribute('data-ami-parameters', 'action=' + operationName + (this.aFullEnvActions.indexOf(operationName) >= 0 ? '&ami_full=1' : ''));
                AMI.Browser.Event.addHandler(oButton, 'click', function(_this, _operationName, _oButton){return function(evt){
                    var operation = document.getElementsByName('grp_type')[0].value;
                    var id_cat = document.getElementsByName('grp_id_cat')[0].value;

                    var parameters = _oButton.getAttribute('data-ami-parameters');
                    parameters += '&grp_operation=' + operation;
                    parameters += '&grp_id_cat=' + id_cat;
                    _oButton.setAttribute('data-ami-parameters', parameters);
                    _this.onGroupOperationClick(evt, _operationName);

                }}(this, operationName, oButton));
                oControl.appendChild(oButton);
            }else if(operationName == 'grp_flags'){
                // Eshop special flags
            }
        }else if(typeof(oCustomData.oControl) != 'undefined'){
            oControl = oCustomData.oControl;
        }
        return oControl;
    }

    /**
    * Find row by id in row data and set special class for TR.
    *
    * @param {number} id Id value for id field in row data.
    * @param {string} className Class that should be set for the row. If the class name is empty original class name will be get.
    * @param {bool} bRestoreOthers Should other rows be restored with original class. true if omitted.
    * @returns {void}
    */
    this.setRowClassById = function(id, className, bRestoreOthers){
        if(!this.oList) return;
        var aRows = this.oList.getElementsByTagName('TR');
        for(var i = 0; i < aRows.length; i++){
            if(aRows[i].getAttribute('data-ami-row-id') == id){
                if(aRows[i].className != 'over'){
                    AMI.addClass(aRows[i], className);
                }
                aRows[i].setAttribute('data-ami-super-class', className);
            }else if((typeof(bRestoreOthers) == 'undefined' || bRestoreOthers) && aRows[i].getAttribute('data-ami-super-class') == className){
                aRows[i].setAttribute('data-ami-super-class', '');
                if(aRows[i].className != 'over'){
                    AMI.removeClass(aRows[i], className);
                }
            }
        }
    }

    /**
    * Handler for mouseover of list row. Changes class to 'over'.
    *
    * @param {DOM object} oRow Target row object.
    * @param {object} evt Browser event object.
    * @returns {void}
    */
    this.mouseOverRow = function(oRow, evt){
        if(AMI.Message.send('ON_LIST_ROW_MOUSE_OVER', {oComponent: this, oRow: oRow, oEvent: evt})){
            AMI.addClass(oRow, 'over');
        }
        //oRow.className = 'over';
    }

    /**
    * Handler for mouseout of list row. Changes class to default.
    *
    * @param {DOM object} oRow Target row object.
    * @param {object} evt Browser event object.
    * @returns {void}
    */
    this.mouseOutRow = function(oRow, evt){
        if(AMI.Message.send('ON_LIST_ROW_MOUSE_OUT', {oComponent: this, oRow: oRow, oEvent: evt})){
            AMI.removeClass(oRow, 'over');
        //var className = oRow.getAttribute('data-ami-super-class') ? oRow.getAttribute('data-ami-super-class') : oRow.getAttribute('data-ami-original-class');
        //oRow.className = className;
        }
    }

    /**
    * Handler for mouse click on group checkbox of list header.
    *
    * @param {object} evt Browser event object.
    * @returns {void}
    */
    this.onGroupAllClicked = function(evt){
        var oCkeckbox = AMI.Browser.Event.getTarget(evt);
        for(var i = 0; i < this.aGroupIdCheckboxes.length; i++){
            if(this.aGroupIdCheckboxes[i]){
                this.checkRow(this.aGroupIdCheckboxes[i], oCkeckbox.checked);
            }
        }
    }

    /**
    * Reset rows to default state by removing group field checked.
    *
    * @returns {void}
    */
    this.resetGroupRows = function(){
        for(var i = 0; i < this.aGroupIdCheckboxes.length; i++){
            if(this.aGroupIdCheckboxes[i]){
                this.checkRow(this.aGroupIdCheckboxes[i], false);
            }
        }
    }
    
    /**
    * Check rows.
    *
    * @returns {void}
    */
    this.checkGroupRows = function(){
        for(var i = 0; i < this.aGroupIdCheckboxes.length; i++){
            if(this.aGroupIdCheckboxes[i]){
                this.checkRow(this.aGroupIdCheckboxes[i], true);
            }
        }
    }

    /**
    * Check one row for group action.
    *
    * @param {object} oCheckbox Group row checkbox.
    * @param {bool} bState Set row group id to this state (checked or not).
    * @returns {void}
    */
    this.checkRow = function(oCheckbox, bState){
        if(oCheckbox){
            if(AMI.Message.send('ON_LIST_ROW_CLICK', {oComponent: this, oCheckbox: oCheckbox})){
                oCheckbox.checked = bState;
                if(bState){
                    AMI.$('#moduleList_' + this.componentId + ' TR[data-ami-row-id="' + oCheckbox.value + '"]').addClass('onchecked');
                    //AMI.addClass(AMI.find('TR[data-ami-row-id=' + oCheckbox.value + ']')[0], 'onchecked');
                    //this.setRowClassById(oCheckbox.value, 'onchecked', false);
                }else{
                    // this.setRowClassById(oCheckbox.value, '', false);
                    AMI.$('#moduleList_' + this.componentId + ' TR[data-ami-row-id="' + oCheckbox.value + '"]').removeClass('onchecked');
                    // AMI.removeClass(AMI.find('TR[data-ami-row-id=' + oCheckbox.value + ']')[0], 'onchecked');
                    this.oGroupIdAll.checked = false;
                }
                this.updateCheckedRowsCounter();
            }
        }
    }

    /**
    * Set the number of checked rows to text field in group operations block.
    *
    * @returns {void}
    */
    this.updateCheckedRowsCounter = function(){
        var number = 0;

        for(var i = 0; i < this.aGroupIdCheckboxes.length; i++){
            if(this.aGroupIdCheckboxes[i] && this.aGroupIdCheckboxes[i].checked){
                number++;
            }
        }
        this.oGroupCounter.value = number;
    }

    /**
    * Check the selection, ask a question and proceed/not preceed with the group action. Method stops event if group operation is not allowed.
    *
    * @param {object} evt Browser event object.
    * @param {string} operationName Name of goup operation for question search.
    * @returns {void}
    */
    this.onGroupOperationClick = function(evt, operationName){
        if(this.oGroupCounter.value == 0){
            alert(AMI.Template.Locale.get('group_nonchecked_warn'));
            AMI.Browser.Event.stopProcessing(evt);
            return false;
        }

        if(!AMI.Message.send('ON_AMI_GROUP_OPERATION', this)){
            AMI.Browser.Event.stopProcessing(evt);
            return false;
        }

        var actionQuestion = AMI.Template.Locale.get(operationName + '_warn');
        if(actionQuestion != null && !confirm(actionQuestion)){
            AMI.Browser.Event.stopProcessing(evt);
            return false;
        }

        return true;
    }

    this.fillGroupActionIds = function(){
        var ids = '';
        for(var i = 0; i < this.aGroupIdCheckboxes.length; i++){
            if(this.aGroupIdCheckboxes[i] && this.aGroupIdCheckboxes[i].checked){
                ids += (ids == '' ? '' : ',') + this.aGroupIdCheckboxes[i].value;
                this.aRowsToCheckOnLoad[this.aGroupIdCheckboxes[i].value] = true;
            }
        }
        this.modActionId = ids;
    }

    this.onGroupAction = function(oModule, oParameters){
        if(typeof(oParameters.action) != 'undefined'){
            this.modAction = 'list_' + oParameters.action;
            this.fillGroupActionIds();
            this.ami_full = typeof(oParameters.ami_full) != 'undefined' ? oParameters.ami_full : false;
            oModule.reloadList(this);
        }

        return false;
    }

    this.setGrpPosActionVisibility = function(visibility){
        var
            oSpan = AMI.find('#span_grp_move_position_' + this.componentId),
            p = oSpan,
            display = visibility ? 'inline' : 'none';
        if(oSpan && (this.aColumns.indexOf('position') < 0)){
            oSpan.style.display = display;
            do{
                p = p.previousSibling;
            }while(p && p.nodeType != 1);
            p.style.display = display;
            return;
        }
        if(oSpan){
            // CMS-11457
            if(!visibility){
                AMI.$(oSpan).attr('title', AMI.Template.Locale.get('position_warn_positionInactive'));
                AMI.$(oSpan).find('SELECT').attr('disabled', true);
            }else{
                AMI.$(oSpan).find('SELECT').attr('disabled', false);
                AMI.$(oSpan).attr('title', '');
            }
            return;
        }
    }

    this.getListData = function(){
        return this.oListData;
    }

    this.init();
}
AMI.inherit(AMI.ModuleComponentList, AMI.ModuleComponent);
