AMI.UI.Multiselect = function(idField, iWidth, iRowHeight){
    this.oField = document.getElementById(idField);
    this.oControl = null;
    
    this.lastOptionNumber = -1;
    this.lastOptionSelected = true;
    this.bAllowMoveSelection = false;
    this.hMoveSelectionStop = null;
    
    this.init = function(){
        if(this.oField != null){
            var width = iWidth || this.oField.offsetWidth;
            var height = this.oField.offsetHeight;
            var rowHeight = 18 || iRowHeight;
            var numRows = this.oField.getAttribute('size');
            if(numRows != null && numRows > 0){
                height = rowHeight * numRows;
            }
            
            this.oControl = AMI.Browser.DOM.create(
                'DIV',
                '',
                'mSelectFrame',
                'width: ' + width + 'px; height: ' + height + 'px;'
            );
            this.oControl = this.oField.parentNode.insertBefore(this.oControl, this.oField);
            if(typeof(this.oControl.onselectstart) != 'undefined'){
                this.oControl.onselectstart = function(){ return false; };
            }
            if(typeof(this.oControl.style.MozUserSelect) != 'undefined'){
                this.oControl.style.MozUserSelect = 'none'; 
            }
            this.oField.style.display = 'none';
            
            for(i = 0; i < this.oField.options.length; i++){
                var oOption = AMI.Browser.DOM.create(
                    'DIV',
                    '',
                    'mSelectOption' + (this.oField.options[i].selected ? 'Selected' : ''),
                    'height: ' + rowHeight + 'px; line-height: ' + rowHeight + 'px;',
                    this.oControl
                );
                oOption.innerHTML = this.oField.options[i].text;
                oOption.setAttribute('optionNumber', i);
                oOption.setAttribute('optionValue', this.oField.options[i].value);
                oOption.onmousedown = function(_this){ return function(evt){_this.selectOption(evt, this)} }(this);
                oOption.onmouseup = function(_this){ return function(){_this.selectOptionStop(true)} }(this);
                oOption.onmouseover = function(_this){ return function(evt){_this.selectOptionOnMove(evt, this)} }(this);
                oOption.onmouseout = function(_this){ return function(){_this.selectOptionStop(false)} }(this);
            }
        }
    };
    
    this.selectOption = function(evt, oOption){
        var bSelected = oOption.className == 'mSelectOptionSelected';
        var optionNumber = oOption.getAttribute('optionNumber');
        
        evt = AMI.Browser.Event.validate(evt);
        
        if(evt.shiftKey && this.lastOptionNumber >= 0 && this.lastOptionNumber != optionNumber){
            var iStartIndex = Math.min(optionNumber, this.lastOptionNumber);
            var iEndIndex = Math.max(optionNumber, this.lastOptionNumber);
            aOptions = this.oControl.getElementsByTagName('DIV');
            for(var i = 0; i < aOptions.length; i++){
                var iIntervalOptionNumber = aOptions[i].getAttribute('optionNumber');
                if(iIntervalOptionNumber != null && iIntervalOptionNumber >= iStartIndex && iIntervalOptionNumber <= iEndIndex){
                    this.doSelectOption(aOptions[i], iIntervalOptionNumber, this.lastOptionSelected);
                }
            }
        }else{
            this.doSelectOption(oOption, optionNumber, !bSelected);
        }
        
        if(this.lastOptionNumber == -1 || !evt.shiftKey){
            this.lastOptionNumber = optionNumber;
            this.lastOptionSelected = this.oField.options[optionNumber].selected;
        }
        
        this.bAllowMoveSelection = true;
    }
    
    this.selectOptionOnMove = function(evt, oOption){
        if(this.bAllowMoveSelection){
            clearTimeout(this.hMoveSelectionStop);
            var optionNumber = oOption.getAttribute('optionNumber');
            this.doSelectOption(oOption, optionNumber, this.lastOptionSelected);
        }
    }
    
    this.selectOptionStop = function(bImmediate){
        if(bImmediate){
            clearTimeout(this.hMoveSelectionStop);
            this.bAllowMoveSelection = false;
        }else{
            this.hMoveSelectionStop = setTimeout(function(_this){ return function(){_this.bAllowMoveSelection = false;} }(this), 10);
        }
        
    }
    
    this.doSelectOption = function(oOption, optionNumber, bSelect){
        if(bSelect){
            oOption.className = 'mSelectOptionSelected';
            this.oField.options[optionNumber].selected = true;
        }else{
            oOption.className = 'mSelectOption';
            this.oField.options[optionNumber].selected = false;
        }
    }
    
    this.init();
}