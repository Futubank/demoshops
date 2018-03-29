AMI.Message.addListener('ON_AMI_LIST_ROW', function(oComponent, oParameters){
	if(oParameters.data.is_read != 1){
		oParameters.row.className = oParameters.row.className + ' not_read';
	}
    if(oParameters.data.sender_is_deleted == 1){
        oParameters.data.sender_nickname = '<span style="text-decoration:line-through">' + oParameters.data.sender_nickname + '</span>';
    }
    if(oParameters.data.recipient_is_deleted == 1){
        oParameters.data.recipient_nickname = '<span style="text-decoration:line-through">' + oParameters.data.recipient_nickname + '</span>';
    }
	return true;
});
