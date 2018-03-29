AMI.HTTPRequest = {

    requests: [],
    variables: {},
    urlHash: '',

    // Init XML HTTP object
    _initObjectRequest: function(requestId){
        try{
            this.requests[requestId]['transport'] = new XMLHttpRequest();
        }catch(exception){
            this.requests[requestId]['transport'] = null;
        }
        if(this.requests[requestId]['transport'] == null){
            for(var i = 0; i < 2; i++){
                activeXName = i == 0 ? 'Msxml2.XMLHTTP' : 'Microsoft.XMLHTTP';
                try{
                    this.requests[requestId]['transport'] = new ActiveXObject(activeXName);
                }catch(exception){
                    this.requests[requestId]['transport'] = null;
                }
                if(this.requests[requestId]['transport'] != null){
                    break;
                }
            }
        }
        return (this.requests[requestId]['transport'] != null);
    },

    // Create query string from variables object
    _getRequestVariables: function(requestId){
        var variables = '';
        for(var key in this.requests[requestId]['variables']){
            variables += variables.length > 0 ? '&' : '';
            variables += encodeURIComponent(key) + '=' + encodeURIComponent(this.requests[requestId]['variables'][key]);
        }
        return variables;
    },

    // Create valid url for request
    _prepeareUrl: function(requestId){
        var url = this.requests[requestId]['url'];
        if(this.requests[requestId]['method'] == 'GET'){
            var variables = this._getRequestVariables(requestId);
            if(variables.length > 0){
                url = url + '?' + variables;
            }
            if(this.requests[requestId]['hash'].length > 0){
                url = url + '#' + encodeURIComponent(this.requests[requestId]['hash']);
            }
        /*}else if(this.requests[requestId]['method'] == 'POST'){
            var variables = this._getRequestVariables(requestId);
            this.requests[requestId]['transport'].send(variables);*/
        }
        return url;
    },

    // Process request for session parameters
    _request: function(requestId){
        if(this._initObjectRequest(requestId)){
            this.requests[requestId]['transport'].open(this.requests[requestId]['method'], this._prepeareUrl(requestId), true);
            if(this.requests[requestId]['method'] == 'GET'){
                this.requests[requestId]['transport'].setRequestHeader('If-Modified-Since', 'Sat, 1 Jan 2000 00:00:00 GMT');
                this.requests[requestId]['transport'].send(null);
            }else{
                this.requests[requestId]['transport'].setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                this.requests[requestId]['transport'].send(this._getRequestVariables(requestId));
            }
			this.resetRequestVariables();
            setTimeout('AMI.HTTPRequest._checkResponse('+requestId+')', 10);
        }else{
            alert('Problem with XML HTTP initialization');
        }
    },

    // Check the response from server and process action
    _checkResponse: function(requestId){
        if(this.requests[requestId]['transport'].readyState == 4){
            if(this.requests[requestId]['transport'].status == 200){
                this.requests[requestId]['status'] = 1;
                this.requests[requestId]['content'] = this.requests[requestId]['transport'].responseText;
            }
            else if(this.requests[requestId]['transport'].status == 401){ // Unauthorized
                this.requests[requestId]['status'] = 3;
            }
            else{
                this.requests[requestId]['status'] = 2;
            }
            if(this.requests[requestId]['callback'] != null){
                this.requests[requestId]['callback'](this.requests[requestId]['status'], this.requests[requestId]['content']);
            }
            this.requests[requestId]['transport'] = null;
            this.requests[requestId] = null;
        }else{
            setTimeout('AMI.HTTPRequest._checkResponse('+requestId+')', 10);
        }
    },

    // Remove all query variables
    resetRequestVariables: function(){
        this.variables = {};
    },

    // Add query variable
    addVariable: function(key, value, bDecode){
        bDecode = bDecode || false;
        if(bDecode){
            value = decodeURIComponent(value);
        }
        this.variables[decodeURIComponent(key)] = value;
    },

    // Set url hash code
    setUrlHash: function(value){
        this.urlHash = decodeURIComponent(value);
    },

    // Parse query string and create variables object
    setVariables: function(mVariables){
        if(mVariables != '')
            this.resetRequestVariables();
        if(typeof(mVariables) == 'object'){
            this.setUrlHash('');

            for(key in mVariables){
                this.addVariable(key, mVariables[key]);
            }
        }else if(mVariables != ''){
            mVariables = mVariables.replace(/^[\s?]*(.*?)[\s]*$/g, '$1');

            var aHash = mVariables.split('#');
            if(typeof(aHash[1]) != 'undefined'){
                mVariables = aHash[0];
                this.setUrlHash(aHash[1]);
            }else{
                this.setUrlHash('');
            }

            var aPairs = mVariables.split('&');
            for(var i = 0; i < aPairs.length; i++){
                aPair = aPairs[i].split('=');
                if(aPair[0] != ''){
                    this.addVariable(aPair[0], aPair[1], true);
                }
            }
        }
    },

    addVariablesFromForm: function(oForm){
        for(var i = 0; i < oForm.elements.length; i++){
            var oField = oForm.elements[i];
            if(!oField.disabled && oField.name != ''){
                if(oField.type == 'checkbox' || oField.type == 'radio'){
                    if(oField.checked){
                        this.addVariable(oField.name, oField.value);
                    }
                }else{
                    this.addVariable(oField.name, oField.value);
                }
            }
        }
    },

    getContent: function(method, url, mVariables, callbackFunction){
        var requestId = this.requests.length;
        this.requests[requestId] = {};
        this.requests[requestId]['status'] = 0;
        this.requests[requestId]['callback'] = typeof(callbackFunction) == 'function' ? callbackFunction : null;
        this.requests[requestId]['transport'] = null;
        this.requests[requestId]['method'] = method.toUpperCase();
        this.requests[requestId]['url'] = url;
        this.setVariables(typeof(mVariables) == 'undefined' ? '' : mVariables);
        this.requests[requestId]['variables'] = this.variables;
        this.requests[requestId]['hash'] = this.urlHash;
        this.requests[requestId]['content'] = '';
        this._request(requestId);
    },

    submitForm: function(method, oForm, mAdditionalVariables, callbackFunction){
        var sURL = oForm.attributes.action.value;

        this.setVariables(typeof(mAdditionalVariables) == 'undefined' ? '' : mAdditionalVariables);
        this.addVariablesFromForm(oForm);

        this.getContent(
            method != '' ? method.toUpperCase() : (oForm.attributes.method && oForm.attributes.method.value.toLowerCase() == 'post' ? 'POST' : 'GET'),
            sURL,
            '',
            callbackFunction
        );
    },

    parseURL: function(url){
        var a = document.createElement('a');

        a.href = url;

        return a;
    },

    parseURLQuery: function(query){
        var oResult = {}, aPairs = query.split('&'), aPair;

        for(var i = 0; i < aPairs.length; i++){
            aPair = aPairs[i].split('=');
            oResult[aPair[0]] = aPair[1];
        }

        return oResult;
    }
}
