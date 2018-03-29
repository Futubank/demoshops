AMI.UI.Slider = function(oParent, oBackward, oForward, iStep, bHorizontal){
    this.oParent = oParent;
    this.oSlider = null;
    this.oBackward = oBackward;
    this.oForward = oForward;
    this.iStep = iStep;
    this.bHorizontal = bHorizontal == undefined ? true : bHorizontal;

    this.currentPosition = 0;
    this.minPosition = 0;
    this.controlClassDisabled = 'disabled';

    this.hTimeout = null;
    this.bForward = true;
    this.iPeriod = 10; // ms
    this.toPosition = 0;

    this.bWheelAction = false;

    this.init = function(){
        this.oSlider = this.oParent.getElementsByTagName('div')[0];
        this.oBackward.onclick = function(_this){return function(){_this.setMoveParameters(true);_this.move()}}(this);
        this.oForward.onclick = function(_this){return function(){_this.setMoveParameters(false);_this.move()}}(this);
        AMI.Browser.Event.addHandler(this.oSlider, 'mousewheel', function(_this){return function(event){
            if( !_this.bWheelAction ){
                _this.bWheelAction = true;
                var delta = 0;
                if (event.wheelDelta) { /* IE/Opera. */
                    delta = event.wheelDelta/120;
                } else if (event.detail) { /* Mozilla. */
                    delta = -event.detail/3;
                }

                // todo: mousewheel only 1 step
                _this.setMoveParameters(delta > 0);
                _this.move();
            }
            if (event.preventDefault)
                event.preventDefault();

            event.returnValue = false;
        }}(this))
        this.reInit();
    }

    this.reInit = function(step){
        this.oBackward.className = this.oBackward.className + ' ' + this.controlClassDisabled;
        this.minPosition = Math.min(0, (this.bHorizontal ? this.oParent.offsetWidth - this.oSlider.offsetWidth : this.oParent.offsetHeight - this.oSlider.offsetHeight));
        if(typeof(step) != 'undefined'){
            this.iStep =  step;
        }
    }

    this.setMoveParameters = function(bForward){
        if(this.minPosition == 0){
            this.minPosition = Math.min(0, (this.bHorizontal ? this.oParent.offsetWidth - this.oSlider.offsetWidth : this.oParent.offsetHeight - this.oSlider.offsetHeight));
        }
        this.toPosition = Math.max(this.minPosition, Math.min(0, this.toPosition + this.iStep * (bForward ? 1 : -1)));
        this.bForward = bForward;
    }

    this.move = function(iIterationNumber){
        clearTimeout(this.hTimeout);
        if(typeof(iIterationNumber) == 'undefined'){
            iIterationNumber = 1;
        }
        var bContinue = true;
        var iMultiplier = AMI.Browser.isIE ? 5 : 1;
        var iDelta = 10 * iMultiplier;
        var iDiff = Math.abs(this.toPosition - this.currentPosition);
        if(iDiff < 15 || iIterationNumber <= 5 / iMultiplier){
            iDelta = 1 * iMultiplier;
        }else if(iDiff < 25 || iIterationNumber <= 10 / iMultiplier){
            iDelta = 3 * iMultiplier;
        }else if(iDiff < 50 || iIterationNumber <= 20 / iMultiplier){
            iDelta = 5 * iMultiplier;
        }
        iDelta *= this.bForward ? 1 : -1;
        var iPosition = this.currentPosition + iDelta;
        if(iPosition >= 0){
            bContinue = false;
            iPosition = 0;
            this.oBackward.className = this.oBackward.className + ' ' + this.controlClassDisabled;
        }else if(iPosition <= this.minPosition){
            bContinue = false;
            iPosition = this.minPosition;
            this.oForward.className = this.oForward.className + ' ' + this.controlClassDisabled;
        }else if(this.bForward && iPosition >= this.toPosition){
            bContinue = false;
            iPosition = this.toPosition;
        }else if(!this.bForward && iPosition <= this.toPosition){
            bContinue = false;
            iPosition = this.toPosition;
        }else{
            this.oBackward.className = this.oBackward.className.replace(this.controlClassDisabled, '');
            this.oForward.className = this.oForward.className.replace(this.controlClassDisabled, '');
        }

        this.currentPosition = iPosition;
        if(this.bHorizontal){
            this.oSlider.style.left = this.currentPosition + 'px';
        }else{
            this.oSlider.style.top = this.currentPosition + 'px';
        }

        if(bContinue){
            this.hTimeout = setTimeout(function(_this, _iIterationNumber){return function(){_this.move(_iIterationNumber)}}(this, ++iIterationNumber), this.iPeriod);
        }else{
            this.bWheelAction = false;
        }
    }

    this.init();
}
