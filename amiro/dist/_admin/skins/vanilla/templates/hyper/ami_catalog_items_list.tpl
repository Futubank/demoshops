##--system info: module_owner="" module="" system="1"--##
%%include_language "templates/lang/hyper/ami_catalog_items_list.lng"%%
%%include_template "templates/modules/_list.tpl"%%

<!--#set var="price" value="<b>##price##</b>"-->

<!--#set var="price_empty" value="---"-->

<!--#set var="extra_price_separator" value="<br />"-->

<!--#set var="javascript" value="

window.priceCurrencies = {##currencyJS##};
window.basePriceCurrency = "##baseCurrency##";
AmiExcel.options.maxRows = '##maxRows##';
##if(!isPopup)##
if(typeof(AMI.Page.excelTabsHandler) == 'undefined'){

    AmiExcel.moduleActionHandler = function(action, params){
        if(action == 'form_reset'){
            oListComponent = AMI.Page.getComponent("##_component_id##");
            if(oListComponent.excelMode){
                AmiExcel.addRow();
                return false;
            }
        }
        if(!((action == 'list_oldenv') && (params.oParameters.action == 'ss_apply'))){
            if(AmiExcel.getChangedRows().length > 0){
                return confirm(AMI.Template.Locale.get('form_changed'));
            }
        }
        return true;
    };

    AMI.Message.addListener('ON_MODULE_ACTION', AmiExcel.moduleActionHandler, true);
    AMI.Message.addListener(
        'ON_COMPONENT_CONTENT_PLACED',
        function(oComponent){
            if(oComponent.componentType == 'form'){
                AMI.Message.addListener('ON_MODULE_ACTION', AmiExcel.moduleActionHandler, true);
            }
            return true;
        }, 
        true
    );

    oListComponent = AMI.Page.getComponent("##_component_id##");
    oListComponent.excelMode = false;
    oListComponent.addAction('to_excel', function(oComponent, oParameters){

        oComponent.excelMode = !oComponent.excelMode;

        var tableId = "moduleList_" + oComponent.componentId;
        var excelId = "excelList_" + oComponent.componentId;
        var rawTable = AMI.$('#' + tableId);

        var listColumns = ['sku', 'header', 'price0', 'price1', 'price2', 'price3', 'price4', 'price5', 'price6', 'price7', 'price8', 'price9', 'price10', 'price11', 'price12', 'price13', 'price14', 'price15', 'price16', 'rest'];
        var extraPrices = ['price0', 'price1', 'price2', 'price3', 'price4', 'price5', 'price6', 'price7', 'price8', 'price9', 'price10', 'price11', 'price12', 'price13', 'price14', 'price15', 'price16'];

        var listData = oComponent.oListData.data;

        if(oComponent.excelMode){
//            AMI.$('.paginationSize').hide();

            var oModule = oComponent.oModule;
            var data = [];
            var nRows = listData.list.length;
            var nCols = 0;

            /**
             * Extend AmiExcel with formula calculator
             */
            if(typeof(AmiExcel.calcRow) == 'undefined'){
                AmiExcel.calcRow = function(row, rowData){
                    var formulas = typeof(AmiExcel.formulas[row]) != 'undefined' ? AmiExcel.formulas[row] : {};
                    var allDone = false;
                    var iteration = 0;
                    var varCount = 0;
                    var keyCount = 0;

                    for(var key in rowData){
                        if(typeof(formulas[key]) != 'undefined'){
                            keyCount++;
                        }
                    }

                    // nothing to do
                    if(keyCount < 2){
                        return;
                    }

                    if(typeof(rowData['price0']) != undefined){
                        var price = AmiExcel.data[row][AmiExcel.columns.indexOf('price0')];
                        var price0 = AmiExcel.data[row][AmiExcel.columns.indexOf('price0')];
                    }

                    while(!allDone){

                        iteration++;

                        for(var key in rowData){
                            var isFormula = false;
                            var evalStr = false;
                            var formula = '';
                            if((typeof(formulas[key]) != 'undefined') && (formulas[key] != '')){
                                isFormula = true;
                                var formula = formulas[key].formula;
                            }
                            var currency = (key != 'price0') ? AmiExcel.priceCurrencies[key] : window.basePriceCurrency;
                            if(isFormula){
                                if(key != 'price0'){
                                    evalStr = 'var ' + key + formula + ';';
                                }
                            }else{
                                if(rowData[key] != ''){
                                    var bcVal = rowData[key];
                                    if(currency != window.basePriceCurrency){
                                        bcVal = bcVal / window.priceCurrencies[currency];
                                    }
                                    if(key != 'price0'){
                                        evalStr = 'var ' + key + ' = ' + bcVal + ';'
                                    }
                                }else{
                                    evalStr = 'var ' + key + ' = 0;';
                                }
                            }

                            // It's a kind of magic
                            try{
                                if(evalStr){
                                    eval(evalStr);
                                    if(isFormula){
                                        evalStr = 'if(!isNaN(' + key + ')){rowData[key]=' + key + '; varCount++;}';
                                        eval(evalStr);
                                    }
                                }
                            }catch(e){}

                            if(varCount == keyCount){
                                allDone = true;
                            }
                        }

                        if(iteration > 32){
                            console.log('Invalid formula dependency detected on row ' + row);
                            break;
                        }
                    }

                    for(var key in rowData){
                        var currency = window.basePriceCurrency;
                        if(typeof(formulas[key]) != 'undefined'){
                            currency = formulas[key].currency.length ? formulas[key].currency : currency;
                        }else{
                            continue;
                        }
                        if(currency != window.basePriceCurrency){
                            if(!isNaN(rowData[key]) && (rowData[key] != '')){
                                rowData[key] *= window.priceCurrencies[currency];
                            }
                        }
                    }
                };
            }

            var columns = [];
            var headers = [];
            var columnFormulas = [];
            var priceCurrencies = {};
            if(typeof(listData.extra) != 'undefined'){
                for(var key in listData.extra){
                    var formula = listData.extra[key];
                    var currency = window.basePriceCurrency;
                    if(formula.indexOf('#') > 0){
                        var fparts = formula.split('#');
                        formula = fparts[0];
                        currency = fparts[1];
                    }
                    if(currency.indexOf(':') >= 0){
                        var cparts = currency.split(':');
                        currency = cparts[0];
                    }
                    priceCurrencies[key] = currency;
                }
            }
            AmiExcel.priceCurrencies = priceCurrencies;
            AmiExcel.originalRows = [];

            for(var i = 0; i < listColumns.length; i++){
                var key = listColumns[i];
                if(typeof(listData.listColumns[key]) != 'undefined'){
                    if(columns.indexOf(key) == -1){
                        columns.push(key);

                        var curField = (key == 'price0') ? 'price' : key;
                        var columnHeader = listData.listColumns[curField].caption == null ? '' : listData.listColumns[curField].caption;
                        if(columnHeader == ''){
                            columnHeader = key;
                        }
                        if(typeof(priceCurrencies[key]) != 'undefined'){
                            columnHeader = columnHeader + ' (' + priceCurrencies[key] + ')';
                        }
                        if(headers.indexOf(columnHeader) == -1){
                            headers.push(columnHeader);
                        }
                    }
                }
            }
            nCols = columns.length;
            AmiExcel.columns = columns;

            if(!nCols){
                return;
            }

            for(var i=0; i<nRows; i++){
                columnFormulas.push({});
                var row = [];
                for(var j = 0; j < columns.length; j++){
                    var key = columns[j];
                    var value = listData.list[i][key];
                    var priceIndex = extraPrices.indexOf(key);
                    var isPrice = false;
                    var hasFormula = false;
                    if(priceIndex >= 0){
                        // Base price (0) or extra price (1..16)
                        isPrice = true;
                        if(priceIndex == 0){
                            value = parseFloat(value);
                            columnFormulas[i][key] = {
                                formula: '=' + key,
                                currency: window.basePriceCurrency
                            };
                        }else{
                            if(listData.list[i]['price_mask']){
                                var priceBit = Math.pow(2, parseInt(key.replace('price', '')) - 1);
                                if(listData.list[i]['price_mask'] & priceBit){
                                    hasFormula = typeof(listData.extra) != 'undefined' && typeof(listData.extra[key]) != 'undefined';
                                }
                            }
                        }
                    }

                    if(isPrice && priceIndex > 0){
                        if(hasFormula){
                            var formula = listData.extra[key];
                            if(formula.indexOf('#') > 0){
                                var fparts = formula.split('#');
                                formula = fparts[0];
                            }
                            columnFormulas[i][key] = {
                                formula: formula,
                                currency: priceCurrencies[key]
                            };
                            value = 0;
                        }
                        if(value == null){
                            value = '';
                        }
                        if(value != ''){
                            if(typeof(priceCurrencies[key]) != 'undefined'){
                                var multiplier = window.priceCurrencies[priceCurrencies[key]];
                                value *= multiplier;
                            }
                            value = parseFloat(value).toFixed(2);
                        }
                    }
                    if(key == 'header'){
                        value = listData.list[i]['header_unformatted'];
                    }
                    row.push(value);
                }

                AmiExcel.originalRows.push(listData.list[i]);
                data.push(row);
            }

            AmiExcel.formulas = columnFormulas;

            var begin = new Date().getTime() / 1000;

            var div = AMI.$('<DIV>');
            div.attr('id', excelId);
            div.addClass('amiExcel');
            rawTable.before(div);

            if(!AMI.$('#excelApply').length){
                var btn = AMI.$('<INPUT>');
                btn.attr('id', 'excelApply');
                btn.attr('type', 'button');
                btn.css('margin-top', '16px');
                btn.addClass('but');
                btn.val(AMI.Template.Locale.get('btn_excel_apply'));

                btn.click(function(){
                    var chRows = AmiExcel.getChangedRows();
                    if(!AmiExcel.getChangedRows().length){
                        alert(AMI.Template.Locale.get('no_changes'));
                        return;
                    }
                    var ssData = {}; // {
                    var changed = 0;
                    var added = 0;
                    var deleted = 0;
                    var addClmns = ['id', 'price_mask', 'public'];

                    for(var i = 0; i < chRows.length; i++){
                        var rowN = chRows[i]['row'];
                        var rowData = chRows[i]['data'];
                        var addData = typeof(AmiExcel.originalRows[rowN]) == 'undefined' ? {id:'', price_mask:0, 'public':{enabled: 0}} : AmiExcel.originalRows[rowN];
                        if(rowData[1] == ''){
                            deleted++;
                        }else{
                            if(typeof(AmiExcel.originalRows[rowN]) != 'undefined'){
                                changed++;
                            }else if(rowData[1] != ''){
                                added++;
                                // Add category id, just for sure that item will be added to the right category
                                var catId = AMI.Page.getHashData(AMI.Page.getComponent("##_component_id##").oModule.moduleId)['category'];
                                ssData['ss_cat' + '[' + (i + 1) + ']'] = catId;
                            }
                        }
                        for(var j=0; j<AmiExcel.columns.length; j++){
                            var name = AmiExcel.columns[j];
                            if(name == 'price0'){
                                name = 'price';
                            }
                            if(name == 'header'){
                                name = 'name';
                            }
                            ssData['ss_' + name + '[' + (i + 1) + ']'] = rowData[j];
                        }
                        for(var j=0; j<addClmns.length; j++){
                            var value = (addClmns[j] != 'public') ? addData[addClmns[j]] : addData[addClmns[j]].enabled;
                            ssData['ss_' + addClmns[j] + '[' + (i + 1) + ']'] = value;
                        }
                    }
                    if(confirm(AMI.Template.Locale.get('num_changed') + ': ' + changed + '\n' + AMI.Template.Locale.get('num_added') + ': ' + added + '\n' + AMI.Template.Locale.get('num_deleted') + ': ' + deleted + '\n\n' + AMI.Template.Locale.get('apply_changes_confirm'))){
                        window._cms_document_form_changed = false;
                        doAction('ss_apply', 0, ssData);
                    }
                });
                rawTable.after(btn);
            }

            var options = {
                colHeaders: true,
                rowHeaders: true,
                headers: headers,
                events: {
                    on_cell: function(event){
                        var field = AmiExcel.columns[event.col];
                        // Format price
                        if(field.indexOf('price') >= 0){
                            if(!isNaN(event.value) && event.value != null && (field != 'price0' && event.value != '')){
                                event.value = parseFloat(event.value).formatMoney(2, '.', ',');
                            }
                            if(!isNaN(event.value) && event.value != null && (field == 'price0' && event.value != '')){
                                event.value = parseFloat(event.value).formatMoney(2, '.', ',');
                            }
                            if(event.value == null){
                                event.value = '';
                            }
                            event.cell.css('text-align', 'right');
                        }
                        // Format rest
                        if(field.indexOf('rest') == 0){
                            event.cell.css('text-align', 'right');
                        }
                    },
                    // Executes on first table redraw only
                    on_row: function(event){
                        var rowData = event.rowData;
                        var priceCol = AmiExcel.columns.indexOf('price0');

                        if(typeof(rowData[priceCol]) == 'undefined' || rowData[priceCol] == '' || isNaN(rowData[priceCol])){
                            AmiExcel.data[event.row][priceCol] = 0.00;
                            AmiExcel.getCell(event.row, priceCol).text((0).formatMoney(2, '.', ',')).css('text-align', 'right');
                            rowData[priceCol] = 0.00;
                        }

                        var calc = {};
                        var formulas = typeof(AmiExcel.formulas[event.row]) != 'undefined' ? AmiExcel.formulas[event.row] : {};
                        for(var col = 0; col < AmiExcel.columns.length; col++){
                            var key = AmiExcel.columns[col];
                            if(key.indexOf('price') >= 0){
                                if(key != 'price0' && (typeof(formulas[key]) != 'undefined')){
                                    var cell = AmiExcel.getCell(event.row, col);
                                    cell.addClass('boldGreen readonly');
                                    cell.attr('title', formulas[key].formula);
                                }
                                calc[key] = rowData[col];
                            }
                        }
                        AmiExcel.calcRow(event.row, calc);
                        for(var key in calc){
                            var col = AmiExcel.columns.indexOf(key);
                            if(col >= 0){
                                if(key != 'price0' && (typeof(formulas[key]) != 'undefined')){
                                    if(typeof(AmiExcel.orig[event.row]) != 'undefined'){
                                        AmiExcel.orig[event.row][col] = calc[key];
                                    }
                                }
                                AmiExcel.data[event.row][col] = calc[key];
                                AmiExcel.getCell(event.row, col).text((calc[key] != '') ? parseFloat(calc[key]).formatMoney(2, '.', ',') : '').css('text-align', 'right');
                            }
                        }
                    },
                    // Update row after change
                    on_change: function(event){
                        AmiExcel.fire('on_row', event);
                        if(typeof(window._cms_document_form_changed) != undefined){
                            window._cms_document_form_changed = (event.changedRows.length > 0);
                        }
                    },
                    // Protect price input
                    on_edit: function(event){
                        var column = AmiExcel.columns[event.col];
                        if(column.indexOf('price') == 0){
                            event.val = event.val.replace(',', '.');
                            event.val = event.val.replace(/\s+/g, '');
                            if(!isNaN(parseFloat(event.val)) && event.val != ''){
                                event.val = parseFloat(event.val).toFixed(2);
                            }else if(event.val != '' || (column == 'price0' && event.val == '')){
                                alert(AMI.Template.Locale.get('invalid_price_value'));
                                event.val = (0).toFixed(2);
                            }
                        }
                        if(AmiExcel.columns[event.col] == 'rest'){
                            event.val = event.val.replace(',', '.');
                            event.val = event.val.replace(/\s+/g, '');
                            if(!isNaN(parseFloat(event.val)) && (event.val != '')){
                                event.val = parseInt(event.val);
                            }else if(event.val != ''){
                                alert(AMI.Template.Locale.get('invalid_rest_value'));
                                event.val = 0;
                            }
                        }
                    }
                },
                rows: nRows,
                cols: nCols,
                highlightChanged: true
            };

            if(nRows > AmiExcel.options.maxRows){
                AmiExcel.options.maxRows = nRows;
            }

            AmiExcel.init(excelId, data, options);

            if(!nRows){
                AmiExcel.addRow();
            }

            var end = new Date().getTime() / 1000;
            // console.log('Excel list generation time: ' + (end - begin));

            rawTable.hide();
            AMI.$('.group_operations_panel').hide();
            AMI.$('#div_properties_form').hide();
        }else{
//            AMI.$('.paginationSize').show();
            AmiExcel.destroy();
            AMI.$('#excelApply').remove();
            AMI.$('.group_operations_panel').show();
            AMI.$('#div_properties_form').show();
            rawTable.show();
        }
        return true;
    },
    false);

    AMI.Message.addListener('ON_PAGES_ELEMENT_NEEDED', function(oComponent, oParameters){

        if(!AMI.$('#tab-control-excel').length){

            var tabsContainer = AMI.$('<DIV>');
            tabsContainer.addClass('tab-control');
            tabsContainer.attr('id', 'tab-control-exceltable');
            tabsContainer.attr('onselectstart', 'return false;');

            AMI.$(oComponent.oList).before(tabsContainer);

            window.onTabSelectedCustom = function(component){
                return function(idTab, bState){
                    if(bState){
                        var catId = AMI.Page.getHashData(oComponent.oModule.moduleId)['category'];
                        if(catId && catId != "0"){
                            if((idTab == 'table' && component.excelMode)||(idTab == 'excel' && !component.excelMode)){
                                var ok = true;
                                if(component.excelMode && AmiExcel.getChangedRows().length > 0){
                                    if(!window.amiInstantExcelMode){
                                        ok = confirm(AMI.Template.Locale.get('form_changed'));
                                    }
                                }
                                if(ok){
                                    component.executeAction('to_excel', {oComponent: component, oParameters: {}});
                                }else{
                                    return false;
                                }
                            }
                        }else{
                            if(idTab == 'excel'){
                                alert(AMI.Template.Locale.get('choose_category'));
                                return false;
                            }
                        }
                    }
                    return true;
                }
            }(oComponent);

            AMI.Page.listTabs = new cTabs('tab-control-exceltable',
                {
                    'table': [AMI.Template.Locale.get('tab_table'), 'active', '', false],
                    'excel': [AMI.Template.Locale.get('tab_excel'), 'normal', '', false]
                }
            );
            setTimeout(function(){
                if(!AMI.$('#excelHelp').length){
                    var helpDiv = AMI.$('<DIV id="excelHelp" class="excelHelp">');
                    var header = AMI.Template.Locale.get('excel_help_title');
                    var help = AMI.$('<SPAN>');
                    help.click(function(e){
                        e.preventDefault();
                        new AMI.UI.Popup(AMI.Template.Locale.get('excel_help'), {width:580, header: header, onShow: function(popup){popup.autosize();}});
                    });
                    help.addClass('text_button');
                    help.html(header);
                    helpDiv.append(help);
                    AMI.$('#tab-control-excel').after(helpDiv);
                }
            }, 200);
        }
        return true;
    }, true);
    AMI.Page.excelTabsHandler = true;
}
##endif##

var aDisabledCheckboxes = [];

AMI.Message.addListener('ON_AMI_LIST_ROW', function(oComponent, oParameters){
    if(oParameters.data.id_source > 0){
        oParameters.row.className = 'hide_grp_checkbox';
        aDisabledCheckboxes.push(oParameters.data.id);
    }
});

AMI.Message.addListener(
    'ON_COMPONENT_CONTENT_PLACED',
    function(oComponent){
        if(oComponent.componentType == 'list'){
            AMI.$('TR.hide_grp_checkbox input[type=checkbox]').remove();
            for(var i = 0, q = oComponent.aGroupIdCheckboxes.length; i < q; i++){
                if(aDisabledCheckboxes.indexOf(oComponent.aGroupIdCheckboxes[i].value) > -1){
                    delete oComponent.aGroupIdCheckboxes[i];
                }
            }
        }
        return true;
    },
    true
);

AMI.Message.addListener(
    'ON_LIST_ROW_CLICK',
    function(oArgs){
        return aDisabledCheckboxes.indexOf(oArgs.oCheckbox.value) == -1;
    },
    true
);

##if(isPopup)##
AMI.Message.removeListener('ON_AMI_LIST_SHOW_ADD_BUTTON');
##endif##

"-->
