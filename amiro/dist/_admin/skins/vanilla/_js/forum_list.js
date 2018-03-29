AMI.Message.addListener(
    'ON_MODULE_ACTION',
    function(action, oParameters){
        switch(action){
            case 'filter':
                return AMI.ForumFilter.onSubmit(oParameters);
                break;
            case 'filter_reset':
                return AMI.ForumFilter.onReset(oParameters);
                break;
            case 'list_reply':
                var oList = oParameters.oComponent.oListData.data.list, oRow, id = oParameters.oParameters.id;
                for(var i = 0, q = oList.length; i < q; i++){
                    oRow = oList[i]
                    if(oRow.id == id){
                        var oArgs =
                            {
                                id:              AMI.ForumFilter.isInThread ? id : oRow.msg_id,
                                action:          'reply',
                                flt_id_thread:   oRow.id_thread,
                                id_thread:       oRow.id_thread,
                                flt_topics_only: 0,
                                topics_only:     0
                            };
                            if(AMI.ForumFilter.useSections){
                                oArgs.category = oRow.cat_id;
                            }
                        document.location.href = '?' + AMI.$.param(oArgs);
                        break;
                    }
                }
                return false;
        }
        return true;
    },
    true
);

AMI.Message.addListener(
    'ON_AMI_LIST_ROW',
    function(oComponent, oParameters){
        if(typeof(oParameters.data.cat_header) != 'undefined'){
            oParameters.data.cat_header = oParameters.data.cat_header.replace('onclick="', 'onclick="AMI.ForumFilter.resetThread();');
        }
        var threadId = document.forms[_cms_document_form].elements['flt_id_thread'].value;
        if(threadId && oParameters.data.id == threadId){
            oParameters.row.className = oParameters.row.className + ' not_read';
        }
    }
);
