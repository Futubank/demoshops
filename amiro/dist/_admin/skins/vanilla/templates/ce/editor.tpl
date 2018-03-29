%%include_language "templates/lang/discussion.lng"%%
%%include_language "templates/lang/_discussion_msgs.lng"%%
%%include_language "templates/lang/gadgets.lng"%%
%%include_language "templates/lang/_buttons.lng"%%
%%include_language "templates/ce/editor.lng"%%
%%include_language "templates/lang/main.lng"%%


var UndoStatesArray = Array();
var UndoRangesArray = Array();
var statesStored = Array();
var currentState = Array();
var globalEditor = Array();
var alternativeEditors = new Object();

var imgURL = _editor_images_url;  // images url

if(typeof(_cePageBreakAllowed) == 'undefined'){
    var _cePageBreakAllowed = false;
}
if(typeof(_cePageBreakFields) == 'undefined'){
    var _cePageBreakFields = ';;';
}
if(typeof(_cePageBreakTag) == 'undefined'){
    var _cePageBreakTag = false;
}

function editor_generate(objname, ceOptions, bVisible, width, height, modes) {
  errFunc = editor_generate;

  // Get textarea object
  var taObj = document.getElementById(objname);

  if(typeof(modes) == 'undefined'){
      var modes = ['editor', 'bb', 'textarea'];
  }

  // Set default parameters
  if (typeof(ceOptions) == 'undefined'){
     ceOptions = 0;
  }
  if (typeof(bVisible) == 'undefined'){
     bVisible = true;
  }
  if(typeof(width) == 'undefined' || parseInt(width) <= 0){
    if(taObj.style.width){
        width = parseInt(taObj.style.width);
    }else if(taObj.cols){
        width = (taObj.cols * 8) + 22;
    }else{
        width = '100%';
    }
  }
  if(typeof(height) == 'undefined' || parseInt(height) <= 0){
    if(taObj.style.height){
        height = parseInt(taObj.style.height);
    }else if(taObj.rows){
        height = taObj.rows * 17;
    }else{
        height = '300';
    }
  }

  // Set other parameters
  var m = 1;

  // Check for IE 5.5+ on Windows
  /*var Agent, VInfo, MSIE, Ver, Win32, Opera;
  Agent = navigator.userAgent;
  VInfo = Array();                              // version info
  VInfo = Agent.split(";")
  MSIE  = Agent.indexOf('MSIE') > 0;
  Ver   = typeof(VInfo[1]) != 'ubdefined' ? VInfo[1].substr(6,3) : '';
  Win32 = Agent.indexOf('Windows') > 0 && Agent.indexOf('Mac') < 0 && Agent.indexOf('Windows CE') < 0;
  Opera = Agent.indexOf('Opera') > -1;*/

  alternativeEditors[objname] = new amiHTMLEditor(objname, ceOptions, true, 0, 0, modes);
}

staticJSTranslations = {
    'suggestionCloseLink' : '%%close_link%%'
};

editorTranslation = {
    'Switch' : "",
    'FormatNoFormat' : "%%tl_noformat%%",
    'FormatH1' : "%%tl_heading1%%",
    'FormatH2' : "%%tl_heading2%%",
    'FormatH3' : "%%tl_heading3%%",
    'FormatH4' : "%%tl_heading4%%",
    'FormatH5' : "%%tl_heading5%%",
    'FormatP' : "%%tl_paragraph%%",
    'FormatDiv' : "%%tl_div%%",
    'FormatPre' : "%%tl_pre%%",
    'FormatNoCSS' : "%%tl_nocss%%",
    'InlineStyle' : "%%tl_inlinestyle%%",
    'Bold' : "%%tl_bold%%",
    'Italic' : "%%tl_italic%%",
    'Underline' : "%%tl_underline%%",
    'StrikeThrough' : "%%tl_strike_through%%",
    'SubScript' : "%%tl_subscript%%",
    'SuperScript' : "%%tl_superscript%%",
    'RemoveFormat' : "%%tl_clear_format%%",
    'Spell' : "%%tl_spell%%",
    'PasteAsText' : "%%tl_paste_as_text%%",
    'PasteFromMSOffice' : "%%tl_paste_from_word%%",
    'PasteSpecial' : "%%tl_paste_special%%",
    'SetForeColor' : "%%tl_font_color%%",
    'SelectForeColor' : "%%tl_choose_font_color%%",
    'SetBackColor' : "%%tl_background_color%%",
    'SelectBackColor' : "%%tl_choose_back_color%%",
    'JustifyLeft' : "%%tl_align_left%%",
    'JustifyCenter' : "%%tl_align_center%%",
    'JustifyRight' : "%%tl_align_right%%",
    'JustifyFull' : "%%tl_align_justify%%",
    'InsertOrderedList' : "%%tl_ordered_list%%",
    'InsertUnorderedList' : "%%tl_bulleted_list%%",
    'Outdent' : "%%tl_decrease_indent%%",
    'Indent' : "%%tl_increase_indent%%",
    'Undo' : "%%tl_undo%%",
    'Redo' : "%%tl_redo%%",
    'InsertHorizontalRule' : "%%tl_horizontal_rule%%",
    'InsertPageBreak' : "%%tl_page_break%%",
    'CreateAnchor' : "%%tl_insert_anchor%%",
    'CreateLink' : "%%tl_insert_link%%",
    'UnLink' : "%%tl_delete_link%%",
    'InsertImage' : "%%tl_insert_image%%",
    'BackgroundImage' : "%%tl_background_image%%",
    'InsertSmiles' : "%%tl_insert_smile%%",
    'InsertSpecialChars' : "%%tl_insert_special_chars%%",
    'InsertGadget' : "%%tl_insert_gadget%%",
    'ShowSpecBlocks' : "%%tl_show_spec_blocks%%",
    'ApplyTemplate' : "%%tl_apply_template%%",
    'ShowTableBorders' : "%%tl_table_borders%%",
    'EditTable' : "%%tl_edit_table%%",
    'InsertTable' : "%%tl_insert_table%%",
    'TdAlignTop' : "%%tl_td_aligntop%%",
    'TdAlignMiddle' : "%%tl_td_alignmiddle%%",
    'TdAlignBottom' : "%%tl_td_alignbottom%%",
    'TdAlignLeft' : "%%tl_td_alignleft%%",
    'TdAlignCenter' : "%%tl_td_aligncenter%%",
    'TdAlignRight' : "%%tl_td_alignright%%",
    'InsertRow' : "%%tl_td_insertrow%%",
    'AddRow' : "%%tl_td_addrow%%",
    'DelRow' : "%%tl_td_delrow%%",
    'InsertCell' : "%%tl_td_insertcell%%",
    'DelCell' : "%%tl_td_delcell%%",
    'AddCol_L' : "%%tl_td_addcol_l%%",
    'AddCol_R' : "%%tl_td_addcol_r%%",
    'DelCol' : "%%tl_td_delcol%%",
    'ShowSearch' : "%%tl_show_search%%",
    'DelRowConfirm' : "%%row_delete_confirm%%",
    'DelCellConfirm' : "%%cell_delete_confirm%%",
    'DelColConfirm' : "%%col_delete_confirm%%",
    'Resize' : "%%tl_fullsize%%",
    'Quotes' : "%%tl_quotes%%",
    'NoPaste' : "%%no_paste%%",
    'SearchNotFound' : "%%not_found%%",
    'SearchNotFoundContinue' : "%%not_found%% %%search_continue_confirm%%",
    'ReplaceConfirm' : "%%replace_confirm%%",
    'ReplaceConfirm1' : "%%replace_all_confirm1%%",
    'ReplaceConfirm2' : "%%replace_all_confirm2%%",
    'ReplaceAllFinished' : "%%replace_all_finished%% ( %%replaced%%",
    'specblockOpenData': "%%specblock_open_data%%",
    'specblockOpenOptions': "%%specblock_open_options%%",
    'stripHtmlTags': "%%strip_html_tags%%",
    'modeEditor' : "%%mode_editor%%",
    'modeBB' : "%%mode_bb%%",
    'modeTextarea' : "%%mode_textarea%%",
    'syntaxHighlight' : "%%syntax_highlight%%",
    'wrapLines' : "%%wrap_lines%%",
    'bbCode' : "%%bb_code%%",
    'bbQuote' : "%%bb_quote%%"
};


//
// Table popup functions
//

tableTaName = null;
function edShowTableCreatePopup(textareaName, parentElement){
    edHideSmilesPopupClearTimer();
    tableTaName = textareaName;
    var content = ''
        +  '<table id='+textareaName+'_pd_it_grid cellspacing=1 cellpadding=0 border=1 style="border: 1px #c0c0c0 solid; background:#ffffff; cursor:pointer">'
          +  '<tr><td width=10 nowrap>&nbsp;</td><td  width=10 nowrap>&nbsp;</td><td  width=10 nowrap>&nbsp;</td><td  width=10 nowrap>&nbsp;</td><td  width=10 nowrap>&nbsp;</td><td  width=10 nowrap>&nbsp;</td><td  width=10 nowrap>&nbsp;</td><td  width=10 nowrap>&nbsp;</td><td  width=10 nowrap>&nbsp;</td><td  width=10 nowrap>&nbsp;</td><td  width=10 nowrap>&nbsp;</td><td  width=10 nowrap>&nbsp;</td></tr>'
          +  '<tr><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td></tr>'
          +  '<tr><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td></tr>'
          +  '<tr><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td></tr>'
          +  '<tr><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td></tr>'
          +  '<tr><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td></tr>'
          +  '<tr><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td></tr>'
          +  '<tr><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td></tr>'
          +  '<tr><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td></tr>'
          +  '<tr><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td></tr>'
          +  '<tr><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td></tr>'
          +  '<tr><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td><td nowrap>&nbsp;</td></tr>'
        +  '</table>'
        +  '<nobr><div align=center id='+textareaName+'_pd_it_st width=100%>&nbsp;</div></nobr>'
        ;

    var tableDiv = document.getElementById('htmlEditorTable' + textareaName);
    if(tableDiv == null){
        var handlerOver = function(){edHideTablePopupClearTimer()};
        var handlerOut = function(taName){return function(){edHideTablePopup(taName)}}(textareaName);

        amiCommon.setEventHandler('mouseover', parentElement, handlerOver);
        amiCommon.setEventHandler('mouseout', parentElement, handlerOut);

        tableDiv = document.createElement('div');
        tableDiv.id = 'htmlEditorTable' + textareaName;
        tableDiv.style.display = 'none';
        tableDiv.style.position = 'absolute';
        tableDiv.style.background = '#f0f0f0';
        var zIndex = 3;
        var shadows = AMI.find('.popupWindowShadow');
        if(shadows.length){
            zIndex = parseInt(shadows[0].style.zIndex) + 3;
        }
        tableDiv.style.zIndex = zIndex;
        tableDiv.style.border = '1px solid #0A246A';
        tableDiv.innerHTML =  content;
        tableDiv.onmouseover = handlerOver;
        tableDiv.onmousemove = onTablePopupMove;
        tableDiv.onclick = onTablePopupClick;
        tableDiv.onmouseout = handlerOut;
        document.body.appendChild(tableDiv);
    }

    if(tableDiv.style.display == 'block'){
        tableDiv.style.display = 'none';
    }else{
        var pos = AMI.$(parentElement).offset();
        var maxRight = getScrollLeft() + document.body.clientWidth;
        if(pos.left + 170 > maxRight){
            pos.left = maxRight - 170;
        }
        tableDiv.style.left = pos.left + 'px';
        tableDiv.style.top = pos.top + parentElement.offsetHeight + 'px';
        tableDiv.style.display = 'block';
    }
}

