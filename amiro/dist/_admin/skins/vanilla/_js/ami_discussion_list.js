AMI.Message.addListener(
    'ON_MODULE_ACTION',
    function(action, oParameters){
        switch(action){
            case 'list_reply':
                // console.dir(oParameters);return false;///
                if(AMI.DiscussionFilter.hasTree){
                    AMI.DiscussionFilter.setParentId(oParameters.oParameters.id);
                    return false;
                }
                break;
            case 'list_add_subitem':
                var oList = oParameters.oComponent.oListData.data.list, oRow, id = oParameters.oParameters.id;
                for(var i = 0, q = oList.length; i < q; i++){
                    oRow = oList[i];
                    if(oRow.id == id){
                        return AMI.DiscussionFilter.displayItemMessages(oRow.src_ext_module, oRow.id_ext_module, oRow.id, 'reply');
                    }
                }
                return false;
                break;
            default:
                // alert('list ' + action);return false;///
                //console.log('-------- ' + action + '--------');console.dir(oArgs);return false;///
        }
        return true;
    }
);
