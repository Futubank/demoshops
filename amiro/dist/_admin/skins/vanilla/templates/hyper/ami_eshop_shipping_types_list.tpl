##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_list.tpl"%%

<!--#set var="javascript" value="
AMI.Message.addListener(
    'ON_MODULE_ACTION',
    function(action, oParameters){
        switch(action){
            case 'list_active':
                if(top.document.getElementById('id_shipping_type').value != oParameters.oParameters.id){
                    //fireEvent2(top.document.getElementById('id_shipping_type'), 'change', top.document.forms['eshop_form']);
                }
                top.document.getElementById('id_shipping_type').value = oParameters.oParameters.id;
                closeDialogWindow();
                return false;
                break;
        }
        return true;
    }
);

"-->