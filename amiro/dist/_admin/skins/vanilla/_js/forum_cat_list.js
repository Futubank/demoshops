AMI.Message.addListener(
    'ON_AMI_LIST_ROW',
    function(oComponent, oParameters){
        if(oParameters.data.is_separator > 0){
            oParameters.row.className = oParameters.row.className + ' not_read';
        }
    }
);
