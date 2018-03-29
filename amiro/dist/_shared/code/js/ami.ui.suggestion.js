AMI.UI.Suggestion = function (fieldId, aRequestData, itemsSplitter){
    this.aRequestData = aRequestData || {};

    this.minimumFieldTextLength = 3; // Minimum length of text in parent field when suggestion should be shown
    this.fillRowsTimeout = 500; // Time between last key up and new rows load
    this.maxNameLength = 65; // Maximum length befor ... in dropdown list

    this.fieldId = fieldId;
    this.fieldObject = null;
    this.suggestionId = fieldId + '_suggestion';
    this.suggestionObject = null;
    this.suggestionObjectShown = false;
    this.suggestionIframeObject = null;
    this.allowProcessing = true;
    this.showCauseOfArrows = false;

    this.rowObjects = [];
    this.currentRow = -1;
    this.fillTimeout = null;

    this.itemsSplitter = typeof(itemsSplitter) != 'undefined' ? itemsSplitter : '';
    this.lastFieldValueLength = 0;
    this.doStoreFieldValue = true;
    this.isFieldValueModified = false;
    this.storedFieldValue = '';
    this.fieldLeadingSpaces = '';
    this.itemInitialCaretPosition = 0;
    this.itemEndCaretPosition = 0;

    this.scriptName = 'ami_resp';
    this.scriptExt = 'php';

    // Initialize: Attach class events to text field and other actions
    this.init = function(){
        this.fieldObject = document.getElementById(this.fieldId);
        this.storedFieldValue = this.fieldObject.value;
        this.lastFieldValueLength = this.storedFieldValue.length;

        AMI.Browser.Event.addHandler(this.fieldObject, 'mousedown', function(currentObject){return function(currentEvent){currentObject.onFieldMouseDown(currentEvent)}}(this));
        AMI.Browser.Event.addHandler(this.fieldObject, 'keydown', function(currentObject){return function(currentEvent){currentObject.onFieldKeyDown(currentEvent)}}(this));
        AMI.Browser.Event.addHandler(this.fieldObject, 'keyup', function(currentObject){return function(currentEvent){currentObject.onFieldKeyUp(currentEvent)}}(this));
        AMI.Browser.Event.addHandler(this.fieldObject, 'blur', function(currentObject){return function(currentEvent){currentObject.onFieldBlur(currentEvent)}}(this));
        AMI.Browser.Event.addHandler(this.fieldObject, 'focus', function(currentObject){return function(currentEvent){currentObject.showCauseOfArrows = true; currentObject.startShowObject(true)}}(this));
    }

    this.setDebug = function(aReceived){
        if(DEBUG_BY_IP && typeof(aReceived.debug) != 'undefined'){
            var oDebugBlock = document.getElementById('amid');
            if(oDebugBlock != null){
                oDebugBlock.innerHTML = oDebugBlock.innerHTML + aReceived.debug;
            }
        }
    }

    //
    // Event handlers
    //

    this.onFieldMouseDown = function(currentEvent){
        if((this.showCauseOfArrows || this.allowProcessing) && this.suggestionObjectShown && this.itemsSplitter != ''){
            this.hideSuggestionObject();
        }

        return true;
    }

    // Key down is used for arrow and escape processing
    this.onFieldKeyDown = function(currentEvent){
        currentEvent = AMI.Browser.Event.validate(currentEvent);
        if(currentEvent.keyCode == 38 || currentEvent.keyCode == 40){
            AMI.Browser.Event.stopProcessing(currentEvent);
        }

        if(!this.allowProcessing && !this.showCauseOfArrows){
            return true;
        }

        if(this.suggestionObjectShown){
            if(currentEvent.keyCode == 38 || currentEvent.keyCode == 40){
                if(this.doStoreFieldValue){
                    this.storedFieldValue = this.fieldObject.value;
                    this.doStoreFieldValue = false;
                }
                var rowIndex = this.currentRow + (currentEvent.keyCode == 40 ? 1 : -1);
                if(rowIndex > this.rowObjects.length - 1){
                    rowIndex = -1;
                }else if(rowIndex < -1){
                    rowIndex = this.rowObjects.length - 1;
                }
                this.selectRow(rowIndex, true);
            }else if(currentEvent.keyCode == 27){
                this.resetFieldText();
                this.closeSuggestionObject();
                AMI.Browser.setCaretPosition(this.fieldObject, this.itemInitialCaretPosition);
                AMI.Browser.Event.stopProcessing(currentEvent);
            }else if(currentEvent.keyCode == 13){
                var bSubmit = true;
                if(this.currentRow >= 0 && typeof(this.rowObjects[this.currentRow]) != 'undefined'){
                    if(this.rowObjects[this.currentRow].getAttribute('rowType') == 'result'){
                        var resultURL = this.rowObjects[this.currentRow].getAttribute('rowValue');
                        if(resultURL != ''){
                            document.location = resultURL;
                            bSubmit = false;
                        }
                    }
                }
                this.doStoreFieldValue = true;
                this.hideSuggestionObject();
                AMI.Browser.setCaretPosition(this.fieldObject, this.itemEndCaretPosition);
                AMI.Browser.Event.stopProcessing(currentEvent);
                if(bSubmit){
                    this.submitForm();
                }
            }else if(this.itemsSplitter != '' && (currentEvent.keyCode == 35 || currentEvent.keyCode == 36 || currentEvent.keyCode == 37 || currentEvent.keyCode == 39)){
                this.hideSuggestionObject();
            }
        }

        return true;
    }

    // Key up shows/hides suggestion object when user typing
    this.onFieldKeyUp = function(currentEvent){

        currentEvent = AMI.Browser.Event.validate(currentEvent);

        var doInitActionsCauseOfArrows = false;
        if(!this.showCauseOfArrows){
            this.showCauseOfArrows = (!this.suggestionObjectShown && (currentEvent.keyCode == 38 || currentEvent.keyCode == 40));
            doInitActionsCauseOfArrows = this.showCauseOfArrows;
        }

        if(!this.allowProcessing && !this.showCauseOfArrows){
            return true;
        }

        if(currentEvent.keyCode == 27 || currentEvent.keyCode == 13){
            return false;
        }

        this.startShowObject(doInitActionsCauseOfArrows);

        return true;
    }

    this.startShowObject = function(doInitActionsCauseOfArrows){
        if(this.lastFieldValueLength != this.fieldObject.value.length){
            this.doStoreFieldValue = true;
            this.lastFieldValueLength = this.fieldObject.value.length;
        }else if(!doInitActionsCauseOfArrows){
            return false;
        }

        var currentItem = this.getEditedItemText();
        if(currentItem.length >= this.minimumFieldTextLength){
            this.itemInitialCaretPosition = AMI.Browser.getCaretPosition(this.fieldObject);

            // Create content div
            if(this.suggestionObject == null){
                this.createSuggestionObject();
            }

            // Fill rows
            clearTimeout(this.fillTimeout);
            if(doInitActionsCauseOfArrows){
                this.fillRows();
            }else{
                this.fillTimeout = setTimeout(function(currentObject){return function(){currentObject.fillRows()}}(this), this.fillRowsTimeout);
            }
        }else{
            this.hideSuggestionObject();
        }
    }

    this.doNotCloseOnBlur = false;

    // Hide suggestion object upon blur
    this.onFieldBlur = function(currentEvent){
        if(this.doNotCloseOnBlur){
            this.doNotCloseOnBlur = false;
            return true;
        }

        if(!this.allowProcessing && !this.showCauseOfArrows){
            return true;
        }

        this.hideSuggestionObject();
        return true;
    }

    this.onSuggestionObjectClick = function(currentEvent){
        currentEvent = AMI.Browser.Event.validate(currentEvent);
        var currentTarget = AMI.Browser.Event.getTarget(currentEvent);
        if(currentTarget.tagName){
            if(currentTarget.tagName == 'A' && currentTarget.className == 'suggestionClose'){
                this.resetFieldText();
                this.closeSuggestionObject();
                AMI.Browser.setCaretPosition(this.fieldObject, this.itemInitialCaretPosition);
                AMI.Browser.Event.stopProcessing(currentEvent);
            }else if(currentTarget.tagName == 'A'){
                this.fieldObject.focus();
                this.doNotCloseOnBlur = true;
            }else if(currentTarget.tagName == 'DIV'){
                if(currentTarget.className.indexOf('suggestionRow') == 0){
                    currentIndex = currentTarget.getAttribute('rowIndex');
                    this.selectRow(currentIndex, true);
                    this.hideSuggestionObject();
                    this.submitForm();
                }
            }
        }
        return true;
    }

    //
    // Create / show / hide object functions
    //

    this.createSuggestionObject = function(){
        contentDiv = document.createElement('div');
        contentDiv.id = this.suggestionId;
        contentDiv.className = 'suggestionDiv';

        var fieldPosition = AMI.Browser.getObjectPosition(this.fieldObject);
        contentDiv.style.left = fieldPosition[0] + 'px';
        contentDiv.style.top = fieldPosition[1] + this.fieldObject.offsetHeight + 'px';
        contentDiv.style.height = '12px';

        contentDiv.onmousedown = function(currentObject){return function(currentEvent){currentObject.onSuggestionObjectClick(currentEvent)}}(this);

        this.suggestionObject = document.body.appendChild(contentDiv);
    }

    this.showSuggestionObject = function(bHasHistory, bHasResults){
        this.suggestionObject.style.height = ((this.rowObjects.length - (!bHasHistory ? 1 : 0)) * 15 + (bHasResults ? 42 : 2)) + 'px';

        if(!this.suggestionObjectShown && this.suggestionObject != null){
            this.selectRow(-1, false);

            var fieldPosition = AMI.Browser.getObjectPosition(this.fieldObject);
            contentDiv.style.left = fieldPosition[0] + 'px';
            this.suggestionObject.style.display = 'block';

            var iScreenLeft = AMI.Browser.getDocumentLeft();
            var iScreenRight = AMI.Browser.getWindowWidth() + iScreenLeft - 2;
            var iRightPoint = fieldPosition[0] + this.suggestionObject.offsetWidth;
            if(iRightPoint > iScreenRight){
                contentDiv.style.left = fieldPosition[0] - (iRightPoint - iScreenRight) + 'px';
            }

            this.suggestionObjectShown = true;
        }
    }

    this.hideSuggestionObject = function(){
        this.showCauseOfArrows = false;
        clearTimeout(this.fillTimeout);
        if(this.suggestionObjectShown && this.suggestionObject != null){
            this.suggestionObject.style.display = 'none';
            this.suggestionObjectShown = false;
        }
    }

    this.closeSuggestionObject = function(){
        this.allowProcessing = false;
        this.hideSuggestionObject();
    }

    //
    // Manage data in object
    //

    this.fillRows = function(){
        var url = document.location.protocol + '//' + document.location.host + '/' + this.scriptName + '.' + this.scriptExt + '?';

        var cnt = 0;
        this.aRequestData['phrase'] = this.getEditedItemText();
        for(var name in this.aRequestData){
            url = url + (cnt++ > 0 ? '&' : '') + encodeURIComponent(name) + '=' + encodeURIComponent(this.aRequestData[name]);
        }

        AMI.HTTPRequest.getContent(
            'GET',
            url,
            '',
            function(_this){
                return function(state, content){
                    _this.fillRowsCallback(state, content)
                }
            }(this)
        );
    }

    this.fillRowsCallback = function(state, content){
        if(state == 1){
            this.currentRow = -1;
            this.rowObjects = [];
            this.suggestionObject.innerHTML = '';
            var fieldText = this.getEditedItemText();
            var bHasHistory = false;
            var bHasResults = false;

            if(content.length){
                var aReceived = {};

                if(content.indexOf('{') != 0){
                    aReceived.debug = 'Unknown data received for block ' + this.idContainer + ': ' + content;
                    this.setDebug(aReceived);
                    return;
                }

                aReceived = AMI.String.decodeJSON(content);
                var bResultInserted = false;
                if(typeof(aReceived) == 'object' && typeof(aReceived.data) != 'undefined'){

                    this.setDebug(aReceived);

                    for(var i = 0; i < aReceived.data.list.length; i++){
                        if(typeof(aReceived.data.list[i].query) != 'undefined'){
                            var name = this.trimText(aReceived.data.list[i].query);
                            var itemValue = name;
                            var itemType = 'suggestion';
                            var bExact = aReceived.data.list[i].query == fieldText;
                            bHasHistory = true;
                        }else{
                            name = '<a href="' + aReceived.data.list[i].link + '" title="' + document.location.protocol + '//' + document.location.host + '/' + aReceived.data.list[i].link.replace('"', '&quot;') + '">' + this.trimText(aReceived.data.list[i].name) + '</a>';
                            itemValue = aReceived.data.list[i].link;
                            itemType = 'result'
                            bExact = false;
                            bHasResults = true;
                        }

                        if(itemType == 'result' && !bResultInserted){
                            bResultInserted = true;
                            var oResultsDiv = AMI.Browser.DOM.create('div', '', 'suggestionResult' + (i == 0 ? 'First' : ''), '', this.suggestionObject);
                            oResultsDiv.innerHTML = 'Результаты поиска:';
                        }

                        this.appendRow(name, itemValue, itemType, bExact);

                        if(itemType == 'result' && i == aReceived.data.list.length - 1){
                            this.appendResultsRow();
                        }
                    }
                }
            }

            if(bHasHistory || bHasResults){
                var minWidthDiv = AMI.Browser.DOM.create('div', '', 'suggestionMinWidth', '', this.suggestionObject);
                minWidthDiv.style.width = this.fieldObject.offsetWidth - 3 + 'px';

                this.showSuggestionObject(bHasHistory, bHasResults);
            }else{
                this.hideSuggestionObject();
            }
        }
    }

    this.trimText = function(data){
        if(data.length > this.maxNameLength){
            data = data.substr(0, this.maxNameLength) + '...';
        }
        return data;
    }

    this.appendRow = function(itemText, itemValue, itemType, isExact){
        var currentIndex = this.rowObjects.length;
        this.rowObjects[currentIndex] = AMI.Browser.DOM.create('div', this.fieldId + '_suggestionItem_' + currentIndex, 'suggestionRow' + (isExact ? ' suggestionRowExact' : ''), '', this.suggestionObject);
        this.rowObjects[currentIndex].innerHTML = itemText;
        this.rowObjects[currentIndex].setAttribute('rowIndex', currentIndex);
        this.rowObjects[currentIndex].setAttribute('rowValue', itemValue);
        this.rowObjects[currentIndex].setAttribute('rowType', itemType);
        this.rowObjects[currentIndex].setAttribute('rowExact', isExact ? '1' : '0');
        this.rowObjects[currentIndex].onmouseover = function(currentObject, divIndex){return function(){currentObject.selectRow(divIndex, false)}}(this, currentIndex);
    }

    this.appendResultsRow = function(){
        var currentIndex = this.rowObjects.length;
        this.rowObjects[currentIndex] = AMI.Browser.DOM.create('div', this.fieldId + '_suggestionItem_' + currentIndex, 'suggestionRow suggestionRowAllResults', '', this.suggestionObject);
        this.rowObjects[currentIndex].setAttribute('rowIndex', currentIndex);
        this.rowObjects[currentIndex].setAttribute('rowValue', '');
        this.rowObjects[currentIndex].setAttribute('rowType', 'resultAll');
        this.rowObjects[currentIndex].setAttribute('rowExact', '0');
        this.rowObjects[currentIndex].onmouseover = function(currentObject, divIndex){return function(){currentObject.selectRow(divIndex, false)}}(this, currentIndex);

        var oResultsOthersLink = AMI.Browser.DOM.create('a', '', 'suggestionAllResults', '', this.rowObjects[currentIndex]);
        oResultsOthersLink.href = 'javascript:void(0)';
        oResultsOthersLink.innerHTML = 'Все результаты &raquo;';
        oResultsOthersLink.onclick = function(_this){return function(){_this.submitForm()}}(this);
    }

    this.selectRow = function(rowIndex, setRowText){
        if(this.currentRow >= 0){
            this.rowObjects[this.currentRow].className = 'suggestionRow' + (this.rowObjects[this.currentRow].getAttribute('rowExact') == '1' ? ' suggestionRowExact' : '') + (this.rowObjects[this.currentRow].getAttribute('rowType') == 'resultAll' ? ' suggestionRowAllResults' : '');
        }
        if(rowIndex != null && rowIndex >= 0){
            this.rowObjects[rowIndex].className = 'suggestionRowSelected' + (this.rowObjects[rowIndex].getAttribute('rowExact') == '1' ? ' suggestionRowExact' : '') + (this.rowObjects[rowIndex].getAttribute('rowType') == 'resultAll' ? ' suggestionRowAllResults' : '');
        }

        if(setRowText){
            if(rowIndex != null && rowIndex >= 0){
                var rowType = this.rowObjects[rowIndex].getAttribute('rowType');
                if(rowType == 'suggestion'){
                    this.setItemText(this.rowObjects[rowIndex].getAttribute('rowValue'));
                    this.lastFieldValueLength = this.fieldObject.value.length;
                    this.isFieldValueModified = true;
                }else{
                    this.resetFieldText();
                }
            }else{
                this.resetFieldText();
            }
        }

        this.currentRow = rowIndex;
    }

    this.resetFieldText = function(){
        if(this.isFieldValueModified){
            var caretPosition = AMI.Browser.getCaretPosition(this.fieldObject);
            this.fieldObject.value = this.storedFieldValue;
            AMI.Browser.setCaretPosition(this.fieldObject, caretPosition);
            this.lastFieldValueLength = this.fieldObject.value.length;
        }
    }

    this.getEditedItemText = function(){
        var itemText = '';
        if(this.itemsSplitter != ''){
            var splitterLength = this.itemsSplitter.length;
            var caretPosition = AMI.Browser.getCaretPosition(this.fieldObject);
            var items = this.fieldObject.value.split(this.itemsSplitter);
            var currentLength = 0;
            for(var i = 0; i < items.length; i++){
                currentLength += items[i].length + (i > 0 ? splitterLength : 0);
                if(currentLength >= caretPosition){
                    itemText = items[i];
                    break;
                }
            }
        }else{
            itemText = this.fieldObject.value;
        }

        itemText = itemText.replace(/^( *)(.*) *$/, function(currentObject){return function(wholeString, spaces, content){
            currentObject.fieldLeadingSpaces = spaces;
            return content;
        }}(this));
        return itemText;
    }

    this.setItemText = function(textValue){
        if(this.itemsSplitter != ''){
            var splitterLength = this.itemsSplitter.length;
            var caretPosition = AMI.Browser.getCaretPosition(this.fieldObject);
            var items = this.fieldObject.value.split(this.itemsSplitter);
            var currentLength = 0;
            var isReplaced = false;
            var result = '';
            for(var i = 0; i < items.length; i++){
                currentLength += items[i].length + (i > 0 ? splitterLength : 0);
                var itemValue = items[i];
                if(!isReplaced && currentLength >= caretPosition){
                    itemValue = this.fieldLeadingSpaces + AMI.String.decodeHTMLSpecialChars(textValue);
                    isReplaced = true;
                    this.itemEndCaretPosition = currentLength + itemValue.length - items[i].length;
                }
                result += (result != '' ? this.itemsSplitter : '') + itemValue;
            }
            this.fieldObject.value = result;
            AMI.Browser.setCaretPosition(this.fieldObject, caretPosition);
        }else{
            this.fieldObject.value = this.fieldLeadingSpaces + AMI.String.decodeHTMLSpecialChars(textValue);
            this.itemEndCaretPosition = this.fieldObject.value.length;
        }
    }

    this.submitForm = function(){
        if(this.fieldObject != null && typeof(this.fieldObject.form) != 'undefined'){
            this.fieldObject.form.submit();
        }
    }

    // Do initializing
    this.init();
}