edHideTablePopupTimer = null;
function edHideTablePopup(textareaName, rightnow){
    if(typeof(rightnow) == "undefined" || !rightnow){
        edHideTablePopupTimer = setTimeout('edHideTablePopup("' + textareaName + '", 1)', 200);
    }else{
        var tableDiv = document.getElementById('htmlEditorTable' + textareaName);
        if(tableDiv != null){
            tableDiv.style.display = 'none';
        }
    }
}

function edHideTablePopupClearTimer(){
    clearTimeout(edHideTablePopupTimer);
}

function onTablePopupMove(evt){
  errFunc = onTablePopupMove;

  evt = amiCommon.getValidEvent(evt);
  var target = amiCommon.getEventTarget(evt);
  var popupTable = document.getElementById(tableTaName + '_pd_it_grid');
  var popupTableStatus = document.getElementById(tableTaName + '_pd_it_st');

  if (target.tagName == "TD"){
    var trEl = target.parentNode;
    var tdElements = popupTable.getElementsByTagName('TD');
    for (var i=0;i<tdElements.length;i++)
      tdElements[i].bgColor="";
    var cols = 0;

    while (target){
      target.bgColor = '#004080';
      target = target.previousSibling;
      cols++;
    }
    var rows = 1;
    trEl = trEl.previousSibling;
    while (trEl){
      target = trEl
      for (j=0; j<cols; j++)
        trEl.cells[j].bgColor="#004080";
      trEl = trEl.previousSibling;
      rows++;
    }
    popupTableStatus.cols = cols;
    popupTableStatus.rows = rows;
    popupTableStatus.innerHTML = cols + ' x ' + rows;
  }else if (target.tagName == "DIV"){
    var tdElements = popupTable.getElementsByTagName('TD');
    for (var i=0;i<tdElements.length;i++)
      tdElements[i].bgColor = '';
      popupTableStatus.innerHTML = '&nbsp;';
  }
}

function onTablePopupClick(evt){
    errFunc = onTablePopupClick;

    evt = amiCommon.getValidEvent(evt);
    var target = amiCommon.getEventTarget(evt);

    if(target.tagName.toUpperCase() == 'TD'){
        edHideTablePopup(tableTaName, 1);
        var textareaObject = document.getElementById(tableTaName);
        if(textareaObject.editorAttached && textareaObject.editorObject.currentMode == 'editor'){
            editorObject = textareaObject.editorObject;
            editorObject.insertTable(evt, parseInt(document.getElementById(tableTaName+"_pd_it_st").cols), parseInt(document.getElementById(tableTaName+"_pd_it_st").rows));
        }
    }
}

//
// Smiles popup functions
//

function edShowSmilesPopup(textareaName, parentElement){
    edHideSmilesPopupClearTimer();
    var content = ''
        + '<table cellspacing=0 cellpadding=0 border=0 style="width: 295px; border-top: 5px solid #ffffff; border-bottom: 5px solid #ffffff; background:#ffffff">'
        + '<tr>##smiles##</tr>'
        + ('##smiles_copyright##' != '' ? '<tr><td colspan="5">&nbsp;</td></tr><tr><td colspan="5" style="text-align: center; border-top: 1px #0A246A solid; margin-top: 5px">##smiles_copyright##</td></tr>' : '')
        + '</table>';

    var smilesDiv = document.getElementById('htmlEditorSmiles' + textareaName);
    if(smilesDiv == null){
        var handlerOver = function(){edHideSmilesPopupClearTimer()};
        var handlerOut = function(taName){return function(){edHideSmilesPopup(taName)}}(textareaName);

        amiCommon.setEventHandler('mouseout', parentElement, handlerOut);
        amiCommon.setEventHandler('mouseover', parentElement, handlerOver);

        smilesDiv = document.createElement('div');
        smilesDiv.id = 'htmlEditorSmiles' + textareaName;
        smilesDiv.style.display = 'none';
        smilesDiv.style.position = 'absolute';

        smilesDiv.style.background = '#f0f0f0';
        smilesDiv.style.border = '1px solid #0A246A';
        var zIndex = 3;
        var shadows = AMI.find('.popupWindowShadow');
        if(shadows.length){
            zIndex = parseInt(shadows[0].style.zIndex) + 3;
        }
		smilesDiv.style.zIndex = zIndex;
        smilesDiv.innerHTML =  content;
        smilesDiv.onmouseover = handlerOver;
        smilesDiv.onmouseout = handlerOut;
        document.body.appendChild(smilesDiv);
    }

    if(smilesDiv.style.display == 'block'){
        smilesDiv.style.display = 'none';
    }else{
        var pos = AMI.$(parentElement).offset();
        var maxRight = getScrollLeft() + document.body.clientWidth;
        if(pos.left + 297 > maxRight){
            pos.left = maxRight - 300;
        }
        smilesDiv.style.left = pos.left + 'px';
        smilesDiv.style.top = pos.top + parentElement.offsetHeight + 'px';
        smilesDiv.style.display = 'block';
    }
}

edHideSmilesPopupTimer = null;
function edHideSmilesPopup(textareaName, rightnow){
    if(typeof(rightnow) == "undefined" || !rightnow){
        edHideSmilesPopupTimer = setTimeout('edHideSmilesPopup("' + textareaName + '", 1)', 200);
    }else{
        var smilesDiv = document.getElementById('htmlEditorSmiles' + textareaName);
        if(smilesDiv != null){
            smilesDiv.style.display = 'none';
        }
    }
}

function edHideSmilesPopupClearTimer(){
    clearTimeout(edHideSmilesPopupTimer);
}

function edShowSmilesPopupClick(evt, textareaName, smilePath, smileCaption){
    errFunc = edShowSmilesPopupClick;

    edHideSmilesPopup(textareaName, 1);

    var textareaObject = document.getElementById(textareaName);
    if(textareaObject.editorAttached && textareaObject.editorObject.currentMode == 'editor'){
        editorObject = textareaObject.editorObject;
        editorObject.setEditorSelection(editorObject.sessionData.rng);
        editorObject.insertContent('<img src="'+smilePath+'"' + (smileCaption != '' ? ' title="'+smileCaption+'"' : '') + '>');
        editorObject.formChanged(evt);
        editorObject.updateToolBar();
    }
    if(textareaObject.editorAttached && textareaObject.editorObject.currentMode == 'bb'){
        editorObject = textareaObject.editorObject;
        // editorObject.setEditorSelection(editorObject.sessionData.rng);
        editorObject.txtEd.procAction('smile_by_caption', smileCaption);
        editorObject.formChanged(evt);
        editorObject.updateToolBar();
    }
}

<!--#set var="smile_field" value="<td width="55" align="center"><img src="##root_path####smile_path##" title="##smile_caption##" style="cursor: pointer" onClick="edShowSmilesPopupClick(event, \''+textareaName+'\', \'##smile_path##\', \'##smile_caption2##\');"></td>"-->
<!--#set var="smile_field_splitter" value="</tr><tr>"-->


//
// Characters popup functions
//

