if('undefined' === typeof(isStatusCloned)){
    var isStatusCloned = false;
}

AMI.Message.addListener('ON_PAGE_CONTENT_RECEIVED', function(){
    // Clone statuses list from filter to list group operation

    if(
        isStatusCloned ||
        !document.getElementById('id_status') ||
        !document.getElementById('grp_change_status')
    ){
        return;
    }

    var
        aSrcOpts = document.getElementById('id_status').options,
        oSelect = document.getElementById('grp_change_status'),
        oOption;


    for(var i = 0, q = aSrcOpts.length; i < q; i++){
        oOption = document.createElement('OPTION');
        oOption.text = aSrcOpts[i].text;
        oOption.value = aSrcOpts[i].value;
        oSelect.add(oOption);
    }

    isStatusCloned = true;
});

function exportPopupClose(){
    var
        oModule = AMI.Page.getModule(amiModId),
        aListComponents = oModule.getComponentsByType('list'),
        oListComponent = aListComponents[0];

    oListComponent.aRowsToCheckOnLoad = {};
    oModule.reloadList(oListComponent);
}
