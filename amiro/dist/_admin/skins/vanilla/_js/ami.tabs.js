var cTabs = function(blockName, aTabs, bAttach){

    this.oBlock = null;
    this.aBlockTabs = new Array();

    this.aTabs = new Array();
    this.aActiveTabs = new Object();

    this.bAttachSupported = false;
    this.bAttachBreaks = new Object();

    this.tabLineBreak = null;

    this.initialized = false;

    this.init = function(blockName, aTabs, bAttach){
        // Need to fix bug with iFrame reload in Opera
        this.initialized = false; //(typeof(window.opera) != 'undefined');

        this.oBlock = document.getElementById(blockName);
        if(typeof(bAttach) == "undefined"){
          var bAttach = true;
        }
        if(this.oBlock != null){

            var bHasNotAttachedActiveTabs = false;
            var oFirstNotAtachedTabs = null;

            var iLength = -1;
            for(idTab in aTabs){
              iLength++;
            }
            for(idTab in aTabs){
                if(idTab == ''){
                  continue;
                }

                this.aTabs[this.aTabs.length] = idTab;

                var oTab = document.createElement('div');
                oTab.id = 'tab-control-' + idTab;
                oTab.setAttribute('idTab', idTab);
                if(aTabs[idTab][2]){
                    oTab.setAttribute('title', aTabs[idTab][2]);
                }
                oTab.innerHTML = '<div class="tab-caption"><div class="tab-left-side"></div><div class="tab-label" id="tab-control-'+idTab+'-label">' + aTabs[idTab][0] + '</div><div class="tab-right-side"></div></div>';
                oTab.onmouseover = function(){if (this.className != "tab-active" && this.className != "tab-disabled") this.className="tab-over";};
                oTab.onmouseout = function(){if (this.className == "tab-over") this.className="tab-normal";};
                oTab = this.oBlock.appendChild(oTab);

                oTab.onclick = function(oCurrentTabs, oActionTab){ return function(){
                    oCurrentTabs.selectTab(oActionTab, true, true);
                }}(this, oTab);

                var bIsTabNotAttached = true;
                var bIsTabNotAttachedAndActive = false;

                if(bAttach && (iLength > 1)){
                    var bAttachable = true;
                    /*if(!bIsIE){
                        var aTextareas = document.getElementById('tab-page-' + idTab).getElementsByTagName('textarea');
                        if(aTextareas.length == 1){
                            if(aTextareas[0].getAttribute('id') == aTextareas[0].getAttribute('name')){
                                bAttachable = false;
                            }
                        }
                    }*/

                    if(bAttachable){
                        this.bAttachSupported = true;
                        var oDiv = document.createElement('div');
                        oDiv.id = 'tab-attached-' + idTab;
                        oDiv.onclick = function(oCurrentTabs, oActionTab){ return function(oEvent){ oCurrentTabs.attachTab(oActionTab); oEvents.stopEvent(oEvent); }}(this, oTab);
                        oTab.appendChild(oDiv);

                        if(aTabs[idTab][3]){
                            bIsTabNotAttached = false;
                            this.attachTabOn(oTab);
                        }else{
                            this.attachTabOff(oTab);
                        }
                    }
                }

                this.aBlockTabs.push(oTab);
                if(aTabs[idTab][1] == 'active'){
                    if(!this.selectTab(oTab)){
                        oTab.className = 'tab-normal';
                        this.onTabSelected(idTab, false);
                    }else{
                        bIsTabNotAttachedAndActive = true;
                        this.onTabSelected(idTab, true);
                    }
                 }else{
                    this.onTabSelected(idTab, false);
                 }
                oTab.className = 'tab-' + aTabs[idTab][1];

                if(this.bAttachSupported){
                    var tabAttachValue = amiCookies.get(this.getTabAttachCookieName(idTab));
                    if(tabAttachValue != null){
                        this.attachTab(oTab, tabAttachValue == 1 ? 'on' : 'off');
                        if(tabAttachValue == 1){
                            bIsTabNotAttached = false;
                            bIsTabNotAttachedAndActive = false;
                        }
                    }
                }

                if(bIsTabNotAttached && oFirstNotAtachedTabs == null){
                    oFirstNotAtachedTabs = oTab;
                }
                if(bIsTabNotAttachedAndActive){
                    bHasNotAttachedActiveTabs = true;
                }
            }
            var oBR = document.createElement('br');
            oBR.setAttribute('clear', 'all');
            this.tabLineBreak = this.oBlock.appendChild(oBR);

            var oDiv = document.createElement('div');
            oDiv.className = 'tab-bottom';
            this.oBlock.appendChild(oDiv);

            if(!bHasNotAttachedActiveTabs && oFirstNotAtachedTabs != null){
                this.selectTab(oFirstNotAtachedTabs, false);
            }
        }

        this.reloadForm();

        this.initialized = true;
    }

    this.parseHashBangArgs = function(aURL) {

        aURL = aURL || window.location.hash;

        var vars = {};
        var hashes = aURL.slice(aURL.indexOf('#') + 1).split('&');

        for(var i = 0; i < hashes.length; i++) {
            var hash = hashes[i].split('=');

            if(hash.length > 1) {
                vars[hash[0]] = hash[1];
            } else {
                vars[hash[0]] = null;
            }
        }

        return vars;
    }

    this.saveTab = function(idTab){
        var hash = this.parseHashBangArgs();
        if(typeof(hash['id']) != 'undefined'){
            var path = AMI.Cookie.getModPath();
            AMI.Cookie.set('ami_tab', idTab, 3600, path, true);
            AMI.Cookie.save(true, true);
        }
    }

    this.reloadForm = function(){
        if(typeof(window.listernerAdded) == 'undefined'){
            AMI.Message.addListener(
                'ON_COMPONENT_CONTENT_PLACED',
                function(_this){
                    return function(oComponent){
                        if(oComponent.componentType == 'form'){
                            _this.restoreTab();
                        }
                        return true;
                    }
                }(this),
                true
            );
            window.listernerAdded = true;
        }
    }

    this.restoreTab = function(){
        if(typeof(baseTabs) == 'undefined'){
            return;
        }
        var hash = baseTabs.parseHashBangArgs();
        if((typeof(hash['id']) != 'undefined') && (hash['id'] != '')){
            if(AMI.Cookie.get('ami_tab') != null){
                var idTab = AMI.Cookie.get('ami_tab');
                var tabIndex = baseTabs.aTabs.indexOf(idTab);
                if(tabIndex >= 0){
                    var attached = AMI.$('#' + baseTabs.aBlockTabs[tabIndex].id).attr('attached');
                    if(attached != 'on'){
                        baseTabs.selectTab(baseTabs.aBlockTabs[tabIndex]);
                    }
                }
            }
        }
    }

    this.getTabAttachCookieName = function(sTabName){
        var currentModule = module_name || 'notmodule';
        return 'bTabAttached.' + currentModule + '.' + sTabName;
    }

    this.selectTab = function(oCurrentTab, bDeactivateOtherTabs, bSaveTab){

        if(typeof(bSaveTab) == 'undefined'){
            bSaveTab = false;
        }

        if(typeof(bDeactivateOtherTabs) == 'undefined'){
            bDeactivateOtherTabs = true;
        }

        if(this.oBlock != null){
            if(oCurrentTab.className != 'tab-disabled'){
                var idTab = oCurrentTab.getAttribute('idTab');
                var iNumberOfActive = 0;
                for(var i in this.aActiveTabs){ iNumberOfActive ++; }
                if(oCurrentTab.className == 'tab-active'){
                    if(iNumberOfActive > 1){
                        // Check if this is one tab from not-active
                        var bDoSelection = true;
                        var iCurrentTabIndex = -1;
                        for(var i = 0; i < this.aTabs.length; i++){
                            if(this.aTabs[i] == idTab){
                                iCurrentTabIndex = i;
                            }else{
                                var oTab = document.getElementById('tab-control-' + this.aTabs[i]);
                                if(oTab.className != 'tab-disabled' && oTab.getAttribute('attached') != 'on' && this.isTabActive(this.aTabs[i])){
                                    bDoSelection = false;
                                    break;
                                }
                            }
                        }

                        if(!bDoSelection || iCurrentTabIndex < 0){
                            // Inactivate
                            if(!this.onTabSelected(idTab, false)){
                              return false;
                            }
                            //this.attachTabOff(oCurrentTab);
                            oCurrentTab.className = 'tab-normal';
                            delete this.aActiveTabs[idTab];
                        }

                        // Attach off
                        this.attachTabOff(oCurrentTab);

                        return false;
                    }
                }else{
                    if(!this.onTabSelected(idTab, true)){
                        return false;
                    }
                    var aActiveTabsNew = new Object();
                    for (var i in this.aActiveTabs){
                        if(this.aActiveTabs[i] && (this.aActiveTabs[i].getAttribute('attached') != 'on')){
                            if(bDeactivateOtherTabs && this.onTabSelected(this.aActiveTabs[i].getAttribute('idTab'), false)){
                                this.aActiveTabs[i].className = 'tab-normal';
                            }else{
                                aActiveTabsNew[this.aActiveTabs[i].getAttribute('idTab')] = this.aActiveTabs[i];
                            }
                        }else{
                            aActiveTabsNew[this.aActiveTabs[i].getAttribute('idTab')] = this.aActiveTabs[i];
                        }
                    }
                    this.aActiveTabs = aActiveTabsNew;
                    oCurrentTab.className='tab-active';
                    this.aActiveTabs[idTab] = oCurrentTab;

                    if(bSaveTab){
                        this.saveTab(idTab);
                    }

                    return true;
                }
            }
        }
    }

    this.showTab = function(idTab){
      this.setTabState(idTab, "active");
    }

    this.isTabActive = function(idTab){
      for(var i in this.aActiveTabs){
        if(this.aActiveTabs[i].getAttribute('idTab') == idTab){
            return true;
        }
      }
      return false;

    }

    this.setTabState = function(idTab, sState){
      for(i = 0; i < this.aBlockTabs.length; i++){
        if(this.aBlockTabs[i].getAttribute('idTab') == idTab){
          if(sState == "active"){
            this.selectTab(this.aBlockTabs[i]);
          }else if(sState == "normal"){
            this.attachTabOff(this.aBlockTabs[i]);
            this.aBlockTabs[i].className = 'tab-normal';
            delete this.aActiveTabs[idTab];
          }else if(sState == "disabled"){
            this.attachTabOff(this.aBlockTabs[i]);
            this.aBlockTabs[i].className = 'tab-disabled';
            delete this.aActiveTabs[idTab];
          }
        }
      }
    }

    this.attachTab = function(oCurrentTab, forceValue){
        if(this.oBlock != null && this.bAttachSupported){
            var bAttach = oCurrentTab.getAttribute('attached') != "on";
            if(typeof(forceValue) != 'undefined'){
                bAttach = forceValue == 'on';
            }

            if(!bAttach){
              this.attachTabOff(oCurrentTab);
              amiCookies.set(this.getTabAttachCookieName(oCurrentTab.getAttribute('idTab')), '0', '/', 1, 0);

              if(oCurrentTab.className != 'tab-normal'){
                   this.selectTab(oCurrentTab, false);
              }
            }else{
              this.attachTabOn(oCurrentTab);
              amiCookies.set(this.getTabAttachCookieName(oCurrentTab.getAttribute('idTab')), '1', '/', 1, 0);

              if(oCurrentTab.className != 'tab-active'){
                   this.selectTab(oCurrentTab, false);
              }
            }
        }
    }

    this.attachTabOn = function(oCurrentTab){
        if(this.oBlock != null && this.bAttachSupported){
            oCurrentTab.setAttribute('attached', 'on');
            document.getElementById('tab-attached-' + oCurrentTab.getAttribute('idTab')).className = 'tab-attached tab-attached-on';

            var idTab = oCurrentTab.getAttribute('idTab');

            var isCurrentTabActive = this.isTabActive(idTab);

            var oSheet = document.getElementById('tab-page-' + idTab);

            var objectBefore = null;
            var bStartSearch = false;
            for(var i = 0; i < this.aTabs.length; i++){
                if(this.aTabs[i] == idTab){
                    bStartSearch = true;
                }else if(bStartSearch){
                    var oTab = document.getElementById('tab-control-' + this.aTabs[i]);
                    if(oTab.getAttribute('attached') == 'on'){
                        objectBefore = oTab;
                        break;
                    }
                }
            }

            // Fix FF bug https://bugzilla.mozilla.org/show_bug.cgi?id=254144 that also present in other browsers such as Opera, Chrome
            var oRestoreEditorObject = this.fixIframeBugBeforeMoving(oSheet);

            if(objectBefore){
                oSheet = objectBefore.parentNode.insertBefore(oSheet, objectBefore);
            }else{
                oSheet = oSheet.parentNode.appendChild(oSheet);
            }
            oSheet.parentNode.insertBefore(oCurrentTab, oSheet);

            // Continue of fixing iframe reloading bug
            if(oRestoreEditorObject != null){
                if(this.initialized){
                    oRestoreEditorObject.reInitIframe();
                }
            }

            var oBR = document.createElement('br');
            oBR.setAttribute('clear', 'all');
            this.bAttachBreaks[idTab] = oSheet.parentNode.insertBefore(oBR, oSheet);

            if(isCurrentTabActive){
                iCurrentTabIndex = -1;
                for(var i = 0; i < this.aTabs.length; i++){
                    if(this.aTabs[i] == idTab){
                        iCurrentTabIndex = i;
                    }else if(iCurrentTabIndex >= 0){
                        // Move to function
                        var oTab = document.getElementById('tab-control-' + this.aTabs[i]);
                        if(!this.isTabActive(this.aTabs[i]) && oTab.className != 'tab-disabled'){
                            this.setTabState(this.aTabs[i], 'active');
                            this.saveTab(this.aTabs[i]);
                            iCurrentTabIndex = -1;
                            break;
                        }
                    }
                }
                if(iCurrentTabIndex != -1 && iCurrentTabIndex != 0){
                    for(var i = iCurrentTabIndex - 1; i >= 0; i--){
                        // Move to function
                        var oTab = document.getElementById('tab-control-' + this.aTabs[i]);
                        if(!this.isTabActive(this.aTabs[i]) && oTab.className != 'tab-disabled'){
                            this.setTabState(this.aTabs[i], 'active');
                            this.saveTab(this.aTabs[i]);
                            iCurrentTabIndex = -1;
                            break;
                        }
                    }
                }
            }
        }
    }

    this.attachTabOff = function(oCurrentTab){
        if(this.oBlock != null && this.bAttachSupported){
            oCurrentTab.setAttribute('attached', 'off');
            var oTabPin = document.getElementById('tab-attached-' + oCurrentTab.getAttribute('idTab'))
            if(oTabPin != null){
                oTabPin.className = 'tab-attached tab-attached-off';

                var idTab = oCurrentTab.getAttribute('idTab');

                var objectBefore = this.tabLineBreak;
                var bStartSearch = false;
                for(var i = 0; i < this.aTabs.length; i++){
                    if(this.aTabs[i] == idTab){
                        bStartSearch = true;
                    }else if(bStartSearch){
                        var oTab = document.getElementById('tab-control-' + this.aTabs[i]);
                        if(oTab.getAttribute('attached') != 'on'){
                            objectBefore = oTab;
                            break;
                        }
                    }
                }

                if(objectBefore != null){
                    try{
                        // Some strange errors were here in async 5.0 form
                        this.oBlock.insertBefore(oCurrentTab, objectBefore);
                    }catch(e){}
                }

                if(this.bAttachBreaks[idTab]){
                    this.bAttachBreaks[idTab].parentNode.removeChild(this.bAttachBreaks[idTab]);
                    this.bAttachBreaks[idTab] = null;
                }

                var oSheet = document.getElementById('tab-page-' + idTab);

                // Fix FF bug https://bugzilla.mozilla.org/show_bug.cgi?id=254144 that also present in other browsers such as Opera, Chrome
                //debugMsg += 'Before moving: ' + idTab + '\n';
                var oRestoreEditorObject = this.fixIframeBugBeforeMoving(oSheet);

                oSheet = oSheet.parentNode.insertBefore(oSheet, oSheet.parentNode.firstChild);
                //debugMsg += 'Moving: ' + idTab + '\n';

                // Continue of fixing iframe reloading bug
                if(oRestoreEditorObject != null){
                    //debugMsg += 'ReInit: ' + idTab + '\n';
                    if(this.initialized){
                        oRestoreEditorObject.reInitIframe();
                    }
                }
            }
        }
    }

    this.fixIframeBugBeforeMoving = function(oSheet){
        var oRestoreEditorObject = null;
        if(!bIsIE || (bIsIE && parseInt(navigator.appVersion.match(/MSIE ([\d.]+)/)[1]) >= 9)){
            var aIframes = oSheet.getElementsByTagName('iframe');
            //debugMsg += 'Frames count: ' + aIframes.length + ', ' + (aIframes[0] && aIframes[0].id ? aIframes[0].id : 'id is not defined') + '\n';
            if(aIframes.length == 1 && aIframes[0].id){
                var idEditorPos = aIframes[0].id.indexOf('_editor');
                if(idEditorPos > 0){
                    //debugMsg += 'Editor idetifier found\n';
                    var oTextarea = document.getElementById(aIframes[0].id.substr(0, idEditorPos));
                    /*if(oTextarea != null){
                        debugMsg += 'Textarea for editor found\n';
                    }*/
                    if(oTextarea != null && oTextarea.editorAttached){
                        //debugMsg += 'Editor is attached for textarea, object returned\n';
                        oRestoreEditorObject = oTextarea.editorObject;
                        if(oRestoreEditorObject.currentMode == 'editor' && oTextarea.editorInitialized){
                            //debugMsg += 'Content stored to textarea\n';
                            oRestoreEditorObject.transportTextFromEditorToTextarea(true);
                        }
                    }
                }
            }
        }
        return oRestoreEditorObject;
    }

    this.onTabSelected = function(idTab, bState){
        if(typeof(onTabSelectedCustom) == 'function'){
            if(!onTabSelectedCustom(idTab, bState)){
                return false;
            }
        }

        var oDiv = document.getElementById('tab-page-' + idTab);
        if(oDiv != null){
            oDiv.style.display = bState ? 'block' : 'none';
        }

        return true;
    }

    this.init(blockName, aTabs, bAttach);
  }
