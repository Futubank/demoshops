AMI.TextEditor = function(textareaId, bFixResize, options, parentSize, fromCE){
    this.fromCE = (typeof(fromCE) == 'undefined') ? false : fromCE;
    this.bFixResize = (typeof(bFixResize) == 'undefined') ? true : bFixResize;
    this.highlighted = false;
    this.textareaId = textareaId;
    this.cookieLifeTime = 36000; // 10 hours

    if (typeof(options) == 'undefined'){
        this.options = {
            mode: "amitpl",
            tabMode: "shift",
            indentUnit: 4,
            lineWrapping: false
        }
    }else{
        this.options = options;
    }
    this.useParentSize = (typeof(parentSize) == 'undefined') ? false : parentSize;

    /**
     * Sets server cookie
     */
    this.setOpt = function(name, value){
        var path = '/50/' + window.module_name + '/';
        if(typeof(AMI.Page) != 'undefined'){
            for (var moduleId in AMI.Page.aModules) break;
            if(moduleId){
                if(typeof(module60compatible) != 'undefined'){
                    path = '/PA/'  + moduleId + '/';
                }else{
                    path = '/60/' + moduleId + '/';
                }
            }
        }
        // Set cookie but do not save, because we have alternative save mechanizm
        AMI.Cookie.set('CM_' + this.textareaId + '_' + name, value, this.cookieLifeTime, path);
    }

    /**
     * Gets server cookie
     */
    this.getOpt = function(name, defaultValue){
        var res = false;
        res = AMI.Cookie.get('CM_' + this.textareaId + '_' + name);
        if(!res && typeof(defaultValue) != 'undefined'){
            res = defaultValue;
        }
        return res;
    }

    this.oTextarea = AMI.find('#' + textareaId);

    // Resize ability
    if(!this.fromCE){
        this.oTextarea.style.resize = 'none';
        this.wrapper = document.createElement('DIV');
        this.wrapper.id = textareaId + '_wrapper';
        this.wrapper.style.position = 'relative';
        this.wrapper.style.marginBottom = '14px';
        AMI.$(this.oTextarea).wrap(AMI.$(this.wrapper));

        this.wrapper = AMI.find('#' + textareaId + '_wrapper');
        this.resizer = document.createElement('DIV');
        this.resizer.id = textareaId + '_editor';
        this.resizer.className = 'ce_resize_corner';
        AMI.Browser.Event.addHandler(this.resizer, 'mousedown', function(_this){return function(e){_this.startResize(e);}}(this));
        this.wrapper.appendChild(this.resizer);

        this.bottomSpace = document.createElement('DIV');
        this.bottomSpace.className = 'ce_bottom_space';
        this.wrapper.appendChild(this.bottomSpace);

        var boxSizing = 'border-box';
        this.oTextarea.style.boxSizing = boxSizing;
        this.oTextarea.style.MozBoxSizing = boxSizing;
        this.oTextarea.style.webkitBoxSizing = boxSizing;

        this.wrapper.style.boxSizing = boxSizing;
        this.wrapper.style.MozBoxSizing = boxSizing;
        this.wrapper.style.webkitBoxSizing = boxSizing;

        var width = (typeof(this.oTextarea.style.width) == 'undefined') || (this.oTextarea.style.width == '100%') ? '100%' : AMI.$(this.oTextarea).outerWidth();
        var height = AMI.$(this.oTextarea).height();
        height = this.getOpt('height', height);
        // Opera 9.x and 10.x hack...
        if(parseInt(height) == 0){
            height = '400px';
        }
        AMI.$(this.wrapper).width(width);
        AMI.$(this.wrapper).height(height);
        AMI.$(this.oTextarea).height(height);
    }

    this.oEditor = null;

    this.lastPos = null;
    this.lastQuery = null;
    this.marked = [];

    this.lastWidth = 0;

    // Resize fix
    if(this.bFixResize){
        AMI.Browser.Event.addHandler(window, 'resize', function(obj){
            return function(){
                if(obj.oEditor){
                    if(document.body.clientWidth != this.lastWidth){
                        obj.highlight(false);
                        obj.highlight(true);
                        this.lastWidth = document.body.clientWidth;
                    }
                }
            }
        }(this));
    }

    this.startResize = function(currentEvent){
        currentEvent = amiCommon.getValidEvent(currentEvent);

        this.isResizing = true;

        var resizeObj = (this.highlighted) ? this.oEditor.getWrapperElement() : this.oTextarea;

        var positionMouse = amiCommon.getMousePosition(currentEvent);
        var positionFrame = amiCommon.getElementPosition(resizeObj);

        this.divResizePositionDeltaX = positionMouse[0] - positionFrame[0] - resizeObj.offsetWidth;
        this.divResizePositionDeltaY = positionMouse[1] - positionFrame[1] - resizeObj.offsetHeight;

        AMI.Browser.Event.addHandler(window.document, 'mouseup', function(_this){return function(e){_this.stopResize(e)}}(this));
        AMI.Browser.Event.addHandler(window.document, 'mousemove', function(_this){return function(e){_this.resize(e)}}(this));
        amiCommon.stopEvent(currentEvent);
    };

    this.resize = function(currentEvent){
        if(this.isResizing){
            currentEvent = amiCommon.getValidEvent(currentEvent);

            var resizeObj = (this.highlighted) ? this.oEditor.getWrapperElement() : this.oTextarea;

            var positionFrame = amiCommon.getElementPosition(resizeObj);
            var positionMouse = amiCommon.getMousePosition(currentEvent);

            var newWidth = Math.max(0, positionMouse[0] - positionFrame[0] - this.divResizePositionDeltaX);
            if(newWidth < 200){
                newWidth = 200;
            }

            var newHeight = Math.max(0, positionMouse[1] - positionFrame[1] - this.divResizePositionDeltaY);
            if(newHeight < 100){
                newHeight = 100;
            }
            this.wrapper.style.width = newWidth + 'px';
            this.wrapper.style.height = newHeight + 'px';

            if(this.highlighted){
                this.setSize(newWidth, newHeight);
            }else{
                resizeObj.style.width = newWidth + 'px';
                resizeObj.style.height = newHeight + 'px';
            }

            amiCommon.stopEvent(currentEvent);
        }
    };

    this.stopResize = function(currentEvent){
        if(this.isResizing){

            this.isResizing = false;

            if(this.wrapper.style.width.length > 0){
                // this.setOpt('width', this.wrapper.style.width);
            }
            if(this.wrapper.style.height.length > 0){
                this.setOpt('height', this.wrapper.style.height);
            }

            currentEvent = amiCommon.getValidEvent(currentEvent);
            amiCommon.stopEvent(currentEvent);
        }
    }

    this.unmark = function() {
        for (var i = 0; i < this.marked.length; ++i) try { this.marked[i].clear(); } catch(e){}
        this.marked.length = 0;
    };

    this.mark = function(text, bCase){
        if(typeof(bCase) == 'undefined'){
            bCase = false;
        }
        this.unmark();
        for (var cursor = this.oEditor.getSearchCursor(text, false, bCase); cursor.findNext();){
            this.marked.push(this.oEditor.markText(cursor.from(), cursor.to(), "searched"));
        }
    }

    this.search = function(text, bCase){
        if(typeof(bCase) == 'undefined'){
            bCase = false;
        }
        if (!text) return;
        this.mark(text, bCase);
        if (this.lastQuery != text) this.lastPos = null;
        var cursor = this.oEditor.getSearchCursor(text, this.lastPos || this.oEditor.getCursor(), bCase);
        if (!cursor.findNext()) {
        cursor = this.oEditor.getSearchCursor(text, false, bCase);
        if (!cursor.findNext()) return;
        }
        this.oEditor.setSelection(cursor.from(), cursor.to());
        this.lastQuery = text;this.lastPos = cursor.to();
    };

    this.replace = function(text, replace, question, bCase){
        if(typeof(bCase) == 'undefined'){
            bCase = false;
        }
        if (!text) return;
        this.mark(text, bCase);
        for (var cursor = this.oEditor.getSearchCursor(text, false, bCase); cursor.findNext();){
            this.oEditor.setSelection(cursor.from(), cursor.to());
            if(confirm(question)){
                cursor.replace(replace);
                this.mark(text);
            }else{
                return;
            }
        }
    };

    this.replaceAll = function(text, replace, question, bCase){
        if(typeof(bCase) == 'undefined'){
            bCase = false;
        }
        if (!text) return;
        this.mark(text, bCase);
        
        if(!this.marked.length) return;

        if(!confirm(question.replace("%d", this.marked.length))){
            return;
        }

        // Escape special regexp symbols
        text = text.replace( new RegExp('\\\\', 'g'), '\\\\');
        text = text.replace( new RegExp('\\^', 'g'), '\\^');
        text = text.replace( new RegExp('\\*', 'g'), '\\*');
        text = text.replace( new RegExp('\\$', 'g'), '\\$');
        text = text.replace( new RegExp('\\+', 'g'), '\\+');
        text = text.replace( new RegExp('\\.', 'g'), '\\.');
        text = text.replace( new RegExp('\\(', 'g'), '\\(');
        text = text.replace( new RegExp('\\)', 'g'), '\\)');
        text = text.replace( new RegExp('\\[', 'g'), '\\[');
        text = text.replace( new RegExp('\\]', 'g'), '\\]');        
        text = text.replace( new RegExp('\\/', 'g'), '\\/');
        text = text.replace( new RegExp('\\?', 'g'), '\\?');
        text = text.replace( new RegExp('\\|', 'g'), '\\|');
        text = text.replace( new RegExp('\\{', 'g'), '\\{');
        text = text.replace( new RegExp('\\}', 'g'), '\\}');

        this.oTextarea.value = this.oEditor.getValue();
        this.oTextarea.value = this.oTextarea.value.replace(new RegExp(text, ((bCase) ? "gi" : "g")), replace);
        this.oEditor.setValue(this.oTextarea.value);
        this.oEditor.refresh();
        this.unmark();
    };

    this.highlight = function(bState, bNoFocus){
        bNoFocus = bNoFocus ? true : false;
        if(bState && this.oEditor == null){
            if(!bNoFocus && (this.oTextarea.offsetHeight) > 0 && (this.oTextarea.value)){
                var cursorPosition = AMI.Browser.getCaretPosition(this.oTextarea);
            }else{
                cursorPosition = '';
            }
            
            var taWidth = this.oTextarea.offsetWidth;
            
            var nPos, nPrevPos = -1;
            var cursorLine = 0, cursorPos = -1;
            while((nPos = this.oTextarea.value.indexOf('\n', nPrevPos + 1)) != -1){
                cursorLine ++;
                if(nPos >= cursorPosition){
                    cursorPos = cursorPosition - (nPrevPos + 1);
                    break;
                }
                nPrevPos = nPos;
            }
            this.oEditor = CodeMirror.fromTextArea(this.oTextarea, this.options);
            this.setSize(taWidth, 0);

            if(cursorPos >= 0){
                this.oEditor.setCursor(cursorLine - 1, cursorPos);
                if(!bNoFocus && (this.oTextarea.value)){
                    this.oEditor.focus();
                }
            }
            if(!this.fromCE){
                var wrEl = this.oEditor.getWrapperElement();
                var boxSizing = 'border-box';
                wrEl.style.boxSizing = boxSizing;
                wrEl.style.MozBoxSizing = boxSizing;
                wrEl.style.webkitBoxSizing = boxSizing;                
            }
            this.highlighted = true;
        }else if(!bState && this.oEditor != null){
            var scrollTop = this.oEditor.getWrapperElement().scrollTop;
            
            var oPos = this.oEditor.getCursor(true);
            this.oEditor.toTextArea();
            this.oEditor = null;
            if(!bNoFocus){
                this.oTextarea.focus();
                var nPos, nPrevPos = -1;
                var cursorLine = 0;
                while((nPos = this.oTextarea.value.indexOf('\n', nPrevPos + 1)) != -1){
                    if(cursorLine ++ == oPos.line){
                        setCaretPos(this.oTextarea.getAttribute('id'), (nPrevPos + oPos.ch + 1) + '|' + scrollTop);
                        break;
                    }
                    nPrevPos = nPos;
                }
            }
            if(!this.fromCE){
                AMI.$(this.oTextarea).width(AMI.$(this.wrapper).outerWidth());
                AMI.$(this.oTextarea).height(AMI.$(this.wrapper).outerHeight());
            }

            this.highlighted = false;
        }
    }

    this.getEditorScroll = function(){
        if(this.oEditor){
            var editor = this.oEditor.getWrapperElement();
            return AMI.$(editor).find('.CodeMirror-scroll')[0];
        }
        return AMI.$(this.oTextarea).find('.CodeMirror-scroll')[0];
    }

    this.setSize = function(width, height){

        if(width == '100%'){
            width = 0;
        }
        width = parseInt(width);
        height = parseInt(height);
        var editor = this.oEditor.getWrapperElement();
        var editorScroll = this.getEditorScroll();
        
        if(editorScroll && editor){
            if(width > 0){
                editor.style.width = width + 'px';
                editorScroll.style.width = width + 'px';
            }else if(this.oTextarea.style.width != '' && this.oTextarea.style.width != '100%'){
                editorScroll.style.width = this.oTextarea.style.width;
                editor.style.width = this.oTextarea.style.width;
            }else{
                if(this.useParentSize){
                    editorScroll.style.width = this.oTextarea.parentNode.style.width;
                    editor.style.width = this.oTextarea.parentNode.style.width;
                }
            }
            if(height > 0){
                editor.style.height = height + 'px';
                editorScroll.style.height = height + 'px';
            }else if(this.oTextarea.style.height != ''){
                editorScroll.style.height = this.oTextarea.style.height;
                editor.style.height = this.oTextarea.style.height;
            }
        }
    }

    this.save = function(){
        if(this.oEditor != null){
            this.oEditor.save();

            var scrollTop = this.oEditor.getWrapperElement().scrollTop;
            var oPos = this.oEditor.getCursor(true);

            var res = '';
            var nPos, nPrevPos = -1;
            var cursorLine = 0;
            while((nPos = this.oTextarea.value.indexOf('\n', nPrevPos + 1)) != -1){
                if(cursorLine ++ == oPos.line){
                    res = (nPrevPos + oPos.ch + 1) + '|' + scrollTop;
                    break;
                }
                nPrevPos = nPos;
            }
            
            return res;
        }
        
        return false;
    }
} 