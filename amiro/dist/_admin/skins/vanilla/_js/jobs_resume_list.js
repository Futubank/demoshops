AMI.Message.addListener(
    'ON_MODULE_ACTION',
    function(action, oParameters){
        if(oParameters.oComponent.componentId == '##_component_id##'){

	        var modId = oParameters.oComponent.getModuleId();
        	_cms_script_link = modId + '.php?';

		if(action === 'list_print'){
			window.open(_cms_script_link + 'action=print&id=' + oParameters.oParameters.id);
		        return false;
	        }else if(action === 'list_reply'){
		        document.location.href = _cms_script_link + 'action=reply&id=' + oParameters.oParameters.id
		        return false;
		}else if(action === 'list_attach'){
                    	var oList = oParameters.oComponent.getListData().data.list;
                    	for(var i = 0, q = oList.length; i < q; i++){
                        	if(oList[i].id == oParameters.oParameters.id && oList[i].id_file){
				        document.location.href = 'ftpgetfile.php?module=files&id=' + oParameters.oParameters.id;
					return false;
				}
			}
			return false;
		}else if(action === 'list_attach-off'){
			return false;
		}
	}
        return true;
    }
);

AMI.Message.addListener('ON_AMI_LIST_ROW', function(oComponent, oParameters){
        if(!oParameters.data.id_file != 1){
            oParameters.data.actions[2].value = oParameters.data.actions[2].value + '-off';
        }
});


