AMI.UI.showBlock = function(idLink, idBlock, shownClassName, mReplacement){
    
    this.oLink = AMI.find('#' + idLink);
    this.oBlock = AMI.find('#' + idBlock);
    this.blockHiddenHeight = 0;
    this.blockFullHeight = 0;
    this.hiddenClassName = this.oLink != null ? this.oLink.className : '';
    this.shownClassName = shownClassName;
    this.replacement = mReplacement || null;
    this.originalLinkContent = this.oLink.innerHTML;
    
    this.hAnimation = null;
    this.aAnimationInterval = 10;
    this.animationIteration = 0;
    this.currentHeight = 0;
    this.destinationHeight = 0;

    this.init = function(){
        this.blockHiddenHeight = this.oBlock.offsetHeight;
        AMI.Browser.Event.addHandler(this.oLink, 'click', function(_this){return function(evt){_this.onLinkClick(evt); return false;}}(this));
    }
    
    this.onLinkClick = function(evt){
        clearTimeout(this.hAnimation);
        AMI.Browser.Event.stopProcessing(evt);
        var currentState = this.oBlock.getAttribute('data-showblock-state');
        if(currentState == 'shown'){
            if(this.shownClassName != null){
                this.oLink.className = this.hiddenClassName;
            }
            if(this.replacement != null){
                this.oLink.innerHTML = this.originalLinkContent;
            }
            this.oBlock.setAttribute('data-showblock-state', 'hidden');

            if(this.oBlock.offsetHeight > this.blockHiddenHeight){
                this.startAnimation(this.blockHiddenHeight);
            }
        }else{
            if(this.shownClassName != null){
                this.oLink.className = this.shownClassName;
            }
            if(this.replacement != null){
                this.oLink.innerHTML = typeof(this.replacement) == 'object' ? this.replacement.innerHTML : this.replacement;
            }
            this.oBlock.setAttribute('data-showblock-state', 'shown');

            this.blockFullHeight = this.oBlock.scrollHeight;
            if(this.blockFullHeight > this.blockHiddenHeight){
                this.startAnimation(this.blockFullHeight);
            }
        }
    }
    
    this.startAnimation = function(destinationHeight){
        this.animationIteration = 0;
        this.currentHeight = this.oBlock.offsetHeight;
        this.destinationHeight = destinationHeight;
        this.move();
    }
    
    this.move = function(){
        this.animationIteration ++;
        var difference = Math.abs(this.currentHeight - this.destinationHeight);
        
        var step = 1;
        if(difference < 50){
            step = Math.max(1, difference / 3);
        }else{
            step = Math.min(step + this.animationIteration, 20);
        }
        
        if(this.currentHeight < this.destinationHeight){
            this.currentHeight += step;
            this.currentHeight = Math.min(this.currentHeight, this.destinationHeight);
        }else if(this.currentHeight > this.destinationHeight){
            step *= -1;
            this.currentHeight += step;
            this.currentHeight = Math.max(this.currentHeight, this.destinationHeight);
        }else{
            step = 0;
        }
        
        this.oBlock.style.height = this.currentHeight + 'px';

        if(step != 0){
            this.hAnimation = setTimeout(
                function(_this){return function(){_this.move(); return false;}}(this),
                this.aAnimationInterval
            );
        }
    }
    
    this.init();
}