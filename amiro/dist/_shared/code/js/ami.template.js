AMI.Template = {
    currentValues : null,
    conditionStrings : [],

    storeConditionStrings : function(match, quote, str, offset, originalString){
        var result = this.conditionStrings.length;
        this.conditionStrings[result] = quote + str + quote;
        return '"' + result + '"';
    },

    restoreConditionStrings : function(match, position, offset, originalString){
        if(typeof(this.conditionStrings[position]) != 'undefined'){
            return this.conditionStrings[position];
        }else{
            return '';
        }
    },

    getCondition : function(construction){
        construction = construction.replace(/\\'/g, "'").replace(/\\\\/g, '\\').replace(/&amp;/g, '&');
        this.conditionStrings = [];
        construction = construction.replace(
            /('|")((?:.|[\r\n])*?)\1/g,
            function(_this){
                return function(match, quote, str, offset, originalString){
                    return _this.storeConditionStrings(match, quote, str, offset, originalString);
                }
            }(this)
        );
        construction = construction.replace(/(^|[^"\'A-Za-z\_0-9\[])([0-9A-Za-z\_]*[A-Za-z_]+[0-9A-Za-z\_]*)([^\]"\'A-Za-z\_0-9\(\[]|$)/g, '$1AMI.Template.getValue("$2")$3');
        construction = construction.replace(
            /"(\d+)"/g,
            function(_this){
                return function(match, position, offset, originalString){
                    return _this.restoreConditionStrings(match, position, offset, originalString);
                }
            }(this)
        );
        return construction;
    },

    replaceSpecial : function(match, construction, offset, originalString){
        var result = '';
        if(matches = construction.match(/^if\((.*?)\)$/)){
            result = "'; if(" + this.getCondition(matches[1]) + "){evalResult += '";
        }else if(matches = construction.match(/^else if\((.*?)\)$/)){
            result = "';} else if(" + this.getCondition(matches[1]) + "){evalResult += '";
        }else if(construction == 'else'){
            result = "';} else { evalResult += '";
        }else if(construction == 'endif'){
            result = "';} evalResult += '";
        }else if(/^[a-zA-Z0-9_\.\-]+$/.test(construction)){
            result = "' + AMI.Template.getValue('" + construction + "') + '";
        }else{
            result = match;
        }
        return result;
    },

    getValue : function(varKey){
        if(typeof(this.currentValues[varKey]) != 'undefined'){
            return this.currentValues[varKey];
        }else{
            return '';
        }
    },

    parse : function(content, aData){
        content = "'" + content.replace(/\\/g, '\\' + '\\').replace(/'/g, "\\'").replace(/\r/g, '').replace(/\n/g, "\\" + "\n") + "';";
        content = content.replace(
            /@@(.*?)@@/g,
            function(_this){
                return function(match, construction, offset, originalString){
                    return _this.replaceSpecial(match, construction, offset, originalString);
                }
            }(this)
        );

        this.currentValues = aData;
        var evalResult = '';
        eval('evalResult = ' + content);

        return evalResult;
    },

    getTemplate: function(elementId){
        var content = '';
        var oElement = AMI.find('#' + elementId);
        if(oElement != null){
            content = oElement.innerHTML;
            content = content.replace(/^\s*<\!--([\s\S]*)-->\s*$/i, '$1');
        }
        return content;
    }
}

AMI.Template.Locale = {
    oDictionary: {},

    init: function(oDictionary){
        this.oDictionary = oDictionary;
    },

    /**
     * Set single caption
     *
     * @param  {string} key
     * @param  {string} caption
     * @return void
     */
    set : function(key, caption){
        this.oDictionary[key] = caption;
    },

    /**
     * Append only new captions to dictionary
     *
     * @param  {object} oDictionary  Object containing properties as keys and its values as captions
     * @return void
     */
    append : function(oDictionary){
        for(var key in oDictionary){
            if(typeof(this.oDictionary[key]) == 'undefined'){
                this.oDictionary[key] = oDictionary[key];
            }
        }
    },

    /**
     * Append new captions, override obsolete
     *
     * @param  {object} oDictionary  Object containing properties as keys and its values as captions
     * @return void
     */
    merge : function(oDictionary){
        for(var key in oDictionary){
            this.oDictionary[key] = oDictionary[key];
        }
    },

    /**
     * Get caption by key
     *
     * @param  {string} key
     * @return {string} | null
     */
    get : function(key, warn){
        if('undefined' === typeof(warn)){
            warn = true;
        }
        if(warn && 'undefined' === typeof(this.oDictionary[key])){
            if(typeof(console) == 'object' && typeof(console.warn) == 'function'){
                // firebug debugging
                console.warn("Undefined dictionary key '" + key + "'");
                // console.trace();
            }
            return null;
        }else{
            return this.oDictionary[key];
        }
    },

    /**
     * Parse caption specified by key using variables
     *
     * @param  {string} key
     * @param  {object} oVariables  Object containing properties as keys and its values as captions
     * @return {string} | null
     */
    parse : function(key, oVariables){
        var caption = this.get(key);
        if(caption){
            for(var variable in oVariables){
                caption = caption.replace('_' + variable + '_', oVariables[variable]);
            }
        }
        return caption;
    }
}

function print_r( array, return_val ) {    // Prints human-readable information about a variable

    var output = "", pad_char = " ", pad_val = 4;

    var formatArray = function (obj, cur_depth, pad_val, pad_char) {
        if(cur_depth > 0)
            cur_depth++;

        var base_pad = repeat_char(pad_val*cur_depth, pad_char);
        var thick_pad = repeat_char(pad_val*(cur_depth+1), pad_char);
        var str = "";

        if(obj instanceof Array || obj instanceof Object) {
            str += "Array\n" + base_pad + "(\n";
            for(var key in obj) {
                if(obj[key] instanceof Array || obj[key] instanceof Object) {
                    str += thick_pad + "["+key+"] => "+formatArray(obj[key], cur_depth+1, pad_val, pad_char);
                } else {
                    str += thick_pad + "["+key+"] => " + obj[key] + "\n";
                }
            }
            str += base_pad + ")\n";
        } else {
            str = obj.toString();
        };

        return str;
    };

    var repeat_char = function (len, char) {
        var str = "";
        for(var i=0; i < len; i++) { str += char; };
        return str;
    };

    output = formatArray(array, 0, pad_val, pad_char);

    if(return_val !== true) {
        document.write("<pre>" + output + "</pre>");
        return true;
    } else {
        return output;
    }
}
