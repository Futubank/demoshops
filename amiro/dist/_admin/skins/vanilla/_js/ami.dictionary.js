/**
 * @param object dictionary  Object containing properties as keys and its values as captions
 * @return void
 */
function amiDictionary(dictionary){
    /**
     * @var object
     */
    this.dictionary = typeof(dictionary) == 'object' ? dictionary : {};

    /**
     * Set single caption
     *
     * @param string key
     * @param string caption
     * @return void
     */
    this.set = function(key, caption){
        this.dictionary[key] = caption;
    }

    /**
     * Append only new captions to dictionary
     *
     * @param object dictionary  Object containing properties as keys and its values as captions
     * @return void
     */
    this.append = function(dictionary){
        for(var key in dictionary){
            if(typeof(this.dictionary[key]) == 'undefined'){
                this.dictionary[key] = dictionary[key];
            }
        }
    }

    /**
     * Append new captions, override obsolete
     *
     * @param object dictionary  Object containing properties as keys and its values as captions
     * @return void
     */
    this.megre = function(dictionary){
        for(var key in dictionary){
            this.dictionary[key] = dictionary[key];
        }
    }

    /**
     * Get caption by key
     *
     * @param string key
     * @return string | null
     */
    this.get = function(key){
        if(typeof(this.dictionary[key]) == 'undefined'){
            if(typeof(console) == 'object' && typeof(console.warn) == 'function'){
                // firebug debugging
                console.warn("Undefined dictionary key '" + key + "'");
                // console.trace();
            }
            return null;
        }else{
            return this.dictionary[key];
        }
    }

    /**
     * Parse caption specified by key using variables
     * Example:
     * <code>
     * <script type="text/javascript">
     * var dictionary = new amiDictionary({js_alert_missing_field: 'Fill _field_ field please!'});
     * alert(dictionary.parse('js_alert_missing_field', {field: 'name'}));
     * </script>
     * </code>
     *
     * @param string key
     * @param object variables  Object containing properties as keys and its values as captions
     * @return string | null
     */
    this.parse = function(key, variables){
        var caption = this.get(key);
        if(caption){
            for(var variable in variables){
                caption = caption.replace('_' + variable + '_', variables[variable]);
            }
        }
        return caption;
    }
}