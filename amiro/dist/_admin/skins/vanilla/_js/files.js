AMI.Message.addListener(
    'ON_FILE_UPLOADED',
    function(oUploader, oParameters){
        if(oParameters.code != 'uploaded'){
            var ext = 'OTHER', aMatches = oParameters.name.match(/\.([^\.]+)$/i);
            if(aMatches != null && aMatches.length >= 2){
                ext = aMatches[1].toLowerCase();
                if(typeof(aExtXFileType[ext]) == 'undefined'){
                    ext = 'OTHER';
                }
            }
            oUploader.fileCodeField.form.elements['type'].value = aExtXFileType[ext];
        }
        return true;
    }
);
