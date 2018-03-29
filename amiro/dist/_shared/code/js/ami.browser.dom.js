AMI.Browser.DOM = {
    create: function(sTagName, sId, sClassName, sStyles, oParentNode){
        var oObject = document.createElement(sTagName);
        if(typeof(sId) != 'undefined' && sId != ''){
            oObject.id = sId;
        }
        if(typeof(sClassName) != 'undefined' && sClassName != ''){
            oObject.className = sClassName;
        }
        if(typeof(sStyles) != 'undefined' && sStyles != ''){
            oObject.style.cssText = sStyles;
        }
        return oParentNode == null ? oObject : this.append(oParentNode, oObject);
    },

    append: function(oParentNode, oNode){

        return oParentNode.appendChild(oNode);
    },

    remove: function(oNode){
        oNode.parentNode.removeChild(oNode);
        return this;
    },

    setInnerHTML: function(oNode, HTML){
        var aJavaScripts = [];
        // TODO: get back comments replacement. Commented because amiro-template structure <s cript><!-- --></s cript>
        //HTML = HTML.replace(/<!--[\s\S]*?-->/ig, '').replace(/(<script[\s\S]*?>)([\s\S]*?)(<\/script>)/ig, function(_aJavaScripts){return function(match, tagStart, code, tagEnd){
        HTML = HTML.replace(/(<script[\s\S]*?>)([\s\S]*?)(<\/script>)/ig, function(_aJavaScripts){return function(match, tagStart, code, tagEnd){
            if(tagStart.indexOf('text/javascript') != -1){
                if(tagStart.indexOf('src=') == -1){
                    _aJavaScripts.push(code);
                    replacement = '';
                }else{
                    var
                        oScript = document.createElement('SCRIPT'),
                        reSRC = /src=["']?([^"'>\s]+)/,
                        reComponentId = /data-ami-component-id=["']?([^"'>\s]+)/;
                    oScript.setAttribute('type', 'text/javascript');
                    oScript.setAttribute('onload', "AMI.Message.send('ON_SCRIPT_LOAD', '" + reComponentId.exec(tagStart)[1] + "');");
                    oScript.setAttribute('src', reSRC.exec(tagStart)[1]);
                    AMI.find('head')[0].appendChild(oScript);
                    replacement = '';
                }
            }else{
                replacement = match;
            }
            return replacement;
        }}(aJavaScripts));

        oNode.innerHTML = HTML; //.replace(/<_AMI_SCRIPT/g, '<script').replace(/_AMI_DBL_PRCNT_/g, '%%');
        for(var i = 0; i < aJavaScripts.length; i++){
            if(window.execScript){
                try{
                    window.execScript(aJavaScripts[i]);
                }catch(e){
                    // alert('Error in script: ' + aJavaScripts[i]);
                }
            }else{
                try{
                    eval.call(window, aJavaScripts[i]);
                }catch(e){
                    if('object' === typeof(console)){
                        console.log('JavaScript syntax error: ' + e.stack);
                        console.log('-- code { --\n\n' + aJavaScripts[i] + '\n\n-- } code --');
                    }
                }
            }
        }
    },

    getCSSSelectors: function(){
        var aResult = [];

        if(typeof(document.styleSheets) != 'undefined'){
            var aCSSSheets = document.styleSheets;
            if(aCSSSheets && (typeof(aCSSSheets.length) != 'undefined')){
                for(var i = 0; i < aCSSSheets.length; i++){
                    if(aCSSSheets[i].disabled){
                        continue;
                    }
                    try{
                        var aRules = typeof(aCSSSheets[i].cssRules) != 'undefined' ? aCSSSheets[i].cssRules : aCSSSheets[i].rules;
                        for(var j = 0; j < aRules.length; j++){
                            aResult.push(aRules[j].selectorText);
                        }
                    }catch(e){};
                }
            }
        }

        return aResult;
    },

    findCSSClass: function(classMask){
        var aResult = [];
        var rx = new RegExp('\\.' + classMask + '($|[^a-z\-_])', 'i');

        var aSelectors = this.getCSSSelectors();
        for(var i = 0; i < aSelectors.length; i++){
            if(rx.test(aSelectors[i])){
                aResult.push(aSelectors[i]);
            }
        }

        return aResult;
    },

    getStyle: function(oObject, sStyleName){
        var sResult = '';

        if(window.getComputedStyle){
            var oDeclaration = window.getComputedStyle(oObject, sStyleName);
            sResult = oDeclaration.getPropertyValue(sStyleName);
        }else if(oObject.currentStyle){
            var i;
            while((i = sStyleName.indexOf("-")) != -1){
                sStyleName = sStyleName.substr(0, i) + sStyleName.substr(i+1,1).toUpperCase() + sStyleName.substr(i+2);
            }

            if(oObject.currentStyle[sStyleName]){
                sResult = oObject.currentStyle[sStyleName];
            }
        }

        return sResult;
    },

    allDescendants: function(element) {
        var res = [];
        for (var i = 0; i < element.childNodes.length; i++) {
            var child = element.childNodes[i];
            var children = AMI.allDescendants(child);
            res.push(child);
            if(children.length){
                for(var j = 0; j < children.length; j++){
                    res.push(children[j]);
                }
            }
        }
        return res;
    },

    getMaxZIndex: function(){
        var elements = document.getElementsByTagName("*");
        var res = 0;

        for (var i = 0; i < elements.length - 1; i++) {
            if (parseInt(elements[i].style.zIndex) > res) {
                res = parseInt(elements[i].style.zIndex);
            }
        }
        return res;
    }
}