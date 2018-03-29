/**
 * New Amiro.CMS select fields with search abilty and AJAX support.
 *
 * @param {type} name
 * @param {type} data
 * @param {object} options  Select fields options.
 *   Options: {
 *       title: 'Input area default title',
 *
 *   }
 * @returns {amiAdminSelect}
 */
var amiAdminSelect = function(name, data, options){
    this.name = name;
    this.aData = data;
    this.container = null;
    this.highlighted = {};
    this.lastStr = '';
    this.showTooMuch = false;

    this.options = typeof(options) !== 'undefined' ? options : {};

    /**
     * Returns options value by param name, null if no option was set and no default value given.
     *
     * @param {String} name
     * @param {mixed} defaultValue
     * @returns {String}
     */
    this.getOpt = function(name, defaultValue){
        var def = typeof(defaultValue) !== 'undefined' ? defaultValue : null;
        return typeof(this.options[name]) !== 'undefined' ? this.options[name] : def;
    };

    /**
     * Initializes select box.
     *
     * @param {String} containerId  Container element ID for select field.
     * @returns {boolean}
     */
    this.init = function(containerId){
        if(typeof(window.amiAdminSelectInstances) == 'undefined'){
            window.amiAdminSelectInstances = {};

            window.getAmiAdminSelect = function(name){
                return (typeof(window.amiAdminSelectInstances[name]) != 'undefined') ? window.amiAdminSelectInstances[name] : null;
            }

            AMI.$(window).keydown(function(e){
                var obj = false;
                for(var id in window.amiAdminSelectInstances){
                    if(AMI.$('#' + id + '-list:visible').length){
                        obj = window.amiAdminSelectInstances[id];
                        break;
                    }
                }
                if(obj !== false){
                    var keys = {
                        enter:  13, // Enter
                        escape: 27, // Escape
                        up:     38, // Up arrow
                        down:   40, // Down arrow
                    };

                    // Cursor keys and Enter
                    var list = obj.getListObject();
                    var activeEl = list.find('.ami-select__selected');

                    if (e.keyCode === keys.enter) {
                        if(activeEl.length){
                            activeEl.click();
                        }
                        e.preventDefault();
                    }
                    var sel = '.ami-select__item';
                    if (e.keyCode === keys.up) {
                        if(!activeEl.length){
                            list.find(sel).first().addClass('ami-select__selected');
                            list.scrollTop(0);
                        }else{
                            var prev = activeEl.prevAll(sel).first();
                            if(!prev.length){
                                prev = activeEl.parent().prev().find(sel).last();
                            }
                            if(prev.length){
                                prev.mouseover();
                                if(prev.position().top < 0){
                                    list.scrollTop(list.scrollTop() + prev.position().top);
                                }
                            }
                        }
                        e.preventDefault();
                    }
                    if (e.keyCode === keys.down) {
                        if(!activeEl.length){
                            list.find(sel).first().addClass('ami-select__selected');
                            list.scrollTop(0);
                        }else{
                            var next = activeEl.nextAll(sel).first();
                            if(!next.length){
                                next = activeEl.parent().next().find(sel).first();
                            }
                            if(next.length){
                                next.mouseover();
                                if(next.position().top > list.height() - next.height()){
                                    list.scrollTop(list.scrollTop() + next.height() + 10);
                                }
                            }
                        }
                        e.preventDefault();
                    }
                }
            });
        }

        window.amiAdminSelectInstances[this.name] = this;

        var container = AMI.$('#' + containerId);
        this.container = container;
        if(container.length){
            // Clear container's contents
            container.empty();

            var callback = this.getOpt('onInit', false);
            if(typeof(callback) == 'function'){
                callback(this);
            }

            // Add header and list data
            this.renderInputRow(container);
            if(this.getOpt('renderDataOnStart', true)){
                this.renderData();
            }
            this.initEvents();

            // Adjust list height
            setTimeout(function(_this){
                return function(){
                    if ( !topEvents || window.self === window.top ){
                        _this.getListObject().css('max-height', AMI.$(window).height() - 250);
                    }else{
                        // iframe
                        _this.getListObject().css('max-height', AMI.$(window.top).height() - 350);
                    }

                    var callback = _this.getOpt('onAfterInit', false);
                    if(typeof(callback) == 'function'){
                        callback(_this);
                    }
                }
            }(this), 300);

            return true;
        }
        this.log('Container element ID #' + containerId + ' not found!');
        return false;
    };

    this.renderInputRow = function(container){
        // Create elements strucure

        // container.css('height', '40px');

        var subcontainer = AMI.$('<DIV>');
        subcontainer.attr('id', this.name + '-container');
        subcontainer.addClass('ami-select__container');
        subcontainer.css('width', Math.round((parseInt(AMI.$('#filter-box').width()) - 100) / 2) + 'px');

        var innerArea = AMI.$('<DIV>');
        innerArea.addClass('ami-select__inner');
        innerArea.addClass('ami-select__resultrow');

        var resultRow = AMI.$('<DIV>');
        resultRow.attr('id', this.name + '-resultrow');
        resultRow.addClass('ami-select-resultrow');

        var rolloverButton = AMI.$('<DIV>');
        rolloverButton.attr('id', this.name + '-rolloverbutton');
        rolloverButton.addClass('ami-select-rolloverbutton');
        rolloverButton.attr('align', 'right');
        //rolloverButton.text(this.getOpt('button', ''));

        var textField = AMI.$('<INPUT>');
        textField.attr('type', 'text');
        textField.val(this.getOpt('title', ''));

        textField.focus(function(_this){
            return function(){
                if(this.value === _this.getOpt('title', '')){
                    this.value = '';
                }
            };
        }(this));

        textField.blur(function(_this){
            return function(){
                if(this.value === ''){
                    this.value = _this.getOpt('title', '');
                }
            };
        }(this));

        var divViewed = AMI.$('<DIV>');
        divViewed.attr('id', this.name + '-viewed');
        divViewed.addClass('ami-select-viewed');

        resultRow.append(textField);
        resultRow.append(divViewed);

        innerArea.append(resultRow);
        innerArea.append(rolloverButton);
        subcontainer.append(innerArea);
        container.append(subcontainer);

        var list = AMI.$('<DIV>');
        list.attr('id', this.name + '-list');
        list.addClass('ami-select__inner');
        list.addClass('ami-select__list');
        list.css('z-index', '100');

        var closeBtn = AMI.$('<DIV>');
        closeBtn.addClass('ami-select__close');
        closeBtn.attr('id', this.name + '-close');
        closeBtn.click(function(_this){
            return function(e){
                _this.closeList(e, true);
            }
        }(this));
        list.append(closeBtn);

        if(this.getOpt('listAlign', 'left') == 'right'){
            list.css('right', '8px');
        }else{
            list.css('left', '10px');
        }

        container.append(list);

        var tooMuchMatches = AMI.$('<DIV>');
        tooMuchMatches.attr('id', this.name + '-tooMuchMaches');
        tooMuchMatches.addClass('ami-select__msgOverflow');
        container.append(tooMuchMatches);
    };

    this.tooMuch = function(isOn, count, total){
        var tooMuch = AMI.$('#' + this.name + '-tooMuchMaches');
        this.showTooMuch = isOn;
        if(isOn && (parseInt(count) < parseInt(total))){
            tooMuch.css('top', this.getListObject().position().top + this.getListObject().height() + 4);
            tooMuch.html(this.getOpt('tooMuch', 'Not all mathes shown').replace('__count__', count).replace('__total__', total));
            tooMuch.show();
        }else{
            tooMuch.html('');
            tooMuch.hide();
        }
    };

    /**
     * Returns list container object.
     */
    this.getListObject = function(){
        return AMI.$('#' + this.name + '-list');
    };

    /**
     * Returns container object.
     */
    this.getContainer = function(){
        return AMI.$('#' + this.name + '-container');
    };

    /**
     * Renders list body.
     *
     * @returns {undefined}
     */
    this.renderData = function(){
        for(var group in this.aData){
            this.addGroup(this.aData[group].caption);
            if(typeof(this.aData[group]) === 'object'){
                for(var item in this.aData[group].items){
                    this.addItem(this.aData[group].caption, this.aData[group].items[item].caption, item);
                }
            }
        }
    };

    /**
     * Returns tru if group with specified name exist, false otherwise.
     *
     * @param {String} name  Group name
     * @returns {boolean}
     */
    this.isGroupExists = function(name){
        return this.getGroup(name).length > 0;
    };

    /**
     * Returns container element for group with specified name.
     *
     * @param {String} name  Group name
     * @returns {object}
     */
    this.getGroup = function(name){
         return this.getListObject().children('DIV[data-ami-select-group="' + name + '"]');
    };

    /**
     * Get all groups.
     */
    this.getGroups = function(){
        return AMI.$('#' + this.name + '-list > .ami-select__group');
    };

    /**
     * Adds group named name to the list.
     *
     * @param {String} name  Group name
     */
    this.addGroup = function(name){
        name = this.clearName(name);
        if(this.isGroupExists(name)){
            return this.getGroup(name);
        }

        var groupContainer = AMI.$('<DIV>');
        groupContainer.addClass('ami-select__group');
        groupContainer.attr('data-ami-select-group', name);

        var groupTitle = AMI.$('<DIV>');
        groupTitle.addClass('ami-select__grouptitle');
        for(var substr in this.highlighted){
            var regx = new RegExp("(" + substr + ")", 'ig');
            name = name.replace(regx, "<b>$1</b>");
        }
        groupTitle.html(name);

        groupContainer.append(groupTitle);
        this.getListObject().append(groupContainer);

        // Get values from clicked elements
        groupContainer.on('click', 'div', function(_this){
            return function(){
                if(AMI.$(this).hasClass('ami-select__item')){
                    AMI.$('#' + _this.name + '-resultrow input, #' + _this.name + '-list').hide();
                    _this.tooMuch(false);
                    AMI.$('#' + _this.name + '-viewed, #' + _this.name + '-rolloverbutton').show();
                    AMI.$('#' + _this.name + '-viewed').text(AMI.$(this).attr('data-ami-select-item-full'));
                    if(typeof(_this.options['onSelect']) !== 'undefined'){
                        _this.options['onSelect'](_this, AMI.$(this).attr('data-ami-select-item-full'), AMI.$(this).attr('data-ami-select-item-value'), AMI.$(this));
                    }
                }
            };
        }(this));

        return groupContainer;
    };

    this.clearName = function(name){
        if(typeof(name) == 'undefined'){
            return '';
        }
        name = name.replace(/&quot;/ig, '"');
        name = name.replace(/&laquo;/ig, '');
        name = name.replace(/&raquo;/ig, '');
        name = name.replace(/\\'/ig, '\'');
        name = name.replace(/\\\//ig, '/');
        return name;
    };

    /**
     * Adds new item to the list.
     *
     * @param {type} group
     * @param {type} name
     * @param {type} value
     * @returns {undefined}
     */
    this.addItem = function(group, name, value, noReselect){
        name = this.clearName(name);
        var groupContainer = this.addGroup(group);
        groupContainer.children('HR').remove();
        var itemContainer = AMI.$('<DIV>');
        itemContainer.addClass('ami-select__item');
        itemContainer.attr('data-ami-select-item-value', value);
        var fullname = groupContainer.attr('data-ami-select-group') + ': ' + name;
        itemContainer.attr('data-ami-select-item-full', fullname);
        if(typeof(noReselect) == 'undefined'){
            if(this.getOpt('selected', '') === value){
                AMI.$('#' + this.name + '-viewed').text(fullname);
                AMI.$('#' + this.name + '-resultrow input').val(fullname);
            }
        }
        for(var substr in this.highlighted){
            var regx = new RegExp("(" + substr + ")", 'ig');
            name = name.replace(regx, "<b>$1</b>");
        }
        itemContainer.html(name);

        var callback = this.getOpt('onAddItem', false);
        if(typeof(callback) == 'function'){
            callback(this, group, name, value, groupContainer, itemContainer);
        }

        groupContainer.append(itemContainer);
        groupContainer.append(AMI.$('<HR>'));
    };

    this.searchItems = function(source, items){
        var res = false;
        for(var i=0; i<items.length; i++){
            if(items[i] == ''){
                continue;
            }
            var src = source.toLowerCase();
            var item = items[i];
            if(src.indexOf(item) >= 0){
                res = true;
                this.highlighted[item] = 1;
            }
        }
        return res;
    };

    /**
     * Initializes list events.
     *
     * @returns {undefined}
     */
    this.initEvents = function(){
        AMI.$(window).resize(function(obj){
            return function(e){
                obj.getContainer().css('width', Math.round((parseInt(AMI.$('#filter-box').width()) - 100) / 2) + 'px');
            }
        }(this));

        // Open list body by clicking on down arrow
        this.getContainer().on('click', '#' + this.name + '-rolloverbutton', function(_this){
            return function(){
                var callback = _this.getOpt('onButtonClick', false);
                var cbRes = false;
                if(typeof(callback) == 'function'){
                    var cbRes = callback(_this);
                }
                if(!cbRes){
                    _this.getListObject().css('display', 'inline-block');
                    var callback = _this.getOpt('onListOpen', false);
                    if(typeof(callback) == 'function'){
                        callback(_this, _this.getListObject());
                    }                    
                    AMI.$('#' + _this.name + '-viewed, #' + _this.name + '-rolloverbutton').hide();
                    AMI.$('#' + _this.name + '-resultrow input').show().focus();
                    _this.ifInputNullShowList();
                    if(_this.showTooMuch){
                        _this.tooMuch(true);
                    }
                }
            };
        }(this));

        // Open list body by clicking on input
        this.getContainer().on('click', '#' + this.name + '-viewed, #' + this.name + '-resultrow > input', function(_this){
            return function(){
                var callback = _this.getOpt('onListClick', false);
                var cbRes = false;
                if(typeof(callback) == 'function'){
                    var cbRes = callback(_this);
                }
                if(!cbRes){
                    _this.getListObject().css('display', 'inline-block');
                    var callback = _this.getOpt('onListOpen', false);
                    if(typeof(callback) == 'function'){
                        callback(_this, _this.getListObject());
                    }                    
                    AMI.$('#' + _this.name + '-viewed, #' + _this.name + '-rolloverbutton').hide();
                    /*
                    if(AMI.$('#' + _this.name + '-viewed').text() !== ''){
                        AMI.$('#' + _this.name + '-resultrow input').val(AMI.$('#' + _this.name + '-viewed').text());
                    }
                    */
                    AMI.$('#' + _this.name + '-resultrow input').val('');
                    if(typeof(_this.lastStr) != 'undefined'){
                        AMI.$('#' + _this.name + '-resultrow input').val(_this.lastStr);
                    }
                    AMI.$('#' + _this.name + '-resultrow input').show().focus().select();
                    _this.ifInputNullShowList();
                    if(_this.showTooMuch){
                        _this.tooMuch(true);
                    }
                }
            };
        }(this));
        
        this.getListObject().scroll(function(_this){
            return function(){
                var topPos = _this.getListObject().scrollTop();
                AMI.$('#' + _this.name + '-close').css('top', topPos + 'px');
            }
        }(this));

        // Close list on click outside of list container
        AMI.$(document).mouseup(function(_this){
            return function(e){
                _this.closeList(e);
            };
        }(this));

        // Close list by pressing ESC key
        AMI.$(document).keyup(function(_this){
            return function(e){
                if (e.keyCode === 27) {
                    _this.closeList(e);
                }
            };
        }(this));

        // Open list body by clicking on input
        this.getListObject().on('mouseover', '.ami-select__item', function(_this){
            return function(){
                AMI.$('.ami-select__item').removeClass('ami-select__selected');
                AMI.$(this).addClass('ami-select__selected');
            }
        }(this));

        // SEARCH
        AMI.$('#' + this.name + '-resultrow input').keyup(function(_this){
            return function(e){
                if (e.keyCode === 27) {
                    AMI.$(this).val('');
                }
                if((e.keyCode === 38) || (e.keyCode === 40)){
                    return;
                }
                _this.delay(function(__this){
                    return function(){
                        var searchItems = [];
                        var searchText = AMI.$('#' + __this.name + '-resultrow input').val().replace(/\:/g, '');
                        searchText = searchText.replace(/\s+/g, " ").replace(/^\s/, '').replace(/\s$/, '');
                        if(!searchText.length){
                            __this.highlighted = {};
                            __this.lastStr = '';
                            var callback = __this.getOpt('onEmptySearch', false);
                            var esRes = false;
                            if(typeof(callback) == 'function'){
                                esRes = callback(__this);
                            }
                            if(!esRes){
                                return;
                            }
                        }else{
                            AMI.$('#' + _this.name + '-viewed, #' + _this.name + '-rolloverbutton').hide();
                            _this.getListObject().css('display', 'inline-block');
                            var callback = __this.getOpt('onListOpen', false);
                            if(typeof(callback) == 'function'){
                                callback(__this, __this.getListObject());
                            }
                            searchText = searchText.replace('\\', '\\\\').toLowerCase();
                            if(__this.lastStr == searchText){
                                return;
                            }
                            __this.highlighted = {};
                            __this.lastStr = searchText;
                            searchItems = searchText.split(' ');
                        }

                        var callback = __this.getOpt('onBeforeHighlight', false);
                        if(typeof(callback) == 'function'){
                            callback(__this);
                        }

                        __this.getListObject().empty();
                        var closeBtn = AMI.$('<DIV>');
                        closeBtn.addClass('ami-select__close');
                        closeBtn.attr('id', __this.name + '-close');
                        closeBtn.click(function(___this){
                            return function(e){
                                ___this.closeList(e, true);
                            }
                        }(__this));
                        __this.getListObject().append(closeBtn);

                        var aFoundItems = {};
                        var cnt = 0;
                        var breaked = false;
                        var total = 0;
                        for(var group in __this.aData){
                            for(var item in __this.aData[group].items){

                                for(var i=0; i<searchItems.length; i++){
                                    if(searchItems[i] != ''){
                                        searchItems[i] = searchItems[i];
                                        __this.highlighted[searchItems[i]] = 0;
                                    }
                                }

                                var customSearch = false;
                                var callback = __this.getOpt('onSearch', false);
                                if(typeof(callback) == 'function'){
                                    customSearch = callback(__this, group, item, searchText, searchItems);
                                }
                                var searchGrp = __this.searchItems(__this.aData[group].caption, searchItems);
                                var searchItm = __this.searchItems(item, searchItems);
                                var searchItC = __this.searchItems(__this.aData[group].items[item].caption, searchItems);

                                var foundAll = true;
                                for(var str in __this.highlighted){
                                    if(!__this.highlighted[str]){
                                        foundAll = false;
                                        break;
                                    }
                                }

                                if(foundAll && (customSearch || searchGrp || searchItm || searchItC)){
                                    total++;
                                    if(breaked){
                                        continue;
                                    }
                                    if(typeof(aFoundItems[group]) == 'undefined'){
                                        aFoundItems[group] = {};
                                    }
                                    aFoundItems[group][item] = __this.aData[group].items[item];

                                    var capt = aFoundItems[group][item].caption;
                                    __this.addItem(__this.aData[group].caption, capt, item, true);
                                    cnt++;
                                    if(cnt == __this.getOpt('maxCount', 1000)){
                                        breaked = true;
                                        break;
                                    }
                                }
                            }
                        }
                        __this.getListObject().find('P').remove();
                        __this.tooMuch(breaked, __this.getOpt('maxCount', 1000), total);
                        if(!cnt){
                            __this.getListObject().append('<p>' + __this.getOpt('notFound', 'Found nothing') + '</p>');
                        }
                    };
                }(_this), 300);
            };
        }(this));
    };

    /**
     * Shows list if input is empty.
     *
     * @returns {undefined}
     */
    this.ifInputNullShowList = function(){
        if(AMI.$('#' + this.name + '-resultrow > input').val() === ''){
            this.getGroups().show();
            // todo: remove HL
            // this.getGroups().find('div').removeHighlight().removeClass('ami-select__Found');
        }
    };

    /**
     * Closes list container.
     *
     * @param {object} e  Event
     * @returns {undefined}
     */
    this.closeList = function(e, force){
        var container = this.getListObject();
        if(force || ((typeof(e.target) != 'undefined') && ((container.has(e.target).length === 0) && (container.attr('id') != AMI.$(e.target).attr('id'))))){
            this.tooMuch(false);
            container.hide();
            AMI.$('#' + this.name + '-rolloverbutton').show();
            if(AMI.$('#' + this.name + '-viewed').text() !== ''){
                AMI.$('#' + this.name + '-viewed').show();
                AMI.$('#' + this.name + '-resultrow input').hide();
            }
        }
    };

    this.timer = 0;
    this.delay = function(callback, ms) {
        clearTimeout(this.timer);
        this.timer = setTimeout(callback, ms);
    };

    /**
     * Log debug message
     *
     * @param {type} msg
     * @param {type} type
     * @returns {undefined}
     */
    this.log = function(msg, type){
        if(this.getOpt('debug', false)){
            console.log(msg);
        }
    };
};
