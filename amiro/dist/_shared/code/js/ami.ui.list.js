AMI.UI.List = function(containerId, requestData){
    this.idContainer = containerId;
    this.oProgress = null;
    this.oContainer = null;
    this.oPrevious = null;
    this.oNext = null;
    this.oPlayPause = null;

    this.oDebug = null;

    this.sRowTemplateId = 'itemRowTemplate_' + containerId;
    this.aRequestData = requestData;

    // Refresh data
    this.refreshInterval = typeof(requestData.refreshInterval) == 'undefined' ? 0 : Math.max(1, parseFloat(requestData.refreshInterval));
    this.refreshIntervalInitial = this.refreshInterval;
    this.refreshMultiplier = typeof(requestData.refreshIntervalMultiplier) == 'undefined' ? 0 : Math.max(1, parseFloat(requestData.refreshIntervalMultiplier));
    this.refreshMaximum = typeof(requestData.refreshNumber) == 'undefined' ? 50 : Math.min(50, parseInt(requestData.refreshNumber));
    this.refreshMaximumInitial = this.refreshMaximum;
    this.refreshType = typeof(requestData.refreshType) == 'undefined' ? 'reload' : requestData.refreshType;
    this.refreshTimeout = null;
    this.refreshPaused = false;

    this.lastAction = '';
    this.lastRecordsCount = 0;

    this.scriptName = 'ami_resp';
    this.scriptExt = 'php';

    this.init = function(){
        this.oContainer = document.getElementById('amiContent' + containerId);
        this.oProgress = document.getElementById('amiProgress' + containerId);
        this.oPrevious = document.getElementById('amiNavPreviuos' + containerId);
        this.oNext = document.getElementById('amiNavNext' + containerId);
        this.oPlayPause = document.getElementById('amiNavPlayPause' + containerId);

        if(this.oProgress == null && this.oContainer != null){
            this.oProgress = AMI.Browser.DOM.create('DIV', '', 'amiListProgress', '', this.oContainer.parentNode);
            var oProgressImage = AMI.Browser.DOM.create('IMG', '', '', '', this.oProgress);
            oProgressImage.src = frontBaseHref + '/_img/ami_jsapi/loader.gif';
        }
        if(isNaN(this.refreshMaximum)){
            this.refreshMaximum = 0;
            this.refreshMaximumInitial = 0;
        }
        if(this.oPlayPause && this.refreshInterval > 0 && this.refreshMaximum > 0){
            this.oPlayPause.className = this.oPlayPause.className.replace(/\s*ami_resp_play_pause_disabled/, '');
        }

        AMI.Message.send('ON_AMI_LIST_READY', this.idContainer, this);
    }

    this.showProgress = function(){
        if(this.oProgress != null){
            var oPos = AMI.Browser.getObjectPosition(this.oContainer, true);
            this.oProgress.style.left = oPos[0] + 'px';
            this.oProgress.style.top = oPos[1] + 'px';
            this.oProgress.style.width = this.oContainer.offsetWidth + 'px';
            this.oProgress.style.height = this.oContainer.offsetHeight + 'px';
            this.oProgress.style.display = 'block';
        }
    }

    this.hideProgress = function(){
        if(this.oProgress != null){
            this.oProgress.style.display = 'none';
        }
    }

    this.updatePrevNext = function(iDisableNext){
        if(this.oPrevious != null){
            if(parseInt(this.aRequestData.offset) <= 0 && this.oPrevious.className.indexOf('ami_resp_prev_disabled') == -1){
                AMI.Message.send('ON_AMI_LIST_PREVIOUS_DISABLE', this.idContainer, this.oPrevious);
                this.oPrevious.className = this.oPrevious.className + (this.oPrevious.className.length > 0 ? ' ' : '') + 'ami_resp_prev_disabled';
            }else if(parseInt(this.aRequestData.offset) > 0 && this.oPrevious.className.indexOf('ami_resp_prev_disabled') >= 0){
                AMI.Message.send('ON_AMI_LIST_PREVIOUS_ENABLE', this.idContainer, this.oPrevious);
                this.oPrevious.className = this.oPrevious.className.replace(/\s*ami_resp_prev_disabled/, '');
            }
        }
        if(this.oNext != null && typeof(iDisableNext) != 'undefined'){
            if(iDisableNext && this.oNext.className.indexOf('ami_resp_next_disabled') == -1){
                AMI.Message.send('ON_AMI_LIST_NEXT_DISABLE', this.idContainer, this.oNext);
                this.oNext.className = this.oNext.className + (this.oNext.className.length > 0 ? ' ' : '') + 'ami_resp_next_disabled';
            }else if(!iDisableNext && this.oNext.className.indexOf('ami_resp_next_disabled') >= 0){
                AMI.Message.send('ON_AMI_LIST_NEXT_ENABLE', this.idContainer, this.oNext);
                this.oNext.className = this.oNext.className.replace(/\s*ami_resp_next_disabled/, '');
            }
        }
    }

    this.setDebug = function(aReceivedData){
        if(DEBUG_BY_IP && typeof(aReceivedData.debug) != 'undefined'){
            if(this.oDebug == null){
                this.oDebug = AMI.Browser.DOM.create('div', '', '', '', document.getElementById('ami_resp_outer_' + this.idContainer));
            }
            this.oDebug.innerHTML = '<div style="background: red; height: 1px; margin-bottom: 5px; overflow: hidden;"></div>' + aReceivedData.debug + this.oDebug.innerHTML;
        }
    }

    this.load = function(lastAction){
        if(typeof(lastAction) == 'undefined'){
            this.lastAction = 'load';
        }else{
            this.lastAction = lastAction;
        }

        clearTimeout(this.refreshTimeout);
        if(this.oContainer != null){
            this.showProgress();

            //var url = document.location.protocol + '//' + document.location.host + '/' + this.scriptName + '.' + this.scriptExt + '?';
            var url = frontBaseHref + this.scriptName + '.' + this.scriptExt + '?';
            var cnt = 0;
            for(var name in this.aRequestData){
                if(name != 'refresh' && name != 'refreshMultiplier' && name != 'refreshType'){
                    url = url + (cnt++ > 0 ? '&' : '') + encodeURIComponent(name) + '=' + encodeURIComponent(this.aRequestData[name]);
                }
            }
            AMI.HTTPRequest.getContent(
                'GET',
                url,
                '',
                function(_this){
                    return function(state, content){
                        _this.onContentReceived(state, content);
                    }
                }(this)
            );
        }
    }

    this.onContentReceived = function(state, content){
        if(state == 1){
            this.hideProgress();

            var aReceived = {};

            if(content.indexOf('{') != 0){
                aReceived.debug = 'Unknown data received for block ' + this.idContainer + ': ' + content;
                this.setDebug(aReceived);
                return;
            }

            aReceived = AMI.String.decodeJSON(content);
            var bDisableNext = true;
            if(typeof(aReceived) == 'object'){
                if(typeof(aReceived.code) != 'undefined' && aReceived.code == -1){
                    document.getElementById('ami_resp_outer_' + this.idContainer).style.display = 'none';
                    document.getElementById('ami_resp_forbidden_' + this.idContainer).innerHTML += " '" + aReceived.message + "'";
                    document.getElementById('ami_resp_forbidden_' + this.idContainer).style.display = 'block';
                    return;
                }

                this.setDebug(aReceived);

                if(typeof(aReceived.data) == 'object' && typeof(aReceived.data.list) == 'object'){
                    this.lastRecordsCount = aReceived.data.list.length;
                    if(aReceived.data.list.length == this.aRequestData.limit){
                        bDisableNext = false;
                    }

                    this.setListData(aReceived.data.list);
                    this.playNext();
                }
            }
            if(this.lastAction == 'next' && this.lastRecordsCount == 0){
                this.aRequestData.offset = Math.max(0, parseInt(this.aRequestData.offset) - parseInt(this.aRequestData.limit));
            }
            if(this.refreshType == 'next' && bDisableNext || this.refreshType == 'previous' && parseInt(this.aRequestData.offset) == 0){
                this.playPause('pause');
            }
            this.updatePrevNext(bDisableNext);
        }
    }

    this.setListData = function(aRowsData){
        var sRowTemplate = AMI.Template.getTemplate(this.sRowTemplateId);

        if(aRowsData.length && aRowsData.length > 0){
            var content = '';
            for(var i=0; i<aRowsData.length; i++){
                AMI.Message.send('ON_AMI_LIST_DRAW_ROW', this.idContainer, aRowsData[i]);
                aRowsData[i]['mod_link'] = this.aRequestData.mod_link;
                aRowsData[i]['ROW_NUMBER'] = i;
                content += AMI.Template.parse(sRowTemplate, aRowsData[i]);
            }
            this.fillBlockContent(content);
        }
    }

    this.fillBlockContent = function(content){
        this.oContainer.innerHTML = content;
    }

    this.previousPage = function(bAutoAction){
        if(typeof(bAutoAction) == 'undefined' || !bAutoAction){
            this.playPause('pause');
        }
        if(parseInt(this.aRequestData.offset) > 0){
            this.aRequestData.offset = parseInt(this.aRequestData.offset) - parseInt(this.aRequestData.limit);
            this.load('previous');
        }
        return false;
    }

    this.nextPage = function(bAutoAction){
        if(typeof(bAutoAction) == 'undefined' || !bAutoAction){
            this.playPause('pause');
        }
        if(this.lastRecordsCount && this.lastRecordsCount == this.aRequestData.limit){
            this.aRequestData.offset = parseInt(this.aRequestData.offset) + parseInt(this.aRequestData.limit);
            this.load('next');
        }
        return false;
    }

    this.playPause = function(forceAction){
        if(typeof(forceAction) == 'indefined'){
            forceAction = 'none';
        }
        if(this.refreshPaused && forceAction != 'pause'){
            if(this.refreshType == 'next' && this.lastRecordsCount != this.aRequestData.limit){
                return;
            }
            this.refreshPaused = false;
            if(this.oPlayPause){
                this.oPlayPause.className = this.oPlayPause.className.replace(/\s*ami_resp_pause/, '');
            }
            this.refreshInterval = this.refreshIntervalInitial;
            this.refreshMaximum = this.refreshMaximumInitial;
            this.playNext(true);
        }else if(!this.refreshPaused && forceAction != 'play'){
            this.refreshPaused = true;
            this.playStop();
            if(this.oPlayPause){
                this.oPlayPause.className = this.oPlayPause.className + ' ami_resp_pause';
            }
        }
    }

    this.playNext = function(bImmediately){
        if(!this.refreshPaused && this.refreshInterval > 0 && this.refreshMaximum > 0){
            var callback = null;
            if(this.refreshType == 'next'){
                var callback = function(_this){return function(){_this.nextPage(true)}}(this);
            }else if(this.refreshType == 'previous'){
                var callback = function(_this){return function(){_this.previousPage(true)}}(this);
            }else{
                var callback = function(_this){return function(){_this.load()}}(this);
            }
            if(bImmediately){
                this.refreshTimeout = setTimeout(callback, 200);
            }else{
                this.refreshTimeout = setTimeout(callback, this.refreshInterval * 1000);
            }
            if(this.refreshMultiplier > 0){
                this.refreshInterval *= this.refreshMultiplier;
                this.refreshMaximum--;
            }
        }else if(!this.refreshPaused){
            this.playPause('pause');
        }
    }

    this.playStop = function(){
        clearTimeout(this.refreshTimeout);
    }

    this.init();
}
