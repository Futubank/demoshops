if(typeof(amiSkinController) !== 'undefined'){
    amiSkinController.gaSendEvent = function(gAction, gValue){
        if((typeof(amiSkinController.toolbar) !== 'undefined') && (typeof(amiSkinController.toolbar.ga) !== 'undefined')){
            var gCategory = 'frn:' + window.active_module;
            amiSkinController.toolbar.ga('send', 'event', gCategory, gAction, gValue);
        }
    };
}