var specialChars = new Array(

['&nbsp;',	'&#160;',	'%%sc_nobreak_space%%',	'00A0'],
['@',		'&#64;',	'%%sc_commercial_at%%',	'0040'],

// Тире, кавычки
['&hellip;',	'&#8230;',	'%%sc_horisontal_ellipsis%%',	'2026'],
['&ndash;',	'&#8211;',	'%%sc_en_dash%%',	'2013'],
['&mdash;',	'&#8212;',	'%%sc_em_dash%%',	'2014'],
['&lsquo;',	'&#8216;',	'%%sc_left_single_quotation_mark%%',	'2018'],
['&rsquo;',	'&#8217;',	'%%sc_right_single_quotation_mark%%',	'2019'],
['&sbquo;',	'&#8218;',	'%%sc_single_low_quotation_mark%%',	'201A'],
['&ldquo;',	'&#8220;',	'%%sc_left_double_quotation_mark%%',	'201C'],
['&rdquo;',	'&#8221;',	'%%sc_right_double_quotation_mark%%',	'201D'],
['&bdquo;',	'&#8222;',	'%%sc_double_low_quotation_mark%%',	'201E'],
['&laquo;',	'&#171;',	'%%sc_left_pointing_double_angle_quotation_mark%%',	'00AB'],
['&raquo;',	'&#187;',	'%%sc_right_pointing_double_angle_quotation_mark%%',	'00BB'],

['&sect;',	'&#167;',	'%%sc_section_sign%%',	'00A7'],
['&para;',	'&#182;',	'%%sc_pilcrow_sign%%',	'00B6'],
['&middot;',	'&#183;',	'%%sc_middle_dot%%',	'00B7'],
['&cedil;',	'&#184;',	'%%sc_cedilla%%',	'00B8'],

['&iexcl;',	'&#161;',	'%%sc_inverted_exclamation_mark%%',	'00A1'],
['&iquest;',	'&#191;',	'%%sc_inverted_question_mark%%',	'00BF'],


// Знаки копирайта и пр.
['&copy;',	'&#169;',	'%%sc_copyright_sign%%',	'00A9'],
['&reg;',		'&#174;',	'%%sc_registered_sign%%',	'00AE'],
['&trade;',	'&#8482;',	'%%sc_trade_mark_sign%%',	'2122'],

['&deg;',		'&#176;',	'%%sc_degree_sign%%',	'00B0'],
['&plusmn;',	'&#177;',	'%%sc_plusminus_sign%%',	'00B1'],

// Денежные единицы
['&cent;',	'&#162;',	'%%sc_cent_sign%%',	'00A2'],
['&euro;',	'&#8364;',	'%%sc_euro_sign%%',	'20AC'],
['&pound;',	'&#163;',	'%%sc_pound_sign%%',	'00A3'],
['&yen;',		'&#165;',	'%%sc_yen_sign%%',	'00A5'],
['&curren;',	'&#164;',	'%%sc_currency_sign%%',	'00A4'],

// Арифметические и логические знаки
['&not;',	'&#172;',	'%%sc_not_sign%%',	'00AC'],
['&brvbar;',	'&#166;',	'%%sc_broken_bar%%',	'00A6'],
['&macr;',	'&#175;',	'%%sc_macron%%',	'00AF'],
['&times;',	'&#215;',	'%%sc_multiplication_sign%%',	'00D7'],
['&divide;',	'&#247;',	'%%sc_division_sign%%',	'00F7'],
['&acute;',	'&#180;',	'%%sc_combining_acute_accent%%',	'0301'],
['&fnof;',	'&#402;',	'%%sc_latin_small_letter_f_with_hook%%',	'0192'],
['&micro;',	'&#181;',	'%%sc_micro_sign%%',	'00B5'],

// Индексы
['&sup1;',	'&#185;',	'%%sc_superscript_one%%',	'00B9'],
['&sup2;',	'&#178;',	'%%sc_superscript_two%%',	'00B2'],
['&sup3;',	'&#179;',	'%%sc_superscript_three%%',	'00B3'],

// Дроби
['&frac14;',	'&#188;',	'%%sc_vulgar_fraction_one_quarter%%',	'00BC'],
['&frac12;',	'&#189;',	'%%sc_vulgar_fraction_half%%',	'00BD'],
['&frac34;',	'&#190;',	'%%sc_vulgar_fraction_three_quarters%%',	'00BE'],
['',	'',	'%%sc_vulgar_fraction_one_third%%',	'2153'],
['',	'',	'%%sc_vulgar_fraction_two_thirds%%',	'2154'],
['',	'',	'%%sc_vulgar_fraction_one_fifth%%',	'2155'],
['',	'',	'%%sc_vulgar_fraction_two_fifths%%',	'2156'],
['',	'',	'%%sc_vulgar_fraction_three_fifths%%',	'2157'],
['',	'',	'%%sc_vulgar_fraction_four_fifths%%',	'2158'],
['',	'',	'%%sc_vulgar_fraction_one_sixth%%',	'2159'],
['',	'',	'%%sc_vulgar_fraction_five_sixths%%',	'215A'],
['',	'',	'%%sc_vulgar_fraction_one_eighth%%',	'215B'],
['',	'',	'%%sc_vulgar_fraction_three_eighths%%',	'215C'],
['',	'',	'%%sc_vulgar_fraction_five_eighths%%',	'215D'],
['',	'',	'%%sc_vulgar_fraction_seven_eighths%%',	'215E'],

['&asymp;',	'&#8776;',	'%%sc_almost_equal_to%%',	'2248'],
['&equiv;',	'&#8801;',	'%%sc_identical_to%%',	'2261'],
['&ne;',	'&#8800;',	'%%sc_not_equal_to%%',	'2260'],


['&prime;',	'&#8242;',	'%%sc_prime%%',	'2032'],
['&Prime;',	'&#8243;',	'%%sc_double_prime%%',	'2033'],
['&oline;',	'&#8254;',	'%%sc_overline%%',	'203E'],
['&frasl;',	'&#8260;',	'%%sc_fraction_slash%%',	'2044'],
['&infin;',	'&#8734;',	'%%sc_infinity%%',	'221E'],

// Стрелки
['&larr;',	'&#8592;',	'%%sc_leftwards_arrow%%',	'2190'],
['&uarr;',	'&#8593;',	'%%sc_upwards_arrow%%',	'2191'],
['&rarr;',	'&#8594;',	'%%sc_rightwards_arrow%%',	'2192'],
['&darr;',	'&#8595;',	'%%sc_downwards_arrow%%',		'2193'],
['&harr;',	'&#8596;',	'%%sc_left_right_arrow%%',	'2194'],
['&crarr;',	'&#8629;',	'%%sc_downwards_arrow_with_corner_leftwards%%',	'21B5'],
['&lArr;',	'&#8656;',	'%%sc_leftwards_double_arrow%%',	'21D0'],
['&uArr;',	'&#8657;',	'%%sc_upwards_double_arrow%%',	'21D1'],
['&rArr;',	'&#8658;',	'%%sc_rightwards_double_arrow%%',	'21D2'],
['&dArr;',	'&#8659;',	'%%sc_downwards_double_arrow%%',	'21D3'],
['&hArr;',	'&#8660;',	'%%sc_left_right_double_arrow%%',	'21D4'],
['',	'&#9668;',	'%%sc_black_left_pointing_pointer%%',	'25C4'],
['',	'&#9650;',	'%%sc_black_up_pointing_pointer%%',	'25B2'],
['',	'&#9658;',	'%%sc_black_right_pointing_pointer%%',	'25BA'],
['',	'&#9660;',	'%%sc_black_down_pointing_pointer%%',	'25BC'],

// Масти
['&spades;',	'&#9824;',	'%%sc_black_spade_suit%%',	'2660'],
['&clubs;',	'&#9827;',	'%%sc_black_club_suit%%',	'2663'],
['&hearts;',	'&#9829;',	'%%sc_black_heart_suit%%',	'2665'],
['&diams;',	'&#9830;',	'%%sc_black_diamond_suit%%',	'2666'],

['&circ;',	'&#710;',	'%%sc_modifier_letter_circumflex_accent%%',	'02C6'],
['&tilde;',	'&#732;',	'%%sc_small_tilde%%',	'02DC'],

['&bull;',	'&#8226;',	'%%sc_bullet%%',	'2022'],
['',	'',	'%%sc_triangular_bullet%%',	'2023'],
['',	'',	'%%sc_black_small_square%%',	'25AA'],
['',	'',	'%%sc_white_small_square%%',	'25AB'],
['',	'',	'%%sc_black_diamond%%',	'25C6'],
['',	'',	'%%sc_white_diamond%%',	'25C7'],
['',	'',	'%%sc_white_diamond_containing_black_small_diamond%%',	'25C8'],
['',	'',	'%%sc_fisheye%%',	'25C9'],
['',	'',	'%%sc_white_circle%%',	'25CB'],
['',	'',	'%%sc_black_circle%%',	'25CF'],
['',	'',	'%%sc_black_parallelogram%%',	'25B0'],
['',	'',	'%%sc_white_parallelogram%%',	'25B1'],
['',	'',	'%%sc_black_small_triangle%%',	'25B4'],
['',	'',	'%%sc_black_small_triangle%%',	'25B5'],
['',	'',	'%%sc_black_small_triangle%%',	'25B8'],
['',	'',	'%%sc_black_small_triangle%%',	'25B9'],
['',	'',	'%%sc_black_small_triangle%%',	'25BE'],
['',	'',	'%%sc_black_small_triangle%%',	'25BF'],
['',	'',	'%%sc_black_small_triangle%%',	'25C2'],
['',	'',	'%%sc_black_small_triangle%%',	'25C3'],




// Римские цифры
['',	'',	'%%sc_roman_numeral_one%%',	'2160'],
['',	'',	'%%sc_roman_numeral_two%%',	'2161'],
['',	'',	'%%sc_roman_numeral_three%%',	'2162'],
['',	'',	'%%sc_roman_numeral_four%%',	'2163'],
['',	'',	'%%sc_roman_numeral_five%%',	'2164'],
['',	'',	'%%sc_roman_numeral_six%%',	'2165'],
['',	'',	'%%sc_roman_numeral_seven%%',	'2166'],
['',	'',	'%%sc_roman_numeral_eight%%',	'2167'],
['',	'',	'%%sc_roman_numeral_nine%%',	'2168'],
['',	'',	'%%sc_roman_numeral_ten%%',	'2169'],
['',	'',	'%%sc_roman_numeral_eleven%%',	'216A'],
['',	'',	'%%sc_roman_numeral_twelve%%',	'216B'],
['',	'',	'%%sc_roman_numeral_fifty%%',	'216C'],
['',	'',	'%%sc_roman_numeral_one_hundred%%',	'216D'],
['',	'',	'%%sc_roman_numeral_five_hundred%%',	'216E'],
['',	'',	'%%sc_roman_numeral_one_thousand%%',	'216F'],

// Греческие буквы
['&Alpha;',	'&#913;',	'%%sc_greek_capital_letter_alpha%%',	'0391'],
['&Beta;',	'&#914;',	'%%sc_greek_capital_letter_beta%%',	'0392'],
['&Gamma;',	'&#915;',	'%%sc_greek_capital_letter_gamma%%',	'0393'],
['&Delta;',	'&#916;',	'%%sc_greek_capital_letter_delta%%',	'0394'],
['&Epsilon;',	'&#917;',	'%%sc_greek_capital_letter_epsilon%%',	'0395'],
['&Zeta;',	'&#918;',	'%%sc_greek_capital_letter_zeta%%',	'0396'],
['&Eta;',	'&#919;',	'%%sc_greek_capital_letter_eta%%',	'0397'],
['&Theta;',	'&#920;',	'%%sc_greek_capital_letter_theta%%',	'0398'],
['&Iota;',	'&#921;',	'%%sc_greek_capital_letter_iota%%',	'0399'],
['&Kappa;',	'&#922;',	'%%sc_greek_capital_letter_kappa%%',	'039A'],
['&Lambda;',	'&#923;',	'%%sc_greek_capital_letter_lambda%%',	'039B'],
['&Mu;',	'&#924;',	'%%sc_greek_capital_letter_mu%%',	'039C'],
['&Nu;',	'&#925;',	'%%sc_greek_capital_letter_nu%%',	'039D'],
['&Xi;',	'&#926;',	'%%sc_greek_capital_letter_xi%%',	'039E'],
['&Omicron;',	'&#927;',	'%%sc_greek_capital_letter_omicron%%',	'039F'],
['&Pi;',	'&#928;',	'%%sc_greek_capital_letter_pi%%',	'03A0'],
['&Rho;',	'&#929;',	'%%sc_greek_capital_letter_rho%%',	'03A1'],
['&Sigma;',	'&#931;',	'%%sc_greek_capital_letter_sigma%%',	'03A3'],
['&Tau;',	'&#932;',	'%%sc_greek_capital_letter_tau%%',	'03A4'],
['&Upsilon;',	'&#933;',	'%%sc_greek_capital_letter_upsilon%%',	'03A5'],
['&Phi;',	'&#934;',	'%%sc_greek_capital_letter_phi%%',	'03A6'],
['&Chi;',	'&#935;',	'%%sc_greek_capital_letter_chi%%',	'03A7'],
['&Psi;',	'&#936;',	'%%sc_greek_capital_letter_psi%%',	'03A8'],
['&Omega;',	'&#937;',	'%%sc_greek_capital_letter_omega%%',	'03A9'],

['&alpha;',	'&#945;',	'%%sc_greek_small_letter_alpha%%',	'03B1'],
['&beta;',	'&#946;',	'%%sc_greek_small_letter_beta%%',	'03B2'],
['&gamma;',	'&#947;',	'%%sc_greek_small_letter_gamma%%',	'03B3'],
['&delta;',	'&#948;',	'%%sc_greek_small_letter_delta%%',	'03B4'],
['&epsilon;',	'&#949;',	'%%sc_greek_small_letter_epsilon%%',	'03B5'],
['&zeta;',	'&#950;',	'%%sc_greek_small_letter_zeta%%',	'03B6'],
['&eta;',	'&#951;',	'%%sc_greek_small_letter_eta%%',	'03B7'],
['&theta;',	'&#952;',	'%%sc_greek_small_letter_theta%%',	'03B8'],
['&iota;',	'&#953;',	'%%sc_greek_small_letter_iota%%',	'03B9'],
['&kappa;',	'&#954;',	'%%sc_greek_small_letter_kappa%%',	'03BA'],
['&lambda;',	'&#955;',	'%%sc_greek_small_letter_lambda%%',	'03BB'],
['&mu;',	'&#956;',	'%%sc_greek_small_letter_mu%%',	'03BC'],
['&nu;',	'&#957;',	'%%sc_greek_small_letter_nu%%',	'03BD'],
['&xi;',	'&#958;',	'%%sc_greek_small_letter_xi%%',	'03BE'],
['&omicron;',	'&#959;',	'%%sc_greek_small_letter_omicron%%',	'03BF'],
['&pi;',	'&#960;',	'%%sc_greek_small_letter_pi%%',	'03C0'],
['&rho;',	'&#961;',	'%%sc_greek_small_letter_rho%%',	'03C1'],
['&sigma;',	'&#963;',	'%%sc_greek_small_letter_sigma%%',	'03C3'],
['&tau;',	'&#964;',	'%%sc_greek_small_letter_tau%%',	'03C4'],
['&upsilon;',	'&#965;',	'%%sc_greek_small_letter_upsilon%%',	'03C5'],
['&phi;',	'&#966;',	'%%sc_greek_small_letter_phi%%',	'03C6'],
['&chi;',	'&#967;',	'%%sc_greek_small_letter_chi%%',	'03C7'],
['&psi;',	'&#968;',	'%%sc_greek_small_letter_psi%%',	'03C8'],
['&omega;',	'&#969;',	'%%sc_greek_small_letter_omega%%',	'03C9']
);

