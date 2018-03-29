AMI.UI.ToolTip = function(evt, text, minWidth, maxWidth){
    this.oOwner = AMI.Browser.Event.getTarget(AMI.Browser.Event.validate(evt));
    this.text = text;
    this.oToolTip = null;
    
    this.bMovable = false;
    
    this.show = function(evt){
        if(this.oOwner != null){
            if(this.oOwner.getAttribute('isToolTipInstalled') != '1'){
                AMI.Browser.Event.addHandler(
                    this.oOwner,
                    'mouseout',
                    function(_this){return function(){_this.hide()}}(this)
                );
                AMI.Browser.Event.addHandler(
                    this.oOwner,
                    'mousemove',
                    function(_this){return function(evt){_this.move(evt)}}(this)
                );
                this.oOwner.setAttribute('isToolTipInstalled', '1');
            }
            var oPosition = this.getPosition(evt);
            this.oToolTip = AMI.Browser.DOM.create(
                'DIV',
                '',
                'AMIToolTip',
                'left: ' + oPosition[0] + 'px; top: ' + oPosition[1] + 'px;',
                document.body
            );
            
            minWidth = 0 || minWidth;
            maxWidth = 0 || maxWidth;
            if(minWidth > 0 && maxWidth > 0 && minWidth == maxWidth){
                this.oToolTip.style.width = minWidth + 'px';
            }else{
                if(minWidth > 0){
                    this.oToolTip.style.minWidth = minWidth + 'px';
                }
                if(maxWidth > 0){
                    this.oToolTip.style.maxWidth = maxWidth + 'px';
                }
            }
            
            this.oToolTip.innerHTML = this.text;
            this.oToolTip.style.display = 'block';
            this.correctPosition();
            this.bMovable = true;
        }
    }
    
    this.getPosition = function(evt){
        var oPointer = AMI.Browser.getPointerPosition(evt);
        return [parseInt(oPointer[0]) + 11, parseInt(oPointer[1]) + 16];
    }
    
    this.correctPosition = function(){
        var iLeft = parseInt(this.oToolTip.style.left) + this.oToolTip.offsetWidth;
        var iMinRight = document.body.scrollLeft;
        var iMaxRight = iMinRight + AMI.Browser.getWindowWidth();
        if(iLeft > iMaxRight){
            iLeft = Math.max(iMinRight, iMaxRight - this.oToolTip.offsetWidth);
            this.oToolTip.style.left = iLeft + 'px';
        }
    }
    
    this.move = function(evt){
        if(this.bMovable){
            var oPosition = this.getPosition(evt);
            this.oToolTip.style.left = oPosition[0] + 'px';
            this.oToolTip.style.top = oPosition[1] + 'px';
            this.correctPosition();
        }
    }
    
    this.hide = function(){
        if(this.oToolTip && this.oToolTip.parentNode){
            this.oToolTip.parentNode.removeChild(this.oToolTip);
            this.oToolTip.style.display = 'none';
            this.bMovable = false;
            this.oOwner.setAttribute('isToolTipInstalled', '');
        }
    }
    
    this.show(evt);
}