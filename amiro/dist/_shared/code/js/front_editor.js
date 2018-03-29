/**
 * @param  {object} oDictionary  Object containing properties as keys and its values as captions
 * @return void
 *
 * @copyright Amiro.CMS. All rights reserved. Changes are not allowed.
 */
function amiDictionary(oDictionary){
    /**
     * @var {object}
     */
    this.oDictionary = typeof(oDictionary) == 'object' ? oDictionary : {};

    /**
     * Set single caption
     *
     * @param  {string} key
     * @param  {string} caption
     * @return void
     */
    this.set = function(key, caption){
        this.oDictionary[key] = caption;
    }

    /**
     * Append only new captions to dictionary
     *
     * @param  {object} oDictionary  Object containing properties as keys and its values as captions
     * @return void
     */
    this.append = function(oDictionary){
        for(var key in oDictionary){
            if(typeof(this.oDictionary[key]) == 'undefined'){
                this.oDictionary[key] = oDictionary[key];
            }
        }
    }

    /**
     * Append new captions, override obsolete
     *
     * @param  {object} oDictionary  Object containing properties as keys and its values as captions
     * @return void
     */
    this.megre = function(oDictionary){
        for(var key in oDictionary){
            this.oDictionary[key] = oDictionary[key];
        }
    }

    /**
     * Get caption by key
     *
     * @param  {string} key
     * @return {string} | null
     */
    this.get = function(key){
        if(typeof(this.oDictionary[key]) == 'undefined'){
            if(typeof(console) == 'object' && typeof(console.warn) == 'function'){
                // firebug debugging
                console.warn("Undefined dictionary key '" + key + "'");
                // console.trace();
            }
            return null;
        }else{
            return this.oDictionary[key];
        }
    }

    /**
     * Parse caption specified by key using variables
     *
     * @param  {string} key
     * @param  {object} oVariables  Object containing properties as keys and its values as captions
     * @return {string} | null
     */
    this.parse = function(key, oVariables){
        var caption = this.get(key);
        if(caption){
            for(var variable in oVariables){
                caption = caption.replace('_' + variable + '_', oVariables[variable]);
            }
        }
        return caption;
    }
}

/**
 * Amiro.CMS text editor
 *
 * @param {string}  Global variable name
 * @param {amiDictionary} oDictionary
 *
 * Textarea editor with pseudo codes and preview support
 * @version 1.0. Last changes: 25/05/2010
 * @copyright Amiro.CMS. All rights reserved. Changes are not allowed.
 */
