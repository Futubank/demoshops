/**
* @fileOverview File contains AMI.UI.Effects static object required to animate UI elements and AMI.UI.AnimatedObject
*/

/**
* Static object that manages UI visual effects
*
* @class Static object for UI visual effects.
*/
AMI.UI.Effects = {

     /**
     * Smoothly displays an obect, from invisible to visible
     *
     * @param {HTMLElement} oObj Object to manipulate
     * @param {int} time Time interval of the effect
     * @param {function} callback A callback function
     * @returns {void}
     */
    fadeIn: function(oObj, time, callback){
        var delay = 50;
        if(oObj.style.visibility != 'visible'){
            oObj.style.visibility = 'visible';
            AMI.Browser.setOpacity(oObj, 0);
        }
        if(time==null){
            var time = 500;
        }
        if(time > 0){
            time -= delay;
            var opacity = AMI.Browser.DOM.getStyle(oObj, 'opacity');
            var newOpacity = parseFloat(opacity) + (1 - parseFloat(opacity)) / (time / delay);
            AMI.Browser.setOpacity(oObj, newOpacity);

            oObj.style.opacity = parseFloat(oObj.style.opacity) + (1 - parseFloat(oObj.style.opacity)) / (time / delay);
            window.setTimeout(function(_oObj, _time, _callback){return function(){AMI.UI.Effects.fadeIn(_oObj, _time, _callback)}}(oObj, time, callback), delay);
        }else{
            //Callback
            if(typeof(callback) == 'function'){
                callback(oObj);
            }
        }
    },

     /**
     * Smoothly hides an obect, from visible to invisible
     *
     * @param {HTMLElement} oObj Object to manipulate
     * @param {int} time Time interval of the effect
     * @param {function} callback A callback function
     * @returns {void}
     */
    fadeOut: function(oObj, time, callback){
        var delay = 50;
        if(time==null){
            var time = 500;
        }
        if(time > 0){
            time -= delay;
            var opacity = AMI.Browser.DOM.getStyle(oObj, 'opacity');
            var newOpacity = parseFloat(opacity) - ( parseFloat(opacity) / (time / delay) );
            AMI.Browser.setOpacity(oObj, newOpacity);
            window.setTimeout(function(_oObj, _time, _callback){return function(){AMI.UI.Effects.fadeOut(_oObj, _time, _callback)}}(oObj, time, callback), delay);
        }else{
            AMI.Browser.setOpacity(oObj, 1);
            oObj.style.visibility = 'hidden';

            //Callback
            if(typeof(callback) == 'function'){
                callback(oObj);
            }
        }
    },

    /**
     * Move or resize element from start point to end point within specified time
     *
     * @param {HTMLElement} oObj Object to move
     * @param {object} oStart Start point {'top':int, 'left':int, 'height':int, 'width':int}
     * @param {object} oEnd End point {'top':int, 'left':int, 'height':int, 'width':int}
     * @param {int} interval Time interval in mseconds
     * @param {function} callback A callback function
     * @returns {void}
     */
    animate: function(oObj, oStart, oEnd, interval, callback){
        var endTime = new Date().getTime() + interval;
        AMI.UI.Effects._move(oObj, oStart, oEnd, endTime, 0, callback);
    },

    /**
     * Move or resize element from start point to end point within specified time
     *
     * @param {HTMLElement} oObj Object to move
     * @param {object} oStart Start point {'top':int, 'left':int, 'height':int, 'width':int}
     * @param {object} oEnd End point {'top':int, 'left':int, 'height':int, 'width':int}
     * @param {int} endTime Sheduled time to finish the animation task (ms)
     * @param {int} lastTime Last time this was called
     * @param {function} callback A callback function
     * @returns {void}
     * @private
     */
    _move: function(oObj, oStart, oEnd, endTime, lastTime, callback){

        var curTime = new Date().getTime();

        // Extract start point
        var startTop    = (typeof(oStart.top) != 'undefined')   ? Math.round(oStart.top)    : null;
        var startLeft   = (typeof(oStart.left) != 'undefined')  ? Math.round(oStart.left)   : null;
        var startHeight = (typeof(oStart.height) != 'undefined')? Math.round(oStart.height) : null;
        var startWidth  = (typeof(oStart.width) != 'undefined') ? Math.round(oStart.width)  : null;

        // Extract end point
        var endTop      = (typeof(oEnd.top) != 'undefined')     ? Math.round(oEnd.top)      : null;
        var endLeft     = (typeof(oEnd.left) != 'undefined')    ? Math.round(oEnd.left)     : null;
        var endHeight   = (typeof(oEnd.height) != 'undefined')  ? Math.round(oEnd.height)   : null;
        var endWidth    = (typeof(oEnd.width) != 'undefined')   ? Math.round(oEnd.width)    : null;

        var interval = ((endTime - curTime) > 0) ? endTime - curTime : 0;
        var diffTime = (lastTime && (lastTime < curTime)) ? interval / (curTime - lastTime) : interval;

        if (diffTime < 1) diffTime = 1;

        if(interval){

            // Next point
            var oNewStart = {};

            this._moveLeft(oObj, startLeft, endLeft, diffTime, oStart, oNewStart);
            this._moveTop(oObj, startTop, endTop, diffTime, oStart, oNewStart);
            this._resizeHeight(oObj, startHeight, endHeight, diffTime, oStart, oNewStart);
            this._resizeWidth(oObj, startWidth, endWidth, diffTime, oStart, oNewStart);

            // Wait 1 ms and repeat from next point
            window.setTimeout(
                function(_oObj, _oStart, _oEnd, _endTime, _lastTime, _callback){
                    return function(){
                        AMI.UI.Effects._move(_oObj, _oStart, _oEnd, _endTime, _lastTime, _callback);
                    }
                }(oObj, oNewStart, oEnd, endTime, curTime, callback),
                1
            );
        }else{
            // Set final object state
            if((startLeft != null) && (endLeft != null)){
                oObj.style.left = endLeft + 'px';
            }
            if((startTop != null) && (endTop != null)){
                oObj.style.top = endTop + 'px';
            }
            if((startHeight != null) && (endHeight != null)){
                oObj.style.height = endHeight + 'px';
            }
            if((startWidth != null) && (endWidth != null)){
                oObj.style.width = endWidth + 'px';
            }
            //Callback
            if(typeof(callback) == 'function'){
                callback(oObj);
            }
        }
    },

    /**
     * Move object by X axis (one step)
     *
     * @param {HTMLElement} oObj Object to move
     * @param {int} startLeft Left start point
     * @param {int} endLeft Left end point
     * @param {int} diffTime Time interval to move
     * @param {object} oStart Initial start point
     * @param {object} oNewStart New start point
     * @returns {void}
     */
    _moveLeft: function(oObj, startLeft, endLeft, diffTime, oStart, oNewStart){
        if((startLeft != null) && (endLeft != null)){
            var diffLeft = endLeft - startLeft;
            var stepLeft = diffLeft / diffTime;
            oNewStart.left = oStart.left + stepLeft;
            oObj.style.left = oNewStart.left + 'px';
        }
    },

    /**
     * Move object by Y axis (one step)
     *
     * @param {HTMLElement} oObj Object to move
     * @param {int} startTop Top start point
     * @param {int} endTop Top end point
     * @param {int} diffTime Time interval to move
     * @param {object} oStart Initial start point
     * @param {object} oNewStart New start point
     * @returns {void}
     */
    _moveTop: function(oObj, startTop, endTop, diffTime, oStart, oNewStart){
        if((startTop != null) && (endTop != null)){
            var diffTop = endTop - startTop;
            var stepTop = diffTop / diffTime;
            oNewStart.top = oStart.top + stepTop;
            oObj.style.top = oNewStart.top + 'px';
        }
    },

    /**
     * Resize object's height (one step)
     *
     * @param {HTMLElement} oObj Object to move
     * @param {int} startHeight Initial value of object's height
     * @param {int} endHeight Final value of object's height
     * @param {int} diffTime Time interval to move
     * @param {object} oStart Initial start point
     * @param {object} oNewStart New start point
     * @returns {void}
     */
    _resizeHeight: function(oObj, startHeight, endHeight, diffTime, oStart, oNewStart){
        if((startHeight != null) && (endHeight != null)){
            var diffHeight = endHeight - startHeight;
            var stepHeight = diffHeight / diffTime;
            oNewStart.height = oStart.height + stepHeight;
            oObj.style.height = oNewStart.height + 'px';
        }
    },

    /**
     * Resize object's width (one step)
     *
     * @param {HTMLElement} oObj Object to move
     * @param {int} startWidth Initial value of object's width
     * @param {int} endWidth Final value of object's width
     * @param {int} diffTime Time interval to move
     * @param {object} oStart Initial start point
     * @param {object} oNewStart New start point
     * @returns {void}
     */
    _resizeWidth: function(oObj, startWidth, endWidth, diffTime, oStart, oNewStart){
        if((startWidth != null) && (endWidth != null)){
            var diffWidth = endWidth - startWidth;
            var stepWidth = diffWidth / diffTime;
            oNewStart.width = oStart.width + stepWidth;
            oObj.style.width = oNewStart.width + 'px';
        }
    }
}

