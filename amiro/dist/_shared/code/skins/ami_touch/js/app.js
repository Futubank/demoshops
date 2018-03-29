/**
 * Form component controller.
 *
 * @param {type} oView
 * @returns {undefined}
 */
var amiFormComponentController = function(oView){

    if(typeof(oView) !== 'undefined'){
        this.oView = oView;
    }else{
        console.error('Form view object is not defined');
        return;
    }

    this.initTinyMCE = function(){
        angular.module('ui.tinymce', [])
            .value('uiTinymceConfig', {})
            .directive('uiTinymce', ['uiTinymceConfig', function(uiTinymceConfig){
            uiTinymceConfig = uiTinymceConfig || {};
            var generatedIds = 0;
            return {
                require: 'ngModel',
                link: function(scope, elm, attrs, ngModel) {
                    var expression, options, tinyInstance;
                    // generate an ID if not present
                    if (!attrs.id) {
                        attrs.$set('id', 'uiTinymce' + generatedIds++);
                    }
                    var updateView = function(){
                        ngModel.$setViewValue(elm.val());
                        if (!scope.$$phase) {
                            scope.$apply();
                        }
                        if(!window.skipValidation){
                            var mceFrame = $('div.field__' + attrs.id).find('.mce-tinymce');
                            if(ngModel.$dirty){
                                mceFrame.addClass('ng-dirty');
                            }else{
                                mceFrame.removeClass('ng-dirty');
                            }
                            if(ngModel.$valid){
                                mceFrame.removeClass('ng-invalid');
                                mceFrame.addClass('ng-valid');
                            }
                            if(ngModel.$invalid){
                                mceFrame.removeClass('ng-valid');
                                mceFrame.addClass('ng-invalid');
                            }
                        }
                    };

                    options = {
                        // Update model when calling setContent (such as from the source editor popup)
                        setup: function(ed) {
                            ed.on('init', function(args) {
                                ngModel.$render();
                            });
                            // Update model on button click
                            ed.on('ExecCommand', function(e) {
                                ed.save();
                                updateView();
                            });
                            // Update model on keypress
                            ed.on('KeyUp', function(e) {
                                ed.save();
                                updateView();
                            });
                        },
                        mode: 'exact',
                        elements: attrs.id,
                        content_css : [
                            parent.frontBaseHref + 'amiro_sys_css.php?styles=common|ami_custom|home',
                            parent.frontBaseHref + '_shared/code/web/skins/ami_touch/plugins/tinymce/plugins/amiro.specblock/plugin.css'
                        ],
                        /*style_formats_merge: true,*/
                        style_formats: [
                            {title: "Headers", items: [
                                {title: "Header 1", format: "h1"},
                                {title: "Header 2", format: "h2"},
                                {title: "Header 3", format: "h3"},
                                {title: "Header 4", format: "h4"},
                                {title: "Header 5", format: "h5"},
                                {title: "Header 6", format: "h6"}
                            ]},
                            {title: "Inline", items: [
                                {title: "Bold", icon: "bold", format: "bold"},
                                {title: "Italic", icon: "italic", format: "italic"},
                                {title: "Underline", icon: "underline", format: "underline"},
                                {title: "Strikethrough", icon: "strikethrough", format: "strikethrough"},
                                {title: "Superscript", icon: "superscript", format: "superscript"},
                                {title: "Subscript", icon: "subscript", format: "subscript"},
                                {title: "Code", icon: "code", format: "code"}
                            ]},
                            {title: "Blocks", items: [
                                {title: "Paragraph", format: "p"},
                                {title: "Blockquote", format: "blockquote"},
                                {title: "Div", format: "div"},
                                {title: "Pre", format: "pre"}
                            ]},
                            {title: "Alignment", items: [
                                {title: "Left", icon: "alignleft", format: "alignleft"},
                                {title: "Center", icon: "aligncenter", format: "aligncenter"},
                                {title: "Right", icon: "alignright", format: "alignright"},
                                {title: "Justify", icon: "alignjustify", format: "alignjustify"}
                            ]},
                            {title: "Horizontal line", cmd:"InsertHorizontalRule", styles: {color: '#000000'}}
                        ],
                        plugins: ["amiro.code", 'amiro.pagebreak', 'amiro.specblock', "amiro.image"],
                        menubar : false,
                        statusbar : true,
                        resize: "height",
                        toolbar: [" bold italic | removeformat | outdent indent | alignleft aligncenter alignright alignjustify | bullist numlist | formatselect | styleselect | amiro.image | amiro.code"],
                        body_id: "lay_body",
                        extended_valid_elements : "nobr[*]"
                    };
                    if(parent.AMI_SessionData.locale === 'ru'){
                        options.language = 'ru';
                    }
                    if (attrs.uiTinymce) {
                        expression = scope.$eval(attrs.uiTinymce);
                    } else {
                        expression = {};
                    }
                    angular.extend(options, uiTinymceConfig, expression);
                    setTimeout(function() {
                        tinymce.init(options);
                    });

                    ngModel.$render = function() {
                        if (!tinyInstance) {
                            tinyInstance = tinymce.get(attrs.id);
                        }
                        if (tinyInstance) {
                            tinyInstance.setContent(ngModel.$viewValue || '');
                        }
                    };
                }
            };
        }]);
    };

    /**
     * Initializes AngularJS form controller.
     *
     * @returns {void}
     */
    this.init = function(){

        // Before initialization
        if(typeof(this.beforeInit) !== 'undefined'){
            this.beforeInit();
        };

        this.initTinyMCE();

        // AngularJS Form Application
        var formApp = angular.module('module', ['ui.tinymce']);

        // Module Controller
        formApp.controller('moduleController', ['ngSanitize']);

        // Adds ami_form tag directive
        formApp.directive(
            'amiForm',
            function(_this){
                return function($compile, $http){
                    return {
                        restrict: 'E',
                        replace: true,
                        link: function (scope, element, attrs){
                            window.modCloseFunction =
                                function($scope){
                                    return function(){
                                        var adminPanelHRef = $(
                                            '#ami-admin-panel',
                                            parent.amiSkinController.toolbar.document
                                        );
                                        if(
                                            adminPanelHRef.length &&
                                            adminPanelHRef.prop('sourceLink')
                                        ){
                                            adminPanelHRef.prop('href', adminPanelHRef.prop('sourceLink'));
                                        }

                                        if(typeof($scope.cancel) !== 'undefined'){
                                            $scope.cancel();
                                        }
                                    };
                                }(scope);
                            scope.$formElement = element;
                            scope.load();
                            _this.oView._init(scope);
                        }
                    };
                };
            }(this)
        );

        formApp.directive('amiValidators', function(oController){
            return function(){
                return {
                    require: 'ngModel',
                    link: function(scope, elm, attrs, ctrl){
                        ctrl.$parsers.unshift(function(viewValue){
                            var aValidators = attrs.amiValidators.split(' ');
                            var isValid = true;
                            if(window.skipValidation){
                                return true;
                            }
                            for(var i=0; i<aValidators.length; i++){
                                if(
                                    'undefined' !== typeof(oController.oView.aCallbacks.validators[aValidators[i]])
                                ){
                                    var callback = oController.oView.aCallbacks.validators[aValidators[i]];
                                    var error = {};
                                    isValid =
                                        callback(
                                            attrs.name,
                                            'undefined' !== typeof(viewValue) ? viewValue : '',
                                            scope,
                                            error
                                        );
                                    if(!isValid){
                                        var errorMsg = '';
                                        if('undefined' !== typeof(error.message)){
                                            if('undefined' !== typeof(oActiveModule.aLocale[error.message])){
                                                errorMsg = oActiveModule.aLocale[error.message];
                                            }else{
                                                errorMsg = error.message;
                                            }
                                        }else{
                                            errorMsg = oActiveModule.aLocale['validator_format'];
                                            if(
                                                'undefined' !== typeof(oActiveModule.aLocale['form_field_' + attrs.name + '_' + aValidators[i]])
                                            ){
                                                errorMsg = oActiveModule.aLocale['form_field_' + attrs.name + '_' + aValidators[i]];
                                            }else if(
                                                'undefined' !== typeof(oActiveModule.aLocale['validator_' + aValidators[i]])
                                            ){
                                                errorMsg = oActiveModule.aLocale['validator_' + aValidators[i]];
                                            }
                                        }
                                        $('#error_msg_' + attrs.name).html(errorMsg);
                                        break;
                                    }
                                }
                            }
                            ctrl.$setValidity('amiValidators', isValid);
                            return isValid ? viewValue : undefined;
                        });
                    }
                };
            };
        }(this));

        // AngularJS application initialization
        if(typeof(this.angularInit) !== 'undefined'){
            this.angularInit();
        };

        // After initialization
        if(typeof(this.afterInit) !== 'undefined'){
            this.afterInit();
        };

        // Update module iframe
        if(!parent.amiSkinController.isModuleVisible){
            parent.amiSkinController.openModule();
        }
    };

    /**
     * Form controller.
     *
     * @param {type} $scope
     * @param {type} $http
     * @param {type} $compile
     * @returns {undefined}
     */
    this.controller = function($scope, $http, $compile){

        /**
         * Watch changes enabled
         */
        $scope.watchChanges = false;

        /**
         * Form has changes
         */
        window.formChanged = false;

        /**
         * Form scope has changes
         */
        $scope.changed = false;

        /**
         * Skip form validation if true
         */
        window.skipValidation = false;

        /**
         * Form model
         */
        $scope.fields = {};

        /**
         * Original fields values
         */
        $scope.fieldsOriginal = {};

        /**
         * Form fields types
         */
        $scope.fieldsTypes = {};

        /**
         * List of fields to watch for changes
         */
        $scope.watchFields = [];

        /**
         *  AJAX Response for parse
         */
        $scope.response = '';

        /**
         * Flag for recompilation
         */
        $scope.recompile = false;

        /**
         * Sets response data to form scope.
         *
         * @param {object} data
         */
        $scope.setResponse = function(data){
            $scope.response = data;
        };

        /**
         * Force recompilation
         * @param {string} data
         */
        $scope.setRecompile = function(data){
            $scope.recompile = data;
        };

        /**
         * HTML form element
         */
        $scope.$formElement = null;

        $scope.$watch(function(){
            var hasChanges = false;
            if($scope.watchChanges){
                for(var field in $scope.fields){
                    if((field === 'body') && ($scope.fields[field] === true)){
                        // Error
                    }
                    if($scope.watchFields.indexOf(field) >= 0){
                        if($scope.fields[field] !== $scope.fieldsOriginal[field]){
                            parent.amiAdminFormPage.showHideOk();
                            hasChanges = true;
                            break;
                        }
                    }
                }
            }
            window.formChanged = hasChanges;
            parent.amiSkinController.setFormChanged(hasChanges);
            $scope.changed = hasChanges;
        });

        $scope.getDataForAPI = function(){
            return {
                fields: $scope.fields,
                fieldsTypes: $scope.fieldsTypes,
                fieldsOriginal: $scope.fieldsOriginal
            };
        };

        /**
         * Place loaded data.
         */
        $scope.$watch('response', function(compile){
            return function(){
                var result = {};

                if(!$scope.response){
                    // response field cleared
                    return;
                }

                try {
                    var result = JSON && JSON.parse($scope.response) || $.parseJSON($scope.response);
                }catch(e){

                    parent.amiSkinController.showMessage(oActiveModule.aLocale['request_error'], true);

                    console.error('Response parse error! (' + e.message + ')');
                    console.log($scope.response);
                    return;
                }

                if((typeof(result) === 'undefined') || (typeof(result.data) === 'undefined')){
                    return;
                }

                $scope.watchChanges = false;

                if((typeof(result.code) !== 'undefined') && (parseInt(result.code) === 1)){
                    parent.amiSkinController.oToolbar.updateSaveButton();
                    if(typeof(window.onSuccessfullSave) === 'function'){
                        window.onSuccessfullSave();
                    }
                    parent.amiSkinController.showRefresh();
                }
                $scope.fields = {};
                $scope.watchFields = [];
                if(typeof(result.data.fields) !== 'undefined'){
                    for(var field in result.data.fields){
                        $scope.fieldsTypes[field] = result.data.fields[field].type;
                        var value = '';
                        switch(result.data.fields[field].type){
                            case 'date':
                                value = $scope.getOnlyDate(result.data.fields[field].value);
                                break;
                            case 'datetime':
                                value = $scope.getOnlyDate(result.data.fields[field].value);
                                var time = $scope.getOnlyTime(result.data.fields[field].value);
                                $scope.fields[field + '_time'] = time;
                                $scope.fieldsTypes[field + '_time'] = 'time';
                                $scope.fieldsOriginal[field + '_time'] = time;
                                break;
                            case 'checkbox':
                                value = (parseInt(result.data.fields[field].value) > 0) ? true : false;
                                break;
                            default:
                                value = result.data.fields[field].value;
                        }
                        // On setting field value from ajax response
                        if(typeof(this.setResponseFieldValue) !== 'undefined'){
                            value = this.setResponseFieldValue(field, result.data.fields[field], value);
                        };

                        if(result.data.fields[field].type !== 'hidden'){
                            $scope.watchFields.push(field);
                        }

                        $scope.fields[field] = value;
                        $scope.fieldsOriginal[field] = value;
                    }
                }

                if(typeof(result.data.htmlCode) !== 'undefined'){
                    $scope.$formElement.html(result.data.htmlCode);
                    compile($scope.$formElement.contents())($scope);
                    $scope.response = '';
                }

                if(typeof(result.debug) !== 'undefined'){
                    $('#debug').html(result.debug);
                }
                $('#form_status_messages').empty();
                if((typeof(result.status_msgs) !== 'undefined') && result.status_msgs.length){
                    for(var i=0; i<result.status_msgs.length; i++){
                        var status = 'info'; // info, success, warning, danger
                        switch(result.status_msgs[i].type){
                            case 'error':
                                status = 'danger';
                                break;
                        }
                        $('#form_status_messages').append('<div class="alert alert-' + status + ' alert-dismissable"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>' + result.status_msgs[i].message + '</div>');
                    }
                }
                if((typeof(result.code) !== 'undefined') && (parseInt(result.code) === 1)){
                    for(var field in result.data.fields){
                        if(result.data.fields[field].type === 'htmleditor'){
                            $scope.ami_form[field].$setViewValue(result.data.fields[field].value);
                            $scope.ami_form[field].$render();
                        }
                    }
                }
                if(typeof(window.onAfterSave) === 'function'){
                    window.onAfterSave();
                }
                $scope.watchChanges = true;
            };
        }($compile));

        /**
         * Recompilation.
         */
        $scope.$watch('recompile', function(compile){
            return function(){
                if($scope.recompile){
                    compile($scope.$formElement.contents())($scope);
                    $scope.recompile = false;
                }
            };
        }($compile));

        /**
         * Show errors.
         */
        $scope.submit = function(){
            if(!window.clickFromToolbar){
                parent.amiSkinController.gaSendEvent('module-click', 'save');
            }
            window.clickFromToolbar = false;

            if(!window.formChanged && oActiveModule.itemId){
                if(!confirm(oActiveModule.aLocale['confirm_save_no_changes'])){
                    return false;
                }
            }
            for(var field in $scope.ami_form){
                if(field[0] !== '$' && $scope.ami_form[field].$pristine){
                    $scope.ami_form[field].$setViewValue($scope.fields[field]);
                }
            }
            // Show last tab with invalid field
            $('.ng-invalid').each(function(idx){
                if($(this).parents('DIV.tab-pane').length){
                    var id = $(this).parents('DIV.tab-pane').prop('id');
                    if(id){
                        $('.nav-tabs a[href=#' + id + ']').tab('show');
                    }
                }
            });

            if($scope.ami_form.$invalid){
                parent.amiSkinController.shakeForm();
                parent.amiSkinController.showMessage(oActiveModule.aLocale['errors_found']);
            }
            return !$scope.ami_form.$invalid;
        };

        /**
         * Load form.
         */
        $scope.load = function(){
            if(window.confirmChanges()){
                window.formChanged = false;
                var aData = {
                    mod_action: 'form_edit',
                    id: oActiveModule['itemId']
                };
                oFormRequest.get(aData);
            }
        };

        /**
         * Cancel edit action.
         */
        $scope.cancel = function(){
            if(!window.clickFromToolbar){
                parent.amiSkinController.gaSendEvent('module-click', 'cancel');
            }
            window.clickFromToolbar = false;

            if(window.confirmChanges()){
                var adminPanelHRef = $(
                    '#ami-admin-panel',
                    parent.amiSkinController.toolbar.document
                );
                if(
                    adminPanelHRef.length &&
                    adminPanelHRef.prop('sourceLink')
                ){
                    adminPanelHRef.prop('href', adminPanelHRef.prop('sourceLink'));
                }
                parent.amiSkinController.oToolbar.setMode('toolbar');
                parent.amiSkinController.closeModule(true);
                parent.amiSkinController.toolbar.$('.save-btn').removeClass('has-changes');
                parent.amiSkinController.moduleReset();
            }
        };

        /**
         * Save form action.
         */
        $scope.save = function(){
            var postFields = {};

            for(var field in this.fields){
                if(typeof($scope.fieldsTypes[field]) !== 'undefined'){
                    var value = this.fields[field];

                    switch(field){
                        case 'html_keywords':
                        case 'html_description':
                            value = value.replace(/"/g, '');
                            break;
                    }
                    switch($scope.fieldsTypes[field]){
                        case 'checkbox':
                            value = value ? 1 : 0;
                            break;
                        case 'time':
                            var aParts = value.split(':');
                            if(aParts.length === 2){
                                value += ':00';
                            }
                            break;
                        case 'static':
                            continue; // for(var field in this.fields){
                    }
                    postFields[field] = value;
                }
            }
            postFields._amits = parent._amits;
            postFields._amitsh = parent._amitsh;
            window.formChanged = false;
            if(typeof(window.onBeforeSave) === 'function'){
                window.onBeforeSave();
            }
            oFormRequest.post(postFields);
        };

        $scope.getOnlyDate = function(Time){
            return (Time) ? Time.replace(/(.+) (.+)/, "$1") : Time;
        };

        $scope.getOnlyTime = function(Time){
            return (Time) ? Time.replace(/(.+) (.+)/, "$2") : Time;
        };
    };
};

/**
 * Module AJAX request class.
 *
 * @param {type} component
 * @returns {amiModuleRequest}
 */
var amiModuleRequest = function(component){
    var aComponents = {
        list: {id: 0, type: 'json'},
        form: {id: 1, type: 'html'}
    };

    var url = parent.frontBaseHref + 'ami_strict.php';
    var request = function(method, aData, callback){
        var modId = oActiveModule['modId'];
        showLoader();
        aData['ami_svc'] = 'module';
        aData['mod_id'] = modId;
        aData['ami_env'] = 'full';
        aData['ami_locale'] = typeof(parent.AMI_SessionData) !== 'undefined' ? parent.AMI_SessionData['locale'] : 'ru';
        aData['ami_asnc'] = 1;
        aData['componentId'] = modId + '_' + aComponents[component].id; // @todo: real component Id
        aData['pageId'] = oActiveModule['pageId'];
        aData['category_id'] = parent.active_module_category_id;
        var
            query = window.location.search.substring(1), vars = query.split('&');
        for(var i = 0, q = vars.length;i < q; i++){
            var pair = vars[i].split('=');
            if('id_mod' === pair[0] && 'undefined' == typeof(aData['id_mod'])){
                aData['id_mod'] = pair[1];
                break;
            }
        }
        $.ajax({
            type: method,
            url: parent.frontBaseHref ? url : '/ami_strict.php',
            data: aData,
            success: function(data){
                hideLoader();
                // var jsonData = JSON.stringify(data);
                if(component === 'form'){
                    $('#ami_ajax_response').scope().setResponse(data);
                    $('#ami_ajax_response').scope().$apply();
                    var oData = {};
                    try{
                        oData = JSON.parse(data);
                    }catch(e){
                        var message = oActiveModule.aLocale['request_error'];
                        $('#form_status_messages').append('<div class="alert alert-danger alert-dismissable"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>' + message + '</div>');
                        return;
                    }
                    var
                        oModMapping = {
                            // eshop_item: 'eshop_item.php',
                            eshop_cat:  'eshop_cat.php',
                            pages:      'pmanager.php'
                        },
                        oData = oData.data,
                        modId = oData.fields.mod_id.value,
                        itemId = parseInt(oData.id),
                        adminPanelHRef = $(
                            '#ami-admin-panel',
                            parent.amiSkinController.toolbar.document
                        ),
                        adminLink =
                            'undefined' === typeof(oModMapping[modId])
                                ? 'engine.php?mod_id=' + modId
                                : oModMapping[modId];

                    if(
                        adminPanelHRef.length &&
                        !adminPanelHRef.prop('sourceLink')
                    ){
                        adminPanelHRef.prop('sourceLink', adminPanelHRef.prop('href'));
                    }
                    if(itemId){
                        if('undefined' !== typeof(oModMapping[modId])){
                            adminLink +=
                                '?id=' + itemId + ('pages' !== modId ? '&action=edit#anchor' : '');
                        }else{
                            adminLink +=
                                '#mid=' + modId +
                                '&_amits=' + parent._amits +
                                '&_amitsh=' + parent._amitsh +
                                '&id=' + itemId +
                                '&scroll_to_form=1';
                        }
                    }
                    adminPanelHRef.prop(
                        'href',
                        top.authData.url +
                        'auth_by_hash.php?domain=' + top.authData.domain +
                        '&sid=' + top.authData.sid +
                        '&url=' + encodeURIComponent(adminLink)
                    );
                }
                if(typeof(callback) !== 'undefined'){
                    callback(data);
                }
            },
            error: function(){
                if(component === 'form'){
                    var message = oActiveModule.aLocale['request_error'];
                    $('#form_status_messages').append('<div class="alert alert-danger alert-dismissable"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>' + message + '</div>');
                }
            },
            dataType: aComponents[component].type
        });
    };

    this.get = function(aData, callback){
        request('GET', aData, callback);
    };

    this.post = function(aData, callback){
        request('POST', aData, callback);
    };
};

/**
 * AJAX request class.
 *
 * @param {type} url
 * @param {type} requestMethod
 * @param {type} responseType
 * @param {type} aData
 * @param {type} callback
 * @returns {undefined}
 */
var amiRequest = function(url, requestMethod, responseType, aData, callback){
    showLoader();
    $.ajax({
        type:     requestMethod,
        url:      url,
        data:     aData,
        success:  function(data){
            hideLoader();
            if('undefined' !== typeof(callback)){
                callback(data);
            }
        },
        error:    function(){
            hideLoader();
            if('object' === typeof(console)){
                console.warn('amiRequest error');
                console.log(this);
            }
            // ??? not sure if it is correct
            var message = oActiveModule.aLocale['request_error'];
            $('#form_status_messages').append('<div class="alert alert-warning alert-dismissable"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>' + message + '</div>');
        },
        dataType: responseType
    });
};

var oFormRequest = new amiModuleRequest('form');
var oListRequest = new amiModuleRequest('list');

function showLoader(){
    $('HTML').css('background', '');
    $('#edit-page-bar').hide();
}

function hideLoader(){
    if(window.location.hash === '#seo'){
        setTimeout(showSeoTab, 400);
        setTimeout(function(){
            $('HTML').css('background', '#fff');
            $('#edit-page-bar').show();
        }, 500);
    }else{
        $('HTML').css('background', '#fff');
        $('#edit-page-bar').show();
    }
}

function clearArea(id, el) {
    $scope = $('#'+id).scope();
    $scope.ami_form[id].$setViewValue('');
    $scope.fields[id] = '';
    $scope.$apply();
    $('#'+id).val('');
    $('#'+id).focus();
    $(el).fadeOut();
};

/**
 * Form API.
 *
 * @type Object
 */
var amiFormComponentView = function(){

    /**
     * Callbacks.
     *
     * @type Object
     */
    this.aCallbacks = {
        init:           [],
        show:           {},
        disable:        {},
        watchers:       [],
        fieldWatchers:  [],
        validators:     {}
    },

    /**
     * Initialization.
     *
     * @param {object} $scope
     * @returns {void}
     */
    this._init = function($scope){

        // Default validators
        this.addValidator('filled', function(name, value, scope, error){
            return '' !== value;
        });

        this.addValidator('alphanum', function(name, value, scope){
            return '' === value || value.match(/^[0-9a-zA-Z]+$/);
        });

        this.addValidator('time', function(name, value, scope){
            return '' === value || value.match(/^[0-9]{1,2}\:[0-9]{1,2}\:[0-9]{2,4}$/);
        });

        this.addValidator('email', function(name, value, scope){
            return '' === value || value.match(/^(\w+[\w.-]*\@[A-Za-z0-9а-яёА-ЯЁ]+((\.|-+)[A-Za-z0-9а-яёА-ЯЁ]+)*\.[\-A-Za-z0-9а-яёА-ЯЁ]+(;|,|$))+$/);
        });

        this.addValidator('domain', function(name, value, scope){
            return '' === value || value.match(/^([A-Za-z0-9а-яёА-ЯЁ_\-\.])+\.([A-Za-zа-яёА-ЯЁ]{2,4})$/);
        });

        this.addValidator('url', function(name, value, scope){
            return value.match(/^https?:\/\/[a-z0-9а-яёА-ЯЁ-]+(\.[a-z0-9а-яёА-ЯЁ-]+)+([/?].+)?$/);
        });

        this.addValidator('int', function(name, value, scope){
            return '' === value || value.toString().match(/^-?[0-9]*$/);
        });

        this.addValidator('double', function(name, value, scope, error){
            var result =
                '' === value ||
                value.toString().match(/^[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?$/);

            if(!result){
                error.message = 'validator_format';
            }

            return result;
        });

        this.addValidator('sublink', function(name, value, scope, error){
            var locale = '', qpos, amppos, qmpos;

            if(typeof(value) === 'undefined' || '' === value){
                return true;
            }

            do{
                if(
                    value.search(/[ ]/) !== -1 ||
                    value.search(/^[0-9a-zA-Z\-\_\.\/]+$/) === -1
                ){
                    locale = 'sublink_invalid_symbols';
                    break;
                }
                qpos = value.indexOf('?');
                if((qpos > 0) && (value.indexOf('?', qpos + 1) > 0)){
                    locale = 'sublink_illegal_qm_usage';
                    break;
                }
                if(qpos <= 0){
                    qpos = value.length;
                }
                amppos = value.indexOf('&');
                qmpos = value.indexOf('=');
                if(
                    ((amppos >= 0) && (amppos < qpos)) ||
                    ((qmpos >= 0) && (qmpos < qpos))
                ){
                    locale = 'sublink_illegal_amp_usage';
                    break;
                }
                if(
                    (value.search(/^\/+.*?$/) !== -1) ||
                    (value.search(/\/{2,}$/) !== -1)
                ){
                    locale = 'sublink_start_slash';
                    break;
                }
                if(value.search(/^[a-zA-Z\-\_\.]/) === -1){
                    locale = 'sublink_start_illegal';
                    break;
                }
            }while(false);
            if('' !== locale){
                error.message = locale;
                return false;
            }

            return true;
        });

        // Run init callbacks
        if(this.aCallbacks.init.length){
            for(var i=0; i<oFormView.aCallbacks.init.length; i++){
                oFormView.aCallbacks.init[i]($scope.getDataForAPI());
            }
        }

        // Show/hide callbacks
        $scope.amiShow = function(oFormView){
            return function(name){
                if(typeof(oFormView.aCallbacks.show[name]) !== 'undefined'){
                    return oFormView.aCallbacks.show[name]($scope.getDataForAPI());
                }
                return false;
            };
        }(this);

        // Disable/enable callbacks
        $scope.amiDisable =  function(oFormView){
            return function(name){
                if(typeof(oFormView.aCallbacks.disable[name]) !== 'undefined'){
                    return oFormView.aCallbacks.disable[name]($scope.getDataForAPI());
                }
                return false;
            };
        }(this);

        // Watchers
        $scope.$watch('fields', function(oFormView){
            return function(){
                if($scope.watchChanges){
                    for(var i=0; i<oFormView.aCallbacks.watchers.length; i++){
                        oFormView.aCallbacks.watchers[i]($scope.getDataForAPI());
                    }
                }
            };
        }(this));

        for(var i=0; i<this.aCallbacks.fieldWatchers.length; i++){
            var oWatcher = this.aCallbacks.fieldWatchers[i];
            $scope.$watch('fields.' + oWatcher.field, function(field, callback){
                return function(newValue, oldValue){
                    if($scope.watchChanges){
                        callback(field, newValue, oldValue, $scope.getDataForAPI());
                    }
                };
            }(oWatcher.field, oWatcher.callback));
        }

        this.scope = $scope;
    };

    /**
     * Adds initialization callback.
     *
     * @param {function} callback
     * @returns {void}
     */
    this.onInit = function(callback){
        this.aCallbacks.init.push(callback);
    };

    /**
     *
     * @param {string} name
     * @param {function} callback
     * @returns {void}
     */
    this.addShowCondition = function(name, callback){
        $('.field__' + name).attr('ng-show', 'amiShow("' + name + '")');
        this.aCallbacks.show[name] = callback;
    };

    /**
     *
     * @param {string} name
     * @param {function} callback
     * @returns {void}
     */
    this.addDisableCondition = function(name, callback){
        $('[name=' + name + ']').attr('ng-disabled', 'amiDisable("' + name + '")');
        this.aCallbacks.disable[name] = callback;
    };

    /**
     * Adds watcher callback.
     *
     * @param {function} callback
     * @returns {void}
     */
    this.watchScope = function(callback){
        this.aCallbacks.watchers.push(callback);
    };

    /**
     * Adds field watcher callback.
     *
     * @param {string} field name
     * @param {function} callback
     * @returns {void}
     */
    this.watchField = function(field, callback){
        var oWatcher = {field: field, callback: callback};
        this.aCallbacks.fieldWatchers.push(oWatcher);
        if(typeof(this.scope) !== 'undefined'){
            this.scope.$watch('fields.' + oWatcher.field, function(field, callback, $scope){
                return function(newValue, oldValue){
                    if($scope.watchChanges){
                        callback(field, newValue, oldValue, $scope.getDataForAPI());
                    }
                };
            }(oWatcher.field, oWatcher.callback, this.scope));
        }
    };

    /**
     * @todo
     * @param {type} name
     * @returns {undefined}
     */
    this.clonePlaceholder = function(name){
        var clone = $('#' + name).clone(true, true);
        var id = clone.prop('id');
        if(id && id.length && (id.indexOf('_')>=0)){
            var parts = id.split('_');
            var lastPart = parts[parts.length-1];
            var newId = '';
            if(+lastPart === parseInt(lastPart)){
                var n = parseInt(lastPart) + 1;
                for(var i=0; i<(parts.length-1); i++){
                    newId += (parts[i] + '_');
                }
                newId += n;
            }else{
                newId = id + '_1';
            }
            clone.prop('id', newId);
        }
        $('#' + name + '_container').append(clone);
        $('#ami_recompile').scope().setRecompile("1");
        $('#ami_recompile').scope().$apply();
    };

    /**
     * @todo
     * @param {type} name
     * @returns {undefined}
     */
    this.deletePlaceholder = function(name){
        $('#' + name).remove();
        $('#ami_recompile').scope().setRecompile("1");
        $('#ami_recompile').scope().$apply();
    };

    /**
     *
     * @param {string} name
     * @param {function} callback
     * @returns {void}
     */
    this.addValidator = function(name, callback){
        this.aCallbacks.validators[name] = callback;
    };
};

AmiUploader = function(id, filename, doDirect){

    if(!$('#' + id).length){
        return;
    }

    /**
     * Uploader container
     */
    this.container = $('#' + id)[0];

    /**
     * Field name
     */
    this.name = id;

    /**
     * Container for file name
     */
    this.fileNameContainer = null;

    /**
     * Field that contains file code
     */
    this.fileCodeField = null;

    /**
     * Upload file field
     */
    this.uploadField = null;

    /**
     * File upload form
     */
    this.form = null;

    /**
     * Iframe, target for file upload form submission
     */
    this.iframe = null;

    /**
     * Container that hides iframe
     */
    this.iframeContainer = null;

    /**
     * Container, that holds file upload fields
     */
    this.uploader = null;

    /**
     * Div that contains file upload form
     */
    this.uploadDialog = null;

    /**
     * Current state of the field ("select", "loading", "uploaded", "error")
     */
    this.state = 'select';

    /**
     * Current filename
     */
    this.filename = filename ? filename : '';

    /**
     * Uploading check timer
     */
    this.checkTimer = null;

    /**
     * Field validators
     */
    this.validators = null;

    /**
     * Delete file button
     */
    this.deleteBtn = null;

    /**
     * Initialize field.
     */
    this.init = function(){

        this.rebuildField();

        if(this.filename){
            this.setUploaded('uploaded', this.filename);
        }
    };

    /**
     * Rebuild whole field
     */
    this.rebuildField = function(){

        // Clear container
        this.container.innerHTML = '';

        var uploader = document.createElement('DIV');
        uploader.className = 'amiFileUploader';

        var deleteBtn = document.createElement('img');
        deleteBtn.className = 'amiFileUploaderDeleteBtn icon';
        deleteBtn.src = parent.frontBaseHref + '_img/close_alert.gif';

        var deleteBtnA = document.createElement('a');
        deleteBtnA.href = '#';
        deleteBtnA.style.float = 'left';
        deleteBtnA.setAttribute('onclick', 'return false');

        var fileNameContainer = document.createElement('DIV');
        fileNameContainer.className = 'fileNameContainer';

        var fileCodeField = document.createElement('INPUT');
        fileCodeField.type = 'hidden';
        fileCodeField.name = this.name;
        fileCodeField.value = '';

        var divIFrame = document.createElement('DIV');
        divIFrame.style.overflow = 'hidden';
        divIFrame.style.width = '310px';
        //divIFrame.id = 'input_file_' + this.name;
        divIFrame.className = 'input_file';
        divIFrame.style.height = '25px';
        divIFrame.style.top = '0px';
        divIFrame.style.left = '0px';
        divIFrame.style.zIndex = '5';
        this.iframeContainer = divIFrame;

        var inputFile = document.createElement('input');
        inputFile.type = 'hidden';
        inputFile.className = 'download_file';
        this.inputFile = inputFile;

        var closeImg = document.createElement('div');
        closeImg.className = 'download_img icon';
        closeImg.style.display = 'none';
        this.closeImg = closeImg;

        var formIFrame = document.createElement('IFRAME');
        var frameName = 'upload_frame_' + this.name;
        var url =
            parent.amiSkinController.getURL('base') +
            '&ami_svc=ext_image' +
            '&ami_env=full' +
            '&ami_resp_mode=HTML' +
            '&action=upload';
        if(typeof(doDirect) !== 'undefined'){
            url += ('&direct_upload=1&mod_id=' + parent.authData.modId);
        }
        formIFrame.setAttribute('src', url);
        formIFrame.frameborder = '0';
        formIFrame.style.border = '0px solid white';
        formIFrame.name = frameName;
        formIFrame.uploader = this;
        this.iframe = formIFrame;

        divIFrame.appendChild(formIFrame);

        this.fileNameContainer = fileNameContainer;
        this.fileCodeField = fileCodeField;

        uploader.appendChild(fileNameContainer);
        uploader.appendChild(fileCodeField);
        uploader.appendChild(divIFrame);
        uploader.appendChild(inputFile);
        uploader.appendChild(closeImg);

        this.deleteBtn = deleteBtn;
        this.uploader = uploader;
        this.container.appendChild(uploader);
        this.container.appendChild(deleteBtnA);
        deleteBtnA.appendChild(deleteBtn);

        deleteBtn.onclick = function(_this){
            return function(e){
                if(_this.state !== 'select'){
                    clearImage(_this.name.replace('_upload', ''));
                }
            };
        }(this);

        if(this.checkTimer){
            clearInterval(this.checkTimer);
            this.checkTimer = null;
        }

        if(this.validators){
            this.setValidators(this.validators);
        }

        this.clear();
    };

    /**
     * Checks if file was not uploaded.
     */
    this.checkDocument = function(){
        if(this.state === 'loading'){
            try{
                if(this.iframe.contentWindow && (typeof(this.iframe.contentWindow.document) !== 'undefined') && !this.iframe.contentWindow.loading){
                    this.setError();
                }
            }catch(e){
                this.setError();
            }
        }else{
            if(this.checkTimer){
                clearInterval(this.checkTimer);
                this.checkTimer = null;
            }
        }
    };

    /**
     * Clears current field state.
     */
    this.clear = function(){
        this.state = 'select';
        $(this.fileNameContainer).removeClass('error');
        $(this.fileNameContainer).removeClass('loading');
        $(this.fileNameContainer).removeClass('uploaded');
        this.fileCodeField.value = '';
        this.fileNameContainer.innerHTML = oActiveModule.aLocale['select_file'];
        this.fileNameContainer.style.display = 'none';
        this.iframeContainer.style.display = 'block';
        this.deleteBtn.style.display = 'none';
        this.closeImg.style.display = 'inline';
        this.inputFile.style.display = 'inline';
    };

    /**
     * Sets field to uploaded state.
     *
     * @param {type} code
     * @param {type} filename
     * @param {type} size
     * @param {type} link
     * @param {type} callback
     * @returns {undefined}
     */
    this.setUploaded = function(code, filename, size, link, callback){
        size = (typeof(size) === 'undefined') ? '' : (' (' + size + ')');
        this.iframeContainer.style.display = 'none';
        this.fileNameContainer.style.display = 'block';
        if(this.checkTimer){
            clearInterval(this.checkTimer);
            this.checkTimer = null;
        }
        this.state = 'uploaded';
        $(this.fileNameContainer).removeClass('error');
        $(this.fileNameContainer).removeClass('loading');
        this.fileCodeField.value = code;
        this.fileNameContainer.innerHTML = filename.replace(/\\'/g, "'") + size;
        $(this.fileNameContainer).addClass('uploaded');
        this.deleteBtn.style.display = 'block';
        this.closeImg.style.display = 'none';
        this.inputFile.style.display = 'none';

        if(typeof(callback) !== 'undefined'){
            callback(this, code, filename, size, link);
        }
    };

    /**
     * Marks field as error.
     *
     * @param {type} errorMsg
     * @returns {undefined}
     */
    this.setError = function(errorMsg){
        if(this.checkTimer){
            clearInterval(this.checkTimer);
            this.checkTimer = null;
        }
        this.iframeContainer.style.display = 'none';
        this.fileNameContainer.style.display = 'block';
        this.state = 'error';
        $(this.fileNameContainer).removeClass('uploaded');
        $(this.fileNameContainer).removeClass('loading');
        this.fileCodeField.value = '';
        this.fileNameContainer.innerHTML = (typeof(errorMsg) !== 'undefined') ? errorMsg : window.oActiveModule.aLocale['upload_failed'];
        $(this.fileNameContainer).addClass('error');
        this.deleteBtn.style.display = 'block';
        if(typeof(this.onError) !== 'undefined'){this.onError(errorMsg);}
    };

    /**
     * Set field to loading state.
     */
    this.setLoading = function(){
        if(typeof(this.onBeforeUpload) !== 'undefined'){
            this.onBeforeUpload();
        }
        this.iframeContainer.style.display = 'none';
        this.fileNameContainer.style.display = 'block';
        this.iframe.contentWindow.loading = true;

        // Check loading state every 10 seconds
        this.checkTimer = setInterval(function(_this){
            return function(){
                _this.checkDocument();
            };
        }(this), 10000);
        this.state = 'loading';
        $(this.fileNameContainer).removeClass('uploaded');
        $(this.fileNameContainer).removeClass('error');
        this.fileCodeField.value = '';
        this.fileNameContainer.innerHTML = oActiveModule.aLocale['upload_in_progress'];
        $(this.fileNameContainer).addClass('loading');
        this.deleteBtn.style.display = 'block';
        this.closeImg.style.display = 'none';
        this.inputFile.style.display = 'none';
    };

    /**
     * Sets field validators.
     *
     * @param {string} validators List of validators
     */
    this.setValidators = function(validators){
        this.fileCodeField.setAttribute('data-ami-validators', validators);
        this.validators = validators;
    };

    this.init();
};

var confirmChanges = function() {
    return (window.formChanged) ? confirm(oActiveModule.aLocale['confirm_changes']) : true;
};

function showSeoTab(){
    $('.nav-tabs a[href=#taboptions_tab]').tab('show');
}

if(oActiveModule.hasForm){
    var oFormView = new amiFormComponentView();
    var oForm = new amiFormComponentController(oFormView);
}