if (!AMI.Form)
    AMI.Form = {};
AMI.Form.Filter = {
    search_method : "action", // name search method (for GET request)
    search_text_name : "search_text", // name of input with text from search line
    submit_script_name : "submit_url", // name of hidden input, its value is: host + default script name
    subcategories_flag_name : "search_subcats", // server logic: if (search_subcats==1) then use current category as top level category for search
    search_from_current_category : true, // by default search is working from current category. can be changed by setSearchMode() method
    category_id_name : 'catid', // name of catid parameter
    
    mode : "filter", // Default mode. Only current category (and may be its subcategories too) used. Can be changed to "search"
    
    /**
     * Checks and submit FilterForm
     *
     * Actually, submit will be cancelled, all form fields will be placed in uri
     * @SubmittedForm - form to be parsed and submitted
     * @offset - related to page. If undefined, offset will be dropped.
     */
    submit : function(SubmittedForm, offset)
    {
        var el, val;
        
        // Create the submit URL
        var submit_url = '';
        
        // Cycle over all form textfields, checkboxes, radios, etc.
        for ( var i = 0 ; i <= SubmittedForm.length - 1 ; i++ )
        {
            el = SubmittedForm.elements[i];
            elName = el.name;

            if (el.type == 'checkbox') // input type checkbox
            {
                if (el.checked)
                {
                    if ((fpos = el.name.indexOf("_flag_")) >= 0)
                    {
                        flagMapAdd(el.name.substr(0, fpos), parseInt(el.name.substr(fpos+6)), 0);
                    }
                    else if (el.value != '')
                    {
                        submit_url += '&'+elName+'='+encodeURIComponent(el.value);
                    }
                    
                    // subcategories flag
                    if (elName == this.subcategories_flag_name)
                    {
                        this.subcategories_flag_string = '&' + elName + '=1';
                    }
                }
                else // unchecked
                {
                    if ((fpos = el.name.indexOf("_flag_")) >= 0) {
                        flagMapAdd(el.name.substr(0, fpos), parseInt(el.name.substr(fpos+6)), 1);
                    } else {
                        //if (el.name.indexOf("[]") <= 0) /* do not process array items */
                        // submit_url += '&'+elName+'=';
                    }
                }
            }
            if (el.type == 'select-one')
            {
                if ((fpos = el.name.indexOf("_flag")) >= 0)
                {
                    flagMapAdd(el.name.substr(0, fpos), parseInt(el.value), 0);
                }
                else if (el.value != '')
                {
                    submit_url += '&'+elName+'='+encodeURIComponent(el.value);
                }
            }
            if (el.type == 'select-multiple')
            {
                fpos = el.name.indexOf("_flag");
                for (k = 0; k < el.length; k++) {
                    if (el.options[k].selected) {
                        if (fpos >= 0) {
                            flagMapAdd(el.name.substr(0, fpos), parseInt(el.options[k].value), 0);
                        } else {
                            submit_url += '&'+encodeURIComponent(elName)+'='+encodeURIComponent(el.options[k].value);
                        }
                    }
                }
            }
            if (el.type == 'radio')
            {
                if (el.checked)
                {
                    if ((fpos = el.name.indexOf("_flag")) >= 0) {
                        flagMapAdd(el.name.substr(0, fpos), parseInt(el.value), 0);
                    } else {
                        submit_url += '&'+elName+'='+encodeURIComponent(el.value);
                    }
                }
            }
            if ( el.type == 'text' || el.type == 'hidden' )
            {
                var preserve_category_id = !((!this.search_from_current_category) && (el.name == this.category_id_name));
                var this_isnt_reserved_name = (el.name != this.search_method && el.name != this.search_text_name && el.name != this.submit_script_name && el.name != 'offset');
                if ( this_isnt_reserved_name && preserve_category_id && el.value != '' ) // prevent duplicating special fields
                    submit_url += '&' + elName + '=' + encodeURIComponent(el.value);
                if (offset)
                    submit_url += '&offset=' + offset;
            }
        }
        
        submit_url += '&' + this.search_method + '=' + this.getSearchMethodName( SubmittedForm, this.search_method );
        
        if (typeof this.subcategories_flag_string != 'undefined')
            submit_url += this.subcategories_flag_string;

        for(i = 0; i < flagMaps.length; i++) {
            if(flagNames[i]) {
                submit_url += '&'+flagNames[i]+'=0x'+arrToHex(flagMaps[i]);
            }
        }

        var search_text_value = this.getSearchText( SubmittedForm, this.search_text_name );
        if (search_text_value != '')
            submit_url += '&' + this.search_text_name + '=' + encodeURIComponent(search_text_value);
        
        submit_url = this.getScriptName(SubmittedForm) + '?' + submit_url;

        window.location.href = submit_url;
        return false;
    },
    
    /**
     * Submit form and set to input with name "letter" value @letter
     */
    submitWithLetter : function(letter)
    {
        if (this.main_form_name)
        {
            var forms = document.forms;
            var i = 0;
            // Finding main filter form
            while ( i <= document.forms.length - 1 && document.forms[i].name != this.main_form_name )
            {
                i++;
            }
            // If we find main form and there is an input type hidden with name 'letter'
            if ( document.forms[i] && document.forms[i].letter )
            {
                document.forms[i].letter.value = letter;
                this.submit( document.forms[i] );
            }
        }
    },
    
    /**
     * @varName - name of form field should be looked (e.g. "action")
     * @returns name of action, i.e. search method name. Not connected with form attr "action"!
     */
    getSearchMethodName : function ( SubmittedForm, varName )
    {
        // only slow search method finding items in all subcategories (fast method include only first level of subcats)
        if (SubmittedForm.search_subcats && SubmittedForm.search_subcats.checked)
        {
            this.setSlowSearchMethod();
            return this.searchMethodName;
        }
        
        if ( this.searchMethodName )
            return this.searchMethodName;
        
        this.setSlowSearchMethod(); // Slow method by default - for Enter submit form in IE
        return this.searchMethodName;
    },
    
    /**
     * Extracts varName from SubmittedForm. Input type text has priority over type hidden. Next input has proiroty over previous.
     *
     * @SubmittedForm - form to be submitted
     * @returns - search text (text from search line of current or previous request)
     */
    getSearchText : function ( SubmittedForm, varName )
    {
        var searchText = '';
        var missHidden = false;
        
        for ( var i = 0 ; i <= SubmittedForm.length - 1 ; i++ )
        {
            if ( SubmittedForm.elements[i].type == 'text' && SubmittedForm.elements[i].name == varName )
            {
                missHidden = true;
                searchText = SubmittedForm.elements[i].value;
            }
            if ( SubmittedForm.elements[i].type == 'hidden' && SubmittedForm.elements[i].name == varName && SubmittedForm.elements[i].value != '' )
            {
                if ( !missHidden )
                    searchText = SubmittedForm.elements[i].value;
            }
        }
        
        return searchText;
    },
    
    /**
     * Set current search method
     */
    setSearchMethodName : function ( name )
    {
        this.searchMethodName = name;
    },
    
    /**
     * Set "rsrtme" (resort me) method as current.
     *
     * Method "rsrtme" finding items only in current category and first level subcategories.
     */
    setFastSearchMethod : function ()
    {
        this.setSearchMethodName( 'rsrtme' );
    },
    
    /**
     * Set "search" (resort me) method as current.
     *
     * Method "search" finding items in current category and all subcategories
     */
    setSlowSearchMethod : function ()
    {
        this.setSearchMethodName( 'search' );
    },
    
    /**
     * Get the submit script name (first part of get request, like action attr of form)
     *
     * There are two ways: 1. Current uri; 2. Default, top level category uri.
     */
    getScriptName : function (SubmittedForm)
    {
        for ( var i = 0 ; i <= SubmittedForm.length - 1 ; i++ )
        {
            if ( SubmittedForm.elements[i].name == this.submit_script_name )
                this.submit_script_value = SubmittedForm.elements[i].value;
        }
        
        var link_without_get_params = window.location.href.slice( 0, window.location.href.indexOf('\?') );
        
        if ( link_without_get_params.indexOf(this.submit_script_value) == -1 || !this.search_from_current_category ) // if we are not in catalog or there is flag, indicating to search from top level category
            return this.submit_script_value;        
        else // we are somewhere in catalog and there is no need to serach from top level category
            return document.location.pathname;
    },
    
    /**
     * Setting search mode, when all catalog is used for search (top level category), and slow search method applied
     *
     * @search_from_current_category - bool flag. if true - search is working from current category, if false - from top level category
     */
    setSearchMode : function (search_from_current_category)
    {
        if (typeof search_from_current_category === "boolean")
            this.search_from_current_category = search_from_current_category;
        this.setSlowSearchMethod(); // Slow search method? for subcategories search
        this.subcategories_flag_string = '&' + this.subcategories_flag_name + '=1'; // it is needed for searching in not top level category (bad server logic)
        this.mode = 'search';
    }
}