var oldFont = 'Arial';
var fontName = '';

function setNewSpecialCharsFont(textareaName){
    return;
    var charactersDiv = document.getElementById('htmlEditorSpecialChars' + textareaName);
    var cells = charactersDiv.getElementsByTagName('td');
    for(i = 0; i < cells.length; i++) {
        cells[i].style.fontFamily = fontName;
    }
}


function edShowSpecialCharsPopup(textareaName, parentElement){
    edHideSpecialCharsPopupClearTimer();

	if(fontName == '') {
		fontName = 'Arial';
	}

    var content = '<table cellspacing=2 cellpadding=2 border=0 style="width: 490px; border-top: 5px solid #ffffff; border-bottom: 5px solid #ffffff; background:#ffffff; table-layout: fixed; font-family: ' + fontName + ';"><colgroup width=20 span=20></colgroup><col width=50>';
    content += '<tr style="display:none;"><td colspan="21" id="htmlEditorSpecialCharsFontTitle' + textareaName + '">&nbsp;</td></tr>';
    content += '<tr><td colspan="20" id="htmlEditorSpecialCharsTitle' + textareaName + '" style="font-size: 10px;">&nbsp;</td>';
    content += '<td rowspan="' + (Math.ceil(specialChars.length/20)+1) + '"><span id="htmlEditorSpecialCharsPreview' + textareaName + '" align="center" style="font-size: 30pt; height: 100%; border: 1px solid #000; vertical-align: middle; text-align: center; display: block; width: 33pt; height: 38pt;"></span> </td></tr>';
    content += '<tr>';
    for(i = 0; i < specialChars.length; i++) {
    	var t = specialChars[i];
    	var characterCode = t[3];
    	characterCode = edShowSpecialCharsHack(characterCode);

    	content += '<td style="text-align: center; border: 1px solid #fff; cursor: pointer;" title="' + t[2] +'" onmouseover=" this.style.border=\'1px solid #999\'; edShowSpecialCharsPopupHover(event, \''+textareaName+'\', \'' + t[3] +'\', \'' + t[2] +'\');" onmouseout="this.style.border=\'1px solid #fff\'; " onclick="edShowSpecialCharsPopupClick(event, \''+textareaName+'\', \'' + t[3] +'\');">';

//    	content += '<td  style="cursor: pointer" onmouseover="edShowSpecialCharsPopupHover(event, \''+textareaName+'\', \'' + t[3] +'\', \'' + t[2] +'\');" onclick="edShowSpecialCharsPopupClick(event, \''+textareaName+'\', \'' + t[3] +'\');">';
    	content += eval('"\\u' + characterCode + '"') + '</td>';
    	if ((i+1) % 20 == 0) {
    		content += '</tr><tr>';
    	}
    }
    content += '</tr></table>';

    var charactersDiv = document.getElementById('htmlEditorSpecialChars' + textareaName);
    if(charactersDiv == null){
        var handlerOver = function(){edHideSpecialCharsPopupClearTimer()};
        var handlerOut = function(taName){return function(){edHideSpecialCharsPopup(taName)}}(textareaName);

        amiCommon.setEventHandler('mouseout', parentElement, handlerOut);
        amiCommon.setEventHandler('mouseover', parentElement, handlerOver);

        charactersDiv = document.createElement('div');
        charactersDiv.id = 'htmlEditorSpecialChars' + textareaName;
        charactersDiv.style.display = 'none';
        charactersDiv.style.position = 'absolute';
        charactersDiv.style.background = '#f0f0f0';
        var zIndex = 3;
        var shadows = AMI.find('.popupWindowShadow');
        if(shadows.length){
            zIndex = parseInt(shadows[0].style.zIndex) + 3;
        }        
		charactersDiv.style.zIndex = zIndex;
        charactersDiv.style.border = '1px solid #0A246A';
        charactersDiv.innerHTML =  content;
        charactersDiv.onmouseover = handlerOver;
        charactersDiv.onmouseout = handlerOut;
        document.body.appendChild(charactersDiv);
    } else {
	    edShowSpecialCharsPopupHover('', textareaName, '0020', '&nbsp;');
    }

    if(charactersDiv.style.display == 'block'){
        charactersDiv.style.display = 'none';
    }else{
        var pos = AMI.$(parentElement).offset();
        var maxRight = getScrollLeft() + document.body.clientWidth;
        if(pos.left + 540 > maxRight){
            pos.left = maxRight - 550;
        }
        charactersDiv.style.left = pos.left + 'px';
        charactersDiv.style.top = pos.top + parentElement.offsetHeight + 'px';
        charactersDiv.style.display = 'block';
    }
}

// Замена символов при визуализации
function edShowSpecialCharsHack(chr) {
	var r = '';
	switch(chr) {
		case '00A0':
			// Исключение для неразрывного пробела (визуализация)
			r = '2423';
			break;
		case '0301':
			// Исключение для ударения
			r = '00B4';
			break;
		default:
			r = chr;
	}
	return r;
}

edHideSpecialCharsPopupTimer = null;
function edHideSpecialCharsPopup(textareaName, rightnow){
    if(typeof(rightnow) == "undefined" || !rightnow){
        edHideSpecialCharsPopupTimer = setTimeout('edHideSpecialCharsPopup("' + textareaName + '", 1)', 200);
    }else{
        var charactersDiv = document.getElementById('htmlEditorSpecialChars' + textareaName);
        if(charactersDiv != null){
            charactersDiv.style.display = 'none';
        }
    }
}

function edHideSpecialCharsPopupClearTimer(){
    clearTimeout(edHideSpecialCharsPopupTimer);
}

function edShowSpecialCharsPopupHover(evt, textareaName, characterCode, characterTitle){
	var preview = document.getElementById('htmlEditorSpecialCharsPreview' + textareaName);
	var title = document.getElementById('htmlEditorSpecialCharsTitle' + textareaName);
	title.innerHTML = characterTitle;
	characterCode = edShowSpecialCharsHack(characterCode);
	preview.innerHTML = eval('"\\u' + characterCode + '"');
}

function edShowSpecialCharsPopupClick(evt, textareaName, characterCode){
    errFunc = edShowSpecialCharsPopupClick;

    edHideSpecialCharsPopup(textareaName, 1);

    var textareaObject = document.getElementById(textareaName);
    if(textareaObject.editorAttached && textareaObject.editorObject.currentMode == 'editor'){
        editorObject = textareaObject.editorObject;
        editorObject.setEditorSelection(editorObject.sessionData.rng);
        editorObject.insertContent(eval('"\\u' + characterCode + '"'));
        editorObject.formChanged(evt);
        editorObject.updateToolBar();
    }
    if(textareaObject.editorAttached && textareaObject.editorObject.currentMode == 'bb'){
        editorObject = textareaObject.editorObject;
        editorObject.txtEd._replaceSelection(eval('"\\u' + characterCode + '"'), 0, 0, true);
        editorObject.formChanged(evt);
        editorObject.updateToolBar();
    }
}


//
// Search bar functions
//

