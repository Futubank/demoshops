AMI.Message.addListener(
    'ON_FORM_FIELD_VALIDATE',
    function(oParameters){
        var value = oParameters.oField.value;

        switch(oParameters.oField.name){
            case 'taborder':
                if(isNaN(parseInt(value)) || parseInt(value) <= 0){
                    oParameters.message = '\n' + AMI.Template.Locale.get('form_field_taborder_invalid_warn');
                    oParameters.error = true;
                    return false;
                }
                break; // case 'taborder'
            case 'new_mod_id':
                if(!value.match(/^[a-z](?:[a-z\d]|_[a-z])+$/)){
                    oParameters.message = '\n' + AMI.Template.Locale.get('form_field_new_mod_id_invalid_warn');
                    oParameters.error = true;
                }
                break; // case 'new_mod_id'
        }
        return true;
    }
);

function showAdvanced(){
    AMI.$('#advanced_settings').show();
    if(typeof(AMI_ModManager) != 'undefined'){
        AMI_ModManager.oPopup.autosize(); AMI.UI.center(AMI_ModManager.oPopup.object);
    }else{
        amiMarket.dlPopup.autosize(); AMI.UI.center(amiMarket.dlPopup.object);
    }
    AMI.$('#advanced_title').hide();
    return false;
}

