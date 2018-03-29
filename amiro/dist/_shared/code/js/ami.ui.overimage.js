AMI.UI.OverImage = {
    oBlock: null,
    hTimeout: null,

    onOver: function(evt){
        this.stopWaiting();
        var oTarget = AMI.Browser.Event.getTarget(evt);
        if(oTarget != null && oTarget.tagName && oTarget.tagName == 'IMG'){
            imageLink = oTarget.getAttribute('data-ami-mbover');
            if(imageLink != null && imageLink != ''){
                if(this.oBlock == null){
                    this.oBlock = AMI.Browser.DOM.create('DIV', '', 'amiOverImage', 'position: absolute', document.body);
                }
                this.oBlock.style.display = 'none';

                this.hTimeout = setTimeout(
                    function(_this, _oTarget, _imageLink){return function(){
                        var oImage = new Image();
                        oImage.onload = function(__this, __oTarget){return function(){__this.showBlock(__oTarget)}}(_this, _oTarget);
                        oImage.src = _imageLink;
                        _this.oBlock.innerHTML = '';
                        _this.oBlock.appendChild(oImage);
                    }}(this, oTarget, imageLink),
                    700
                );
            }
        }
    },

    onOut: function(evt){
        this.stopWaiting();
        var oTarget = AMI.Browser.Event.getTarget(evt);
        if(oTarget != null && oTarget.tagName && oTarget.tagName == 'IMG'){
            imageLink = oTarget.getAttribute('data-ami-mbover');
            if(this.oBlock != null && imageLink != null && imageLink != ''){
                this.oBlock.style.display = 'none';
            }
        }
    },

    stopWaiting: function(evt){
        clearTimeout(this.hTimeout);
    },

    showBlock: function(oParent){
        var aPosition = AMI.Browser.getObjectPosition(oParent);
        this.oBlock.style.display = 'block';
        this.oBlock.style.left = (aPosition[0] + oParent.offsetWidth) + 'px';
        this.oBlock.style.top = aPosition[1] + 'px';
    }
}