function getSearchBarHTML(objname){
    var result = '<table cellspacing=0 cellpadding=0 border=0>'
      +  '<tr>'
      +  '</td><td align=left valign=middle height=16 style="border-right: 1px #c0c0c0 solid">'
      +  '<nobr><input class=check type=checkbox name=_spec_opt_' +objname+ '_search_word_whole id=_spec_opt_' +objname+ '_search_word_whole value=""  tabindex="-1">&nbsp;'
      +  '%%tl_word_whole%%<nobr>'
      +  '</td><td valign=middle align=left nowrap>&nbsp;%%find%%:'
      +  '</td><td valign=middle align=left>'
      +  '<input class=field style="background:#ffffff;border:1px #c0c0c0 solid;width:200px;" type=text name=_spec_opt_' +objname+ '_search_value id=_spec_opt_' +objname+ '_search_text_value value="" onkeypress="if (event.keyCode == 13 ) { amiCommon.stopEvent(event); if (this.value.length>0) editorSearchAction(event, \'search\', \'' + objname + '\');}">&nbsp;'
      +  '</td><td valign=middle align=left>'
      +  '<button doNotDisable=true title="%%tl_search%%" id="_' +objname+ '_Search" class="simpleButtonHTMLEditor" type="button" onclick="if (document.getElementById(\'_spec_opt_' +objname+ '_search_text_value\').value.length>0) editorSearchAction(event, \'search\', \'' + objname + '\')"  tabindex="-1" style="background: url(' +imgURL+ 'ed_search_continue.gif) 50% 50% no-repeat transparent; height:20px;  width: 25px;"></button>'
      +  '</td></tr>'
      +  '<tr>'
      +  '</td><td align=left valign=middle height=16 style="border-right: 1px #c0c0c0 solid" width=140>'
      +  '<nobr><input class=check type=checkbox name=_spec_opt_' +objname+ '_search_case_sensitive id=_spec_opt_' +objname+ '_search_case_sensitive value=""  tabindex="-1">&nbsp;'
      +  '%%tl_case_sensitive%%<nobr>'
      +  '</td><td valign=middle align=left nowrap>&nbsp;%%replace_with%%:'
      +  '</td><td valign=middle align=left>'
      +  '<input class=field style="background:#ffffff;border:1px #c0c0c0 solid;width:200px;" type=text name=_spec_opt_' +objname+ '_replace_value id=_spec_opt_' +objname+ '_replace_text_value value="" onkeypress="if (event.keyCode == 13 ) { amiCommon.stopEvent(event); if (document.getElementById(\'_spec_opt_' +objname+ '_search_text_value\').value.length>0) editorSearchAction(event, \'replace\', \'' + objname + '\');}">&nbsp;'
      +  '</td><td valign=middle align=left>'
      +  '<button doNotDisable=true title="%%tl_replace%%" id="_' +objname+ '_Replace" class="simpleButtonHTMLEditor"  onclick="if (document.getElementById(\'_spec_opt_' +objname+ '_search_text_value\').value.length>0) editorSearchAction(event, \'replace\', \'' + objname + '\')" tabindex="-1"  style="background: url(' +imgURL+ 'ed_replace.gif) 50% 50% no-repeat transparent; height:20px;  width: 25px;"></button>&nbsp;'
      +  '<button doNotDisable=true title="%%tl_replace_all%%" id="_' +objname+ '_ReplaceAll" class="simpleButtonHTMLEditor"  onclick="if (document.getElementById(\'_spec_opt_' +objname+ '_search_text_value\').value.length>0) editorSearchAction(event, \'replaceall\', \'' + objname + '\')" tabindex="-1" style="background: url(' +imgURL+ 'ed_replace_all.gif) 50% 50% no-repeat transparent; height:20px;  width: 25px;"></button>&nbsp;'
      +  '</td></tr>'
    +  '</table>';

    return result;
}


function editorSearchAction(evt, actionType, taName){
    amiCommon.stopEvent(evt);
    var taObject = document.getElementById(taName);
    var isCase = document.getElementsByName("_spec_opt_" + taName + "_search_case_sensitive")[0];
    var isWhole = document.getElementsByName("_spec_opt_" + taName + "_search_word_whole")[0];
    var sSearch = document.getElementsByName("_spec_opt_" + taName + "_search_value")[0];
    var sReplace = document.getElementsByName("_spec_opt_" + taName + "_replace_value")[0];
    taObject.editorObject.actionSearchReplace(actionType, isCase.checked, isWhole.checked, sSearch.value, sReplace.value);
}


/* From ce_act.tpl */

function edShowSpecblocksPopup(textareaName, isEditorMode, editorSelectedObject, dataType){
    if(isEditorMode){
        if(editorSelectedObject != null && ##options_installed##){
            var oForm = document.forms[_cms_document_form];
            var pageName = oForm.elements['name'].value;
            var specCaption = editorSelectedObject.getAttribute('title');
                specCaption = specCaption ? specCaption : '';
            var specBlockNum = editorSelectedObject.getAttribute('spec_num');
                specBlockNum = specBlockNum ? specBlockNum : '';
            var specBlockName = editorSelectedObject.id;
            var moduleName = '';
            var specGroup = '';
            var dataLink = '';
            var bHasOptions = false;
            if(specBlockName == 'spec_module_body'){
                moduleName = oForm.elements['module_name'].value;
                specCaption = specCaption + ' ' + oForm.elements['module_name'].options[oForm.elements['module_name'].selectedIndex].text;
                dataLink = typeof(window.moduleAdminLink) != 'undefined' ? window.moduleAdminLink : '';
                bHasOptions = typeof(window.moduleHasOptions) != 'undefined' && window.moduleHasOptions == '1';
            }else{
                for(var i=0; i<SpecBlocks.length; i++){
                    if(SpecBlocks[i]['name'] == specBlockName){
                        moduleName = SpecBlocks[i]['module'];
                        specGroup = SpecBlocks[i]['group'];
                        dataLink = SpecBlocks[i]['link'];
                        if(dataLink.match(/^(plugin_|engine\.php)/i)){
                            dataLink = '';
                        }
                        bHasOptions = SpecBlocks[i]['hasOptions'] == '1' && SpecBlocks[i]['group'] != 'common';;
                        break;
                    }
                }
            }
            var pageId = oForm.elements['id'].value;
            var block_protected = false;

            if (specBlockName == 'spec_module_body' && oForm.elements['module_name'].value != oForm.elements['module_name'].oldValue){
                alert('%%page_type_changed%%');
            }else if (dataType != 'options' && dataLink == ''){
                alert('%%no_spec_data%%');
            }else if (dataType == 'options' && (!bHasOptions || editorSelectedObject.className == "spec_custom")){
                alert('%%no_spec_options%%');
            }else{
                if(_cms_selected_layout_block == 'lay_body'){
                    var sTitle = specCaption + "' %%for_page%% '" + pageName;
                }else{
                    var sTitle = specCaption + "' %%in_block%% '" + _cms_selected_layout_block_name;
                    block_protected = oForm.elements[_cms_selected_layout_block + "_body_protected"].value;
                }

                var openLink = '';
                var openTitle = '';
                if(dataType != 'options'){
                    openLink = dataLink + (dataLink.indexOf('?') >= 0 ? '&' : '?') + 'flt_module_body_only=1' + (specBlockName == 'spec_module_body' ? '&flt_id_page=' + pageId : '');
                    openTitle = "%%spec_block_data%% '" + sTitle + "'";
                }else if(dataType == 'options'){
                    openLink = 'srv_options.php?_cv='+cms_version+'&flt_container_name=pages&flt_item_id='+pageId+'&flt_module_name='+moduleName+'&flt_spec_block='+specBlockName+'&flt_spec_num='+specBlockNum+'&lang=##admin_lang##&flt_layout_block='+_cms_selected_layout_block+"&flt_layout_block_protected="+block_protected+'&_mt='+window.treeframe.page_mt+'&_rv='+top.rights_version+'&_mtloc='+top._mtloc;
                    openTitle = "%%spec_block_options%% '" + sTitle + "'";
                }

                if(openLink != ''){
                    openDialog(openTitle, openLink, -10, -10);
                }
            }
        }else{
            if (typeof(rights_version)=="undefined"){
                rights_version = 0;
            }
            openDialog("%%spec_blocks%%", 'ce_specblocks.php?_cv='+cms_version+'&obj='+textareaName+'&lang=##admin_lang##&ml=##allow_multi_lang##&rv='+rights_version);
        }
    }
}

function edShowApplyTemplatePopup(textareaName, isEditorMode){
    if(isEditorMode){
        openDialog("%%templates%%", 'ce_templates.php?obj=' + textareaName + '&lang=##admin_lang##');
    }
}

function edShowImagePopup(textareaName, isEditorMode, editorSelectedObject){
    if(editorSelectedObject == null || editorSelectedObject.tagName.toLowerCase() == 'img' && editorSelectedObject.id.substr(0,5) != 'spec_' || editorSelectedObject.tagName.toLowerCase() == 'object'){
        openDialog('%%img_properties%%', 'ce_img_proc.php?obj=' + textareaName + '&cat=' + top.module_name + '&lang=##admin_lang##');
    }
}
// ================>
function edShowGadgetSelectPopup(textareaName, isEditorMode, editorSelectedObject) {

    // Adding jQuery to make code more readable;
    var sContent = '<div style="padding:10px">';
        sContent += '<script src="skins/vanilla/_js/ami.jquery.js" type="text/javascript"></script>';
        sContent += '<script src="skins/vanilla/_js/ami.gadgets.popup.js" type="text/javascript"></script>';

    width = Math.min(800, window.document.body.offsetWidth-40);
    height = Math.min(555, window.document.body.offsetHeight-40);

    // Generating content
    var prevType = '';
    var typesCounter = 0;
    var rowCounter = 1; // need to count how many gadgets will be at the row
    for(var gname in aGadgets) {

    // To find meaning of the gadget array keys look at the _admin\includes\editor_js.php:
    // 0 - real name of the file
    // 1 - name from lang file
    // 2 -  type of the gadget
    // 3 - template the data from GadgetName.tpl file
    // 4 - template the data from GadgetName_parameters.tpl
    // 5 - path to image
    // 6 -  type name from the lang file  gadgets.lng (do this gadget is a system, or user's one)
    // 7 -  Author of the gadjet
    // 8 -  url
    // 9 -  description
    // 10 - the autor label like (Author:)
    // 11 - insert gadget label like (Insert gadget:)

        var gadget = aGadgets[gname];


        if(prevType != gadget[2]) {
            if(typesCounter != 0) {
                sContent += '</fieldset>';
                rowCounter=1;
            }
            sContent += '<fieldset style="margin-bottom: 20px;">'
                + '<legend style="margin-left: 10px; color: #000"><b>' + gadget[6] + '</b></legend>';
            //sContent += '<div style="visibility: hidden;"><br>forIE</div>'; // only for IE, and even this dose not forse IE to make padding after fieldset
            typesCounter++;
            prevType = gadget[2];
        }

        sContent +='<div class="one_gadget one_gadget_mouseout" style="margin:10px; width: 330px;  float: left;  display: inline-block;">';
        // Adding table
        sContent +='<table border="0" cellpadding="0" cellspacing="0"><tr><td valign="middle">';

        sContent +='<div class="left_part_gadget">';


                sContent += '<a href="javascript:"   onClick="top.edShowGadgetFormPopup(\'' + gname + '\', \'' + textareaName + '\'); return false;">';

                //  1 - name from lang file
                //sContent += gadget[1];


                // Check do we have an image for this gadget
                if(gadget[5] != ""){
                    sContent += '<img  class="ui_gadget gadget_title_image img_opacity_yes"'+
                    'style="width: 140px; height: 100px; border:1px solid white;margin: 5px 5px 0px 5px; padding:5px 5px 0px 5px;"'+
                    'src="' + gadget[5] + '" border="0" alt="' + gadget[1] + '">';
                }
                else{
                    sContent +="<div style='width: 140px; height: 100px;";
                    sContent +="width: 140px; height: 100px; border:1px solid white; margin: 5px 5px 0px 5px; padding:5px 5px 0px 5px;";
                    sContent +="vertical-align: middle; text-align: center;";
                    sContent +="font-size: 1.2em; font-weight: bold; color: white;  background-color: #BD75FA; text-decoration: none;'>";
                    sContent +=gadget[0]+"</div>";
                }

                sContent += '</a>';

                sContent += '<a class="gadget_add_text_link"';
                sContent += 'href="javascript:" onClick="top.edShowGadgetFormPopup(\'' + gname + '\', \'' + textareaName + '\'); return false;">';
                sContent += gadget[11]+'</a>';

            sContent +='</div>'; // end leftPart
            sContent +='</td><td>'; // end table cell


            sContent +='<div class="right_part_gadget" style=" ">';
                    sContent += "<div class='gadget_name'>"+gadget[1]+"</div>";
                    sContent += "<div class='gadget_author'>"+gadget[10]+" "+gadget[7]+"</div>";
                    sContent += "<div class='gadget_url'><a href='"+gadget[8]+"' target=\"_blank\">"+gadget[8]+"</a></div>";
                    sContent += "<div class='gadget_descr'>"+gadget[9]+"</div>";

        sContent +='</div>'; // end rightPart
        sContent +='</td><tr></table>'; // Ending table
        sContent +='</div>'; // end One_gadget

        // end row, now 2 gadgets per row
        if( 0==rowCounter%2 ){
                    sContent += '<div style="clear: both;"></div>';
        }
    }
    sContent += '</fieldset></div>';

    top.filledPopup.open('%%insert_gadget%%', width, height, sContent);

}
// ================>
function edShowGadgetFormPopup(gadgetType, textareaName, isEditorMode, gadgetID, contentGadgets) {
	sContent = '<div style="padding:10px;"><form name="gadgetform" id="gadgetform' + gadgetType + '" onsubmit="var r = top.gadgetValidate(window, this, \'' + gadgetType + '\', \'' + textareaName + '\', ' + isEditorMode + ', ' + gadgetID + '); return false;">';
	sContent += aGadgets[gadgetType][4];
	sContent += '<center><input type="submit" class="but" value="%%apply_btn%%"> <input class="but" ID=btnCancel type="button" tabIndex=55 onClick="closeDialogWindow()" value="%%cancel_btn%%"></center>';
	sContent += '</form>';
	if(isEditorMode) {
		sContent += '<script>\
					var form = document.getElementById("gadgetform' + gadgetType + '");\
					var params = new Array(); ';
		var gparams = contentGadgets[gadgetID];
		for(var pname in gparams) {
			if(pname != 'indexOf') {
				sContent += 'params["' + pname.substr(1, pname.length-1) + '"] = decodeURIComponent("' + gparams[pname] + '");' + "\n";
			}
		}
		sContent += '\
					for(var k = 0; k < form.elements.length; k++) {\
						var name = form.elements[k].name;\
						if(form.elements[k].getAttribute(\'setter\')) {\
							var f = form.elements[k].getAttribute(\'setter\');\
							window[f](params);\
						} else {\
							if(params[name]) {\
								top.formSetValue(form, k, params[name]);\
							}\
						}\
					}\
				</script>';
	}
    sContent += '</div>';
	width = Math.max(800, window.document.body.offsetWidth-40);
	height = Math.max(450, window.document.body.offsetHeight-40);
	top.filledPopup.open('%%gadget_properties%% ' + aGadgets[gadgetType][1], 640, 480, sContent);
}

