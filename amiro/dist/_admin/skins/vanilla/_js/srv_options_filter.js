var currentOptionsCount = 0;
var totalOptionsCount = 0;
var oModules;
var oOptions;

var aModules = {};
var aModulesCaptions = {};
var aOwners = {};

AMI.$(document).ready(function(){
    if((typeof(module_name) == 'undefined') || (module_name != 'srv_options') || (typeof(aOptionsData) == 'undefined')){
        return;
    }

    var curModId = AMI.$('INPUT[name="current_module"]').val();
    var curModCaption = '';

    for(var o in aOptionsData){
        totalOptionsCount++;
    }
    currentOptionsCount = totalOptionsCount;

    function fillDataArray(){
        AMI.$('SELECT[name="flt_owner"] OPTION').each(
            function(idx, el){
                aModules[AMI.$(el).val()] = {
                    caption: AMI.$(el).text(),
                    items: {}
                };
                for(var i=0; i<mData[idx].length; i++){
                    var modId = mData[idx][i];
                    var modName = mTitlesData[idx][i];
                    aModules[AMI.$(el).val()].items[modId] = {
                        caption: modName
                    }
                    aModulesCaptions[modId] = AMI.$(el).text() + ': ' + modName;
                    if(modId == curModId){
                        curModCaption = AMI.$(el).text() + ': ' + modName;
                    }
                    aOwners[modId] = AMI.$(el).val();
                }
            }
        );
    }

    function getModOwner(modId){
        return typeof(aOwners[modId]) != 'undefined' ? aOwners[modId] : '';
    }

    fillDataArray();

    var oModOptions = {
        title: '', //srvOptionsStratTypeModName,
        selected: curModId,
        notFound: srvOptionsNotFound,
        button: '▼',
        onListOpen: function(obj, list){
            var selMod = AMI.$('INPUT[name="flt_module"]').val();
            var el = AMI.$('.selected_option[data-ami-select-item-value=' + selMod + ']');
            if(el.length){
                list.scrollTop(list.scrollTop() + el.position().top);
            }
        },
        onSelect: function(obj, str, val){
            if(val !== curModId){
                var mode = AMI.$('INPUT[name="flt_mode"]').val();
                var owner = getModOwner(val);
                var address = 'srv_options.php?flt_module=' + val + '&flt_owner=' + owner + '&flt_mode=' + mode;
                if((typeof(window.skinMode) != 'undefined') && window.skinMode){
                    address = address + '&frn_skin_popup=1';
                }
                var form = AMI.$('<FORM action="' + address + '" method="POST">');
                AMI.$('body').append(form);
                form.submit();
                form.remove();
            }
        },
        onEmptySearch: function(obj){
            return true;
        },
        onSearch: function(obj, group, item, searchStr, searchItems){
            if(!searchStr.length){
                obj.highlighted = {'Fake String That Never Be Found': true};
                return true;
            }
            return false;
        },
        onAddItem: function(obj, group, name, value, groupContainer, itemContainer){
            if(value == obj.getOpt('selected')){
                itemContainer.addClass('selected_option');
                groupContainer.addClass('ami-select__group-selected');
            }
        }
    };

    function navigateByHash(){
        var hash = document.location.hash;
        var aParts = hash.split('|');
        var section = aParts[1];
        var option = aParts[2];
        if(section){
            var row = AMI.$('#switch_group_buttons_' + section);
            if(row.length){
                switchGroup(null, row[0], false);
            }
        }
        // Scroll with 0.5s delay
        if(option){
            setTimeout(
                function(_opt){
                    return function(){
                        AMI.scrollTo(AMI.find('#group_row_' + _opt));
                        AMI.$('TR').removeClass('highlighted-option');
                        AMI.$('#group_row_' + _opt).addClass('highlighted-option');
                    }
                }(option),
                500
            );
        }else if(section){
            // Scroll to section
            setTimeout(
                function(_sect){
                    return function(){
                        AMI.scrollTo(AMI.find('#switch_group_buttons_' + _sect));
                    }
                }(section),
                500
            );
        }
    };

    var oOptOptions = {
        title: srvOptionsStratTypeOptName,
        maxCount: 30,
        notFound: srvOptionsNotFound,
        tooMuch: srvOptionsTooMuch,
        renderDataOnStart: false,
        listAlign: 'right',
        onInit: function(obj){
            obj.isCached = AMI.Cookie.get('options_cache') == window.cms_version;
            obj.addedGroups = {};
            obj.searchInDescription = AMI.Cookie.get('search_in_description');
            obj.searchInCurrentModule = 'no'; //AMI.Cookie.get('search_in_current');
            obj.aCurModData = {};
            obj.aAllModData = {};

            obj.moveObj = function(fromO, toO){
                for(var i in fromO){
                    toO[i] = fromO[i];
                }
            };

            obj.fromCurMod = function(_obj){
                return function(){
                    _obj.aData = AMI.$.extend(true, {}, _obj.aCurModData);
                }
            }(obj);

            obj.toCurMod = function(_obj){
                return function(){
                    _obj.aCurModData = AMI.$.extend(true, {}, _obj.aData);
                }
            }(obj);

            obj.fromAllMod = function(_obj){
                return function(){
                    _obj.aData = AMI.$.extend(true, {}, _obj.aAllModData);
                }
            }(obj);

            obj.toAllMod = function(_obj){
                return function(){
                    _obj.aAllModData = AMI.$.extend(true, {}, _obj.aData);
                }
            }(obj);

            if(!obj.searchInDescription){
                obj.searchInDescription = 'yes';
            }
            if(!obj.searchInCurrentModule){
                obj.searchInCurrentModule = 'no';
            }
            obj.popupInitialized = false;
        },
        onAfterInit: function(obj){
            // Initialuize settings popup
            var labelTM = srvOptionsSearchThisModule;
            var labelSD = srvOptionsSearchInDescriptions;
            var checkedTM = (obj.searchInCurrentModule == 'no') ? '' : 'checked="checked"';
            var checkedSD = (obj.searchInDescription == 'no') ? '' : 'checked="checked"';
            obj.settingsPopup = AMI.$('#select-options-rolloverbutton').after('<div id="srv_options_search_settings"><br>'+
                '<label><input type="checkbox" value="1" id="search_current" ' + checkedTM + '>'+labelTM+'</label><br>'+
                '<label><input type="checkbox" value="1" id="search_description" ' + checkedSD + '>'+labelSD+'</label>'+
                '</div>');
            obj.popupInitialized = true;
            AMI.$('#search_current').click(function(evt){
                oOptions.lastStr = '';
                oOptions.searchInCurrentModule = (this.checked) ? 'yes' : 'no';
                AMI.Cookie.set('search_in_current', oOptions.searchInCurrentModule, 36000, '/50/srv_options/');
                if(oOptions.searchInCurrentModule == 'yes'){
                    oOptions.fromCurMod();
                }else{
                    oOptions.fromAllMod();
                }
            });
            AMI.$('#search_description').click(function(evt){
                oOptions.searchInDescription = (this.checked) ? 'yes' : 'no';
                AMI.Cookie.set('search_in_description', oOptions.searchInDescription, 36000, '/50/srv_options/');
            });
            obj.toCurMod();
        },
        onButtonClick: function(obj){
            if(AMI.$('#srv_options_search_settings').css('height') == '0px') {
                AMI.$('#srv_options_search_settings').animate({height: '60px'});
            } else {
                AMI.$('#srv_options_search_settings').animate({height: '0'})
            }
            return true;
        },
        onAddItem: function(obj, group, name, value, groupContainer, itemContainer){
            var curModId = AMI.$('INPUT[name="current_module"]').val();
            for(var grp in aOptions){
                if(aOptions[grp].caption == group){
                    if(grp == curModId){
                        groupContainer.addClass('ami-select__group-selected');
                    }
                }
            }
            for(var grp in aOptions){
                if(aOptions[grp].caption == group){
                    var groupTitle = groupContainer.find('.ami-select__grouptitle');
                    for(var substr in obj.highlighted){
                        var regx = new RegExp("(" + substr + ")", 'ig');
                        if((grp.indexOf(substr) >= 0) && (groupTitle.text().toLowerCase().indexOf(substr) < 0)){
                            var newCaption = groupTitle.html() + ' [' + grp.replace(regx, "<b>$1</b>") + ']';
                            groupTitle.html(newCaption);
                        }
                    }
                    for(var itm in aOptions[grp].items){
                        if(itm == value){
                            var subGrp = obj.clearName(aOptions[grp].items[itm].group);
                            var valParts = value.split('|');
                            var subGrpId = valParts[0] + '|' + valParts[1];
                            if(subGrp && typeof(obj.addedGroups[subGrpId]) == 'undefined'){
                                var innerGroup = AMI.$('<DIV>');
                                innerGroup.addClass('select-options-subgroup');
                                innerGroup.attr('data-ami-select-item-full', subGrp)
                                var subGrpCapt = subGrp;
                                for(var substr in obj.highlighted){
                                    var regx = new RegExp("(" + substr + ")", 'ig');
                                    subGrpCapt = subGrpCapt.replace(regx, "<b>$1</b>");
                                }
                                innerGroup.html(subGrpCapt);
                                innerGroup.click(
                                    function(section){
                                        return function(){
                                            AMI.$('#' + oOptions.name + '-resultrow input, #' + oOptions.name + '-list').hide();
                                            oOptions.tooMuch(false);
                                            AMI.$('#' + oOptions.name + '-viewed, #' + oOptions.name + '-rolloverbutton').show();
                                            AMI.$('#' + oOptions.name + '-viewed').text(AMI.$(this).attr('data-ami-select-item-full'));
                                            var parts = section.split('|');
                                            var modId = parts[0];
                                            var val = section + '|';
                                            if(curModId == modId){
                                                document.location.hash = val;
                                                navigateByHash();
                                            }else{
                                                // Create form and submit
                                                var mode = AMI.$('INPUT[name="flt_mode"]').val();
                                                var owner = getModOwner(modId);
                                                var address = 'srv_options.php?flt_module=' + modId + '&flt_owner=' + owner + '&flt_mode=' + mode;
                                                if((typeof(window.skinMode) != 'undefined') && window.skinMode){
                                                    address = address + '&frn_skin_popup=1';
                                                }
                                                address = address + '#' + val;
                                                var form = AMI.$('<FORM action="' + address + '" method="POST">');
                                                AMI.$('body').append(form);
                                                form.submit();
                                                form.remove();
                                            }
                                        };
                                    }(subGrpId)
                                );
                                obj.addedGroups[subGrpId] = 1;
                            }
                            var descr = obj.clearName(aOptions[grp].items[itm].description);
                            if(descr != ''){
                                for(var substr in obj.highlighted){
                                    var regx = new RegExp("(" + substr + ")", 'ig');
                                    descr = descr.replace(regx, "<b>$1</b>");
                                }
                                descr = '<br><span style="font-size:9px;color:#000;"><i>' + descr + '</i></span>';
                            }
                            itemContainer.attr('original-text', itemContainer.text());

                            // Ugly hack
                            var parts = itm.split('|');
                            var optName = (typeof(parts[2]) != 'undefined') && parts[2].length ? parts[2] : '';
                            var foundOpt = false;
                            for(var substr in obj.highlighted){
                                var regx = new RegExp("(" + substr + ")", 'ig');
                                subGrp = subGrp.replace(regx, "<b>$1</b>");
                                if(optName.length && (optName.indexOf(substr) >= 0)){
                                    optName = ' [' + optName.replace(regx, "<b>$1</b>") + ']';
                                    foundOpt = true;
                                }
                            }
                            if(!foundOpt){
                                optName = '';
                            }
                            itemContainer.html('<div style="padding-left:16px;">' + itemContainer.html().replace(subGrp + ':', '') + optName + descr + '</div>');
                        }
                    }
                    break;
                }
            }
            groupContainer.append(innerGroup);
        },
        onBeforeHighlight: function(obj){
            obj.addedGroups = {};
        },
        onSearch: function(obj, group, item, searchStr, searchItems){
            if(obj.searchInDescription == 'no'){
                return false;
            }
            var descr = obj.clearName(obj.aData[group].items[item].description);
            if(descr && obj.searchItems(descr, searchItems)){
                return true;
            }
            return false;
        },
        onEmptySearch: function(obj){
            obj.closeList(null, true);
        },
        onListClick: function(obj){
            if(AMI.$('#' + obj.name + '-resultrow > input').val() === ''){
                obj.closeList(null, true);
                return true;
            }
            return false;
        },
        onSelect: function(obj, str, val, elm){
            AMI.$('#' + obj.name + '-viewed').text(elm.attr('original-text'));
            var aParts = val.split('|');
            var modId = aParts[0];
            if(curModId == aParts[0]){
                document.location.hash = val;
                navigateByHash();
            }else{
                // Create form and submit
                var mode = AMI.$('INPUT[name="flt_mode"]').val();
                var owner = getModOwner(modId);
                var address = 'srv_options.php?flt_module=' + modId + '&flt_owner=' + owner + '&flt_mode=' + mode;
                if((typeof(window.skinMode) != 'undefined') && window.skinMode){
                    address = address + '&frn_skin_popup=1';
                }
                address =  address + '#' + val;
                var form = AMI.$('<FORM action="' + address + '" method="POST">');
                AMI.$('body').append(form);
                form.submit();
                form.remove();
            }
         }
    };

    var aOptions = {};
    aOptions[curModId] = {
        caption: curModCaption,
        items: aOptionsData,
    };

    // Add new containers and set height
    AMI.$('#filter-box').html('<div id="srv_options_select_module"></div><div id="srv_options_select_option"></div>');
    AMI.$('#filter-box').height(40);

    oModules = new amiAdminSelect('select-modules-module', aModules, oModOptions);
    oOptions = new amiAdminSelect('select-options-module', aOptions, oOptOptions);

    oOptions.tooMuch = function(_this){
        return function(isOn, count, total){
            var tooMuch = AMI.$('#' + _this.name + '-tooMuchMaches');
            if(isOn){
                tooMuch.html(_this.getOpt('tooMuch', 'Not all mathes shown').replace('__count__', count).replace('__total__', total));
            }
            if(!isOn && (typeof(count) != 'undefined') && (typeof(total) != 'undefined') && (parseInt(total) > 0)){
                isOn = true;
                tooMuch.html('');
            }
            _this.showTooMuch = isOn;
            if(isOn){
                tooMuch.css('top', _this.getListObject().position().top + _this.getListObject().height() + 4);
                var counter = (_this.searchInCurrentModule == 'yes') ? currentOptionsCount : totalOptionsCount;
                var isEndsOnOne = (counter.toString()[counter.toString().length - 1] == '1');
                var msgCount = isEndsOnOne ? srvOptionsCountMsg1 : srvOptionsCountMsg2;
                msgCount = msgCount.replace('__count__', counter);
                tooMuch.append('<DIV class="ami-select__optCounter">' + msgCount + '</DIV>')
                tooMuch.show();
            }else{
                tooMuch.html('');
                tooMuch.hide();
            }
        }
    }(oOptions)

    oModules.init('srv_options_select_module');
    if(oOptions.init('srv_options_select_option')){
        setTimeout(
            function(){
                var loc = document.location.href;
                loc = loc.replace(/\?(.*)/ig, '');
                loc = loc.replace(/\#(.*)/ig, '');
                loc = loc.replace(/\?/ig, '');
                loc +=
                    '?_cv=' + window.cms_version +
                    '&_rv=' + window.rights_version +
                    '&lang=' + window.interface_lang +
                    '&_ah=' + window.amiAccessHash +
                    '&json=1';
                AMI.$.getJSON(loc, {}, function(data){

                    AMI.$('.ami-select__loading').hide();
                    for(var modId in data){
                        aOptions[modId] = data[modId];
                        aOptions[modId].caption = aModulesCaptions[modId];
                        oOptions.aData[modId] = aOptions[modId];
                        for(var o in aOptions[modId].items){
                            totalOptionsCount++;
                        }
                    }
                    totalOptionsCount -= currentOptionsCount;
                    oOptions.toAllMod();
                    if(oOptions.searchInCurrentModule == 'yes'){
                        oOptions.fromCurMod();
                    }
                    AMI.Cookie.set('options_cache', window.cms_version, 3600 * 24 * 365, '/', true);
                });
            },
            oOptions.isCached ? 1000 : 5000
        );
    }
    setTimeout(navigateByHash, 500);
});

$(document).ready(function() {
    $("body").click(function(e) {
        if($(e.target).closest('div').attr('id') != 'srv_options_search_settings' && $("#srv_options_search_settings").css("height") != '0px') {
            $("#srv_options_search_settings").animate({height: "0px"});
        }
    });
});