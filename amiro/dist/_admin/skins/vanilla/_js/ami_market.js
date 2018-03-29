/**
 * amiMarket object.
 * Downloading and installing packages.
 */
var amiMarket = {
    /**
     * Package ID
     *
     * @type String
     */
    pkgId: null,
    /**
     * Package name
     *
     * @type String
     */
    pkgName: null,
    /**
     * Package version
     *
     * @type String
     */
    pkgVer: null,
    /**
     * Popup window ID
     *
     * @type AMI.UI.Popup
     */
    dlPopup: null,
    /**
     * Filesize to download
     *
     * @type Integer
     */
    dlTotal: 0,
    /**
     * Current chunk number
     *
     * @type Integer
     */
    chunk: 0,
    /**
     * Total chunks count
     *
     * @type Integer
     */
    chunks: 0,
    /**
     * Download session ID
     *
     * @type String
     */
    sessId: null,
    /**
     * Installation cancel flag
     *
     * @type Boolean
     */
    cancelled: false,
    /**
     * Is install in progress flag
     *
     * @type Boolean
     */
    inProgress: false,
    /**
     * Downloader hash
     *
     * @type String
     */
    dlHash: false,
    /**
     * Initialization.
     *
     * @returns {undefined}
     */
    init: function(){
        amiMarket.initEvents();
    },

    /**
     * Initialize event listeners.
     *
     * @returns {undefined}
     */
    initEvents: function(){
        if(window.addEventListener){
            window.addEventListener("message", amiMarket.eventListener, false);
        }else{
            window.attachEvent("onmessage", amiMarket.eventListener);
        }
    },

    /**
     * Event listener.
     *
     * @param {Object} event
     * @returns {undefined}
     */
    eventListener: function(event){

        if((event.origin != "http://www.amiro.ru") && (event.origin != "https://www.amiro.ru") && (event.origin != document.location.origin)){
            console.log('Wrong event origin (' + event.origin + ')');
            return;
        }
        var aData = event.data.split('|');
        var action = aData[0];
        if(aData.length >= 3){
            switch(action){
                case 'getScrollPosition':
                    if(typeof(window.intervalIsSet) == 'undefined'){
                        setInterval(
                            function(evt){
                                return function(){
                                    evt.source.postMessage('scrollPos|' + (AMI.$(window).scrollTop() - AMI.$('#market').offset().top), evt.origin);
                                };
                            }(event),
                            300
                        );
                        window.intervalIsSet = true;
                    }
                    break;
                case 'installPackage':
                    event.source.postMessage('connected', event.origin);
                    if(amiMarket.inProgress){
                        return;
                    }
                    amiMarket.pkgId = aData[1];
                    amiMarket.pkgVer = aData[2];
                    if(typeof(aData[3]) != 'undefined'){
                        amiMarket.pkgName = aData[3];
                    }else{
                        amiMarket.pkgName = amiMarket.pkgId;
                    }
                    amiMarket.pkgType = '';
                    if(typeof(aData[4]) != 'undefined'){
                        amiMarket.pkgType = aData[4];
                    }
                    amiMarket.inProgress = true;
                    amiMarket.openPopup();
                    //Check if we already have same package of the same version
                    var havePackage = (typeof(aInstalledPackages[amiMarket.pkgId]) != 'undefined') && (amiMarket.pkgVer == aInstalledPackages[amiMarket.pkgId]['version']);
                    if(!havePackage){
                        amiMarket.download();
                    }else{
                        // todo: check if we can install one more package
                        amiMarket.startInstallation();
                    }
                    break;
                case 'getHash':
                    if(typeof(amiMarketHash) != 'undefined'){
                        event.source.postMessage(amiMarketHash, event.origin);
                        event.source.postMessage('targetWebsite|' + editorBaseHref, event.origin);
                        event.source.postMessage('targetDomain|' + document.location.host, event.origin);
                    }
                    break;
                case 'askDlHash':
                    if(amiMarket.dlHash === false){
                        event.source.postMessage('needDlHash', event.origin);
                    }
                    break;
                case 'setDlHash':
                    if(amiMarket.dlHash === false){
                        amiMarket.dlHash = event.data.toString().substring(11);
                    }
                    break;
                case 'adjustHeight':
                    AMI.$('#market').height(aData[1]);
                    break;
                case 'goAdmin':
                    window.location.href = 'engine.php?mod_id=' + aData[1];
                    break;
                case 'goUpdates':
                    window.location.href = 'srv_updates.php';
                    break;
                case 'goSettings':
                    window.location.href = 'engine.php?mod_id=mod_manager#mid=mod_manager&instant_edit=1&search_id=' + aData[1];
                    break;
                case 'goPageClick':
                    amiMarket.goneToPage = false;
                    break;
                case 'goPage':
                    event.source.postMessage('connected', event.origin);
                    if((typeof(amiMarket.goneToPage) == 'undefined') || !amiMarket.goneToPage){
                        amiMarket.goneToPage = true;
                        window.document.getElementById('market').src='//www.amiro.ru/' + aData[2] + '?lay_id=97' + marketHash;
                    }
                    break;
                default:
            }
        }
    },

    /**
     * Opens popup.
     *
     * @returns {undefined}
     */
    openPopup: function(){
        AMI.$('.amiMarketText').show();
        AMI.$('#amiMarketInstallForm').hide();
        amiMarket.dlPopup = new AMI.UI.Popup(
            AMI.$('#amiMarketInstallDialog')[0],
            {
                header : AMI.Template.Locale.get('progress') + ': ' + amiMarket.pkgName + ' ver. ' + amiMarket.pkgVer,
                modal:   true,
                height:  100,
                movable: false,
                onClose: function(){
                    amiMarket.inProgress = false;
                    amiMarket.cancelled = true;
                },
                onShow: function(){
                    AMI.$(amiMarket.dlPopup.header).css('cursor', 'default');
                }
            }
        );
    },

    /**
     * Download package.
     *
     * @returns {undefined}
     */
    download: function(){
        if(typeof(StatisticCollector) != 'undefined'){
            StatisticCollector.marketDownload(amiMarket.pkgId);
        }
        amiMarket.setStatus(AMI.Template.Locale.get('requesting_pkg_info'));
        AMI.$('.amiMarketStatusBarBack').hide();
        AMI.HTTPRequest.getContent(
            'GET',
            'ajax.php',
            {
                type:   'ami_market',
                action: 'info',
                pkg_id: amiMarket.pkgId,
                lang: window.interface_lang,
                hash: amiMarket.dlHash ? amiMarket.dlHash : ""
            },
            amiMarket.parseInfo
        );
    },

    /**
     * Parses info from AJAX info service and fills popup.
     *
     * @param {Integer} state
     * @param {String} content
     * @returns {undefined}
     */
    parseInfo: function(state, content){
        var oData = {};
        if((state == 1) && (content.substr(0, 1) == '{') && (content.substr(content.length - 1, 1) == '}')){
            var oData = AMI.String.decodeJSON(content);
        }
        var data = typeof(oData.data) !== 'undefined' ? oData.data : false;
        if((data !== false) && !data.error && (typeof(data.fileSize) != 'undefined')){
            //amiMarket.setFilename(data.fileName);
            amiMarket.startDownload(data.sessionId, data.chunks, data.fileSize);
        }else{
            amiMarket.setErrorStatus(oData);
        }
    },

    /**
     * Sets status string in popup.
     *
     * @param {String} status
     * @returns {undefined}
     */
    setStatus: function(status){
        AMI.$('#amiDownloadStatus').html(status);
        amiMarket.dlPopup._openNone();
        AMI.UI.centerH(amiMarket.dlPopup.object);
    },

    /**
     * Formats integer as float with size metrics according to current locale.
     *
     * @param {Integer} bytes
     * @returns {String}
     */
    formatFilesize: function(bytes){
        var ed = AMI.Template.Locale.get('kilobytes');
        var filesize = (bytes / 1024).toFixed(2);
        if(filesize > 100){
            filesize = (filesize / 1024).toFixed(2);
            ed = AMI.Template.Locale.get('megabytes');
        }
        return filesize + ' ' + ed;
    },

    /**
     * Writes on popup formatted downloaded size and totals.
     *
     * @param {Integer} currentSize
     * @returns {undefined}
     */
    setDownloadStatus: function(currentSize){
        var percent = Math.ceil((currentSize / amiMarket.dlTotal) * 100) + '%';

        amiMarket.curPercent = Math.ceil((currentSize / amiMarket.dlTotal) * 100);
        amiMarket.nextPercent = Math.ceil(((currentSize + 4000000)/ amiMarket.dlTotal) * 100);
        if(amiMarket.nextPercent > 100){
            amiMarket.nextPercent = 100;
        }

        AMI.$('.amiMarketStatusBarBack').show();
        if(typeof(amiMarket.animation) != 'undefined'){
            clearInterval(amiMarket.animation);
        }
        amiMarket.animation = setInterval(
            function(){
                if(amiMarket.curPercent > amiMarket.nextPercent){
                    clearInterval(amiMarket.animation);
                    if(amiMarket.nextPercent == 100){
                        amiMarket.setStatus(AMI.Template.Locale.get('unpacking_pkg'));
                    }
                    return;
                }
                AMI.$('#amiStatusBar').width(amiMarket.curPercent + '%');
                AMI.$('#amiStatusBar').text(amiMarket.curPercent + '%');

                var downloaded = amiMarket.formatFilesize(Math.ceil(amiMarket.dlTotal / 100 * amiMarket.curPercent));
                var total = amiMarket.formatFilesize(amiMarket.dlTotal);
                amiMarket.setStatus('<b>' + AMI.Template.Locale.get('downloaded') + ':</b> ' + downloaded + ' / ' + total);
                amiMarket.curPercent++;
            },
            Math.ceil(10 * 100 / (amiMarket.nextPercent - amiMarket.curPercent))
        );
    },

    /**
     * Sets an error status.
     *
     * @returns {undefined}
     */
    setErrorStatus: function(oData){
        var errMsg = AMI.Template.Locale.get('error');
        if(typeof(oData) != 'undefined' && typeof(oData.data) != 'undefined' && typeof(oData.data.errorMessage) != 'undefined'){
            errMsg += ('<br><span style="color:#000;font-weight:normal;">' + oData.data.errorMessage + '</span>');
        }
        amiMarket.setStatus('<span style="color:red; font-weight:bold;">' + errMsg + '</span>');
    },

    /**
     * Sets completed status.
     *
     * @returns {undefined}
     */
    setCompleteStatus: function(){
        amiMarket.setStatus('<span style="color:green; font-weight:bold;">' + AMI.Template.Locale.get('complete') + '</span>');
    },

    /**
     * Starts downloading process.
     *
     * @param {String} sessionId
     * @param {Integer} chunks
     * @param {Integer} totalSize
     * @returns {undefined}
     */
    startDownload: function(sessionId, chunks, totalSize){
        amiMarket.cancelled = false;
        amiMarket.chunk = 0;
        amiMarket.chunks = chunks;
        amiMarket.sessId = sessionId;
        amiMarket.dlTotal = totalSize;
        amiMarket.setDownloadStatus(0);
        amiMarket.proceedDownload();
    },

    /**
     * Coninues downloading of next chunk.
     *
     * @returns {undefined}
     */
    proceedDownload: function(){
        AMI.HTTPRequest.getContent(
            'GET',
            'ajax.php',
            {
                type:    'ami_market',
                action:  'download',
                pkg_id:  amiMarket.pkgId,
                sess_id: amiMarket.sessId,
                chunk:   amiMarket.chunk,
                lang: window.interface_lang,
                hash: amiMarket.dlHash ? amiMarket.dlHash : ""
            },
            amiMarket.downloadStatus
        );
    },

    /**
     * Parses data from AJAX answer and write downs current status of download.
     *
     * @param {Integer} state
     * @param {String} content
     * @returns {unresolved}
     */
    downloadStatus: function(state, content){
        // break chain if cancelled
        if(amiMarket.cancelled){
            return;
        }
        var oData = {};
        if((state == 1) && (content.substr(0, 1) == '{') && (content.substr(content.length - 1, 1) == '}')){
            var oData = AMI.String.decodeJSON(content);
        }
        var data = typeof(oData.data) !== 'undefined' ? oData.data : false;
        if((data !== false) && data.success){
            amiMarket.chunk++;
            amiMarket.setDownloadStatus(data.downloaded);
            if(amiMarket.chunk == amiMarket.chunks){
                switch(amiMarket.pkgType) {
                    case 'design':
                        amiMarket.startDesignInstallation();
                        break;
                    default:
                        amiMarket.unpackArchive();
                }
            }else{
                amiMarket.proceedDownload();
            }
        }else{
            amiMarket.setErrorStatus(oData);
        }
    },

    /**
     * Unpacks downloaded archive.
     *
     * @returns {undefined}
     */
    unpackArchive: function(){
        AMI.$('.amiMarketStatusBarBack').hide();
        AMI.HTTPRequest.getContent(
            'GET',
            'ajax.php',
            {
                type:    'ami_market',
                action:  'unpack',
                pkg_id:  amiMarket.pkgId,
                sess_id: amiMarket.sessId,
                lang: window.interface_lang
            },
            function(state, content){
                var oData = {};
                if((state == 1) && (content.substr(0, 1) == '{') && (content.substr(content.length - 1, 1) == '}')){
                    var oData = AMI.String.decodeJSON(content);
                }
                var data = typeof(oData.data) !== 'undefined' ? oData.data : false;
                if((data !== false) && data.success){
                    amiMarket.startInstallation();
                }else{
                    amiMarket.setErrorStatus(oData);
                }
            }
        );
    },

    /**
     * Installs design.
     *
     * @returns {undefined}
     */
    startDesignInstallation: function() {
        if(typeof(StatisticCollector) != 'undefined'){
            StatisticCollector.marketInstall(amiMarket.pkgId);
        }
        AMI.$('.amiMarketStatusBarBack').hide();
        AMI.HTTPRequest.getContent(
            'GET',
            'ajax.php',
            {
                type:    'ami_market',
                action:  'check_design',
                pkg_id:  amiMarket.pkgId,
                sess_id: amiMarket.sessId,
                lang: window.interface_lang
            },
            function(state, content){
                var oData = {};
                if((state == 1) && (content.substr(0, 1) == '{') && (content.substr(content.length - 1, 1) == '}')){
                    var oData = AMI.String.decodeJSON(content);
                }
                var data = typeof(oData.data) !== 'undefined' ? oData.data : false;
                if((data !== false) && data.success && typeof(data.file) !== 'undefined'){
                    amiMarket.setStatus(AMI.Template.Locale.get('loading_mm_form'));
                    AMI.$('.amiMarketText').hide();
                    AMI.$('#amiMarketInstallForm').show();
                    amiMarket.dlPopup.resize({width: 700});
                    AMI.Browser.DOM.setInnerHTML(
                        AMI.find('#amiMarketInstallForm'),
                        '<iframe id="designInstallFrame" src="layouts.php?action=import_form&design=' + data.file + '" style="border:none;"/>'
                    );
                    AMI.find('#designInstallFrame').onload = function() {
                        $(this).width($(this).parent().width());
                        var height = $(this.contentWindow.document).height();
                        var winH = parseInt(AMI.$(window).height()) - 300;
                        if(winH <= 180){
                            winH = 180;
                        }
                        if(winH > 550) {
                            winH = 550;
                        }
                        if(winH > height) {
                            winH = height;
                        }
                        $(this).height(winH);
                        amiMarket.dlPopup.resize({width: 700, height: winH + 50});
                        AMI.UI.center(amiMarket.dlPopup.object);
                    };
                }else{
                    amiMarket.setErrorStatus(oData);
                }
            }
        );
    },

    /**
     * Installs package.
     *
     * @returns {undefined}
     */
    startInstallation: function(){
        if(typeof(StatisticCollector) != 'undefined'){
            StatisticCollector.marketInstall(amiMarket.pkgId);
        }
        // Update manifest file

        var havePackage = (typeof(aInstalledPackages[amiMarket.pkgId]) != 'undefined') && (amiMarket.pkgVer == aInstalledPackages[amiMarket.pkgId]['version']);
        if(havePackage){
            AMI.HTTPRequest.getContent(
                'GET',
                'ajax.php',
                {
                    type:    'ami_market',
                    action:  'correct_manifest',
                    pkg_id:  amiMarket.pkgId,
                    lang:    window.interface_lang
                },
                function(){}
            );
        }

        var modManagerFormURL =
            '60.mod.php?mod_id=mod_manager&from=market&mod_action=form_edit&componentId=mod_manager_2&ami_full=1&mode=popup&pkg_id=' +
            amiMarket.pkgId + '&pkg_ver=' + amiMarket.pkgVer;

        AMI.$('.amiMarketStatusBarBack').hide();
        amiMarket.setStatus(AMI.Template.Locale.get('loading_mm_form'));
        AMI.HTTPRequest.getContent(
            'GET',
            modManagerFormURL,
            '',
            function(status, content){
                if(status == 1){
                    AMI.$('.amiMarketText').hide();
                    AMI.$('#amiMarketInstallForm').show();

                    // todo: make sure content is correct form html, not a fatal error message

                    // amiMarket.setStatus(content);
                    // AMI.$('#amiMarketInstallDialog').html(content);

                    var oModule = new AMI.Module(
                        'mod_manager',
                        {mod_manager_2: {type: 'form', fullEnv: 1, related: {}}}
                    );
                    AMI.Page.registerModule(oModule);

                    var
                        aComponents = oModule.getComponentsByType('form'),
                        oData = {content: content};

                    AMI.Message.send('ON_COMPONENT_CONTENT_RECEIVED', aComponents[0], oData);
                    content = oData['content'];

                    AMI.Browser.DOM.setInnerHTML(AMI.find('#amiMarketInstallForm'), content);

                    // Remove form table
                    AMI.$('#amiMarketInstallForm').find('#div_properties_form table:eq(0) tr:first').remove();
                    AMI.$('#amiMarketInstallForm').find('#div_properties_form table:eq(0) tr:last').remove();
                    AMI.$('#amiMarketInstallForm').find('#div_properties_form table:eq(0) tr:first td:first').remove();
                    AMI.$('#amiMarketInstallForm').find('#div_properties_form table:eq(0) tr:first td:last').remove();

                    // Remove space after table
                    AMI.$('#amiMarketInstallForm').find('#div_properties_form table:eq(1)').find('tr:first').remove();

                    // Remove debug
                    // AMI.$('.componentDebug').hide();

                    // Make form scrollable
                    var winH = parseInt(AMI.$(window).height()) - 300;
                    if(winH <= 180){
                        winH = 180;
                    }
                    var formInner = AMI.$('#amiMarketInstallForm').find('.table_sticker form');
                    var divScroller = AMI.$('<div id="ami_market_scroll">');
                    AMI.$('#amiMarketInstallForm').find('.table_sticker').append(divScroller);
                    divScroller.css('max-height', winH + 'px');
                    divScroller.css('overflow-y', 'auto');
                    divScroller.css('overflow-x', 'hidden');
                    divScroller.append(formInner);
                    AMI.$('#amiMarketInstallForm').find('#form-buttons').appendTo('#amiMarketInstallForm #div_properties_form');
                    AMI.$('#amiMarketInstallForm').find('#form-buttons').css('padding-top', '8px');
                    AMI.$('#amiMarketInstallForm').find('#form-buttons').css('text-align', 'right');
                    AMI.$('#amiMarketInstallForm').find('#form-buttons').css('padding-bottom', '16px');

                    // Dirtiest hack ever !!!
                    //AMI.$('#form-buttons input')[0].form = AMI.$('.table_sticker form')[0];
                    var onclick = AMI.$('#amiMarketInstallForm').find('#form-buttons input').attr('onclick');
                    if(onclick){
                        onclick = onclick.replace(/this\.form/ig, 'AMI.$(\'#amiMarketInstallForm\').find(\'.table_sticker form\')[0]');
                        onclick += ';AMI.$(\'#amiMarketInstallForm\').find(\'.table_sticker form\').submit();';
                        AMI.$('#amiMarketInstallForm').find('#form-buttons input').attr('onclick', onclick);
                        AMI.$('#amiMarketInstallForm').find('#tr-form-buttons').hide();
                    }else{
                        // Form is broken!
                        console.log('Installation form not found!');
                        return;
                    }

                    var
                        oForm = document.forms['ami_form_mod_manager_2'],
                        value = oForm.elements['hypermod_config'].value,
                        content = '';

                    if(typeof(aMetaInfo[value]) != 'undefined'){
                        for(var metaKey in aMetaInfo[value].meta){
                            content += AMI.Template.Locale.get('meta_' + metaKey) + ': ' + aMetaInfo[value].meta[metaKey] + '<br />\n';
                        }
                        var
                            oMeta = aMetaInfo[value],
                            aLocale = ['en', 'ru'];

                        for(var localeIndex in aLocale){
                            var locale = aLocale[localeIndex];
                            var oTable = AMI.find('#tab-page-captions_' + locale);
                            if(oTable == null){
                                break;
                            }
                            oTable = oTable.children[0];
                            for(var i = oTable.rows.length - 1; i >= 0; i--){
                                oTable.deleteRow(i);
                            }
                            // oMeta.captions = PHP AMI_HyperConfig_Meta::$aCaptions
                            for(var submodPostfix in oMeta.captions[locale]){
                                var aSubmodFields = oMeta.captions[locale][submodPostfix];
                                for(submodField in aSubmodFields){
                                    // submodField - 'menu', 'header', etc.
                                    // aSubmodFields[submodField] - caption struct
                                    var
                                        name = 'captions[' + locale + '][' + (submodPostfix == '' ? '-' : submodPostfix) + '][' + submodField + ']',
                                        validators = aSubmodFields[submodField][2] ? 'filled stop_on_error' : '',
                                        oTR = AMI.Browser.DOM.create('TR', '', '', '', oTable),
                                        oTD = AMI.Browser.DOM.create('TD', '', '', '', oTR);

                                    oTD.innerHTML = oMeta.captions[AMI.Cookie.get('lang')][submodPostfix][submodField][0] + (aSubmodFields[submodField][2] ? '*' : '') + ':&nbsp;';
                                    if(aSubmodFields[submodField][3]){
                                        // textarea
                                        oTD.colSpan = 2;
                                        oTD.style.paddingTop = '5px';
                                        oTD.style.paddingBottom = '2px';
                                        oTR = AMI.Browser.DOM.create('TR', '', '', '', oTable);
                                        oTD = AMI.Browser.DOM.create('TD', '', '', '', oTR);
                                        oTD.colSpan = 2;
                                        oTD.innerHTML = '<textarea class="field" rows="5" style="width: 610px;" data-ami-validators="' + validators + '" name="' + name + '">' + aSubmodFields[submodField][1] + '</textarea>';
                                    }else{
                                        // input.text
                                        oTD = AMI.Browser.DOM.create('TD', '', '', '', oTR);
                                        oTD.innerHTML =
                                            '<input type="text" data-ami-validators="' + validators + '" maxlength="255" value="' +
                                            aSubmodFields[submodField][1] + '" class="field field50" name="' + name + '" />';
                                    }
                                }
                            }
                        }
                        var tabRowTabset = AMI.find('#tab-row-tabset');

                        if(tabRowTabset){
                            tabRowTabset.style.display = tableRowShowStyle;
                        }
                    }
                    AMI.find('#hypermod_config_info').innerHTML = content;

                    AMI.Message.addListener('ON_MODULE_ACTION', amiMarket.onModuleAction, true);
                    AMI.Message.addListener('ON_FORM_POST_REQUEST_DATA', amiMarket.onFormPost, true);
                    AMI.Message.addListener('ON_AFTER_MODULE_ACTION', amiMarket.onAfterModuleAction, true);

                    amiMarket.dlPopup.autosize();
                    amiMarket.dlPopup.resize({width: 700});
                    AMI.UI.center(amiMarket.dlPopup.object);
                }
            }
        );
    },

    /**
     * Event listner to process package installation form submission.
     *
     * @param   {string} action  Action
     * @param   {object} oArgs   Arguments
     * @returns {bool}
     * @static
     */
    onModuleAction: function(action, oArgs){
        if(action == 'form_save'){
            amiMarket.closeAfter = false;
            _cms_document_form_changed = false;
        }
        return true;
    },

    /**
     * Event listner to process package installation form submission.
     *
     * @param   {object} oComponent   Form component
     * @param   {object} oParameters  Request parameters
     * @returns {bool}
     * @static
     */
    onFormPost: function(oComponent, oParameters){
        AMI.$('#amiMarketInstallForm').hide();
        amiMarket.dlPopup.resize({width: 500, height: 100});
        AMI.UI.center(amiMarket.dlPopup.object);
        amiMarket.setStatus(AMI.Template.Locale.get('installing_pkg'));
        AMI.$('.amiMarketText').show();
        amiMarket.closeAfter = true;
        return true;
    },

    /**
     * Event listner to process package installation form submission.
     *
     * @param   {string} action  Action
     * @param   {object} oArgs   Arguments
     * @returns {bool}
     * @static
     */
    onAfterModuleAction: function(action, oArgs){
        if(action == 'form_save'){
            if(oArgs.oParameters.mod_id == 'mod_manager'){
                if(typeof(amiMarket.closeAfter) != 'undefined' && amiMarket.closeAfter){
                    setTimeout(function(){amiMarket.dlPopup.close();}, 3000);
                }
            }
        }
        return true;
    }
};

amiMarket.init();