function gadgetGetHTMLCode(gadgetType, variables, gadgetID) {
	var result = '<img id="editorGadget' + gadgetID + '" class="ui_gadget" src="' + (aGadgets[gadgetType][5] != '' ?  aGadgets[gadgetType][5]  : '') + '" gadgettype="' + gadgetType +'"';
//	var result = '<span class="gadget" gadgettype="' + gadgetType +'"';
	for(var k in variables) {
		result += 'g' + k + '="' + encodeURIComponent(variables[k]) + '" ';
	}
	result += '>';
	return result;
}

function gadgetValidate(formWindow, form, gadgetType, textareaName, isEditorMode, gadgetID) {
    // var formWindow = top.currentParentWindow ? top.currentParentWindow : top;
    var textareaObject = /*formWindow.*/document.getElementById(textareaName);
    if(textareaObject != null && textareaObject.editorAttached && textareaObject.editorObject.currentMode == 'editor') {
        editorObject = textareaObject.editorObject;
        var cbFunc = function(result, params){
            if(result != null){
                editorObject.documentPaste(result);
            }
        }
	}
	var result = formValidate(formWindow, form, gadgetType);
	if(result) {
		if(isEditorMode) {
		} else {
			if(!editorObject.gadgetContent) {
				editorObject.gadgetContent = new Array();
			}
			var gadgetID = editorObject.gadgetContent.length;
			editorObject.gadgetContent[gadgetID] = new Array();
			editorObject.gadgetContent[gadgetID]['gadgettype'] = gadgetType;
			cbFunc(gadgetGetHTMLCode(gadgetType, result, gadgetID));
		}
		for(var k in result) {
			editorObject.gadgetContent[gadgetID]['g' + k] = encodeURIComponent(result[k]);
		}
	} else {
		return;
	}
	editorObject.formChanged();
	top.popupWindow.closeAll();
	return;
}


function formGetValue(form, element) {
	var el = form.elements[element], ret = null;
	switch(el.type) {
		case 'hidden':
		case 'text':
		case 'password':
			ret = el.value;
			break;
		case 'checkbox':
			ret = el.checked;
			break;
		case 'radio':
			// Необходимо дописать под радиобаттоны
			break;
		case 'select':
			// Необходимо будет модифицировать под множественный выбор
			ret = el.value;
			break;
		case 'button':
		case 'submit':
		case 'image':
		case 'reset':
			break;
        default:
            if(el.tagName == 'TEXTAREA'){
                ret = el.value;
            }
	}
	return ret;
}

function formSetValue(form, element, value) {
	var el = form.elements[element];
	switch(el.type) {
		case 'hidden':
		case 'text':
		case 'password':
			el.value = value;
			break;
		case 'checkbox':
			el.checked = value;
			break;
		case 'radio':
			// Необходимо дописать под радиобаттоны
			break;
		case 'select':
			// Необходимо будет модифицировать под множественный выбор
			for(var k = 0; k < el.options.length; i++) {
				if(el.options[k].value == value) {
					el.options[k].selected = true;
				}
			}
			break;
		case 'button':
		case 'submit':
		case 'image':
		case 'reset':
			break;
        default:
            if(el.tagName == 'TEXTAREA'){
                el.value = value;
            }
	}
}

function formValidate(formWindow, form, gadgetType) {
	var els = form.elements;
	var values = Array();
	var formValid = true;
	for(var i = 0; i < els.length; i++) {
		// Перебор элементов формы
		// Определение валидатора
		var validator = null;
		var validatorLocal = false;
		// Если установлен getter
		if(els[i].getAttribute('getter')) {
			validator = els[i].getAttribute('getter');
			validatorLocal = true;
		}
		// Если getter не установлен, но задан тип поля
		if(!validator && els[i].getAttribute('fieldtype')) {
			validator = 'formValidate_' + els[i].getAttribute('fieldtype');
		}
		// Необходимость поля
		var required = els[i].getAttribute('required') && els[i].getAttribute('required') == 'yes';
		// Валидация и возврат значений
		var value = formGetValue(form, i);
		if(validator) {
			if(validatorLocal == true) {
				// Кастомный валидатор
				value = formWindow[validator](value, els[i]);
			} else {
				// Стандартный валидатор
				value = top.window[validator](value);
			}
		} else {
		}
		if(typeof(value) == 'object') {
			for(var k in value) {
				values[k] = value[k];
			}
		} else if(value != false || value == '') {
			values[els[i].name] = value;
		}
		if(required && !value) {
			formValid = false;
			// error message
			var msg = els[i].getAttribute('errmessage') ? els[i].getAttribute('errmessage') : ' %%field_is_required%%: ' + els[i].name;
			alert(msg);
		}
	}
	return (formValid) ? values : false;
}


function formValidate_int(value) {
	return (parseInt(value).toString() == value) ? parseInt(value) : false;
}

function formValidate_email(value) {
	var r = /^(\w+[\w.-]*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+(;|,|$))+$/;
	var result = r.exec(value);
	return result != null;
}

