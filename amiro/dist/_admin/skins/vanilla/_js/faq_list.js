AMI.Message.addListener('ON_AMI_LIST_ROW', function(oComponent, oParameters){
    if(!parseInt(oParameters.data.is_answered)){
         oParameters.row.className = oParameters.row.className + ' not_read';
    }
	return true;
});