/**
* Adds animation methods for an object
*
*
*/
AMI.UI.AnimatedObject = function(oNode){
    /**
     * Animation queue
     */
    oNode._amiQueue = [];

    /**
     * Callback to call after animation is finished
     */
    oNode._amiCallback = null;

    /**
     * Adds "move" action to a queue
     */
    oNode.move = function(oStart, oEnd, duration, callback){
        this._amiQueue.push({
            action:  'move',
            start:    oStart,
            end:      oEnd,
            duration: duration,
            callback: callback
        });
        return this;
    };

    /**
     * Adds "wait" action to a queue
     */
    oNode.wait = function(duration, callback){
        this._amiQueue.push({
            action:  'wait',
            duration: duration,
            callback: callback
        });
        return this;
    };

    /**
     * Adds "fadeIn" action to a queue
     */
    oNode.fadeIn = function(duration, callback){
        this._amiQueue.push({
            action:  'fadein',
            duration: duration,
            callback: callback
        });
        return this;
    };

    /**
     * Adds "fadeOut" action to a queue
     */
    oNode.fadeOut = function(duration, callback){
        this._amiQueue.push({
            action:  'fadeout',
            duration: duration,
            callback: callback
        });
        return this;
    };

    /**
     * Starts animation process
     */
    oNode.startAnimation = function(){

        // Perform animation
        if(this._amiQueue.length){
            var ani = this._amiQueue.shift();

            // Set a callback function if specified
            if(typeof(ani.callback) == 'function'){
                this._amiCallback = ani.callback;
            }

            switch(ani.action){
                case 'move':
                    AMI.UI.Effects.animate(this, ani.start, ani.end, ani.duration, function(oObj){
                        if(typeof(oObj._amiCallback) == 'function'){
                            oObj._amiCallback();
                        }
                        oObj.startAnimation();
                    });
                    break;
                case 'wait':
                    setTimeout(function(oObj){
                        return function(){
                            if(typeof(oObj._amiCallback) == 'function'){
                                oObj._amiCallback();
                            }
                        }
                    }(this), ani.duration);
                    break;
                case 'fadein':
                    AMI.UI.Effects.fadeIn(this, ani.duration, function(oObj){
                        if(typeof(oObj._amiCallback) == 'function'){
                            oObj._amiCallback();
                        }
                        oObj.startAnimation();
                    });
                    break;
                case 'fadeout':
                    AMI.UI.Effects.fadeOut(this, ani.duration, function(oObj){
                        if(typeof(oObj._amiCallback) == 'function'){
                            oObj._amiCallback();
                        }
                        oObj.startAnimation();
                    });
                    break;
            }
        }
    }

    return oNode;
}