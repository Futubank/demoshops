AMI.String = {
    decodeHTMLSpecialChars : function(content){
        return content.replace(/&(.{2,4});/gi, function(wholeString, match){
            // Remember to change php unhtmlentities when expanding replacements
            var associations = {
                '#039' : "'",
                '#037' : "%",
                '#035' : '#',
                'quot' : '"',
                'lt' : '<',
                'gt' : '>',
                'amp' : '&'
            };
            if(associations[match]){
                return associations[match];
            }else{
                return match;
            }
        });
    },

    decodeJSON: function(data){
        var oResult;
        eval('oResult = ' + data);
        return oResult;
    },

    stripTags: function(str){
        return str.replace(/<\/?[^\s^>]+[^>]*?>/gi, '');
    },

    trim: function(str){
        return str.replace(/^\s+/mg, '').replace(/\s+$/mg, '');
    }
}
