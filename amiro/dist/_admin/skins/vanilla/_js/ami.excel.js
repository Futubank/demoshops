var AmiExcel = {

    /**
     * Is debug mode
     */
    debug: false,

    /**
     * Excel table container
     */
    container: null,

    /**
     * Excel table
     */
    table: null,

    /**
     * Original data
     */
    orig: {},

    /**
     * Inner data
     */
    data: {},

    /**
     * Undo data
     */
    possibleUndoData: null,
    undoData: [],
    undoStep: 0,
    needSaveUndo: false,
    prevChangedRows: [],

    /**
     * Changed rows numbers
     */
    changedRows: [],

    /**
     * Table redraw in progress
     */
    redrawInProgress: false,

    /**
     * Options
     */
    options: {
        colHeaders:         false,  // Column headers
        rowHeaders:         false,  // Row headers
        excelDelimiter:     "\t",   // Excel copy/paste delimiter
        maxRows:            500,    // Maximum rows allowed        
        events:             {},     // Event callbacks
        columnTypes:        [],     // Column types
        highlightChanged:   false,  // Highlight changed rows
        changeRowOnMoveLR:  false   // Jump to next/previous on cursor move to left/right
    },

    /**
     * Columns count
     */
    cols: 5,

    /**
     * Rows count
     */
    rows: 20,

    /**
     * Is in edit mode
     */
    edited: false,

    /**
     * Editor object
     */
    editor: {
        /**
         * Editor div
         */
        object: null,

        /**
         * Editor input
         */
        input: null,

        /**
         * Start edit with blank value
         */
        blank: false,

        /**
         * Original cell value
         */
        originalValue: null,

        /**
         * Start cell edit
         */
        start: function(){
            AmiExcel.edited = true;
            AmiExcel.prepareUndo();
            var editor = AmiExcel.editor;
            editor.show();
        },

        /**
         * Show editor
         */
        show: function(){
            var editor = AmiExcel.editor;
            var cursor = AmiExcel.cursor;
            var cell = AmiExcel.getCell(cursor.row, cursor.col);
            if(editor.object == null){
                var object = AMI.$('<DIV>');
                var input = AMI.$('<INPUT>');
                object.addClass('editor');
                object.append(input);
                AmiExcel.container.append(object);
                editor.object = object;
                editor.input = input;
                editor.input.bind('keydown', AmiExcel.onEditorKeyDown);
            }else{
                var object = editor.object;
                var input = editor.input;
            }

            if(AmiExcel.selection.active){
                AmiExcel.selection.clear();
            }

            var position = cell.position();
            object.css('top', position.top + 2);
            object.css('left', position.left + 2);
            object.width(cell.outerWidth() - 3);
            object.height(cell.outerHeight() - 3);
            input.width(cell.outerWidth() - 14);
            input.height(cell.outerHeight() - 5);

            if(!editor.blank){
                if(typeof(AmiExcel.data[cursor.row]) != 'undefined' && typeof(AmiExcel.data[cursor.row][cursor.col]) != 'undefined'){
                    input.val(AmiExcel.data[cursor.row][cursor.col]);
                }
            }else{
                input.val('');
                editor.blank = false;
            }

            object.show();
            input.focus();
        },

        /**
         * Stop edit
         */
        stop: function(cancel){
            AmiExcel.edited = false;
            var editor = AmiExcel.editor;
            var cursor = AmiExcel.cursor;

            var newValue = editor.input.val();

            var event = {
                row: cursor.row,
                col: cursor.col,
                val: newValue,
                cancel: (typeof(cancel) == 'undefined' ? false : cancel)
            }
            AmiExcel.fire('on_edit', event);
            newValue = event.val;
            cancel = event.cancel;

            editor.input.val("");
            editor.input.blur();
            editor.object.hide();
            if(!cancel){
                AmiExcel.updateCell(cursor.row, cursor.col, newValue);
            }
        },

        /**
         * Cancel edit
         */
        cancel: function(){
            AmiExcel.editor.stop(true);
        }
    },

    /**
     * Clipboard object
     */
    clipboard: {
        /**
         * Clipboard div
         */
        object: null,

        /**
         * Clipboard input
         */
        input: null,

        /**
         * Initialize clipboard
         */
        init: function(){
            var clipboard = AmiExcel.clipboard;
            clipboard.object = AMI.$('<DIV>');
            clipboard.object.addClass('clipboard');
            clipboard.input = AMI.$('<TEXTAREA>');
            clipboard.object.append(clipboard.input);
            AmiExcel.container.append(AmiExcel.clipboard.object);

            clipboard.input.bind('paste', clipboard.process);
        },

        /**
         * Copy selected data in Excel-compatible format
         */
        copy: function(cut){
            if(typeof(cut) == 'undefined'){
                cut = false;
            }
            // @debug
            if(AmiExcel.debug){
                console.log('------------------------------------------');
                console.log(cut ? 'CUT' : 'COPY');
            }

            var clipboard = AmiExcel.clipboard;
            var cursor = AmiExcel.cursor;
            var selection = AmiExcel.selection;
            var res = '';
            if(selection.active && selection.object){
                for(var i = selection.rowStart; i <= selection.rowEnd; i++){
                    for(var j = selection.colStart; j <= selection.colEnd; j++){
                        if(typeof(AmiExcel.data[i][j]) != 'undefined'){
                            res += AmiExcel.data[i][j]
                        }
                        // Do not add last tab in a row
                        if(j < selection.colEnd){
                            res += AmiExcel.options.excelDelimiter;
                        }
                    }
                    if(i < selection.rowEnd){
                        res += "\n";
                    }
                }
                if(cut){
                    selection.del();
                }
            }else{
                if(typeof(AmiExcel.data[cursor.row][cursor.col]) != 'undefined'){
                    res = AmiExcel.data[cursor.row][cursor.col];
                }
                if(cut){
                    AmiExcel.updateCell(cursor.row, cursor.col, '');
                }
            }

            var cell = AmiExcel.getCell(cursor.row, cursor.col);
            var position = cell.position();
            clipboard.object.css('top', position.top + 2);
            clipboard.object.css('left', position.left + 2);
            clipboard.object.show();
            clipboard.input.focus();

            clipboard.input.val(res);
            clipboard.input.focus();
            clipboard.input.select();

            if(AmiExcel.debug){
                console.log('Copied: ' + res);
                console.log('------------------------------------------');
            }
        },

        /**
         * Paste data
         */
        paste: function(){
            var clipboard = AmiExcel.clipboard;
            var cursor = AmiExcel.cursor;
            if(cursor.active){
                var cell = AmiExcel.getCell(cursor.row, cursor.col);
                var position = cell.position();
                clipboard.object.css('top', position.top + 2);
                clipboard.object.css('left', position.left + 2);
                clipboard.object.show();
                clipboard.input.focus();
            }
        },

        /**
         * Process pasteing
         */
        process: function(event){
            setTimeout(AmiExcel.clipboard.finish, 0)
        },

        /**
         * Finish paste
         */
        finish: function(){
            var data = AmiExcel.clipboard.input.val();
            var cursor = AmiExcel.cursor;

            AmiExcel.clipboard.input.val('');
            AmiExcel.clipboard.input.blur();
            AmiExcel.clipboard.object.hide();

            var rows = data.split("\n");
            var nrows = rows.length;

            // @debug
            if(AmiExcel.debug){
                console.log('------------------------------------------');
                console.log('PASTE');
                console.log(nrows + ' rows to paste');
                var begin = new Date().getTime() / 1000;
            }
            
            // add row if neccessary
            var lastRow = cursor.row + (nrows - 1);
            if(lastRow >= AmiExcel.rows){
                AmiExcel.addRows(lastRow - AmiExcel.rows + 1);
            }

            // Do not redraw cursor on paste
            AmiExcel.cursor.active = false;

            for(var i=0; i < nrows; i++){
                var row = rows.shift();
                var cols = row.split(AmiExcel.options.excelDelimiter);
                var ncols = cols.length;
                for(var j=0; j < ncols; j++){
                    var col = cols.shift();
                    if(typeof(AmiExcel.data[cursor.row + i]) == 'undefined'){
                        if(cursor.row + i < AmiExcel.rows){
                            AmiExcel.data[cursor.row + i] = [];
                        }
                    }
                    if(((cursor.row + i) < AmiExcel.rows) && ((cursor.col + j) < AmiExcel.cols)){
                        AmiExcel.updateCell(cursor.row + i, cursor.col + j, col);
                    }
                }
            }

            AmiExcel.cursor.active = true;
            AmiExcel.cursor.show();

            // @debug
            if(AmiExcel.debug){
                var end = new Date().getTime() / 1000;
                console.log((end - begin) + ' seconds total');
                console.log('------------------------------------------');
            }
        }
    },


    /**
     * Cursor object
     */
    cursor: {
        /**
         * Cursor jQuery wrapped DOM object
         */
        object: null,

        /**
         * Is cursor active
         */
        active: false,

        /**
         * Cursor row position
         */
        row: 0,

        /**
         * Cursor column position
         */
        col: 0,

        /**
         * Set cursor position
         */
        position: function(row, col){
            var cursor = AmiExcel.cursor;
            cursor.row = row;
            cursor.col = col;
        },

        /**
         * Move cursor
         */
        move: function(rowN, colN){
            var cursor = AmiExcel.cursor;
            var orig = {
                row: cursor.row,
                col: cursor.col
            };
            if(rowN != 0){
                if(rowN == -1 && cursor.row > 0){
                    cursor.row--;
                }
                if(rowN == 1){
                    if(cursor.row == (AmiExcel.rows - 1)){
                        AmiExcel.addRow();
                    }
                    if(cursor.row < (AmiExcel.rows - 1)){
                        cursor.row++;
                    }
                }
            }
            if(colN != 0){
                // Previous column
                if(colN == -1){
                    if(cursor.col > 0){
                        cursor.col--;
                    }else if(cursor.row > 0){
                        // First column reached, move to last cell of previous row
                        if(AmiExcel.options.changeRowOnMoveLR){
                            cursor.col = AmiExcel.cols - 1;
                            cursor.row--;
                        }
                    }
                }
                // Next column
                if(colN == 1){
                    if(cursor.col < (AmiExcel.cols - 1)){
                        cursor.col++;
                    }else{
                        // End reached, move to first cell of the next row
                        if(cursor.row == (AmiExcel.rows - 1)){
                            if(AmiExcel.options.changeRowOnMoveLR){
                                AmiExcel.addRow();
                            }
                        }
                        if(cursor.row < (AmiExcel.rows - 1)){
                            if(AmiExcel.options.changeRowOnMoveLR){
                                cursor.col = 0;
                                cursor.row++;
                            }
                        }
                    }
                }
            }
            if(cursor.col != orig.col || cursor.row != orig.row){
                cursor.show();
            }
        },

        /**
         * Show cursor
         */
        show: function(){
            AmiExcel.textarea.focus();
            var cursor = AmiExcel.cursor;
            if(cursor.active){
                var cell = AmiExcel.getCell(cursor.row, cursor.col);
                var position = cell.position();
                cursor.object.css('top', position.top);
                cursor.object.css('left', position.left);
                var vBorders = (cursor.col == (AmiExcel.cols - 1)) ? 2 : 1;
                var hBorders = (cursor.row == (AmiExcel.rows - 1)) ? 2 : 1;
                cursor.object.width(cell.outerWidth() + vBorders);
                cursor.object.height(cell.outerHeight() + hBorders);
                cursor.object.show();
                if(!cursor.isVisible()){
                    cursor.scrollTo();
                }
                if(AmiExcel.selection.active){
                    AmiExcel.selection.clear();
                }else{
                    AmiExcel.table.find('TH').removeClass('selected');
                }
                if(AmiExcel.options.rowHeaders){
                    var idx = (AmiExcel.options.colHeaders) ? cursor.row + 1 : cursor.row;
                    AmiExcel.table.find('TR:eq(' + idx + ') TH:eq(0)').addClass('selected');
                }
                if(AmiExcel.options.colHeaders){
                    var idx = (AmiExcel.options.rowHeaders) ? cursor.col + 1 : cursor.col;
                    AmiExcel.table.find('TR:eq(0) TH:eq(' + idx + ')').addClass('selected');
                }
            }
        },

        /**
         * Hide cursor
         */
        hide: function(){
            var cursor = AmiExcel.cursor;
            cursor.active = false;
            cursor.object.hide();
        },

        /**
         * Check if cursor is visible
         */
        isVisible: function(){
            var cursor = AmiExcel.cursor;
            var cursorObj = cursor.object;
            var off = cursorObj.offset();
            var top = off.top;
            var height = cursorObj.height();
            var scrollTop = AMI.$(window).scrollTop();
            var docH = AMI.$(window).height();

            return (top > scrollTop && top + height < scrollTop + docH);
        },

        /**
         * Scroll viewport to cursor
         */
        scrollTo: function(){
            AMI.$(window).scrollTop(AmiExcel.container.position().top + AmiExcel.cursor.object.position().top);
        }
    },

    /**
     * Selection
     */
    selection: {

        active:     false,  // Is selection active
        mouse:      false,  // Is mouse selection active
        object:     null,   // Selection div
        rowStart:   null,   // top row
        rowEnd:     null,   // bottom row
        colStart:   null,   // left column
        colEnd:     null,   // right column

        /**
         * Marks selection active
         */
        activate: function(){
            var selection = AmiExcel.selection;
            var cursor = AmiExcel.cursor;
            selection.active = true;
            selection.rowStart = cursor.row;
            selection.colStart = cursor.col;
            selection.rowEnd = cursor.row;
            selection.colEnd = cursor.col;
        },

        /**
         * Selects whole coiumn
         */
        selectColumn: function(col){
            if(AmiExcel.edited){
                AmiExcel.editor.cancel();
            }

            var selection = AmiExcel.selection;
            var cursor = AmiExcel.cursor;

            cursor.active = true;
            cursor.position(0, col);
            cursor.show();

            if(!selection.active){
                selection.activate();
            }

            selection.rowStart = 0;
            selection.rowEnd = AmiExcel.rows - 1;
            selection.colStart = col;
            selection.colEnd = col;
            selection.redraw();
        },

        /**
         * Selects whole row
         */
        selectRow: function(row){
            if(AmiExcel.edited){
                AmiExcel.editor.cancel();
            }

            var selection = AmiExcel.selection;
            var cursor = AmiExcel.cursor;

            cursor.active = true;
            cursor.position(row, 0);
            cursor.show();

            if(!selection.active){
                selection.activate();
            }

            selection.rowStart = row;
            selection.rowEnd = row;
            selection.colStart = 0;
            selection.colEnd = AmiExcel.cols - 1;
            selection.redraw();
        },

        /**
         * Set selection top-left corner
         */
        setStart: function(row, col){
            var selection = AmiExcel.selection;
            if(!selection.active){
                selection.activate();
            }
            selection.rowStart = row;
            selection.colStart = col;
        },

        /**
         * Set selection bottom-right corner
         */
        setEnd: function(row, col){            
            var selection = AmiExcel.selection;
            if(!selection.active){
                selection.activate();
            }
            selection.rowEnd = row;
            selection.colEnd = col;
        },

        /**
         * Move selection (Should be named "shift" or so...)
         */
        move: function(rowN, colN){
            var selection = AmiExcel.selection;
            var cursor = AmiExcel.cursor;            

            if(!selection.active){
                selection.activate();
            }
            // Right
            if(colN > 0){
                if(selection.colStart < cursor.col && selection.colEnd == cursor.col){
                    selection.colStart++;
                }
                else if(selection.colEnd >= cursor.col && selection.colStart == cursor.col){
                    if(selection.colEnd < AmiExcel.cols - 1){
                        selection.colEnd++;
                    }
                }
            }
            // Left
            if(colN < 0){
                if(selection.colStart <= cursor.col && selection.colEnd == cursor.col){
                    if(selection.colStart > 0){
                        selection.colStart--;
                    }
                }
                else if(selection.colEnd > cursor.col && selection.colStart == cursor.col){
                    selection.colEnd--;
                }
            }
            // Bottom
            if(rowN > 0){
                if(selection.rowStart < cursor.row && selection.rowEnd == cursor.row){
                    selection.rowStart++;
                }
                else if(selection.rowEnd >= cursor.row && selection.rowStart == cursor.row){
                    if(selection.rowEnd < AmiExcel.rows - 1){
                        selection.rowEnd++;
                    }
                }
            }
            // Top
            if(rowN < 0){
                if(selection.rowStart <= cursor.row && selection.rowEnd == cursor.row){
                    if(selection.rowStart > 0){
                        selection.rowStart--;
                    }
                }
                else if(selection.rowEnd > cursor.row && selection.rowStart == cursor.row){
                    selection.rowEnd--;
                }
            }            
        },

        /**
         * Redraw selection area
         */
        redraw: function(){
            var selection = AmiExcel.selection;
            if(selection.active){
                if(!selection.object){
                    selection.object = AMI.$('<DIV>');
                    selection.object.addClass('selection');

                    // Borders (not required)
                    var sbr = AMI.$('<DIV>');
                    var sbl = AMI.$('<DIV>');
                    var sbt = AMI.$('<DIV>');
                    var sbb = AMI.$('<DIV>');
                    sbr.addClass('selectionBorderRight');
                    sbl.addClass('selectionBorderLeft');
                    sbt.addClass('selectionBorderTop');
                    sbb.addClass('selectionBorderBottom');
                    selection.object.append(sbr);
                    selection.object.append(sbl);
                    selection.object.append(sbt);
                    selection.object.append(sbb);
                    
                    selection.object.find('DIV').addClass('selectionBorder');

                    AmiExcel.container.append(selection.object);
                }
                var topCell = AmiExcel.getCell(selection.rowStart, selection.colStart);
                var topPosition = topCell.position();

                var botCell = AmiExcel.getCell(selection.rowEnd, selection.colEnd);
                var botPosition = botCell.position();

                var width = botPosition.left - topPosition.left + botCell.outerWidth();
                var height = botPosition.top - topPosition.top + botCell.outerHeight();

                var vBorders = (selection.colEnd == (AmiExcel.cols - 1)) ? 2 : 1;
                var hBorders = (selection.rowEnd == (AmiExcel.rows - 1)) ? 2 : 1;

                selection.object.css('top', topPosition.top);
                selection.object.css('left', topPosition.left);
                selection.object.width(width + vBorders);
                selection.object.height(height + hBorders);

                selection.object.show();

                // Highlight headers
                AmiExcel.table.find('TH.selected').removeClass('selected');
                if(AmiExcel.options.rowHeaders){
                    for(var i = selection.rowStart; i <= selection.rowEnd; i++){
                        var idx = (AmiExcel.options.colHeaders) ? i + 1 : i;
                        AmiExcel.table.find('TR:eq(' + idx + ') TH:eq(0)').addClass('selected');
                    }
                }
                if(AmiExcel.options.colHeaders){
                    for(var i = selection.colStart; i <= selection.colEnd; i++){
                        var idx = (AmiExcel.options.rowHeaders) ? i + 1 : i;
                        AmiExcel.table.find('TR:eq(0) TH:eq(' + idx + ')').addClass('selected');
                    }
                }
            }
        },

        /**
         * Delete selection data
         */
        del: function(){
            for(var i = AmiExcel.selection.rowStart; i <= AmiExcel.selection.rowEnd; i++){
                for(var j = AmiExcel.selection.colStart; j <= AmiExcel.selection.colEnd; j++){
                    AmiExcel.updateCell(i, j, '');
                }
            }
            AmiExcel.selection.clear();           
        },

        /**
         * Remove selection
         */
        clear: function(){
            var selection = AmiExcel.selection;
            if(selection.active && selection.object){
                AmiExcel.table.find('TH.selected').removeClass('selected');
                selection.object.remove();
                selection.active = false;
                selection.object = null;
            }
        }
    },

    /**
     * Global events initialized
     */
    globalEventsInitialized: false,

    /**
     * Keyboard events
     */
    keyListener: null,

    /**
     * Resize handler interval ID
     */
    resizeHandler: null,

    /**
     * Last checked table width
     */
    storedWidth: 0,

    /**
     * Handles resize
     */
    handleResize: function(){
        if(AmiExcel.table.outerWidth() != AmiExcel.storedWidth){
            AmiExcel.storedWidth = AmiExcel.table.outerWidth();
            if(AmiExcel.cursor.active){
                AmiExcel.cursor.show();
            }
        }
    },

    /**
     * Initialization
     */
    init: function(id, data, options){
        AmiExcel.container = AMI.$('#' + id);
        AmiExcel.data = data;
        AmiExcel.orig = AMI.$.extend(true, [], data); // Clone data
        if(typeof(options) == 'object'){
            for(var key in options){
                AmiExcel.options[key] = options[key];
            }
        }

        if(typeof(options.rows) != 'undefined'){
            AmiExcel.rows = options.rows;
        }
        
        if(typeof(options.cols) != 'undefined'){
            AmiExcel.cols = options.cols;
        }

        AmiExcel.cursor.object = AMI.$('<DIV>');
        AmiExcel.cursor.object.addClass('cursor');
        AmiExcel.cursor.object.click(function(){
            if(!AmiExcel.edited){
                AmiExcel.editCell(AmiExcel.cursor.row, AmiExcel.cursor.col);
            }
        });

        AmiExcel.cursor.object.bind('mousedown', AmiExcel.onMouseDown);
        AmiExcel.cursor.object.bind('mousemove', AmiExcel.onMouseMove);
        AmiExcel.cursor.object.bind('mouseup', AmiExcel.onMouseUp);

        AmiExcel.container.append(AmiExcel.cursor.object);

        AmiExcel.redraw();

        if(AmiExcel.resizeHandler == null){
            AmiExcel.resizeHandler = setInterval(AmiExcel.handleResize, 500);
        }

        AmiExcel.clipboard.init();
        AmiExcel.initTextarea();
        AmiExcel.initEvents();
    },

    /**
     * Events initialization
     */
    initEvents: function(){
        if(!AmiExcel.globalEventsInitialized){
            // Add global event listeners here
            AmiExcel.globalEventsInitialized = true;
        }
    },

    /**
     * Hidden textarea proxy to catch keypresses
     */
    textarea: null,
    
    /**
     * Copy or paste operation in progress
     */
    copypaste: false,

    /**
     * Creates hidden textarea and adds keypress listener
     */ 
    initTextarea: function(){
        var div = $('<DIV style="width:0px; height:0px; overflow:hidden;">');
        AmiExcel.textarea = $('<TEXTAREA>');
        div.append(AmiExcel.textarea);
        AmiExcel.container.append(div);
        AmiExcel.textarea.bind('blur', function(e){
            if(!AmiExcel.edited && !AmiExcel.copypaste){
                AmiExcel.cursor.hide();
            }
        });
        AmiExcel.textarea.bind('keydown', AmiExcel.onKeyDown);
    },

    /**
     * Is keycode a printable char (start edit on type immediately)
     */
    isPrintableChar: function(keyCode){
        return ((keyCode == 32) || //space
            (keyCode >= 48 && keyCode <= 57) ||     // 0-9
            (keyCode >= 96 && keyCode <= 111) ||    // numpad
            (keyCode >= 186 && keyCode <= 192) ||   // ;=,-./`
            (keyCode >= 219 && keyCode <= 222) ||   // []{}\|"'
            (keyCode >= 226) ||                     // special chars
            (keyCode >= 65 && keyCode <= 90));      // a-z
    },

    /**
     * Onkeydown event handler
     */
    onKeyDown: function(event){
        // console.log(event.keyCode);
        var edited = AmiExcel.edited;
        var cursor = AmiExcel.cursor;
        
        var pageRows = 20;

        if(!cursor.active) return;
        if(edited) return;

        var ctrlDown = (event.ctrlKey || event.metaKey) && !event.altKey;
        var shiftDown = event.shiftKey;
        var keyCode = event.keyCode;

        if(!edited && !ctrlDown && AmiExcel.isPrintableChar(keyCode)){
            AmiExcel.editor.blank = true;
            AmiExcel.editCell(cursor.row, cursor.col);
            return;
        }

        var skipPrevent = false;

        var keys = {
            bs:     8,  // Backspace
            tab:    9,  // Tab
            enter:  13, // Enter
            escape: 27, // Escape
            pgup:   33, // PageUp
            pgdown: 34, // PageDown
            end:    35, // End
            home:   36, // Home
            left:   37, // Left arrow
            up:     38, // Up arrow
            right:  39, // Right arrow
            down:   40, // Down arrow
            del:    46, // Delete
            a:      65, // 'A' key
            c:      67, // 'C' key
            v:      86, // 'V' key
            x:      88, // 'X' key
            y:      89, // 'Y' key
            z:      90, // 'Z' key
            f2:     113 // F2
        }
        switch(keyCode){

/* LEFT */
            case keys.left:
                if(shiftDown){
                    AmiExcel.selection.move(0, -1);
                    AmiExcel.selection.redraw();
                }else{
                    AmiExcel.cursor.move(0, -1);
                }
                break;
/* RIGHT */
            case keys.right:
                if(shiftDown){
                    AmiExcel.selection.move(0, 1);
                    AmiExcel.selection.redraw();
                }else{
                    AmiExcel.cursor.move(0, 1);
                }
                break;
/* UP */
            case keys.up:
                if(shiftDown){
                    AmiExcel.selection.move(-1, 0);
                    AmiExcel.selection.redraw();
                }else{
                    AmiExcel.cursor.move(-1, 0);
                }
                break;
/* DOWN */
            case keys.down:
                if(shiftDown){
                    AmiExcel.selection.move(1, 0);
                    AmiExcel.selection.redraw();
                }else{
                    AmiExcel.cursor.move(1, 0);
                }
                break;
/* PAGE UP */
            case keys.pgup:
                if((cursor.row - pageRows) > 0){
                    cursor.row -= pageRows;
                }else{
                    cursor.row = 0;
                }
                cursor.show();
                break;
/* PAGE DOWN */
            case keys.pgdown:
                if((cursor.row + pageRows) < AmiExcel.rows){
                    cursor.row += pageRows;
                }else{
                    cursor.row = AmiExcel.rows - 1;
                }
                cursor.show();
                break;
/* HOME */
            case keys.home:
                if(shiftDown){
                    AmiExcel.selection.setStart(AmiExcel.cursor.row, 0);
                    AmiExcel.selection.setEnd(AmiExcel.cursor.row, AmiExcel.cursor.col);
                    AmiExcel.selection.redraw();
                }else{
                    if(ctrlDown){
                        AmiExcel.cursor.row = 0;
                    }
                    AmiExcel.cursor.col = 0;
                    AmiExcel.cursor.show();
                }
                break;
/* END */
            case keys.end:
                if(shiftDown){
                    AmiExcel.selection.setStart(AmiExcel.cursor.row, AmiExcel.cursor.col);
                    AmiExcel.selection.setEnd(AmiExcel.cursor.row, AmiExcel.cols - 1);
                    AmiExcel.selection.redraw();
                }else{
                    if(ctrlDown){
                        AmiExcel.cursor.row = AmiExcel.rows - 1;
                    }
                    AmiExcel.cursor.col = AmiExcel.cols - 1;
                    AmiExcel.cursor.show();
                }
                break;
/* F2 */
            case keys.f2:
                AmiExcel.editCell(cursor.row, cursor.col);
                break;
/* ENTER */
            case keys.enter:
                AmiExcel.cursor.move((shiftDown) ? -1 : 1, 0);
                break;
/* TAB */
            case keys.tab:
                AmiExcel.cursor.move(0, (shiftDown) ? -1 : 1);
                break;
/* DELETE */
            case keys.del:
            case keys.bs:
                AmiExcel.prepareUndo();
                if(!AmiExcel.selection.active){
                    AmiExcel.updateCell(cursor.row, cursor.col, '');
                }else{
                    AmiExcel.selection.del();
                }
                break;                
/* ESCAPE */
            case keys.escape:
                if(cursor.active){
                    // hide cursor (?)
                }
                break;
/* A */
            case keys.a:
                // Select All
                if(ctrlDown){
                    AmiExcel.cursor.position(0,0);
                    AmiExcel.cursor.show();
                    AmiExcel.selection.setStart(0,0);
                    AmiExcel.selection.setEnd(AmiExcel.rows - 1,AmiExcel.cols - 1);
                    AmiExcel.selection.redraw();
                }
                break;
/* C */
            case keys.c:
                // Copy
                if(ctrlDown){
                    AmiExcel.copypaste = true;
                    AmiExcel.clipboard.copy();
                    if(AMI.$.browser.opera){
                        AmiExcel.clipboard.input.triggerHandler('copy');
                    }
                    setTimeout(function(){AmiExcel.cursor.show()}, 0);
                    AmiExcel.copypaste = false;
                    skipPrevent = true;
                }
                break;
/* X */
            case keys.x:
                // Cut
                AmiExcel.prepareUndo();
                if(ctrlDown){
                    AmiExcel.copypaste = true;
                    AmiExcel.clipboard.copy(true);
                    if(AMI.$.browser.opera){
                        AmiExcel.clipboard.input.triggerHandler('cut');
                    }
                    setTimeout(function(){AmiExcel.cursor.show()}, 0);
                    AmiExcel.copypaste = false;
                    skipPrevent = true;
                }
                break;
/* V */
            case keys.v:
                // Paste
                AmiExcel.prepareUndo();
                if(ctrlDown){
                    AmiExcel.copypaste = true;
                    AmiExcel.clipboard.paste();
                    if(AMI.$.browser.opera){
                        AmiExcel.clipboard.input.triggerHandler('paste');
                    }
                    AmiExcel.copypaste = false;
                    skipPrevent = true;
                }
                break;
/* Z */
            case keys.y:
                // Redo
                if(ctrlDown){
                    AmiExcel.redo();
                    AmiExcel.needSaveUndo = false;
                }
                break;
/* Z */
            case keys.z:
                // Undo
                if(ctrlDown){
                    AmiExcel.undo();
                    AmiExcel.needSaveUndo = false;
                }
                break;
/* else */
            default:
                // @debug
                if(AmiExcel.debug){
                    // console.log('Key pressed: ' + event.keyCode);
                }
                break;
        }
        if(AmiExcel.needSaveUndo){
            AmiExcel.saveUndo();
            AmiExcel.needSaveUndo = false;
        }
        if(!skipPrevent){
            event.preventDefault();
        }
    },

    /**
     * Onkeydown event handler
     */
    onEditorKeyDown: function(event){
        // console.log(event.keyCode);
        var edited = AmiExcel.edited;
        var cursor = AmiExcel.cursor;
        
        var pageRows = 20;

        if(!cursor.active) return;
        if(!edited) return;

        var ctrlDown = (event.ctrlKey || event.metaKey) && !event.altKey;
        var shiftDown = event.shiftKey;
        var keyCode = event.keyCode;

        var keys = {
            tab:    9,  // Tab
            enter:  13, // Enter
            escape: 27, // Escape
            up:     38, // Up arrow
            down:   40, // Down arrow
            f2:     113 // F2
        }
        switch(keyCode){

/* UP */
            case keys.up:
                AmiExcel.editor.stop();
                AmiExcel.cursor.move(-1, 0);
                event.preventDefault();
                break;
/* DOWN */
            case keys.down:
                AmiExcel.editor.stop();
                AmiExcel.cursor.move(1, 0);
                event.preventDefault();
                break;
/* F2 */
            case keys.f2:
                event.preventDefault();
                AmiExcel.editor.stop();
                AmiExcel.cursor.move((shiftDown) ? -1 : 1, 0);
                break;
/* ENTER */
            case keys.enter:
                event.preventDefault();
                AmiExcel.editor.stop();
                AmiExcel.cursor.move((shiftDown) ? -1 : 1, 0);
                break;
/* TAB */
            case keys.tab:
                event.preventDefault();
                AmiExcel.editor.stop();
                AmiExcel.cursor.move(0, (shiftDown) ? -1 : 1);
                break;
/* ESCAPE */
            case keys.escape:
                AmiExcel.editor.cancel();
                break;
        }
        if(AmiExcel.needSaveUndo){
            AmiExcel.saveUndo();
            AmiExcel.needSaveUndo = false;
        }
    },


    /**
     * Redraw whole table
     */
    redraw: function(){
        AmiExcel.redrawInProgress = true;

        if(AmiExcel.table){
            AmiExcel.table.empty();
        }else{
            AmiExcel.table = AMI.$('<TABLE>');
        }

        AmiExcel.table.attr('onselectstart', 'return false;');

        AmiExcel.table.attr('cellspacing', '0');
        AmiExcel.table.attr('cellpadding', '0');
        if(AmiExcel.options.colHeaders){
            AmiExcel.addHeadersRow();
        }
        for(var i=0; i<AmiExcel.rows; i++){
            AmiExcel.addRow();
        }
        AmiExcel.container.append(AmiExcel.table);
        AmiExcel.fill();

        AmiExcel.table.bind('mousedown', AmiExcel.onMouseDown);
        AmiExcel.table.bind('mousemove', AmiExcel.onMouseMove);
        AmiExcel.table.bind('mouseup', AmiExcel.onMouseUp);

        AmiExcel.redrawInProgress = false;
    },

    /**
     * Table mousedown
     */
    onMouseDown: function(event){
        if(AmiExcel.edited){
            AmiExcel.editor.stop();
        }
        var pos = false;

        var cell = false;

        // FF workaround
        if(typeof(event.srcElement) == 'undefined'){
            if(typeof(event.originalEvent) != 'undefined'){
                var oEvent = event.originalEvent;
                if(typeof(oEvent.explicitOriginalTarget) != 'undefined'){
                   cell = oEvent.explicitOriginalTarget;
                }
            }
        }else{
            cell = event.srcElement;
        }
        if(!cell){
            event.preventDefault();
            return;
        }
        if(cell.nodeName == 'TD'){
            pos = AmiExcel.getCellPosition(cell);
            AmiExcel.cursor.position(pos.row, pos.col);
            AmiExcel.cursor.active = true;
            AmiExcel.cursor.show();
        }else if(cell.nodeName == 'DIV'){
            pos = {
                row: AmiExcel.cursor.row,
                col: AmiExcel.cursor.col
            };
        }
        if(pos){
            AmiExcel.selection.clear();
            AmiExcel.selection.mouse = true;
            AmiExcel.selection.setStart(pos.row, pos.col);
        }
        event.preventDefault();        
    },

    /**
     * Table mouse move
     */
    onMouseMove: function(event){
        if(AmiExcel.selection.mouse){
            var cell = false;

            // FF workaround
            if(typeof(event.srcElement) == 'undefined'){
                if(typeof(event.originalEvent) != 'undefined'){
                    var oEvent = event.originalEvent;
                    if(typeof(oEvent.explicitOriginalTarget) != 'undefined'){
                       cell = oEvent.explicitOriginalTarget;
                    }
                }
            }else{
                cell = event.srcElement;
            }
            if(!cell){
                event.preventDefault();
                return;
            }

            var pos = false;
            if(cell.nodeName == 'TD'){
                pos = AmiExcel.getCellPosition(cell);
            }else if(cell.nodeName == 'DIV'){
                pos = {
                    row: AmiExcel.cursor.row,
                    col: AmiExcel.cursor.col
                };                
            }
            if(pos){
                var startRow = AmiExcel.cursor.row;
                var endRow = AmiExcel.cursor.row;
                var startCol = AmiExcel.cursor.col;
                var endCol = AmiExcel.cursor.col;

                if (pos.row < AmiExcel.cursor.row){
                    startRow = pos.row;
                }else{
                    endRow = pos.row;
                }

                if (pos.col < AmiExcel.cursor.col){
                    startCol = pos.col;
                }else{
                    endCol = pos.col;
                }

                AmiExcel.selection.setStart(startRow, startCol);
                AmiExcel.selection.setEnd(endRow, endCol);

                AmiExcel.selection.redraw();
            }
        }
        event.preventDefault();
    },

    /**
     * Table mouse up
     */
    onMouseUp: function(event){
        if(AmiExcel.selection.active && !AmiExcel.selection.object){
            AmiExcel.selection.active = false;
        }
        AmiExcel.selection.mouse = false;
        event.preventDefault();        
    },

    /**
     * Get position of cell TD element
     */
    getCellPosition: function(cell){
        var col = cell.cellIndex;
        var row = cell.parentNode.rowIndex;
        if(AmiExcel.options.colHeaders){
            row--;
        }
        if(AmiExcel.options.rowHeaders){
            col--;
        }
        return {
            row: row,
            col: col
        };
    },

    /**
     * Add row to the end of table
     */
    addRow: function(){
        var rowNumber = AmiExcel.table.find('tr').length;
        if(rowNumber && AmiExcel.options.colHeaders){
            rowNumber = rowNumber - 1;
        }

        if(AmiExcel.options.maxRows && rowNumber >= AmiExcel.options.maxRows){
            return false;
        }

        var row = AMI.$('<TR>');
        if(AmiExcel.options.colHeaders){
            var cell = AMI.$('<TH>');
            cell.addClass('columnHeader');
            cell.html(rowNumber + 1);
            cell.click(function(row){
                return function(event){
                    var clear = true;
                    var selection = AmiExcel.selection;
                    var cursor = AmiExcel.cursor;
                    if(event.shiftKey){
                        // Select by shift-click
                        if(selection.active){
                            // If row already selected
                            if(selection.colStart == 0 && selection.colEnd == (AmiExcel.cols - 1)){
                                if(selection.rowEnd < row){
                                    selection.rowEnd = row;
                                    if(selection.rowEnd > cursor.row){
                                        selection.rowStart = cursor.row;
                                    }
                                }else if(selection.rowStart > row){
                                    selection.rowStart = row;
                                    if(selection.rowStart < cursor.row){
                                        selection.rowEnd = cursor.row;
                                    }
                                }else if(selection.rowStart <= row <= selection.rowEnd){
                                    if(row >= cursor.row){
                                        selection.rowEnd = row;
                                    }
                                    if(row <= cursor.row){
                                        selection.rowStart = row;
                                    }
                                }
                                clear = false;
                            }
                        }
                    }
                    if(clear){
                        selection.clear();
                        selection.selectRow(row);
                    }else{
                        selection.redraw();
                    }                    
                }
            }(rowNumber));

            row.append(cell);
        }
        for(var i=0; i<AmiExcel.cols; i++){
            var cell = AMI.$('<TD>');
            cell.click(function(row, col){
                return function(){
                    if(AmiExcel.edited){
                        AmiExcel.editor.stop();
                        if(AmiExcel.needSaveUndo){
                            AmiExcel.saveUndo();
                            AmiExcel.needSaveUndo = false;
                        }                        
                    }
                    AmiExcel.cursor.position(row, col);
                    AmiExcel.cursor.active = true;
                    AmiExcel.cursor.show();
                }
            }(rowNumber, i));
            row.append(cell);
        }
        AmiExcel.table.append(row);

        if(rowNumber >= AmiExcel.rows){
            AmiExcel.rows = rowNumber + 1;
        }

        return true;
    },

    /**
     * Adds N rows
     */
    addRows: function(n){
        // @debug
        if(AmiExcel.debug){        
            var begin = new Date().getTime() / 1000;
            console.log('adding ' + n + ' new rows');
        }
        if(n > 0){
            for(var i = 0; i < n; i++){
                AmiExcel.addRow();
            }
        }
        // @debug
        if(AmiExcel.debug){
            var end = new Date().getTime() / 1000;
            console.log((end - begin) + ' seconds to add rows');
        }
    },

    /**
     * Add row to the end of table
     */
    addHeadersRow: function(){
        var row = AMI.$('<TR>');
        var cols = AmiExcel.cols;
        if(AmiExcel.options.colHeaders){
            cols++;
        }
        for(var i=0; i<cols; i++){
            var cell = AMI.$('<TH>');
            var headerIdx = (AmiExcel.options.rowHeaders) ? i - 1 : i;
            if(typeof(AmiExcel.options.headers) != 'undefined' && typeof(AmiExcel.options.headers[headerIdx]) != 'undefined'){
                cell.html(AmiExcel.options.headers[headerIdx]);
            }
            if(!(AmiExcel.options.rowHeaders && i == 0)){
                cell.click(function(column){
                    return function(event){
                        var clear = true;
                        var selection = AmiExcel.selection;
                        var cursor = AmiExcel.cursor;
                        if(event.shiftKey){
                            // Select by shift-click
                            if(selection.active){
                                // If column already selected
                                if(selection.rowStart == 0 && selection.rowEnd == (AmiExcel.rows - 1)){
                                    if(selection.colEnd < column){
                                        selection.colEnd = column;
                                        if(selection.colEnd > cursor.col){
                                            selection.colStart = cursor.col;
                                        }
                                    }else if(selection.colStart > column){
                                        selection.colStart = column;
                                        if(selection.colStart < cursor.col){
                                            selection.colEnd = cursor.col;
                                        }
                                    }else if(selection.colStart <= column <= selection.colEnd){
                                        if(column >= cursor.col){
                                            selection.colEnd = column;
                                        }
                                        if(column <= cursor.col){
                                            selection.colStart = column;
                                        }
                                    }
                                    clear = false;
                                }
                            }
                        }
                        if(clear){
                            selection.clear();
                            selection.selectColumn(column);
                        }else{
                            selection.redraw();
                        }
                    }
                }(headerIdx));
            }
            row.append(cell);
        }
        AmiExcel.table.append(row);
    },

    /**
     * Fill table with data
     */
    fill: function(){
        for(var row=0; row<AmiExcel.rows; row++){
            for(var col=0; col<AmiExcel.cols; col++){
                if(typeof(AmiExcel.data[row]) == 'undefined'){
                    AmiExcel.data[row] = [];
                }
                if(typeof(AmiExcel.data[row][col]) != 'undefined'){
                    AmiExcel.updateCell(row, col);
                }
            }
            var event = {
                row: row,
                rowData: AmiExcel.data[row]
            };
            AmiExcel.fire('on_row', event);
        }
    },

    /**
     * Get cell object by its position
     */
    getCell: function(row, col){
        if(AmiExcel.options.rowHeaders){
            row = row + 1;
        }
        return AmiExcel.table.find('tr:eq(' + row + ') td:eq(' + col + ')');
    },

    /**
     * Update cell data at position
     */
    updateCell: function(row, col, value){
        if(typeof(value) != 'undefined'){
            if(typeof(AmiExcel.data[row]) == 'undefined'){
                AmiExcel.data[row] = [];
            }
            if((typeof(AmiExcel.data[row][col]) == 'undefined') || (AmiExcel.data[row][col] != value)){
                AmiExcel.data[row][col] = value;
                if(!AmiExcel.redrawInProgress){
                    AmiExcel.needSaveUndo = true;
                }
            }
            if(!AmiExcel.redrawInProgress){
                AmiExcel.handleChanged(row);
            }
        }

        AmiExcel.setCellValue(row, col);

        if(AmiExcel.cursor.active){
            AmiExcel.cursor.show();
        }
        
        AmiExcel.selection.redraw();
    },

    /**
     * Sets cell formatted value
     */
    setCellValue: function(row, col){
        var value = AmiExcel.data[row][col];
        var cell = AmiExcel.getCell(row, col);
        var event = {
            row: row,
            col: col,
            value: value,
            cell: cell,
            rowData: AmiExcel.data[row]
        };
        AmiExcel.fire('on_cell', event);
        cell.text(event.value);
    },

    /**
     * Show cell data editor
     */
    editCell: function(row, col){
        var cell = AmiExcel.getCell(row, col);
        if(!cell.hasClass('readonly')){
            AmiExcel.editor.start(row, col);
        }
    },

    /**
     * Fires an internal event
     */
    fire: function(event, data){
        if(typeof(AmiExcel.options.events[event]) != 'undefined'){
            AmiExcel.options.events[event](data);
        }
    },

    /**
     * Adds unexisted data row
     */
    checkDataRow: function(row){
        if(typeof(AmiExcel.data[row]) == 'undefined'){
            AmiExcel.data[row] = [];
        }
    },

    /**
     * Handles changed/unchanged row
     */
    handleChanged: function(row, skipSaveUndo){
        var changed = false;
        var data = AmiExcel.data;
        var orig = AmiExcel.orig;
        
        AmiExcel.checkDataRow(row);

        if(typeof(orig[row]) == 'undefined'){
            for(var i=0; i<AmiExcel.cols; i++){
                if(typeof(data[row][i]) != 'undefined' && data[row][i] != ''){
                    changed = true;
                    break;
                }
            }
        }else{
            for(var i=0; i<AmiExcel.cols; i++){
                if(typeof(data[row][i]) == 'undefined' && typeof(orig[row][i]) == 'undefined'){
                    continue;
                }
                if((typeof(data[row][i]) == 'undefined' && typeof(orig[row][i]) != 'undefined') || (typeof(orig[row][i]) == 'undefined' && typeof(data[row][i]) != 'undefined')){
                    changed = true;
                    break;
                }
                if(!changed && (data[row][i] != orig[row][i])){
                    changed = true;
                    break;
                }
            }
        }

        var event = {
            row: row,
            rowData: data[row],
            changedRows: AmiExcel.changedRows
        };
        AmiExcel.fire('on_change', event);

        if(changed && AmiExcel.changedRows.indexOf(row) < 0){
            AmiExcel.changedRows.push(row);
            AmiExcel.changedRows.sort();
        }
        if(!changed && AmiExcel.changedRows.indexOf(row) >= 0){
            AmiExcel.changedRows.splice(AmiExcel.changedRows.indexOf(row), 1);
        }
        if(AmiExcel.options.highlightChanged){
            var realRowIndex = (AmiExcel.options.colHeaders) ? row + 1 : row;
            AmiExcel.table.find('TR:eq(' + realRowIndex + ')')[changed ? 'addClass' : 'removeClass']('changed');
        }
    },

    /**
     * Highlight changed rows
     */
    highlightChanges: function(){
        for(var i = 0; i < AmiExcel.data.length; i++){
            AmiExcel.handleChanged(i, true);
        }
    },

    /**
     * Get all changed rows
     */
    getChangedRows: function(){
        var res = [];
        for(var i=0; i<AmiExcel.changedRows.length; i++){
            res.push({
                row: AmiExcel.changedRows[i], 
                data: AmiExcel.data[AmiExcel.changedRows[i]]
            });
        }
        return res;
    },

    /**
     * Remove table and all service elements.
     */
    destroy: function(){
        if(AmiExcel.edited){
            AmiExcel.editor.cancel();
        }
        AmiExcel.editor.object = null;
        AmiExcel.orig = {};
        AmiExcel.data = {};
        AmiExcel.changedRows = [];
        AmiExcel.selection.clear();
        AmiExcel.cursor.active = false;
        if(AmiExcel.container){
            AmiExcel.container.remove();
        }
        if(AmiExcel.resizeHandler != null){
            clearInterval(AmiExcel.resizeHandler);
        }
    },


    /**
     * Prepare data for undo save
     */
    prepareUndo: function(){
        AmiExcel.possibleUndoData = AMI.$.extend(true, [], AmiExcel.data);
    },

    /**
     * Save undo
     */
    saveUndo: function(){
        if(AmiExcel.possibleUndoData != null){
            AmiExcel.undoData[AmiExcel.undoStep] = AMI.$.extend(true, [], AmiExcel.possibleUndoData);
            if(AmiExcel.undoData.length > 10){
                AmiExcel.undoData.shift();
            }else{
                AmiExcel.undoStep++;
            }
            if(AmiExcel.undoData.length > AmiExcel.undoStep){
                AmiExcel.undoData = AmiExcel.undoData.slice(0, AmiExcel.undoStep);
            }
            AmiExcel.possibleUndoData = null;
        }
    },

    /**
     * Execute undo
     */
    undo: function(){
        if(typeof(AmiExcel.undoData[AmiExcel.undoStep]) == 'undefined'){
            AmiExcel.undoData[AmiExcel.undoStep] = AMI.$.extend(true, [], AmiExcel.data);
        }
        if(AmiExcel.undoStep && AmiExcel.undoData.length && typeof(AmiExcel.undoData[AmiExcel.undoStep - 1]) != 'undefined'){
            AmiExcel.data = AMI.$.extend(true, [], AmiExcel.undoData[AmiExcel.undoStep - 1]);
            AmiExcel.undoStep--;
            AmiExcel.redraw();
            AmiExcel.highlightChanges();
        }
    },

    /**
     * Execute redo
     */
    redo: function(){
        if((AmiExcel.undoData.length > AmiExcel.undoStep) && typeof(AmiExcel.undoData[AmiExcel.undoStep + 1]) != 'undefined'){
            AmiExcel.data = AMI.$.extend(true, [], AmiExcel.undoData[AmiExcel.undoStep + 1]);
            AmiExcel.undoStep++;
            AmiExcel.redraw();
            AmiExcel.highlightChanges();
        }
    },

    /**
     * That's all folks!
     */
    finish: true
}