function formValidate_url(value) {
	var r = /^(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?$/;
	var result = r.exec(value);
	return result != null;
}

function formValidate_float(value) {
	return (parseFloat(value).toString() == value) ? parseFloat(value) : false;
}


function edShowBackgroundImagePopup(textareaName, isEditorMode, editorSelectedObject){
    openDialog("%%bgimg_properties%%", "ce_img_proc.php?bgobj=" + textareaName + "&cat=" + parent.module_name + "&lang=##admin_lang##");
}

function edSelectElementColor(textareaName, type, color){
    var textareaObject = document.getElementById(textareaName);
    if(textareaObject != null && textareaObject.editorAttached && textareaObject.editorObject.currentMode == 'editor'){
        editorObject = textareaObject.editorObject;
        oPopupParams = {'textareaName' : textareaName, 'color' : color};
        var cbFunc = function(result, params){
            if(result != null && result != params['color']){
                editorObject.setEditorSelection(editorObject.sessionData.rng);
                editorObject.actionSetColor(null, type, true, result);
            }
        }
        openExtDialog('%%color_properties%%', 'select_color.php?obj=' + textareaName + '&cmd=' + type + '&lang=##admin_lang##&v=1', 0, 0, 555, 420, 0, 0, false, false, cbFunc, oPopupParams);
    }
}

function edEditInlineStyles(textareaName){
    var textareaObject = document.getElementById(textareaName);
    if(textareaObject != null && textareaObject.editorAttached && textareaObject.editorObject.currentMode == 'editor'){
        editorObject = textareaObject.editorObject;
        _selectedObj = editorObject.getSelectedAnchorNode();
        if(!_selectedObj.tagName || _selectedObj.tagName == 'IMG' || _selectedObj.tagName == 'BR'){
            _selectedObj = _selectedObj.parentNode;
        }
        if(_selectedObj && _selectedObj.tagName && _selectedObj.tagName.toLowerCase() != 'body' && _selectedObj.tagName.toLowerCase() != 'br'){
            oPopupParams = {'textareaName' : textareaName, 'oElement' : _selectedObj, 'cssText' : _selectedObj.style.cssText, 'className' : _selectedObj.className};
            var cbFunc = function(result, params){
                if(result != null && result != params['cssText']){
                    //_selectedObj.style.cssText = result;
                }else if(result == null){
                    _selectedObj.style.cssText = params['cssText'];
                    _selectedObj.className = params['className'];
                }
                editorObject.focusWindow();
            }
            openExtDialog('%%style_properties%%', 'ce_style_proc.php?'+cms_version, 0, 0, 730, 510, 0, 0, false, false, cbFunc, oPopupParams);
        }else{
            alert('%%style_impossible%%');
        }
    }
}

function edOpenPasteTextDialog(textareaName){
    var textareaObject = document.getElementById(textareaName);
    if(textareaObject != null && textareaObject.editorAttached && textareaObject.editorObject.currentMode == 'editor'){
        editorObject = textareaObject.editorObject;
        var cbFunc = function(result, params){
            if(result != null){
                editorObject.documentPaste(result);
            }
        }
        openExtDialog('%%tl_paste_as_text%%', 'ce_paste_proc.php?type=plain&'+cms_version, 0, 0, 800, 550, 0, 0, false, false, cbFunc);
    }
}

function edOpenPasteHtmlDialog(textareaName){
    var textareaObject = document.getElementById(textareaName);
    if(textareaObject != null && textareaObject.editorAttached && textareaObject.editorObject.currentMode == 'editor'){
        editorObject = textareaObject.editorObject;
        var cbFunc = function(result, params){
            if(result != null){
                editorObject.documentPaste(result);
            }
        }
        openExtDialog('%%tl_paste_special%%', 'ce_paste_proc.php?type=html&formatted=0&'+cms_version, 0, 0, 800, 550, 0, 0, false, false, cbFunc);
    }
}

function edOpenPasteHtmlFormattedDialog(textareaName){
    var textareaObject = document.getElementById(textareaName);
    if(textareaObject != null && textareaObject.editorAttached && textareaObject.editorObject.currentMode == 'editor'){
        editorObject = textareaObject.editorObject;
        var cbFunc = function(result, params){
            if(result != null){
                editorObject.documentPaste(result);
            }
        }
        openExtDialog('%%tl_paste_from_word%%', 'ce_paste_proc.php?type=html&formatted=1&'+cms_version, 0, 0, 800, 550, 0, 0, false, false, cbFunc);
    }
}

function edEditTable(textareaName){
    openDialog("%%tbl_properties%%", 'ce_tbl_proc.php?obj=' + textareaName + '&lang=##admin_lang##', 600, 500);
}

function edCreateLink(textareaName){
    openDialog("%%url_properties%%", "ce_url_proc.php?obj=" + textareaName + "&lang=##admin_lang##");
}

/* From ce_func1.tpl */

function makeUndoStep(objname, sOperationName, bUpdateButtons){
  errFunc = makeUndoStep;
}

function _prepareRegExpVal(rxVal){
  errFunc = _prepareRegExpVal;
  return rxVal.replace(/([.*\\\/?\[\]\{\}\_\-])/g, "\\$1");
}

function getNextSpecIndex(res, name, threeDig, direct){
  errFunc = getNextSpecIndex;
    var usedIndexes = Array();
    var regOrig = _prepareRegExpVal(specBlockTpl);
    for (var i=0;i<SpecBlocks.length;i++){
       if(name != SpecBlocks[i]['name'])
          continue;
       if(direct){
           var reg = regOrig;
           reg = reg.replace(/\\\[CLASS\\\]/g, "spec_"+_prepareRegExpVal(SpecBlocks[i]['group']));
           reg = reg.replace(/\\\[NAME\\\]/g, _prepareRegExpVal(SpecBlocks[i]['name']));
           reg = reg.replace(/\\\[CAPTION\\\]/g, _prepareRegExpVal(SpecBlocks[i]['caption']));
           reg = reg.replace(/\\\{([^{]*?)=\\\[NUM\\\]\\\}/g, "\\s*( $1=(|\"|\')(\\d\\d\\d)\\2)?");
           reg = reg.replace(/( ?)\\\[NUM\\\]/g, "($1(\\d\\d\\d)?)?");
           reg = reg.replace(/\s+/g, "\\s+");
           var re = new RegExp(reg, "ig");
           res = res.replace(re, function(allstr, qu, postf, dig){
                                   if(dig != undefined){
                                      usedIndexes[parseInt(dig, 10)] = true;
                                   }
                                   return "";
                                 });
       }else{
           var reg = "#\#"+SpecBlocks[i]['name']+"(_(\\d\\d\\d)\\d*)?#\#";
           var re = new RegExp(reg, "ig");
           res = res.replace(re, function(allstr, postf, dig){
                                   if(dig != undefined){
                                                 usedIndexes[parseInt(dig, 10)] = true;
                                   }
                                   return "";
                                 });
       }
       break;
    }
    useIndex = -1;
    for(i = 1; i < usedIndexes.length; i++){
      if(usedIndexes[i] == undefined || !usedIndexes[i]){
          useIndex = i;
          break;
      }
    }
    if(useIndex == -1){
      useIndex = usedIndexes.length > 0 ? usedIndexes.length : 1;
    }

    if(threeDig){
      useIndex = useIndex.toString(10);
      while(useIndex.length < 3){
          useIndex = "0"+useIndex;
      }
    }

    return useIndex;
}


function findSpec(body, tag){
  errFunc = findSpec;
  var res;
  var reg = "#\#"+tag+"(_([0-9]+))?#\#";
  var re = new RegExp(reg, "ig");
  res = body.search(re);
  return res;
}

function specBlockIsUniq(name){
  errFunc = specBlockIsUniq;
  for (var i=0;i<SpecBlocks.length;i++ ){
    if (SpecBlocks[i]['name']==name){
      return SpecBlocks[i]['uniq'];
    }
  }
}

function specBlockFromCodeToHTML(specBlockName, specBlockPostf){
    var
        specBlockTemplate =
            '<img src="[IMG]" title="[CAPTION] [NUM]" alt="[NAME] [NUM]" class="editorSpecBlock ' + interface_lang + '_[CLASSNAME]" id="[NAME]"{spec_num=[NUM]} />',
        res = '', img;

    for(var i = 0; i < SpecBlocks.length; i++){
        if(SpecBlocks[i]['name'] == specBlockName){
            res = specBlockTemplate;

            img = '_img/spacer.gif';
            if(aHyperModulesInstances.indexOf(SpecBlocks[i]['module']) >= 0){
                var psName = SpecBlocks[i]['name'].replace('spec_', '').replace('small_', '');
                // img = '_local/_admin/images/icons/' + psName + '_specblock_' + interface_lang + '.gif';

                img = amiCommon.getModResourceURL(
                    'mod_specblock',
                    {
                        modId: SpecBlocks[i]['module'],
                        locale: interface_lang,
                        entity: '_specblock',
                        block: psName
                    }
                );
            }

            res = res.replace(/\[IMG\]/g, img);
            res = res.replace(/\[NAME\]/g, SpecBlocks[i]['name']);
            res = res.replace(/\[CLASSNAME\]/g, SpecBlocks[i]['name'].indexOf('spec_small_plugin') == 0 ? 'spec_small_plugin' : SpecBlocks[i]['name']);
            res = res.replace(/\[CAPTION\]/g, SpecBlocks[i]['caption']);
            if(typeof(specBlockPostf) != 'undefined'){
                res = res.replace(/\{([^{]*?)=\[NUM\]\}/g, " $1="+specBlockPostf);
                res = res.replace(/\[NUM\]/g, specBlockPostf);
            }else{
                res = res.replace(/\{([^{]*?)=\[NUM\]\}/g, "");
                res = res.replace(/\[NUM\]/g, "");
            }
        }
    }

    return res;
}

function insertSpecBlock(evt, objname, name){
    errFunc = insertSpecBlock;
    var textareaObject = document.forms[parent._cms_document_form].elements[objname];
    if(textareaObject.editorAttached){
        var editorObject = textareaObject.editorObject;
        var specBlockExists = false;
        var templateBlockName;

        if(editorObject.currentMode == 'editor'){
            editor_updateHiddenField(objname);
            var specblockName = name;
            var oForm = document.forms[_cms_document_form];
            if(typeof(_cms_pm_template_blocks_number) != "undefined"){
                for (var i=1; i<=_cms_pm_template_blocks_number; i++){
                    if(oForm.elements['lay_f'+i+'_body'] != "undefined" && findSpec(oForm.elements['lay_f'+i+'_body'].value, specblockName) >= 0){
                        specBlockExists = true;
                        templateBlockName = oForm.elements['lay_f'+i+'_body'].Name;
                    }
                }

                if(findSpec(oForm.elements['lay_body_body'].value, specblockName) >= 0){
                    specBlockExists = true;
                    templateBlockName = oForm.elements['lay_body_body'].Name;
                }

                var bSpecBlockIsUniq = specBlockIsUniq(specblockName);

                if (!specBlockExists || !bSpecBlockIsUniq){
                    var allText = oForm.elements[_cms_selected_layout_block+'_body'].value;
                    var postf = getNextSpecIndex(allText, specblockName, true, false);
                    if(_cms_selected_layout_block == 'lay_body'){
                        var sLayNum = '000';
                    }else{
                        var sLayNum = _cms_selected_layout_block.replace('lay_f', '');
                        while (sLayNum.length<3){
                            sLayNum = '0'+sLayNum;
                        }
                    }

                    postf += sLayNum + oForm.elements["layout_id"].value;
                    if(_cms_selected_layout_block == 'lay_body' || oForm.elements[_cms_selected_layout_block+'_body_protected'].value == '1'){
                        postf += oForm.elements['id'].value;
                    }

                    editorObject.setEditorSelection(editorObject.sessionData.rng);
                    editorObject.insertContent(specBlockFromCodeToHTML(specblockName, postf));
                    //makeUndoStep(objname, '%%un_ins_specblock%%');

                    editorObject.formChanged(evt);
                    editorObject.updateToolBar();

                }else{
                    alert('%%unique_spec_block_alert%% "' + templateBlockName + '"');
                }
            }
        }
    }
}

/* From ce_func2.tpl */

function editor_updateHiddenField(textareaName){
    errFunc = editor_updateHiddenField;
    var editorObject = null;
    var formWindow = window;
    var oForm = formWindow.document.forms[formWindow._cms_document_form];

    if(textareaName.indexOf('form_') == 0){
        var textareaObject = formWindow.document.getElementById(textareaName);
    }else{
        var textareaObject = formWindow.document.getElementsByName(textareaName)[0];
    }
    if(!textareaObject || !textareaObject.editorAttached){
        textareaObject = null;
    }
    if(!textareaObject){
        var formWindow = top.currentParentWindow ? top.currentParentWindow : top;
        if(textareaName.indexOf('form_') == 0){
            var textareaObject = formWindow.document.getElementById(textareaName);
        }else{
            var textareaObject = formWindow.document.getElementsByName(textareaName)[0];
        }
    }
    if(textareaObject.editorAttached){
        var editorObject = textareaObject.editorObject;
        if (editorObject.contentChanged) {
            if(editorObject.highlighter){
                editorObject.highlighter.save();
                editorObject.highlighter.highlight(false);
            }
            if(editorObject.currentMode == 'editor'){
                editorObject.transportTextFromEditorToTextarea(true);
            }
            if(editorObject.currentMode == 'bb'){
                editorObject.transportTextFromBBToTextarea();
            }
        } else {
            textareaObject.value = editorObject.originalHTML;
        }
    }

    // Inserting gadgets code
    var result = textareaObject.value;
	var re = /\#\#gadget([\d]+)\#\#/ig;
	result = result.replace(re,
       	function(allstr, gadgetID) {
       		var pr = /(\w+)=\"([^\"]+)\"/gi
                if(typeof(editorObject.gadgetContent[gadgetID]) == 'undefined'){
                    return allstr;
                }
       			var gadgetParams = editorObject.gadgetContent[gadgetID];
       			var gadgetType = gadgetParams['gadgettype'];
				var code = aGadgets[gadgetType][3];
				var spanParams = 'gadgettype="' + gadgetType + '"';
				for(var k in gadgetParams) {
					var pname = k.substr(1, k.length - 1);
					var pvalue = decodeURIComponent(gadgetParams[k]);
					var re2 = new RegExp('\#\#' + pname + '\#\#', 'gi');
					code = code.replace(re2, pvalue);
					spanParams += ' ' + k + '="' + gadgetParams[k] + '"';
				}
				//alert(code);
           		return '<span class="gadget" ' + spanParams + '>' + code + '</span class="gadget">';
       	});
    textareaObject.value = result;

    var log_changes = _cms_log_form_changes;
    _cms_log_form_changes = false;
    if(oForm.elements[_cms_selected_layout_block + '_body']){
        oForm.elements[_cms_selected_layout_block+'_body'].value = result;
        oForm.elements[_cms_selected_layout_block+'_body_modified'].value = 1;
    }
    _cms_log_form_changes = log_changes;
}

function submitEditForm(){
  errFunc = submitEditForm;
  var oForm = document.forms[_cms_document_form];
  if (!oForm.isReadOnly && (typeof(oForm.elements[_cms_selected_layout_block+"_body"])!="undefined")){
    fireEvent2(oForm, "submit");
  }
}

function _editor_focus(editor_obj) {
  errFunc = _editor_focus;

  var objname     = editor_obj.id.replace(/^_(.*)_[^_]*$/, '$1');


  if ( document.getElementById("div_"+objname).currentStyle.display == 'none')
    return;

  // check editor mode
  if (editor_obj.tagName.toLowerCase() == 'textarea') {         // textarea
    //var myfunc = function() { editor_obj.focus(); };
    //setTimeout(myfunc,100);
    editor_obj.focus();
  }
  else {                                                        // wysiwyg
    var editdoc = editor_obj.contentWindow.document;            // get iframe editor document object
    var editorRange = editdoc.body.createTextRange();           // editor range
    var curRange    = editdoc.selection.createRange();          // selection range

    //alert(editorRange.inRange(curRange));
    if (editdoc.selection.type != "Control")                    // make sure it's not a controlRange
      if ( !editorRange.inRange(curRange) ) {                   // is selection in editor range
        var log_changes = _cms_log_form_changes;
        _cms_log_form_changes = false;
        document.body.setActive();
        editorRange.collapse();                                 // move to start of range
        editdoc.body.focus();
        editorRange.select();                                   // select
        curRange = editorRange;
        _cms_log_form_changes = log_changes;
      }else{
        editdoc.body.focus();
        curRange.select();                                        // select
      }
  }

  if (document.getElementById("div_"+objname).style.position=='absolute'){
    window.scrollTo(0,0);
  }
}


function checkHTML(sHTML){
   errFunc = checkHTML;
   var res = false;
   res =  (String(sHTML).indexOf('MsoNormal') > 0 ) || (String(sHTML).indexOf('msoNormal') > 0 ) || (String(sHTML).indexOf('mso-width') > 0 ) || (String(sHTML).indexOf('mso-ansi') > 0 ) || (String(sHTML).indexOf('schemas-microsoft') > 0 ) || (String(sHTML).indexOf('MsoBody') > 0 )
   res =  res || (String(sHTML).indexOf('xnum:') > 0 ) || (String(sHTML).indexOf('x:fmla') > 0 ) || (String(sHTML).indexOf('x:err') > 0 );
   return res;
}

function cleanHTML_old(sHTML){
   errFunc = cleanHTML_old;

  sHTML = sHTML.replace(/<\/?SPAN[^>]*>/gi, "" );
  sHTML = sHTML.replace(/<(\w[^>]*) class=([^ |>]*)([^>]*)/gi, "<$1$3") ;
  sHTML = sHTML.replace(/<(\w[^>]*) style="([^"]*)"([^>]*)/gi, "<$1$3") ;
  sHTML = sHTML.replace(/<(\w[^>]*) lang=([^ |>]*)([^>]*)/gi, "<$1$3") ;
  sHTML = sHTML.replace(/<\\?\?xml[^>]*>/gi, "") ;
  sHTML = sHTML.replace(/<\/?\w+:[^>]*>/gi, "") ;
  sHTML = sHTML.replace(/&nbsp;/gi, " " );

  return sHTML;
}

function cleanHTML(sHTML, cleanType){
errFunc = cleanHTML;

if(typeof(cleanType) == 'undefined' || cleanType != 'MSOffice'){
    sHTML = sHTML.replace(/<\/?SPAN[^>]*>/gi, "");
    sHTML = sHTML.replace(/<(\w[^>]*) class=([^ |>]*)([^>]*)/gi, "<$1$3") ;
    sHTML = sHTML.replace(/<(\w[^>]*) style="([^"]*)"([^>]*)/gi, "<$1$3") ;
    sHTML = sHTML.replace(/<(\w[^>]*) lang=([^ |>]*)([^>]*)/gi, "<$1$3") ;
    sHTML = sHTML.replace(/<(\w[^>]*) x:str([^>]*)/gi, "<$1$2");
    sHTML = sHTML.replace(/<(\w[^>]*) x:num(="[^>]*")?([^>]*)/gi, "<$1$3") ;
    sHTML = sHTML.replace(/<(\w[^>]*) x:fmla='([^']*)'([^>]*)/gi, "<$1$3") ;
    sHTML = sHTML.replace(/<(\w[^>]*) x:fmla="([^"]*)"([^>]*)/gi, "<$1$3") ;
    sHTML = sHTML.replace(/<(\w[^>]*) x:err="([^"]*)"([^>]*)/gi, "<$1$3") ;
    sHTML = sHTML.replace(/<\\?\?xml[^>]*>/gi, "") ;
    sHTML = sHTML.replace(/<\/?\w+\:[^>]*>/gi, "") ;
    sHTML = sHTML.replace(/&nbsp;/gi, " " );
}else{
    sHTML = sHTML.replace(/<(\/?)SPAN/gi, "<$1font");
    sHTML = sHTML.replace(/<(\w[^>]*) class=([^ |>]*)([^>]*)/gi, "<$1$3");
    sHTML = sHTML.replace(/<(\w[^>]*) lang=([^ |>]*)([^>]*)/gi, "<$1$3");
    sHTML = sHTML.replace(/<(\w[^>]*) x:str([^>]*)/gi, "<$1$2");
    sHTML = sHTML.replace(/<(\w[^>]*) x:num(="[^>]*")?([^>]*)/gi, "<$1$3");
    sHTML = sHTML.replace(/<(\w[^>]*) x:fmla='([^']*)'([^>]*)/gi, "<$1$3");
    sHTML = sHTML.replace(/<(\w[^>]*) x:fmla="([^"]*)"([^>]*)/gi, "<$1$3");
    sHTML = sHTML.replace(/<(\w[^>]*) x:err="([^"]*)"([^>]*)/gi, "<$1$3");
    sHTML = sHTML.replace(/mso\-[^>]*?(;|("|'))/gi, "$2");
    sHTML = sHTML.replace(/<\\?\?xml[^>]*>/gi, "");
    sHTML = sHTML.replace(/<\/?\w+\:[^>]*>/gi, "");
    sHTML = sHTML.replace(/&nbsp;/gi, " " );
}

return sHTML;
}

wordPasteReplaceRx = new RegExp('(href|src)=(\'|"|)(##admin_root_q##|##front_root_q##)', 'gi');
documentCharset = '##char_set##';

function initializeBBEditor(divId, fieldName){
    var txtEd = new amiroTEdit('txtEd', new amiDictionary({
        'bold': '%%bb_bold%%',
        'italic': '%%bb_italic%%',
        'underline': '%%bb_underline%%',
        'strike': '%%bb_strike%%',
        'header': '%%bb_header%%',
        'insert_olist': '%%bb_insert_olist%%',
        'quote': '%%bb_quote%%',
        'align_left': '%%bb_align_left%%',
        'align_center': '%%bb_align_center%%',
        'align_right': '%%bb_align_right%%',
        'justify': '%%bb_justify%%',
        'insert_list': '%%bb_insert_list%%',
        'insert_link': '%%bb_insert_link%%',
        'delete_link': '%%bb_delete_link%%',
        'insert_image': '%%bb_insert_image%%',
        'font': '%%bb_font%%',
        'size': '%%bb_size%%',
        'color': '%%bb_color%%',
        'more': '%%bb_more%%',
        'insert_code': '%%bb_insert_code%%',
        'indent': '%%bb_indent%%',
        'outdent': '%%bb_outdent%%',
        'preview': '%%bb_preview%%',
        'hide_preview': '%%bb_hide_preview%%',
        'update_preview': '%%bb_update_preview%%',
        'warn_message_length': '%%bb_warn_message_length%%',
        'warn_invalid_image_url': '%%bb_warn_invalid_image_url%%',
        'warn_image_url_internal_links_forbidden': '%%bb_warn_image_url_internal_links_forbidden%%',
        'warn_image_url_external_links_forbidden': '%%bb_warn_image_url_external_links_forbidden%%',
        'prompt_enter_list_element': '%%bb_prompt_enter_list_element%%',
        'prompt_enter_next_list_element': '%%bb_prompt_enter_next_list_element%%',
        'prompt_enter_url': '%%bb_prompt_enter_url%%',
        'prompt_enter_image_url': '%%bb_prompt_enter_image_url%%',
        'warn_urls_reg_only': '%%bb_warn_urls_reg_only%%'
    }));
    txtEd.allowedImages = ['internal_links', 'external_links', 'upload'];
    txtEd.createEditor(600, 250, fieldName, '', true, '', divId);
    txtEd.setUseNoindex(##noindex_external_links##);
    return txtEd;
}




<!--#set var="astItem" value="'##key##':'##value##'"-->

astContent = {##astContent##};
astContent['no_help'] = astContent['show_level_3'] + astContent['show_level_4'];


/* From editor_specplocks.tpl */

<!--#set var="specblocks_img" value="<SPAN class=spec_##group## id=##tag## contentEditable=false##disabled##>##name##</SPAN>"-->

<!--#set var="specblocks_content" value="
var specBlockTpl = "<SPAN class=[CLASS] id=[NAME] contentEditable=false{spec_num=[NUM]}>[CAPTION] [NUM]</SPAN>";
var SpecBlocks = Array();
##spec_block_array##
"-->
