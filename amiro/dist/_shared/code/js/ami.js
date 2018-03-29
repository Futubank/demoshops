/**
* @fileOverview File contains AMI container with AMI global functions description.
*/

/**
* Base container of Amiro JS API classes.
*
* @class Base container of Amiro JS API classes.
*/
var AMI = {

    $: function(){
        if(typeof(window.amiNoJqueryAlerted) == 'undefined'){
            alert('jQuery is not installed!');
            window.amiNoJqueryAlerted = true;
        }
    },

    /**
    * Inherit one class from other and creating superclass definition in child.
    *
    * @example <strong>Example of inheriting classes:</strong>
    * parentClass = function(param1, param2){}
    * childClass = function(param1, param2){
    *     AMI.ModuleComponentCustom.superclass.constructor.call(this, param1, param2);
    *     // Child class methods further
    * }
    * AMI.inherit(childClass, parentClass);
    *
    * @param {function} oChildClass Class that should be inherited.
    * @param {function} oParentClass Parent class object.
    * @returns {void}
    */
    inherit: function(oChildClass, oParentClass){
        var oTmp = function(){};
        oTmp.prototype = oParentClass.prototype;
        oChildClass.prototype = new oTmp();
        oChildClass.prototype.constructor = oChildClass;
        oChildClass.superclass = oParentClass.prototype;
    },

    /**
    * Find element in DOM by id, class or tag.
    *
    * @param {string} search Search string in format "#idOfElement" or ".classNameOfElement" or "tagName".
    * @param {DOM object} oParent DOM element where target element will be searched.
    * @returns {mixed} Found element or null in case of search by ID, array of elements in other search cases.
    */
    find: function(search, oParent){
        oParent = oParent || document;
        if(search.lastIndexOf('[') >= 0){
            var parts = search.match(/\[(.*)\]/ig);
            if(typeof(parts[0]) != 'undefined'){
                parts = parts[0].split('=');
                if(parts.length == 2){
                    var attribute = parts[0].substr(1);
                    var value = parts[1].substr(0, parts[1].length-1);
                }
                search = search.substr(0, search.lastIndexOf('['));
            }
        }

        var result = null;
        var singleObject = false;
        if(search.length > 0){
            if(search.substr(0, 1) == '#'){
                result = document.getElementById(search.substr(1));
                singleObject = true;
            }else if(search.substr(0, 1) == '.'){
                search = search.substr(1);
                if(oParent.getElementsByClassName){
                    result = oParent.getElementsByClassName(search);
                }else{
                    var aElements = oParent.getElementsByTagName('*');
                    var aResult = [];
                    for(var i = 0; i < aElements.length; i++){
                        var rx = new RegExp('(^| )' + search + '( |$)', 'i');
                        if(rx.test(aElements[i].className)){
                            aResult.push(aElements[i]);
                        }
                    }
                    result = aResult;
                }
            }else{
                result = oParent.getElementsByTagName(search);
            }
        }else{
            result = oParent.getElementsByTagName('*');
        }

        // Check attributes if needed
        if((result != null) && (typeof(attribute) != 'undefined') && (typeof(value) != 'undefined')){
            var res = null;
            if(!singleObject){
                for(var i=0; i < result.length; i++){
                    var element = result[i];
                    var val = (element.getAttribute && element.getAttribute(attribute)) || null;
                    if( !val ) {
                        var attrs = element.attributes;
                        var length = attrs.length;
                        for(var j = 0; j < length; j++){
                            if(attrs[j].nodeName === attribute){
                                val = attrs[j].nodeValue;
                            }
                        }
                    }
                    if(val == value){
                        if (res == null){
                            res = [];
                        }
                        res.push(element);
                    }
                }
                result = res;
            }else{
                if((typeof(result.attributes[attribute]) == 'undefined') || (result.attributes[attribute] != value)){
                    result = null;
                }
            }
        }
        return result;
    },

    /**
    * Animated scroll to any object on page.
    *
    * @param {DOM object} oElement DOM element to scroll to.
    * @param {number} paddingLeftTop Padding from left and top (equal) that shold be left after scrolling if possible.
    * @returns {void}
    */
    scrollTo: function(oElement, paddingLeftTop){
        /**
        * @private
        */
        this.move = function(){
            this.step++;

            if(this.step == this.numberOfSteps){
                this.currentPosition[0] = this.aMoveTo[0];
                this.currentPosition[1] = this.aMoveTo[1];
            }else{
                this.currentPosition[0] += (this.aMoveTo[0] - this.currentPosition[0]) / (this.numberOfSteps - this.step);
                this.currentPosition[1] += (this.aMoveTo[1] - this.currentPosition[1]) / (this.numberOfSteps - this.step);
            }
            var
                x = Math.ceil(this.currentPosition[0]),
                y = Math.ceil(this.currentPosition[1]);

            if(typeof(window.scrollTo) == 'function'){
                window.scrollTo(x, y);
            }else{
                AMI.Browser.setDocumentLeft(x);
                AMI.Browser.setDocumentTop(y);
            }
            if(this.currentPosition[0] != this.aMoveTo[0] || this.currentPosition[1] != this.aMoveTo[1]){
                setTimeout(function(_this){return function(){_this.move()}}(this), 10);
            }
        }

        this.oElement = oElement;
        this.numberOfSteps = 15;
        this.step = 0;
        if(typeof(this.oElement) == 'object'){
            this.aMoveTo = AMI.Browser.getObjectPosition(this.oElement);
            if(typeof(paddingLeftTop) != 'undefined'){
                this.aMoveTo[0] = Math.max(0, this.aMoveTo[0] - paddingLeftTop);
                this.aMoveTo[1] = Math.max(0, this.aMoveTo[1] - paddingLeftTop);
            }
            this.currentPosition = [AMI.Browser.getDocumentLeft(), AMI.Browser.getDocumentTop()];
            this.move();
        }
    },

    /**
     * Check if element has class 'className'.
     *
     * @param {number} element DOM element
     * @param {string} className class name
     * @returns {bool}
     */
    hasClass: function (element, className){
        return (element.className != undefined) ? element.className.match(new RegExp('(\\s|^)' + className + '(\\s|$)')) : false;
    },

    /**
     * Adds specified class name to the DOM element.
     *
     * @param {number} element DOM element
     * @param {string} className class name
     * @returns {void}
     */
    addClass: function(element, className){
        if(!this.hasClass(element, className)){
            element.className += " " + className;
        }
    },

    /**
     * Removes specified class name out of the DOM element.
     *
     * @param {number} element DOM element
     * @param {string} className class name
     * @returns {void}
     */
    removeClass: function(element, className){
        if(this.hasClass(element, className)){
            var reg = new RegExp('(\\s|^)' + className + '(\\s|$)');
            element.className=element.className.replace(reg,' ').replace('\\w+', ' ');
        }
    },

    /**
     * Returns count of object properties.
     *
     * @param   {object} obj  Object
     * @returns {void}
     */
    countProperties: function(obj){
        var count = 0;

        for(var prop in obj){
            if(obj.hasOwnProperty(prop)){
                ++count;
            }
        }

        return count;
    }
};

if(typeof(jQuery) != 'undefined'){
    AMI.$ = jQuery;
}