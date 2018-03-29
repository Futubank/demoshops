AMI.Message.addListener(
    'ON_MODULE_ACTION',
    function(action, oParameters){
        if(oParameters.oComponent.componentId == '##_component_id##' && action === 'list_print'){
            var modId = oParameters.oComponent.getModuleId(), defaultPrintForm = '##default_print_form##';
            _cms_script_link = modId + '.php?';
            if(defaultPrintForm.length){
                window.open(_cms_script_link + 'action=print&id=' + oParameters.oParameters.id);
            }else{
                openDialog(
                    AMI.Template.Locale.get('caption_print_form'),
                    _cms_script_link + 'action=print&id=' + oParameters.oParameters.id,
                    320, 200
                );
            }
            return false;
        }
        return true;
    }
);

AMI.Message.addListener('ON_AMI_LIST_ROW_FOOTER', function(oComponent, oParameters){
    AMI.$('#moduleList_eshop_order_1').find('col:eq(1)').attr('width', '50px');
    oParameters.data['status'].caption = '<span style="font-weight: bold;float: right;font-size: 14px;padding-top: 6px;">' + oParameters.data['status'].caption + ':</span>';

    var total = 0;
    oListData = oComponent.getListData();
    for(var i = 0; i < oListData.data.list.length; i++){
        if(oListData.data.list[i]['sum'] != 'undefined'){
            total += oListData.data.list[i]['sum'];
        }
    }
    oParameters.data['amount'].caption = '<nobr><span style="font-weight: bold;float: right;padding-top: 6px;font-size: 14px;padding: 6px 0 0 10px;color: green;">' + formatMoney(total) + '</span></nobr>';
    return true;
});

AMI.Message.addListener('ON_ADD_NEW_GROUP_CONTROL', function(opeartionName, oCustomData){
    if('grp_change_status' === opeartionName){
        oCustomData.oControl = document.createElement('SPAN');
        oCustomData.oControl.id = 'grp_change_status_span';
        oCustomData.oControl.style = 'white-space: nowrap;';

        oCustomData.oControl.innerHTML =
            AMI.Template.Locale.get('grp_change_status') +
            ': <select id="grp_change_status" name="grp_change_status"></select>';

        oCustomData.oControl.appendChild(document.createTextNode(' '));

        var oButton = AMI.Browser.DOM.create('INPUT', '', 'but-short', 'margin-left: 4px;');
        oButton.type = 'button';
        oButton.value = 'OK';
        AMI.Browser.Event.addHandler(
            oButton,
            'click',
            function(_this, _operationName){
                return function(evt){
                    if(_this.oGroupCounter.value > 100){
                        alert(AMI.Template.Locale.get('grp_change_status_warn_over_100'));
                        return false;
                    }

                    var backup = AMI.Template.Locale.get('grp_change_status_warn_backup', false);

                    if('undefined' === typeof(backup)){
                        console.log('backuped');///
                        AMI.Template.Locale.set(
                            'grp_change_status_warn_backup',
                            AMI.Template.Locale.get('grp_change_status_warn')
                        );
                    }else{
                        console.log('restored');///
                        AMI.Template.Locale.set('grp_change_status_warn', backup);
                    }

                    if(_this.oGroupCounter.value > 10){
                        AMI.Template.Locale.set(
                            'grp_change_status_warn',
                            AMI.Template.Locale.get('grp_change_status_warn_over_10') + '\n' +
                            AMI.Template.Locale.get('grp_change_status_warn')
                        );
                    }
                    if(_this.onGroupOperationClick(evt, _operationName)){
                        _this.fillGroupActionIds();
                        openExtDialog(
                            AMI.Template.Locale.get('grp_change_status_popup_header'),
                            amiModuleLink +
                            '?mod_id=' + amiModId +
                            '&ami_full=1' +
                            '&mod_action=custom_component_view' +
                            '&componentId=eshop_order_0' +
                            '&status=' + document.getElementById('grp_change_status').value +
                            '&mod_action_id=' + _this.modActionId,
                            0, 0, 550, 330, -1, -1, 1, 1
                        );
                    }
                }
            }(oCustomData.oComponent, 'grp_change_status')
        );
        oCustomData.oControl.appendChild(oButton);

        return false;
    }

    return true;
});