function amiroTEdit(varName, oDictionary){
    this.isInitialized = false;
    this.currentMode = 'editor';
    this.varName = varName;
    this.editorId = 'amiroTEdDivEditor';
    this.idPreviewDiv = 'amiroTEdDivPreview';
    this.previewButtonObj = undefined;
    this.editorObj = false;
    this.oDictionary = (oDictionary == undefined ? {} : oDictionary);
    this.isIE = true;
    this.useNoIndex = false;
    this.fontHeight = 15;
    this.regTextAreaResizeY = 0;
    this.editorModeCode = false;
    this.updatePreviewMode = '';
    this.allowedImages = [];
    this.bAllowURLs = true;
    this.ceMode = false;
    this.aTags = {
        'empty'        : ['', ''],
        'bold'         : ['[B]', '[/B]'],
        'strike'       : ['[S]', '[/S]'],
        'indent'       : ['[INDENT]', '[/INDENT]'],
        'code'         : ['[CODE]', '[/CODE]'],
        'italic'       : ['[I]', '[/I]'],
        'underlined'   : ['[U]', '[/U]'],
        'quote'        : ['[Q]', '[Q="#\#value#\#"]', '[/Q]'],
        'align:left'   : ['[LEFT]', '[/LEFT]'],
        'align:right'  : ['[RIGHT]', '[/RIGHT]'],
        'align:center' : ['[CENTER]', '[/CENTER]'],
        'align:justify': ['[JUSTIFY]', '[/JUSTIFY]'],
        'ulist'        : ['[LIST]', '\n[/LIST]'],
        'ulist_item'   : ['\n[*]', ''],
        'olist'        : ['[OL]', '\n[/OL]'],
        'olist_item'   : ['\n[*]', ''],
        'addlink'      : ['[URL="#\#value#\#"]', '[/URL]'],
        'addimg'       : ['[IMG]', '[/IMG]'],
        'font_family'  : ['[FONT="#\#value#\#"]', '[/FONT]'],
        'font_size'    : ['[SIZE="#\#value#\#"]', '[/SIZE]'],
        'font_color'   : ['[COLOR="#\#value#\#"]', '[/COLOR]'],
        'header'       : ['[H#\#value#\#]', '[/H#\#value#\#]'],
        'smile'        : ['', '']
    };
    this.usedFonts = [##fonts##];
    this.maxTextSize = ##max_text_size##;
    this.usedColors = [##colors##];
    this.smilesPath = '##smiles_path##';
    this.baseSmiles = [##base_smiles##];
    this.allSmiles = [##extra_smiles##];
    this.allSmilesTitles = {'': ''};
    this.smilesCopyright = '##smiles_copyright##';
    this.baseHref = typeof(frontBaseHref) != 'undefined' ? frontBaseHref : (typeof(editorBaseHref) != 'undefined' ? editorBaseHref : '');
    window.bbEditorBaseHref = this.baseHref;

    this.init = function(){
        userAgent = navigator.userAgent.toLowerCase();
        this.isIE = userAgent.indexOf('msie') != -1 && userAgent.indexOf('opera') == -1 && typeof(window.opera) == 'undefined';
        if(typeof(this.oDictionary) != 'object' || this.oDictionary.length == 0){
            this.oDictionary = new amiDictionary({
                'bold': 'Bold',
                'italic': 'Italic',
                'underline': 'Underline',
                'strike': 'Strike through',
                'quote': 'Quote',
                'align_left': 'Align left',
                'align_center': 'Align center',
                'align_right': 'Align right',
                'justify': 'Justify',
                'insert_list': 'Insert list',
                'insert_olist': 'Insert ordered list',
                'insert_link': 'Insert link',
                'delete_link': 'Delete link',
                'insert_image': 'Insert image',
                'font': 'Font',
                'size': 'Size',
                'header': 'Select header',
                'color': 'Color',
                'more': 'more',
                'insert_code': 'Insert code',
                'indent': 'Indent',
                'outdent': 'Outdent',
                'preview': 'Preview',
                'hide_preview': 'Hide preview',
                'update_preview': 'Update preview',
                'warn_message_length': 'Message to short!',
                'warn_invalid_image_url': 'Invalid image URL!',
                'warn_image_url_internal_links_forbidden': 'Images from this site are forbidden!',
                'warn_image_url_external_links_forbidden': 'Images from other sites are forbidden!',
                'prompt_enter_list_element': 'Enter list element',
                'prompt_enter_next_list_element': 'Enter list element or leave field empty to finish',
                'prompt_enter_url': 'Enter URL',
                'prompt_enter_image_url': 'Enter image URL',
                'warn_urls_reg_only': 'Using URLs forbidden for unregistered users.'
            });
        }
        for(i = 0; i < this.baseSmiles.length; i++){
            this.allSmilesTitles[this.baseSmiles[i][0]] = this.baseSmiles[i][1];
        }
        for(i = 0; i < this.allSmiles.length; i++){
            this.allSmilesTitles[this.allSmiles[i][0]] = this.allSmiles[i][1];
        }
    }

    this.setUseNoindex = function(noindexState){
        this.useNoIndex = noindexState;
    }

    this.setFontHeight = function(fontHeight){
        this.fontHeight = fontHeight;
    }

    this.procAction = function(action, subaction){
        var res = false;
        if(this.isInitialized){
            if(this._procAction(action, subaction)){
                res = true;
            }
        }
        return res;
    }

    this.setCEMode = function(ceObj){
        this.aTags = {
            'empty'        : ['', ''],
            'bold'         : ['[B]', '[/B]'],
            'strike'       : ['[S]', '[/S]'],
            'indent'       : ['[INDENT]', '[/INDENT]'],
            'code'         : ['[CODE]', '[/CODE]'],
            'italic'       : ['[I]', '[/I]'],
            'underlined'   : ['[U]', '[/U]'],
            'quote'        : ['[Q]', '[Q="#\#value#\#"]', '[/Q]'],
            'align:left'   : ['[LEFT="DIV"]', '[/LEFT]'],
            'align:right'  : ['[RIGHT="DIV"]', '[/RIGHT]'],
            'align:center' : ['[CENTER="DIV"]', '[/CENTER]'],
            'align:justify': ['[JUSTIFY="DIV"]', '[/JUSTIFY]'],
            'ulist'        : ['[LIST]', '\n[/LIST]'],
            'ulist_item'   : ['\n[*]', ''],
            'olist'        : ['[OL]', '\n[/OL]'],
            'olist_item'   : ['\n[*]', ''],
            'addlink'      : ['[URL="#\#value#\#"]', '[/URL]'],
            'addimg'       : ['[IMG]', '[/IMG]'],
            'font_family'  : ['[FONT="#\#value#\#"]', '[/FONT]'],
            'font_size'    : ['[SIZE="#\#value#\#"]', '[/SIZE]'],
            'font_color'   : ['[COLOR="#\#value#\#"]', '[/COLOR]'],
            'h1'           : ['[H1]', '[/H1]'],
            'h2'           : ['[H2]', '[/H2]'],
            'h3'           : ['[H3]', '[/H3]'],
            'h4'           : ['[H4]', '[/H4]'],
            'h5'           : ['[H5]', '[/H5]'],
            'paragraph'    : ['[P]',  '[/P]'],
            'div'          : ['[LEFT="DIV"]',  '[/LEFT]'],
            'smile'        : ['', '']
        };

        this.ceMode = true;
        this.ce = ceObj;
    }

    this._procAction = function(action, subaction){
        var success = false;
        switch(action){
            case 'bold':
            case 'italic':
            case 'underlined':
            case 'code':
            case 'strike':
            case 'indent':
            case 'h1':
            case 'h2':
            case 'h3':
            case 'h4':
            case 'h5':
            case 'paragraph':
            case 'div':
                this._boundSelectionWithTags(this.aTags[action]);
                success = true;
                break;
            case 'outdent':
                var selTxt = this._getSelectedText();
                if(selTxt != '' && selTxt.indexOf('[INDENT]') != -1 && selTxt.indexOf('[/INDENT]') != -1){
                    selTxt = selTxt.replace(/\[INDENT\]((.|\r|\n)*?)\[\/INDENT\]/g, '$1');
                    this._boundSelectionWithTags(this.aTags['empty'], selTxt);
                    success = true;
                }
                break;
            case 'quote':
                if(typeof(subaction) == "undefined"){
                    subaction = "";
                }
                var selTxt = this._getSelectedText();
                var tmpTags = [subaction.length == 0 ? this.aTags['quote'][0] : this.aTags['quote'][1], this.aTags['quote'][2]];
                if(!this.ceMode){
                    subaction = subaction.replace(/<[a-zA-Z\/].*?>/g, '').replace(/^\s+/g, '').replace(/\s+$/g, '');
                    selTxt = selTxt.replace(/<[a-zA-Z\/].*?>/g, '');
                }
                tmpTags[0] = tmpTags[0].replace(/#\#value#\#/g, subaction.replace(/"/g, '&quot;'));
                this._boundSelectionWithTags(tmpTags, selTxt);
                success = true;
                break;
            case 'align':
                if(subaction != undefined && this.aTags['align:'+subaction]){
                    this._boundSelectionWithTags(this.aTags['align:'+subaction]);
                    success = true;
                }
                break;
            case 'ulist':
            case 'olist':
                var selTxt = this._getSelectedText();
                if(selTxt != ''){
                    this._procSelectionList(selTxt, action);
                }else{
                    this._boundSelectionWithTags(this.aTags[action]);
                    var listLine = '';
                    listLine = prompt(this.oDictionary.get('prompt_enter_list_element'), '');
                    while(listLine != '' && listLine != null){
                        this._boundSelectionWithTags(this.aTags[action + '_item'], listLine, true);
                        listLine = prompt(this.oDictionary.get('prompt_enter_next_list_element'), '');
                    }
                }
                success = true;
                break;
            case 'addlink':
                if(this.bAllowURLs){
                    urlLine = prompt(this.oDictionary.get('prompt_enter_url'), 'http://');
                    if(urlLine.indexOf('data:') == 0){
                        urlLine = '';
                    }
                    if(urlLine != '' && urlLine != null){
                        var selTxt = this._getSelectedText();
                        var tmpTags = [this.aTags['addlink'][0], this.aTags['addlink'][1]];
                        tmpTags[0] = tmpTags[0].replace(/#\#value#\#/g, urlLine.replace(/"/g, '&quot;'));
                        selTxt = selTxt == '' ? urlLine : selTxt;
                        this._boundSelectionWithTags(tmpTags, selTxt);
                        success = true;
                    }
                }else{
                    alert(this.oDictionary.get('warn_urls_reg_only'));
                }
                break;
            case 'dellink':
                var selTxt = this._getSelectedText();
                if(selTxt != '' && selTxt.indexOf('[URL') != -1 && selTxt.indexOf('[/URL]') != -1){
                    selTxt = selTxt.replace(/\[URL=\".*?\"\]/g, '');
                    selTxt = selTxt.replace(/\[\/URL\]/g, '');
                    this._boundSelectionWithTags(this.aTags['empty'], selTxt);
                    success = true;
                }
                break;
            case 'addimg':
                var urlLine = 'http://';
                do {
                    urlLine = prompt(this.oDictionary.get('prompt_enter_image_url'), urlLine);
                    askURL = urlLine != null;
                    if (askURL) {
                        urlLine = urlLine.replace(/^(.*?)\?.*$/, '$1');
                        if (urlLine != '') {
                            var allowedImages = this.allowedImages;
                            var re = /^https?\:\/\/([^\/]+)(\/[^\?]*)(\?.*)?/;
                            re.exec(urlLine);
                            if (RegExp.$2 == '' || RegExp.$1 == '') {
                                alert(this.oDictionary.get('warn_invalid_image_url'));
                            } else if (allowedImages.indexOf('internal_links') < 0 && urlLine.indexOf(this.baseHref) == 0) {
                                alert(this.oDictionary.get('warn_image_url_internal_links_forbidden'));
                            } else if (allowedImages.indexOf('external_links') < 0 && urlLine.indexOf(this.baseHref) != 0) {
                                alert(this.oDictionary.get('warn_image_url_external_links_forbidden'));
                            } else {
                                var tmpTags = [this.aTags['addimg'][0], this.aTags['addimg'][1]];
                                this._boundSelectionWithTags(tmpTags, urlLine);
                                success = true;
                                askURL = false;
                            }
                        }
                    }
                } while (askURL);
                break;
            case 'font_family':
            case 'font_size':
            case 'header':
            case 'font_color':
                if(subaction != undefined && subaction != ''){
                    var tmpTags = [this.aTags[action][0], this.aTags[action][1]];
                    tmpTags[0] = tmpTags[0].replace(/#\#value#\#/g, subaction);
                    tmpTags[1] = tmpTags[1].replace(/#\#value#\#/g, subaction);
                    this._boundSelectionWithTags(tmpTags);
                    success = true;
                }
                break;
            case 'br':
                var selTxt = this._getSelectedText() + '↵\n';
                this._boundSelectionWithTags(this.aTags['empty'], selTxt, true);
                var value = (this.ce.hlBB) ? this.ce.highlighter.oEditor.getValue() : this.editorObj.value;
                if(value.match(/\[RAW\]((.|\r|\n)*)↵\n((.|\r|\n)*)\[\/RAW\]/ig)){
                    this.ce.placeSelectionMarks();
                    value = (this.ce.hlBB) ? this.ce.highlighter.oEditor.getValue() : this.editorObj.value;
                    value = value.replace(/\[RAW\]((.|\r|\n)*?)\[\/RAW\]/ig, function(obj){
                        return function(allstr, code){
                            code = code.replace('↵\n', '\n');
                            return '[RAW]' + code + '[/RAW]';
                        }
                    }(this));
                    if(this.ce.hlBB){
                        this.ce.highlighter.oEditor.setValue(value);
                    }else{
                        this.editorObj.value = value;
                    }
                    this.ce.markSelection(this.editorObj);
                }
                success = true;
                break;
            case 'smile':
                if(subaction != undefined){
                    this._boundSelectionWithTags(this.aTags['smile'], subaction, true);
                    success = true;
                }
                break;
            case 'smile_by_caption':
                if(subaction != undefined){
                    var found = false;
                    var smile = '';
                    for(var i=0; i<this.baseSmiles.length; i++){
                        if(this.baseSmiles[i][1] == subaction){
                            smile = this.baseSmiles[i][2];
                            found = true;
                        }
                    }
                    if(!found && this.allSmiles.length){
                        for(var i=0; i<this.allSmiles.length; i++){
                            if(this.allSmiles[i][1] == subaction){
                                smile = this.allSmiles[i][2];
                                found = true;
                            }
                        }
                    }
                    if(found){
                        this._boundSelectionWithTags(this.aTags['smile'], smile, true);
                        success = true;
                    }
                }
                break;
        }
        this.updatePreviewButton();
        return success;
    }

    this._boundSelectionWithTags = function(pTags, text, setPointerToEnd){
        if(pTags[0] == undefined)
            pTags[0] = '';
        if(pTags[1] == undefined)
            pTags[1] = '';
        if(text == undefined)
            text = this._getSelectedText();
        this._replaceSelection(pTags[0]+text+pTags[1], pTags[0].length, pTags[1].length, setPointerToEnd);
    }

    this._procSelectionList = function(text, action){
        // Try to understand next regexp ;-). From start of string any not empty string which does not start from [/?LIST] or [*]
        if(action == 'ulist'){
            text = text.replace(/(^|\n)(?!(\r?\n)|(\[\/?LIST\])|(\[\*\]))/g, this.aTags[action + '_item'][0]);
        }else{
            text = text.replace(/(^|\n)(?!(\r?\n)|(\[\/?OL\])|(\[\*\]))/g, this.aTags[action + '_item'][0]);
        }
        this._boundSelectionWithTags(this.aTags[action], text);
    }

    this._calcMultiLineTextLen = function(text){
        if(this.isIE){
            text = text.replace(/\r/g, '');
        }
        return text.length;
    }

    this._getSelectedText = function(){
        var text = '';
        if(this.ceMode && this.ce.hlBB){
            text = this.ce.highlighter.oEditor.getSelection();
        }else{
            this.editorObj.focus();
            if(document.selection && document.selection.createRange()){
                var sRange = document.selection.createRange();
                text = sRange.text;
            }else if(typeof(this.editorObj.selectionStart) != undefined){
                var sStart = parseInt(this.editorObj.selectionStart);
                var sEnd = parseInt(this.editorObj.selectionEnd);
                text = this.editorObj.value;
                text = text.substr(sStart, sEnd-sStart);
            }
        }
        return text;
    }

    this._replaceSelection = function(newText, newSelDl, newSelDr, setPointerToEnd){
        if(this.ceMode && this.ce.hlBB){
            var begin = '';
            if(newSelDl > 0){
                begin = newText.substring(0, newSelDl);
            }
            var end = '';
            if(newSelDr > 0){
                end = newText.substring(newSelDr-1);
            }
            this.ce.highlighter.oEditor.replaceSelection(newText, (setPointerToEnd ? "end" : ""));
            if(begin.length && end.length){
                selStart = this.ce.highlighter.oEditor.getSelStart();
                selEnd = this.ce.highlighter.oEditor.getSelEnd();
                selStart.ch += newSelDl;
                selEnd.ch -= newSelDr;
                if((selEnd.line == selStart.line) && (selEnd.ch < selStart.ch)){
                    selEnd.ch = selStart.ch;
                }
                this.ce.highlighter.oEditor.setSelection(selStart, selEnd);
            }
        }else{
            this.editorObj.focus();

            if(document.selection && document.selection.createRange()){
                var sRange = document.selection.createRange();
                sRange.text = newText.replace(/\r?\n/g, '\r\n');
                if(setPointerToEnd)
                    sRange.moveStart('character', -newSelDr);
                else
                    sRange.moveStart('character', -this._calcMultiLineTextLen(newText)+newSelDl);
                sRange.moveEnd('character', -newSelDr);
                sRange.select();

            }else if(typeof(this.editorObj.selectionStart) != undefined){
                var sStart = parseInt(this.editorObj.selectionStart);
                var sEnd = parseInt(this.editorObj.selectionEnd);
                var sTop = this.editorObj.scrollTop;
                var sText = this.editorObj.value;
                this.editorObj.value = sText.substr(0, sStart)+newText+sText.substr(sEnd);
                if(setPointerToEnd)
                    this.editorObj.selectionStart = sStart+newText.length-newSelDr;
                else
                    this.editorObj.selectionStart = sStart+newSelDl;
                this.editorObj.selectionEnd = sStart+newText.length-newSelDr;
                this.editorObj.scrollTop = sTop;
            }
        }
    }

    this.regTextAreaResize = function(clientY){
        this.regTextAreaResizeY = clientY;
        globalATEObj = this;
        document.onmousemove = handleMouseMove;
        document.onmouseup = releaseMouseMoveHandler;
        return false;
    }

    this.handleMouseMove = function(clientY){
        if(this.regTextAreaResizeY > 0){
            var reqHeight = this.editorObj.offsetHeight-this.regTextAreaResizeY+clientY;
            if(reqHeight > 50){
                this.editorObj.style.height = reqHeight;
                this.regTextAreaResizeY = clientY;
            }
        }
        return false;
    }

    this._HTMLSpecialChars = function(taValue){
        //taValue = taValue.replace(/&/g, '&amp;');
        taValue = taValue.replace(/&^(?! (\#[1-9][\d]{1,3} | [a-z][\da-z]+) ;)/gi, '&amp;');
        taValue = taValue.replace(/"/g, '&quot;');
        taValue = taValue.replace(/</g, '&lt;');
        taValue = taValue.replace(/>/g, '&gt;');
        return taValue;
    }

    this.raws = [];

    this.getHTMLContent = function(cutLongURL){
        var smilesPath = this.baseHref + '_mod_files/smiles/' + this.smilesPath + '/';
        var specSmiles = {";)":"wink", ":)":"smile", ":D":"laugh", ":(":"frown"};
        var localUseNoIndex = this.useNoIndex;
        var fontHeight = this.fontHeight;

        var taValue = this._HTMLSpecialChars(this.editorObj.value);

        if(this.ceMode && this.ce.useSpecialCharsFeature){
            taValue = taValue.replace(/·/g, '&nbsp;');
        }else{
            taValue = taValue.replace(/\r?\n/g, '<br>\r\n');
        }

        if(this.ceMode){
            taValue = taValue.replace(
                /\[RAW\]((?:.|\r|\n)*?)\[\/RAW\]/gi,
                function(obj){
                    return function(allstr, tagContent){
                        var rawIndex = obj.raws.length; 

                        tagContent = tagContent.replace(/&amp;/g,  '&');
                        tagContent = tagContent.replace(/&quot;/g, '"');
                        tagContent = tagContent.replace(/&lt;/g,   '<');
                        tagContent = tagContent.replace(/&gt;/g,   '>');
                        if(!obj.ce.useSpecialCharsFeature){
                            tagContent = tagContent.replace(/<br>/g,   '');
                        }
                        obj.raws.push(tagContent);
                        return ('##__AMI_RAW_' + rawIndex + '__##');
                    };
                }(this)
            );

            if(this.ce.useSpecialCharsFeature){
                taValue = taValue.replace(/↵/g, '<br>');
            }

            // Script tag
            taValue = taValue.replace(/\<script.*?>((?:.|\r|\n)*?)\<\/script>/gi,  function(allstr, tagContent){
                // Despecialcharsize
                tagContent = tagContent.replace(/&amp;/g,  '&');
                tagContent = tagContent.replace(/&quot;/g, '"');
                tagContent = tagContent.replace(/&lt;/g,   '<');
                tagContent = tagContent.replace(/&gt;/g,   '>');
                tagContent = tagContent.replace(/<br>/g,   '');
                return '<script>' + tagContent + '</script>';
            });
        }

        taValue = taValue.replace(/\[DIV\]/gi, '<div>');
        taValue = taValue.replace(/\[\/DIV\]/gi, '</div>');
        if(this.ceMode){
            taValue = taValue.replace(/\[LEFT\]/gi, '<div style="text-align:left;">');
            taValue = taValue.replace(/\[\/LEFT\]/gi, '</div>');
            taValue = taValue.replace(/\[RIGHT\]/gi, '<div style="text-align:right;">');
            taValue = taValue.replace(/\[\/RIGHT\]/gi, '</div>');
            taValue = taValue.replace(/\[CENTER\]/gi, '<div style="text-align:center;">');
            taValue = taValue.replace(/\[\/CENTER\]/gi, '</div>');
            taValue = taValue.replace(/\[JUSTIFY\]/gi, '<div style="text-align:justify;">');
            taValue = taValue.replace(/\[\/JUSTIFY\]/gi, '</div>');

            taValue = taValue.replace(/\[LEFT=&quot;DIV&quot;\]/gi, '<div style="text-align:left;">');
            taValue = taValue.replace(/\[RIGHT=&quot;DIV&quot;\]/gi, '<div style="text-align:right;">');
            taValue = taValue.replace(/\[CENTER=&quot;DIV&quot;\]/gi, '<div style="text-align:center;">');
            taValue = taValue.replace(/\[JUSTIFY=&quot;DIV&quot;\]/gi, '<div style="text-align:justify;">');            
        }else{
            taValue = taValue.replace(/\[LEFT\]/gi, '<div class="edParagraph" style="text-align:left;">');
            taValue = taValue.replace(/\[\/LEFT\]/gi, '</div>');
            taValue = taValue.replace(/\[RIGHT\]/gi, '<div class="edParagraph" style="text-align:right;">');
            taValue = taValue.replace(/\[\/RIGHT\]/gi, '</div>');
            taValue = taValue.replace(/\[CENTER\]/gi, '<div class="edParagraph" style="text-align:center;">');
            taValue = taValue.replace(/\[\/CENTER\]/gi, '</div>');
            taValue = taValue.replace(/\[JUSTIFY\]/gi, '<div class="edParagraph" style="text-align:justify;">');
            taValue = taValue.replace(/\[\/JUSTIFY\]/gi, '</div>');

            taValue = taValue.replace(/\[LEFT=&quot;DIV&quot;\]/gi, '<div class="edParagraph" style="text-align:left;">');
            taValue = taValue.replace(/\[RIGHT=&quot;DIV&quot;\]/gi, '<div class="edParagraph" style="text-align:right;">');
            taValue = taValue.replace(/\[CENTER=&quot;DIV&quot;\]/gi, '<div class="edParagraph" style="text-align:center;">');
            taValue = taValue.replace(/\[JUSTIFY=&quot;DIV&quot;\]/gi, '<div class="edParagraph" style="text-align:justify;">');
        }
        taValue = taValue.replace(/\[LEFT=&quot;P&quot;\]((?:.|\r|\n)*?)\[\/LEFT=&quot;P&quot;\]/gi, '<p align="left">$1</p>');
        taValue = taValue.replace(/\[RIGHT=&quot;P&quot;\]((?:.|\r|\n)*?)\[\/RIGHT=&quot;P&quot;\]/gi, '<p align="right">$1</p>');
        taValue = taValue.replace(/\[CENTER=&quot;P&quot;\]((?:.|\r|\n)*?)\[\/CENTER=&quot;P&quot;\]/gi, '<p align="center">$1</p>');
        taValue = taValue.replace(/\[JUSTIFY=&quot;P&quot;\]((?:.|\r|\n)*?)\[\/JUSTIFY=&quot;P&quot;\]/gi, '<p align="justify">$1</p>');

        taValue = taValue.replace(/\[(\/?)(B|I|U|S|P|H\d)\]/gi, '<$1$2>');
        window.amiSimpleEditorCodes = [];
        taValue = taValue.replace(/\[CODE\]((?:.|\r|\n)*?)\[\/CODE\]/gi,  function(allstr, tagContent){
            tagContent = tagContent.replace(/<br>/gi, '');
            var nlCount = 1;
            var nlPos = tagContent.indexOf('\n');
            while(nlPos != -1){
                nlCount++;
                nlPos = tagContent.indexOf('\n', nlPos+1);
            }
            if(nlCount > 10)
                nlCount = 10;
            var codeKey = window.amiSimpleEditorCodes.length;
            window.amiSimpleEditorCodes[codeKey] = tagContent;
            return '<PRE class="edCode" style="height:'+(nlCount*fontHeight+40)+'">CodeId_'+codeKey+'</PRE>';
        });
        taValue = taValue.replace(/\[Q\]/gi, '<BLOCKQUOTE class="edQuote">');
        taValue = taValue.replace(/\[Q=&quot;(.*?)&quot;\]/gi, '<BLOCKQUOTE class="edQuote"><b>$1:</b><br>');
        taValue = taValue.replace(/\[(\/?)(INDENT|Q)\]/gi, '<$1BLOCKQUOTE>');

        taValue = taValue.replace(/\[LIST\]/gi, '<UL>');
        taValue = taValue.replace(/\[\/LIST\]/gi, '</UL>');
        taValue = taValue.replace(/\[UL\]/gi, '<UL>');
        taValue = taValue.replace(/\[\/UL\]/gi, '</UL>');
        taValue = taValue.replace(/\[OL\]/gi, '<OL>');
        taValue = taValue.replace(/\[\/OL\]/gi, '</OL>');
        taValue = taValue.replace(/\[\*\]/gi, '<LI>');
        taValue = taValue.replace(/\[FONT=&quot;(.*?)&quot;\]/gi, function(allstr, fontName){return '<FONT face="'+_tagsParamReplace(fontName, false)+'">'});
        taValue = taValue.replace(/\[(COLOR|SIZE)=&quot;(.*?)&quot;\]/gi, function(allstr, tagParam, paramValue){return '<FONT '+tagParam+'="'+_tagsParamReplace(paramValue, false)+'">'});
        taValue = taValue.replace(/\[\/(FONT|SIZE|COLOR)\]/gi, '</FONT>');

        var urlMaxLength = typeof(cutLongURL) == 'undefined' ? 0 : ##url_max_length##;
        if(this.ceMode){
            taValue = taValue.replace(/\[URL=&quot;(.*?)&quot;\]((?:.|\r|\n)*?)\[\/URL\]/gi, function(allstr, url, linkContent){
                var curUseNoIndex = localUseNoIndex;
                var curUrl = _tagsParamReplace(url, false);
                if(curUseNoIndex && (!curUrl.match(/^https?:\/\//i) || (window.bbEditorBaseHref.length > 0 && curUrl.indexOf(window.bbEditorBaseHref) >= 0)))
                    curUseNoIndex = false;
                var attributes = '';
                linkContent = _trim(linkContent);
                var noTagsLinkContent = _trim(_stripTags(linkContent).replace(/\"/g, '&quot;'));
                if ((urlMaxLength > 0) && (noTagsLinkContent.length > urlMaxLength)) {
                    attributes =
                        ' title="' + noTagsLinkContent + '"';
                    linkContent = noTagsLinkContent.substr(0, urlMaxLength - 8 - 3) + '...' + noTagsLinkContent.substr(noTagsLinkContent.length - 8);
                }
                if(curUrl.indexOf('data:') == 0){
                    curUrl = '';
                }
                return (curUseNoIndex ? '<NOINDEX>' : '')+'<A HREF="'+curUrl+'"'+(curUseNoIndex ? ' rel="nofollow"' : '') + attributes + '>'+linkContent+'</A>'+(curUseNoIndex ? '</NOINDEX>' : '');
            });

            var allSmilesTitles = this.allSmilesTitles;
            taValue = taValue.replace(/\[IMG\](.*?)\[\/IMG\]/gi, function(allstr, url){return '<IMG SRC="'+_tagsParamReplace(url, true)+'">'});
            var specSmileReg = new RegExp(((this.ceMode) ? '[^A-Za-z\\d]?(;\\)|:\\)|:D|:\\()' : '(;\\)|:\\)|:D|:\\()'), 'g');
            taValue = taValue.replace(specSmileReg, function(allstr, smile){var imgName = specSmiles[smile]+'.gif'; return '<IMG SRC="'+smilesPath+imgName+'" title="'+(typeof(allSmilesTitles[imgName]) != 'undefined' ? allSmilesTitles[imgName] : '')+'">'});
            taValue = taValue.replace(/\:([a-z\_]{1,20})\:/gi, function(allstr, smile){var imgName = smile+'.gif'; return '<IMG SRC="'+smilesPath+smile+'.gif" title="'+(typeof(allSmilesTitles[imgName]) != 'undefined' ? allSmilesTitles[imgName] : '')+'">'});

            taValue = taValue.replace(/((?:<IMG .*?>)|(?:<A (?:.|\r|\n)*?<\/A>))/gi, function(allstr, pTagContent){
                pTagContent = pTagContent.replace(/http(s?)\:/gi, 'htBREAKtp$1:');
                pTagContent = pTagContent.replace(/www/gi, 'wBREAKwBREAKw');
                return pTagContent;
            });
            taValue = taValue.replace(/((?:<IMG .*?>)|(?:<A (?:.|\r|\n)*?<\/A>))/gi, function(allstr, pTagContent){
                pTagContent = pTagContent.replace(/wBREAKwBREAKw/gi, 'www');
                pTagContent = pTagContent.replace(/htBREAKtp(s?):/gi, 'http$1:');
                return pTagContent;
            });
        }else{
            taValue = taValue.replace(/\[URL=&quot;(.*?)&quot;\]((?:.|\r|\n)*?)\[\/URL\]/gi, function(allstr, url, linkContent){
                var curUseNoIndex = localUseNoIndex;
                var curUrl = _tagsParamReplace(url, false);
                if(curUseNoIndex && (!curUrl.match(/^https?:\/\//i) || (window.bbEditorBaseHref.length > 0 && curUrl.indexOf(window.bbEditorBaseHref) >= 0)))
                    curUseNoIndex = false;
                var attributes = '';
                linkContent = _trim(linkContent);
                var noTagsLinkContent = _trim(_stripTags(linkContent).replace(/\"/g, '&quot;'));
                if ((urlMaxLength > 0) && (noTagsLinkContent.length > urlMaxLength)) {
                    attributes =
                        ' title="' + noTagsLinkContent + '"';
                    linkContent = noTagsLinkContent.substr(0, urlMaxLength - 8 - 3) + '...' + noTagsLinkContent.substr(noTagsLinkContent.length - 8);
                }
                return (curUseNoIndex ? '<NOINDEX>' : '')+'<A HREF="'+curUrl+'"'+(curUseNoIndex ? ' rel="nofollow"' : '')+' target="_blank" ' + attributes + '>'+linkContent+'</A>'+(curUseNoIndex ? '</NOINDEX>' : '');
            });

            var allSmilesTitles = this.allSmilesTitles;
            taValue = taValue.replace(/\[IMG\](.*?)\[\/IMG\]/gi, function(allstr, url){return '<IMG SRC="'+_tagsParamReplace(url, true)+'">'});
            if(this.ceMode){
                taValue = taValue.replace(/(\s;\)|\s:\)|:D|:\()/g, function(allstr, smile){smile = smile.replace(' ', ''); var imgName = specSmiles[smile]+'.gif'; return '<IMG SRC="'+smilesPath+imgName+'" title="'+(typeof(allSmilesTitles[imgName]) != 'undefined' ? allSmilesTitles[imgName] : '')+'">'});
            }else{
                taValue = taValue.replace(/(;\)|:\)|:D|:\()/g, function(allstr, smile){var imgName = specSmiles[smile]+'.gif'; return '<IMG SRC="'+smilesPath+imgName+'" title="'+(typeof(allSmilesTitles[imgName]) != 'undefined' ? allSmilesTitles[imgName] : '')+'">'});
            }
            taValue = taValue.replace(/\:([a-z\_]{1,20})\:/gi, function(allstr, smile){var imgName = smile+'.gif'; return '<IMG SRC="'+smilesPath+smile+'.gif" title="'+(typeof(allSmilesTitles[imgName]) != 'undefined' ? allSmilesTitles[imgName] : '')+'">'});

            taValue = taValue.replace(/((?:<IMG .*?>)|(?:<A (?:.|\r|\n)*?<\/A>))/gi, function(allstr, pTagContent){
                pTagContent = pTagContent.replace(/http(s?)\:/gi, 'htBREAKtp$1:');
                pTagContent = pTagContent.replace(/www/gi, 'wBREAKwBREAKw');
                return pTagContent;
            });
            taValue = taValue.replace(/(https?:\/\/www\.|https?:\/\/|www\.)(?:[a-z0-9\-]+\.)+[a-z]{2,8}[^ \r\n\t'"><]*/gi, function(allstr, prefx){
                var curUseNoIndex = localUseNoIndex;
                var curUrl = _tagsParamReplace(allstr);
                if(prefx.toLowerCase() == 'www.'){
                    curUrl = 'http://' + curUrl;
                }
                if(curUseNoIndex && (!curUrl.match(/^https?:\/\//i) || (window.bbEditorBaseHref.length > 0 && curUrl.indexOf(window.bbEditorBaseHref) >= 0)))
                    curUseNoIndex = false;
                return (curUseNoIndex ? '<NOINDEX>' : '')+'<A HREF="'+curUrl+'"'+(curUseNoIndex ? ' rel="nofollow"' : '') +' target="_blank">'+allstr+'</A>'+(curUseNoIndex ? '</NOINDEX>' : '');
            });
            taValue = taValue.replace(/((?:<IMG .*?>)|(?:<A (?:.|\r|\n)*?<\/A>))/gi, function(allstr, pTagContent){
                pTagContent = pTagContent.replace(/wBREAKwBREAKw/gi, 'www');
                pTagContent = pTagContent.replace(/htBREAKtp(s?):/gi, 'http$1:');
                return pTagContent;
            });
        }

        taValue = taValue.replace(/(<PRE[^>]*?>)CodeId_(\d+)(<\/PRE>)/g, function(allstr, preStart, codeId, preEnd){
            var result = preStart;
            if(window.amiSimpleEditorCodes[codeId]){
                result += window.amiSimpleEditorCodes[codeId];
            }
            result += preEnd;
            return result;
        });

        if(this.ceMode){
            taValue = taValue.replace(
                /##__AMI_RAW_(\d+)__##/gi,
                function(obj){
                    return function(allstr, tagContent){
                        return obj.raws[parseInt(tagContent)];
                    }
                }(this)
            );
        }

        taValue = taValue.replace(/<LI>([^\n]*?)<br>([\r\n]*?)<LI>/gi, '<LI>$1</LI>$2<LI>');
        taValue = taValue.replace(/<LI>([^\n]*?)<br>([\r\n]*?)<\//gi, '<LI>$1</LI>$2</');
        taValue = taValue.replace(/<br>([\r\n]*?)<LI>/gi, '</LI>$1<LI>');
        taValue = taValue.replace(/<br>([\r\n]*?)<\/OL>/gi, '</LI>$1</OL>');
        taValue = taValue.replace(/<br>([\r\n]*?)<\/UL>/gi, '</LI>$1</UL>');
        taValue = taValue.replace(/<UL><br>/gi, '<UL>');
        taValue = taValue.replace(/<OL><br>/gi, '<OL>');
        taValue = taValue.replace(/<\/UL><br>/gi, '</UL>');
        taValue = taValue.replace(/<\/OL><br>/gi, '</OL>');
        taValue = taValue.replace(/<\/P><br>/gi, '</P>');
        taValue = taValue.replace(/<\/DIV><br>/gi, '</DIV>');
        taValue = taValue.replace(/<\/TR><br>/gi, '</TR>');
        taValue = taValue.replace(/<\/TD><br>/gi, '</TD>');
        taValue = taValue.replace(/<\/TBODY><br>/gi, '</TBODY>');
        taValue = taValue.replace(/<\/TABLE><br>/gi, '</TABLE>');
        taValue = taValue.replace(/<\/BLOCKQUOTE><br>/gi, '</BLOCKQUOTE>');
        taValue = taValue.replace(/<TR((?:.|\r|\n)*?)><br>/gi, '<TR$1>');
        taValue = taValue.replace(/<TBODY((?:.|\r|\n)*?)><br>/gi, '<TBODY$1>');
        taValue = taValue.replace(/<TABLE((?:.|\r|\n)*?)><br>/gi, '<TABLE$1>');
        taValue = taValue.replace(/<COL((?:.|\r|\n)*?)><br>/gi, '<COL$1>');
        taValue = taValue.replace(/<OL><\/LI>/gi, '<OL>');
        taValue = taValue.replace(/<\/H(\d)><br>/gi, '</H$1>');
        taValue = taValue.replace(/<UL><\/LI>/gi, '<UL>');
        taValue = taValue.replace(/<OL><\/LI>/gi, '<OL>');

        window.amiSimpleEditorCodes = [];

        return taValue;
    }

    this.fromHTMLContent = function(taValue){
        var smilesPath = '_mod_files/smiles/' + this.smilesPath + '/';
        var specSmiles = {"wink":";)", "smile":":)", "laugh":":D", "frown":":("};
        
        if(this.ceMode){
            taValue = taValue.replace(/(##[^#]*##)/g, function(str, match, offset, src) {
                var result = match;
                
                if (!isInRaw(src, offset)) {
                    result = result.replace(/\[RAW\](.+)\[\/RAW\]/g, '$1');
                    result = '[RAW]' + match + '[/RAW]';
                }

                return result;
            });
        }
        
        if(this.ceMode && this.ce.useSpecialCharsFeature){
            taValue = taValue.replace(/<br>/gi, '_spec_rpl_val_br');
            taValue = taValue.replace(/&nbsp;/gi, '·');
        }else{
            taValue = taValue.replace(/<\/LI>\r?\n?<br.*?>/gi, '</LI>\r\n<br><br>');
            taValue = taValue.replace(/<\/OL>\r?\n?<br.*?>/gi, '</OL>\r\n<br><br>');
            taValue = taValue.replace(/<\/UL>\r?\n?<br.*?>/gi, '</UL>\r\n<br><br>');
            taValue = taValue.replace(/<\/P>\r?\n?<br.*?>/gi, '</P>\r\n<br><br>');
            taValue = taValue.replace(/<\/DIV>\r?\n?<br.*?>/gi, '</DIV>\r\n<br><br>');
            taValue = taValue.replace(/<\/H(\d)>\r?\n?<br.*?>/gi, '</H$1>\r\n<br><br>');
            taValue = taValue.replace(/\r?\n?<br.*?>\r?\n?/gi, '\r\n');
        }

        taValue = taValue.replace(/ style=""/gi, '');
        taValue = taValue.replace(/ class=""/gi, '');
        taValue = taValue.replace(/ target="_self"/gi, '');

        if(this.ceMode){
            taValue = taValue.replace(/<script((?:.|\r|\n)*?)\/script>/gi, function(str, p1, offset, src) {
                if (!isInRaw(src, offset)) {
                    return '[RAW]<script' + p1 + '/script>[/RAW]';
                }
                
                return str;
            });            
            taValue = taValue.replace(/<!--((?:.|\r|\n)*?)-->/gi, function(str, p1, offset, src) {
                if (!isInRaw(src, offset)) {
                    return '[RAW]<!--' + p1 + '-->[/RAW]';
                }
                
                return str;
            });
            taValue = taValue.replace(/↵/gi, function(str, offset, src) {
                if (!isInRaw(src, offset)) {
                    return '[RAW]↵[/RAW]';
                }
                
                return '↵';
            });
        }

        taValue = taValue.replace(/\\([rn])/gi, '[_spec_rpl_val_$1]');
        taValue = taValue.replace(/\r?\n/g, '\\n');

        // Replace simple elements

        taValue = taValue.replace(/<PRE class="edCode".*?>/gi, '[CODE]');
        taValue = taValue.replace(/<\/PRE>/gi, '[/CODE]');
        taValue = taValue.replace(/<(\/?)(B|I|U|S|H\d)>/gi, '[$1$2]');
        taValue = taValue.replace(/<UL>/gi, '[LIST]');
        taValue = taValue.replace(/<\/UL>/gi, '[/LIST]');
        taValue = taValue.replace(/<OL>/gi, '[OL]');
        taValue = taValue.replace(/<\/OL>/gi, '[/OL]');
        taValue = taValue.replace(/<LI>/gi, '[*]');
        taValue = taValue.replace(/<\/LI.*?>/gi, '');
        taValue = taValue.replace(/<STRIKE>/gi, '[S]');
        taValue = taValue.replace(/<\/STRIKE>/gi, '[/S]');

        taValue = taValue.replace(/<img src=\"([^"]*?)\">/gi, "[IMG]$1[/IMG]");

        // Replace smiles
        taValue = taValue.replace(/<img[^>]*?src=((?:"|').*?(?:"|')|[^\s]*).*?>/gi,
          function(allstr, tagUrl){
            var tagUrl = tagUrl.replace(/^('|")(.*?)\1$/g, '$2');
            var pathPos = tagUrl.indexOf(smilesPath);
            if(pathPos >= 0){
                var dotPos = tagUrl.indexOf(".", pathPos+smilesPath.length);
                if(dotPos >= 0){
                    var startPos = pathPos+smilesPath.length;
                    var smileName = tagUrl.substr(startPos, dotPos-startPos);
                    if(specSmiles[smileName] != undefined){
                        return specSmiles[smileName];
                    }else
                        return ':'+smileName+':';
                }
            }
            return allstr;}
        );

        // Replace nested elements
        var replaceType = ['align', 'font', 'url', 'blockquote'];
        for(var i = 0; i < replaceType.length; i++){
            var checkLen = 0;
            do{
                checkLen = taValue.length;
                if(replaceType[i] == 'align'){
                    if(this.ceMode){
                        taValue = taValue.replace(/<div>(.*?)<\/div>/ig, '[DIV]$1[/DIV]');
                        taValue = taValue.replace(/<div class="edParagraph" style="text-align:\s?(right|left|center|justify);">(.*?)<\/div>/i, '[$1="DIV"]$2[/$1]');
                        taValue = taValue.replace(/<div style="text-align:\s?(right|left|center|justify);">(.*?)<\/div>/i, '[$1="DIV"]$2[/$1]');
                        taValue = taValue.replace(/<p align="(right|left|center|justify)">(.*?)<\/p>/i, '[$1="P"]$2[/$1="P"]');
                    }else{
                        taValue = taValue.replace(/<div class="edParagraph" style="text-align:\s?(right|left|center|justify);">(.*?)<\/div>/i, '[$1]$2[/$1]');
                        taValue = taValue.replace(/<p align="(right|left|center|justify)">(.*?)<\/p>/i, '[$1]$2[/$1]');
                        //taValue = taValue.replace(/^(.*)<p[^a-z][^>]*?align=(?:"|')?(right|left|center|justify)(?:"|')?.*?>(.*?)<\/p(?:>|[^a-z].*?>)/i, '$1[$2]$3[/$2]');
                    }
                }
                else if(replaceType[i] == 'font'){
                    if(this.ceMode){
                        taValue = taValue.replace(
                            /^(.*)<font[^>]*?(face|size|color)="(.*?)">(.*?)<\/font>/ig,
                            function(allstr, textStart, tagName, tagValue, tagContent){
                                if(tagValue.indexOf(" ") > 0){
                                    return allstr;
                                }
                                var tagTag = (tagName.toLowerCase() == "face" ? "FONT" : tagName.toUpperCase());
                                tagValue = tagValue.replace(/^('|")(.*?)\1$/g, '$2');
                                return textStart+'['+tagTag+'="'+tagValue+'"]'+tagContent+'[/'+tagTag+']';
                            }
                        );
                    }else{
                        taValue = taValue.replace(/^(.*)<font[^>]*?(face|size|color)=((?:"|').*?(?:"|')|[^\s>]*).*?>(.*?)<\/font.*?>/i, function(allstr, textStart, tagName, tagValue, tagContent){var tagTag = (tagName.toLowerCase() == "face" ? "FONT" : tagName.toUpperCase()); tagValue = tagValue.replace(/^('|")(.*?)\1$/g, '$2'); return textStart+'['+tagTag+'="'+tagValue+'"]'+tagContent+'[/'+tagTag+']';});
                    }
                }
                else if(replaceType[i] == 'url') {
                    if(this.ceMode){
                        taValue = taValue.replace(/<a href="([^"]*?)"\s?(target="_self")?\s*?>(.*?)<\/a>/igm, '[URL="$1"]$3[/URL]');
                    }else{
                        taValue = taValue.replace(/^(.*)<a[^a-z]([^>]*?)href=((?:"|').*?(?:"|')|[^\s>]*)(.*?)>(.*?)<\/a(?:>|[^a-z].*?>)/i,  function(allstr, textStart, tagParams1, tagUrl, tagParams2, tagContent){
                            if(tagUrl.indexOf('javascript:') > 0) return allstr;

                            var tagUrl = tagUrl.replace(/^('|")(.*?)\1$/g, '$2');
                            urlContent = tagContent;
                            if(aParts = (tagParams1 + " " + tagParams2).match(/[^a-z]title="([^"]+)"/i)){
                                urlContent = aParts[1].replace(/&quot;/mg, '"').replace(/&#10;/mg, '\n').replace(/&#13;/mg, '\r');
                            }
                            return textStart + '[URL="' + tagUrl + '"]' + urlContent + '[/URL]';
                        });
                    }

                }
                else if(replaceType[i] == 'blockquote'){
                    taValue = taValue.replace(/^(.*)<BLOCKQUOTE(.*?)>(?:\[B\](.*?):\[\/B\]\\n)?(.*?)<\/BLOCKQUOTE>/i, function(allstr, tagBefore, tagInner, qAuthor, tagContent){
                        var isQuote = (tagInner.indexOf('edQuote') >= 0);
                        var hasAuthor = (typeof(qAuthor) != "undefined" && qAuthor.length > 0);
                        if(isQuote){
                            var startTag = '[Q'+(hasAuthor ? '="'+qAuthor+'"' : '')+']';
                            return tagBefore+startTag+tagContent+'[/Q]';
                        }else{
                            return tagBefore+'[INDENT]'+(hasAuthor ? qAuthor : '')+tagContent+'[/INDENT]';
                        }
                    });
                }
            }while(checkLen != taValue.length);
        }

        taValue = taValue.replace(/<(\/?)(P)>/gi, '[$1$2]');

        // Replace HTML base chars
        taValue = taValue.replace(/&reg;/gi, '®');
        taValue = taValue.replace(/&copy;/gi, '©');
        taValue = taValue.replace(/&laquo;/gi, '«');
        taValue = taValue.replace(/&raquo;/gi, '»');
        taValue = taValue.replace(/&ndash;/gi, '–');
        taValue = taValue.replace(/&mdash;/gi, '—');
        taValue = taValue.replace(/&euro;/gi, '€');
        taValue = taValue.replace(/&quot;/gi, '"');
        taValue = taValue.replace(/&nbsp;/gi, ' ');

        // RAWs
        if(this.ceMode){
            taValue = taValue.replace(/(<(([^>]|\n|\r|\s|\t)+)>)/ig, function(match, m1, m2, m3, offset, src) {
                if (!isInRaw(src, offset)) {
                    m1 = m1.replace(/\[RAW\](.+)\[\/RAW\]/g, '$1');
                    return '[RAW]' + m1 + '[/RAW]';
                }
                
                return m1;
            }).replace(/\[\/RAW\]((\r|\n)*?)\[RAW\]/g, "$1");
            
            // Tags fully closed with RAW
            var rawTags = ['script', 'object', 'style', 'textarea'];
            for(var i=0; i<rawTags.length; i++){
                var regExp = new RegExp('<' + rawTags[i] + '((?:.|\r|\n)*?)\/' + rawTags[i] + '>', 'ig');
                taValue = taValue.replace(
                    regExp,
                    function(tag){
                        return function(allstr, tagContent){
                            tagContent = tagContent.replace(/\[RAW\]/ig, "");
                            tagContent = tagContent.replace(/\[\/RAW\]/ig, "");
                            return '<' + tag + tagContent + '/' + tag + '>';
                        }
                    }(rawTags[i])
                );
            }

            // Remove RAWs and replace brs inside RAW
            var regExp = new RegExp('\\[RAW\\]<((.|\r|\n)*?)>\\[\\/RAW\\]', 'ig');
            taValue = taValue.replace(
                regExp,
                function(allstr, tagContent){
                    tagContent = tagContent.replace(/\_spec\_rpl\_val\_br/gi, '<br>');
                    tagContent = tagContent.replace(/\[RAW\]/ig, "");
                    tagContent = tagContent.replace(/\[\/RAW\]/ig, "");
                    return '[RAW]<' + tagContent + '>[/RAW]';
                }
            );
        }

        // Replace &gt; and &lt;
        taValue = taValue.replace(/&lt;/gi, '<');
        taValue = taValue.replace(/&gt;/gi, '>');

        // Replace &amp;s
        taValue = taValue.replace(/&amp;/gi, '&');

        // Make multiline string
        taValue = taValue.replace(/\\n/g, '\r\n');
        taValue = taValue.replace(/\[\_spec\_rpl\_val\_([rn])\]/gi, '\\$1');
        taValue = taValue.replace(/\_spec\_rpl\_val\_br/gi, '↵');

        return taValue;
    }

    this.createEditor = function(taWidth, taHeight, taValueName, taValue, isValueHTML, idPreviewDiv, divId){
        if (typeof(isValueHTML) != undefined) {
            var re = /(<noindex>|<\/noindex>)/gi;
            taValue = taValue.replace(re, '');
        }
        if(taValueName && taValueName != "message"){
            this.editorId = 'id'+taValueName;
        }
        var i = 0;

        /*var usedFonts = '';
        for(i = 0; i < this.usedFonts.length; i++){
            usedFonts += '<option value="'+this.usedFonts[i]+'">'+this.usedFonts[i]+'</option>';
        }*/

        var baseSmilesCount = 0;
        var TEdDivBaseSmiles = document.createElement('DIV');
        for(i = 0; i < this.baseSmiles.length; i++){
            var smile = document.createElement('IMG');
            smile.src = this.baseHref + '_mod_files/smiles/' + this.smilesPath + '/' +this.baseSmiles[i][0];
            smile.setAttribute('title', this.baseSmiles[i][1]);
            smile.className = 'amiroTEdSmile';
            AMI.Browser.Event.addHandler(smile, 'click', function(_this, num){return function(e){_this.procAction('smile', _this.baseSmiles[num][2]);}}(this, i));
            TEdDivBaseSmiles.appendChild(smile);
            baseSmilesCount++;
        }

        var allSmilesCount = 0;
        var TEdDivAllSmiles = document.createElement('DIV');
        TEdDivAllSmiles.style.display = 'none';
        for(i = 0; i < this.baseSmiles.length; i++){
            var smile = document.createElement('IMG');
            smile.src = this.baseHref + '_mod_files/smiles/' + this.smilesPath + '/' +this.baseSmiles[i][0];
            smile.setAttribute('title', this.baseSmiles[i][1]);
            smile.className = 'amiroTEdSmile';
            AMI.Browser.Event.addHandler(smile, 'click', function(_this, num){return function(e){_this.procAction('smile', _this.baseSmiles[num][2]);}}(this, i));
            TEdDivAllSmiles.appendChild(smile);
            allSmilesCount++;
        }
        for(i = 0; i < this.allSmiles.length; i++){
            var smile = document.createElement('IMG');
            smile.src = this.baseHref + '_mod_files/smiles/' + this.smilesPath + '/' +this.allSmiles[i][0];
            smile.setAttribute('title', this.allSmiles[i][1]);
            smile.className = 'amiroTEdSmile';
            AMI.Browser.Event.addHandler(smile, 'click', function(_this, num){return function(e){_this.procAction('smile', _this.allSmiles[num][2]);}}(this, i));
            TEdDivAllSmiles.appendChild(smile);
            allSmilesCount++;
        }
        if(this.smilesCopyright){
            var smilesCopyrightDiv = document.createElement('DIV');
            smilesCopyrightDiv.setAttribute('align', 'right');
            smilesCopyrightDiv.innerHTML = this.smilesCopyright;
            TEdDivAllSmiles.appendChild(smilesCopyrightDiv);
        }

        var contentPreviewDiv = '';
        if(typeof(idPreviewDiv) != "undefined"){
            this.idPreviewDiv = idPreviewDiv;
        }else{
            this.idPreviewDiv = 'amiroTEdDivPreview';
            contentPreviewDiv = '<div id="amiroTEdDivPreview" class="amiroTEdDivPreview" style="width:' + (taWidth - 12) + 'px;margin-bottom:7px"></div>';
        }

        var allowedImages = this.allowedImages;

        var TEdDiv = document.createElement('DIV');
        TEdDiv.className = "amiroTEdDiv";
        TEdDiv.style.width = taWidth + 'px';

        // Separator
        var separator = document.createElement('IMG');
        separator.src = this.baseHref + '_img/ed_sep.gif';
        separator.className = 'amiroTEdSep';

        // Bold button
        var btnBold = document.createElement('IMG');
        btnBold.src = this.baseHref + '_img/ed_bold.gif';
        btnBold.title = this.oDictionary.get('bold');
        AMI.Browser.Event.addHandler(btnBold, 'click', function(_this){return function(e){_this.procAction('bold');}}(this));

        // Italic button
        var btnItalic = document.createElement('IMG');
        btnItalic.src = this.baseHref + '_img/ed_italic.gif';
        btnItalic.title = this.oDictionary.get('italic');
        AMI.Browser.Event.addHandler(btnItalic, 'click', function(_this){return function(e){_this.procAction('italic');}}(this));

        // Underline button
        var btnUnderline = document.createElement('IMG');
        btnUnderline.src = this.baseHref + '_img/ed_underline.gif';
        btnUnderline.title = this.oDictionary.get('underline');
        AMI.Browser.Event.addHandler(btnUnderline, 'click', function(_this){return function(e){_this.procAction('underlined');}}(this));

        // StrikeThrough button
        var btnStrike = document.createElement('IMG');
        btnStrike.src = this.baseHref + '_img/ed_strike.gif';
        btnStrike.title = this.oDictionary.get('strike');
        AMI.Browser.Event.addHandler(btnStrike, 'click', function(_this){return function(e){_this.procAction('strike');}}(this));

        // Quote button
        var btnQuote = document.createElement('IMG');
        btnQuote.src = this.baseHref + '_img/ed_quote.gif';
        btnQuote.title = this.oDictionary.get('quote');
        AMI.Browser.Event.addHandler(btnQuote, 'click', function(_this){return function(e){_this.procAction('quote');}}(this));
        this.insertQuoteBtn = btnQuote;

        var buttonsBlock1 = document.createElement('NOBR');
        buttonsBlock1.appendChild(btnBold);
        buttonsBlock1.appendChild(btnItalic);
        buttonsBlock1.appendChild(btnUnderline);
        buttonsBlock1.appendChild(btnStrike);
        buttonsBlock1.appendChild(btnQuote);

        // Outdent button
        var btnOutdent = document.createElement('IMG');
        btnOutdent.src = this.baseHref + '_img/ed_outdent.gif';
        btnOutdent.title = this.oDictionary.get('outdent');
        AMI.Browser.Event.addHandler(btnOutdent, 'click', function(_this){return function(e){_this.procAction('outdent');}}(this));

        // Indent button
        var btnIndent = document.createElement('IMG');
        btnIndent.src = this.baseHref + '_img/ed_indent.gif';
        btnIndent.title = this.oDictionary.get('indent');
        AMI.Browser.Event.addHandler(btnIndent, 'click', function(_this){return function(e){_this.procAction('indent');}}(this));

        var buttonsBlock2 = document.createElement('NOBR');
        buttonsBlock2.appendChild(btnOutdent);
        buttonsBlock2.appendChild(btnIndent);

        // Left button
        var btnLeft = document.createElement('IMG');
        btnLeft.src = this.baseHref + '_img/ed_alignl.gif';
        btnLeft.title = this.oDictionary.get('align_left');
        AMI.Browser.Event.addHandler(btnLeft, 'click', function(_this){return function(e){_this.procAction('align', 'left');}}(this));

        // Center button
        var btnCenter = document.createElement('IMG');
        btnCenter.src = this.baseHref + '_img/ed_alignc.gif';
        btnCenter.title = this.oDictionary.get('align_center');
        AMI.Browser.Event.addHandler(btnCenter, 'click', function(_this){return function(e){_this.procAction('align', 'center');}}(this));

        // Right button
        var btnRight = document.createElement('IMG');
        btnRight.src = this.baseHref + '_img/ed_alignr.gif';
        btnRight.title = this.oDictionary.get('align_right');
        AMI.Browser.Event.addHandler(btnRight, 'click', function(_this){return function(e){_this.procAction('align', 'right');}}(this));

        // Justify button
        var btnJustify = document.createElement('IMG');
        btnJustify.src = this.baseHref + '_img/ed_alignj.gif';
        btnJustify.title = this.oDictionary.get('justify');
        AMI.Browser.Event.addHandler(btnJustify, 'click', function(_this){return function(e){_this.procAction('align', 'justify');}}(this));

        var buttonsBlock3 = document.createElement('NOBR');
        buttonsBlock3.appendChild(btnLeft);
        buttonsBlock3.appendChild(btnCenter);
        buttonsBlock3.appendChild(btnRight);
        buttonsBlock3.appendChild(btnJustify);

        // List button
        var btnUlist = document.createElement('IMG');
        btnUlist.src = this.baseHref + '_img/ed_list.gif';
        btnUlist.title = this.oDictionary.get('insert_list');
        AMI.Browser.Event.addHandler(btnUlist, 'click', function(_this){return function(e){_this.procAction('ulist');}}(this));

        // Orderes list button
        var btnOlist = document.createElement('IMG');
        btnOlist.src = this.baseHref + '_img/ed_ol.gif';
        btnOlist.title = this.oDictionary.get('insert_olist');
        AMI.Browser.Event.addHandler(btnOlist, 'click', function(_this){return function(e){_this.procAction('olist');}}(this));

        // Add link button
        var btnLink = document.createElement('IMG');
        btnLink.src = this.baseHref + '_img/ed_link.gif';
        btnLink.title = this.oDictionary.get('insert_link');
        AMI.Browser.Event.addHandler(btnLink, 'click', function(_this){return function(e){_this.procAction('addlink');}}(this));

        // Del link button
        var btnUnlink = document.createElement('IMG');
        btnUnlink.src = this.baseHref + '_img/ed_unlink.gif';
        btnUnlink.title = this.oDictionary.get('delete_link');
        AMI.Browser.Event.addHandler(btnUnlink, 'click', function(_this){return function(e){_this.procAction('dellink');}}(this));

        // Add image button
        var btnImg = document.createElement('IMG');
        btnImg.src = this.baseHref + '_img/ed_image.gif';
        btnImg.title = this.oDictionary.get('insert_image');
        AMI.Browser.Event.addHandler(btnImg, 'click', function(_this){return function(e){_this.procAction('addimg');}}(this));

        // Code button
        var btnCode = document.createElement('IMG');
        btnCode.src = this.baseHref + '_img/ed_code.gif';
        btnCode.title = this.oDictionary.get('insert_code');
        AMI.Browser.Event.addHandler(btnCode, 'click', function(_this){return function(e){_this.procAction('code');}}(this));
        this.insertCodeBtn = btnCode;

        var buttonsBlock4 = document.createElement('NOBR');
        buttonsBlock4.appendChild(btnLink);
        buttonsBlock4.appendChild(btnUnlink);
        if(allowedImages.length){
            buttonsBlock4.appendChild(btnImg);
        }
        buttonsBlock4.appendChild(btnCode);

        var buttonsBlock5 = document.createElement('NOBR');
        buttonsBlock5.style.display = 'inline-block';
        buttonsBlock5.style.verticalAlign = 'top';
        buttonsBlock5.style.marginTop = '-2px';

        var selectSize = document.createElement('SELECT');
        selectSize.name = 'amiroTEdit_selsize';
        selectSize.className = 'amiroTEdCtrl';
        AMI.Browser.Event.addHandler(selectSize, 'change', function(_this, sel){return function(e){_this.procAction('font_size', sel.value); sel.options[0].selected=true;}}(this, selectSize));
        var option = document.createElement('option');
        option.text = this.oDictionary.get('size');
        option.value = "";
        try{selectSize.add(option, null);}catch(ex){selectSize.add(option);}
        buttonsBlock5.appendChild(selectSize);
        for(i = 1; i <= this.maxTextSize; i++){
            var option = document.createElement('option');
            option.text = i;
            option.value = i;
            try{selectSize.add(option, null);}catch(ex){selectSize.add(option);}
        }
        this.sizeSelectionBox = selectSize;

        var selectColor = document.createElement('SELECT');
        selectColor.name = 'amiroTEdit_selcolor';
        selectColor.style.width = '80px';
        selectColor.className = 'amiroTEdCtrl';
        AMI.Browser.Event.addHandler(selectColor, 'change', function(_this, sel){return function(e){_this.procAction('font_color', sel.value); sel.options[0].selected=true;}}(this, selectColor));
        buttonsBlock5.appendChild(selectColor);
        var option = document.createElement('option');
        option.text = this.oDictionary.get('color');
        option.value = "";
        try{selectColor.add(option, null);}catch(ex){selectColor.add(option);}
        for(i = 0; i < this.usedColors.length; i++){
            var option = document.createElement('option');
            option.text = this.usedColors[i];
            option.value = this.usedColors[i];
            option.style.backgroundColor = this.usedColors[i];
            option.style.color = this.usedColors[i]
            try{selectColor.add(option, null);}catch(ex){selectColor.add(option);}
        }
        this.colorSelectionBox = selectColor;

        var selectHeader = document.createElement('SELECT');
        selectHeader.name = 'amiroTEdit_selheader';
        selectHeader.className = 'amiroTEdCtrl';
        AMI.Browser.Event.addHandler(selectHeader, 'change', function(_this, sel){return function(e){_this.procAction('header', sel.value); sel.options[0].selected=true;}}(this, selectHeader));
        var option = document.createElement('option');
        option.text = this.oDictionary.get('header');
        option.value = "";
        try{selectHeader.add(option, null);}catch(ex){selectHeader.add(option);}
        // buttonsBlock5.appendChild(selectHeader);
        for(i = 1; i <= 5; i++){
            var option = document.createElement('option');
            option.text = 'H' + i;
            option.value = i;
            try{selectHeader.add(option, null);}catch(ex){selectHeader.add(option);}
        }
        this.headerSelectionBox = selectHeader;



        if(allSmilesCount > baseSmilesCount){
            var more = document.createElement('SPAN');
            more.className = 'amiroTEdMore';
            more.innerHTML = this.oDictionary.get('more');
            AMI.Browser.Event.addHandler(more, 'click', function(_this, allSmilesDiv, baseSmilesDiv){
                return function(e){
                    allSmilesDiv.style.display = 'block';
                    baseSmilesDiv.style.display = 'none';
                }
            }(this, TEdDivAllSmiles, TEdDivBaseSmiles));
        }

        // Textarea
        var TEdDivEditor = document.createElement('DIV');
        TEdDivEditor.className = 'amiroTEdDivEditor';

        var TEdTextarea = document.createElement('TEXTAREA');
        TEdTextarea.id = this.editorId;
        TEdTextarea.name = taValueName;
        TEdTextarea.setAttribute('wrap', 'fisical');
        TEdTextarea.className = 'amiroTEdCtrl';
        TEdTextarea.style.width = '100%'; //taWidth + 'px';
        TEdTextarea.style.height = taHeight + 'px';
        TEdTextarea.value = (typeof(isValueHTML) == undefined || !isValueHTML ? taValue : this.fromHTMLContent(taValue));
        AMI.Browser.Event.addHandler(TEdTextarea, 'keydown', function(_this){return function(e){_this.procKeyPress(e);}}(this));
        AMI.Browser.Event.addHandler(TEdTextarea, 'keyup', function(_this){return function(e){_this.procKeyUp(e);}}(this));

        TEdDivEditor.appendChild(TEdTextarea);

        TEdDiv.innerHTML = contentPreviewDiv;

        var TEdToolbar = document.createElement('DIV');
        TEdToolbar.id = 'amiroTEdPureDiv';
        this.toolbarObj = TEdToolbar;

        TEdToolbar.appendChild(buttonsBlock1);
        TEdToolbar.appendChild(separator.cloneNode(true));
        TEdToolbar.appendChild(buttonsBlock2);
        TEdToolbar.appendChild(separator.cloneNode(true));
        TEdToolbar.appendChild(buttonsBlock3);
        TEdToolbar.appendChild(separator.cloneNode(true));
        TEdToolbar.appendChild(btnUlist);
        TEdToolbar.appendChild(btnOlist);
        TEdToolbar.appendChild(separator.cloneNode(true));
        TEdToolbar.appendChild(buttonsBlock4);
        TEdToolbar.appendChild(separator.cloneNode(true));
        TEdToolbar.appendChild(buttonsBlock5);
        TEdToolbar.appendChild(document.createElement('BR'));
        TEdToolbar.appendChild(TEdDivBaseSmiles);

        if((allSmilesCount > baseSmilesCount) && more){
            TEdDivBaseSmiles.appendChild(more);
            TEdToolbar.appendChild(TEdDivAllSmiles);
        }
        TEdDiv.appendChild(TEdToolbar);
        TEdDiv.appendChild(TEdDivEditor);

        if(divId == undefined){
            divId = "amiBBEditor";
            document.writeln('<div id="' + divId + '"></div>');
        }

        AMI.find('#' + divId).appendChild(TEdDiv);
        this.editorObj = document.getElementById(this.editorId);
        this.editorDiv = TEdDiv;
        this.isInitialized = true;
    }

    this.insertContent = function(taValue, actionType, isValueHTML, subaction, addon){
        if (typeof(isValueHTML) != undefined) {
            var re = /(<noindex>|<\/noindex>)/gi;
            taValue = taValue.replace(re, '');
        }

        this.setMode('editor');
        if(typeof(addon) != "undefined" && actionType == "bold"){
            taValue = "[B]"+taValue+"[/B]"+addon;
            this._replaceSelection(typeof(isValueHTML) == undefined || !isValueHTML ? taValue : this.fromHTMLContent(taValue), 0, 0, true);
        }else{
            this._replaceSelection(typeof(isValueHTML) == undefined || !isValueHTML ? taValue : this.fromHTMLContent(taValue), 0, 0);
            if(actionType != 'undefined' && (actionType == 'quote' || actionType == 'bold' || actionType == 'italic' || actionType == 'underlined')){
                this.procAction(actionType, subaction);
            }
        }
    }

    this.setMode = function(mode){
        if(mode == 'editor' && !this.updatePreviewMode){
            document.getElementById(this.idPreviewDiv).style.display = 'none';
            this.currentMode = 'editor';
            if(this.editorModeCode.length > 0){
                eval(this.editorModeCode);
            }
        }else if(mode == 'preview' || this.updatePreviewMode){
            var content = this.getHTMLContent(1);
            if (content.length) {
                document.getElementById(this.idPreviewDiv).style.display = 'block';
                document.getElementById(this.idPreviewDiv).innerHTML = content;
                this.currentMode = 'preview';
                if (this.updatePreviewMode) {
                    this.previewButtonObj.value = this.oDictionary.get('hide_preview');
                }
                this.updatePreviewMode = false;
            }
        }
        if (typeof(amiroTEditOnSwitchMode) == 'function') {
            amiroTEditOnSwitchMode(this.currentMode);
        }
    }

    this.switchMode = function(){
        if(this.currentMode == 'editor'){
            this.setMode('preview');
        }else{
            this.setMode('editor');
        }
    }

    this.stopEvent = function(evt){
        if(typeof(evt.stopPropagation) == "function"){
            evt.stopPropagation();
            evt.preventDefault();
            return evt;
        }else{
            window.event.returnValue = false;
            window.event.cancelBubble = true;
            return window.event;
        }
    }

    this.procKeyPress = function(evt){
        if(this.ceMode && this.ce.useSpecialCharsFeature){
            switch(evt.keyCode){
                case 13 /*ENTER */:
                    if(!evt.shiftKey){
                        this.procAction('br');
                        return this.stopEvent(evt);
                    }
                    break;
            }
        }
        if(evt.ctrlKey && evt.keyCode != 17){
            switch(evt.keyCode){
                case 66 /*B*/:
                    this.procAction('bold');
                    return this.stopEvent(evt);
                    break;
                case 73 /*I*/:
                    this.procAction('italic');
                    return this.stopEvent(evt);
                    break;
                case 85 /*U*/:
                    this.procAction('underlined');
                    return this.stopEvent(evt);
                    break;
                case 83 /*S*/:
                    this.procAction('strike');
                    return this.stopEvent(evt);
                    break;
            }
        }else if(!evt.ctrlKey && !evt.altKey){
            this.updatePreviewButton();
        }
    }

    this.procKeyUp = function()
    {
        if (this.currentMode == 'preview' && this.contentLength() < 2) {
            this.updatePreviewMode = false;
            this.previewButtonOnClick();
            alert(this.oDictionary.get('warn_message_length'));
        }
    }

    this.contentLength = function(){
        var contentData = this.editorObj.value;
        contentData = contentData.replace(/[ \t\r\n]/g, '');

        var replaceType = ['q'];
        for(var i = 0; i < replaceType.length; i++){
            var checkLen = 0;
            do{
                checkLen = contentData.length;
                if(replaceType[i] == 'q'){
                    contentData = contentData.replace(/^(.*)\[Q[^\]]*?\](.*?)\[\/Q\]/i, '$1');
                }
            }while(checkLen != contentData.length);
        }

        contentData = contentData.replace(/\[.*?\]/g, '');
        return contentData.length;
    }

    this.previewButtonOnClick = function(btn)
    {
        if (btn != undefined) {
            this.previewButtonObj = btn;
        } else {
            btn = this.previewButtonObj;
        }
        if (this.currentMode == 'preview') {
            btn.value = this.oDictionary.get('preview');
            this.setMode('editor');
        } else if (this.contentLength() < 2) {
            alert(this.oDictionary.get('warn_message_length'));
            this.editorObj.focus();
        } else {
            btn.value = this.oDictionary.get('hide_preview');
            this.setMode('preview');
        }
        return false;
    }

    this.updatePreviewButton = function(){
        if (this.currentMode == 'preview' && this.previewButtonObj != undefined) {
            this.previewButtonObj.value = this.oDictionary.get('update_preview');
            this.updatePreviewMode = true;
        }
    }

    this.checkURLUsage = function(){
        var res = this.bAllowURLs || !this.getHTMLContent().match(/<A[^>]+HREF=/gi);
        if(!res){
            alert(this.oDictionary.get('warn_urls_reg_only'));
        }
        return res;
    }

    this.init();
}
function handleMouseMove(evt){
    if(typeof(globalATEObj) == 'object')
        return globalATEObj.handleMouseMove(evt == undefined ? window.event.clientY : evt.pageY);
    else
        return false;
}
function releaseMouseMoveHandler(){
    document.onmousemove = null;
    document.onmouseup = null;
    return false;
}
function _tagsParamReplace(param, doCheckImage){
    var res = param.replace(/&amp;/, '&');

    do{
        var prevLength = res.length;
        res = res.replace(/^\s*javascript\:/, '');
    }while(res.length != prevLength);

    if(doCheckImage){
        var test = res.replace(/^ *(.*?) *$/i, '$1').toLowerCase();
        if(test.indexOf('/_admin/') >= 0){
            res = '';
        }else{
            var isRelativeAddress = (test.search(/^https?:\/\//) == -1);
            var isLocalAddress = false;
            if(!isRelativeAddress){
                test = test.replace(/^https:\/\//, 'http://');
                var localURL = window.bbEditorBaseHref;
                if(localURL != '' && test.indexOf(localURL) == 0){
                    isLocalAddress = true;
                }
            }
            if((isRelativeAddress || isLocalAddress) && test.search(/^[^?]*\.(jpg|png|gif|jpeg|swf)$/) == -1){
                res = '';
            }
        }
    }

    return res;
}

function _stripTags(str)
{
    return str.replace(/<\/?[^\s^>]+[^>]*?>/gi, '');
}

function _trim(str)
{
    return str.replace(/^\s+/mg, '').replace(/\s+$/mg, '');
}
