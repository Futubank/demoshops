##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%


<!--#set var="javascript" value="

AMI.$('SELECT[name=module]').chosen({
    search_contains: true,
    disable_search_threshold: 20,
    width: '400px',
    no_results_text: AMI.Template.Locale.get('not_found')
});
AMI.$('SELECT[name=module]').prop('chosen', true);

var curType = '##type##';
var is_readonly = ##is_readonly##;

function openModulesTemplates(mod_id, template_id, popup_title, content_default, diff){
    content_default = content_default || 0;
    diff = diff || 0;
    var cursorLine = 0;
    openDialog(popup_title, 'engine.php?mod_id=' + mod_id + '&mode=popup&form_only=1&content_default=' + content_default + '&diff=' + diff + '&copy_button=1&modname=eshop.eshop_order&id=' + template_id, '');
}

// popup mode (not diff)
if(typeof(diffMode) == 'undefined'){
    if((top != window) && (typeof(window.cmRefresh) == 'undefined')){
        setTimeout(function(){
            // Refresh cm
            if(document.getElementsByName("ta_highlight_content_flag")[0].checked){
                var checked = document.getElementsByName("ta_highlight_content_flag")[0].checked;
                oTextEditor_content.highlight(!checked, true);
                oTextEditor_content.highlight(checked, true);
                window.cmRefresh = true;
                if((typeof(defaultContentMode) != 'undefined') && defaultContentMode){

                    var callerWindow = top;
                    var topWindow = 0;
                    for(var i in top.popupWindow.dialogsWindows){
                        if(top.popupWindow.dialogsWindows[i] != null){
                            if(typeof(top.popupWindow.dialogsWindows[i].contentWindow.defaultContentMode) == 'undefined'){
                                callerWindow = top.popupWindow.dialogsWindows[i].contentWindow;
                            }
                        }
                    }

                    if(callerWindow.document.getElementsByName("ta_highlight_content_flag")[0].checked){
                        var scrollPos = AMI.$(callerWindow.oTextEditor_content.oEditor.getScrollerElement()).scrollTop();
                    }else{
                        var scrollPos = AMI.$(callerWindow.document.getElementById('content')).scrollTop();
                    }
                    if(document.getElementsByName("ta_highlight_content_flag")[0].checked){
                        window.oTextEditor_content.oEditor.scrollTo(0, scrollPos);
                    }else{
                        AMI.$(document.getElementById('content')).scrollTop(scrollPos);
                    }
                }
            }
        },
        500);
    }
}

function getInputSelection(el) {
    var start = 0, end = 0, normalizedValue, range,
        textInputRange, len, endRange;

    if (typeof el.selectionStart == "number" && typeof el.selectionEnd == "number") {
        start = el.selectionStart;
        end = el.selectionEnd;
    } else {
        range = document.selection.createRange();

        if (range && range.parentElement() == el) {
            len = el.value.length;
            normalizedValue = el.value.replace(/\r\n/g, "\n");

            textInputRange = el.createTextRange();
            textInputRange.moveToBookmark(range.getBookmark());

            endRange = el.createTextRange();
            endRange.collapse(false);

            if (textInputRange.compareEndPoints("StartToEnd", endRange) > -1) {
                start = end = len;
            } else {
                start = -textInputRange.moveStart("character", -len);
                start += normalizedValue.slice(0, start).split("\n").length - 1;

                if (textInputRange.compareEndPoints("EndToEnd", endRange) > -1) {
                    end = len;
                } else {
                    end = -textInputRange.moveEnd("character", -len);
                    end += normalizedValue.slice(0, end).split("\n").length - 1;
                }
            }
        }
    }

    return {
        start: start,
        end: end
    };
}

function insertTpl(src, type){

    if(type != curType){
        alert('%%incompatible_types%%');
        return false;
    }

    if(is_readonly){
        alert('%%readonly_err%%');
        return false;
    }

    var content = document.getElementById('content').value;
    content += src;

    var srclines = src.split('\n');
    var lines = content.split('\n');

    if(document.getElementsByName("ta_highlight_content_flag")[0].checked){
        oTextEditor_content.oEditor.setValue(content);
        oTextEditor_content.oEditor.setCursor(lines.length, 0);
        oTextEditor_content.oEditor.setSelection({line: (lines.length - srclines.length + 1), ch: 0}, {line: lines.length, ch:0});
    }else{
        document.getElementById('content').value = content;
    }

    return true;
}

function copySelectedTpl(){
    var sel = '';
    if(document.getElementsByName("ta_highlight_content_flag")[0].checked){
        sel = oTextEditor_content.oEditor.getSelection();
    }else{
        var txt = document.getElementById('content');
        sel = txt.value.substr(txt.selectionStart, (txt.selectionEnd - txt.selectionStart))
        // var selection = getInputSelection(textarea);
        // var selectedText = textarea.value.slice(selection.start, selection.end);
    }

    if(!sel.length){
        sel = document.getElementById('content').value;
    }
    sel = '\n#' + '#-- This sets below are copied here from ##currentTpl## --#' + '#\n' + sel + '\n#' + '#-- //This sets above are copied here from ##currentTpl## --#' + '#\n';
    var callerWindow = top;
    var topWindow = 0;
    if(typeof(top.insertTpl) == 'undefined'){
        for(var i in top.popupWindow.dialogsWindows){
            if(top.popupWindow.dialogsWindows[i] != null){
                topWindow = i;
                callerWindow = top.popupWindow.dialogsWindows[i].contentWindow;
                break;
            }
        }
    }
    if(callerWindow.insertTpl(sel, curType)){
        if(!topWindow){
            window.parent.AMI.$('.popupWindowClose').click();
        }else{
            for(var instance in top.popupWindow.closedDialogs){
                if(instance != topWindow){
                    if(!top.popupWindow.closedDialogs[instance]){
                        top.popupWindow.close(instance);
                    }
                }
            }
        }
    }
}

function closeLastPopup(){
    var lastPopup = 0;
    for(var instance in top.popupWindow.closedDialogs){
        if(!top.popupWindow.closedDialogs[instance]){
            lastPopup = instance;
        }
    }
    top.popupWindow.close(lastPopup);
}
"-->

<!--#set var="section_tplhint" value="
<tr>
    <td colspan="2">
        <div class="tooltip" style="margin-top: 5px; margin-right: 0px; margin-bottom: 5px; margin-left: 0px; display: block; " id="commonFieldTooltip">%%tpl_hint%%</div>
    </td>
</tr>
"-->

<!--#set var="section_includes" value="
<tr>
    <td colspan="2"><br /><b>%%includes_list%%:</b><br /><br /></td>
</tr>
##section_html##
"-->

<!--#set var="hint_field" value="
<tr>
    <td class="content_default_field" colspan="2">##tpl_type## (##hint##): <span class="text_button" onclick="openModulesTemplates('##module##', ##id##, '##tpl_type## (##side##): ##value##');">##value##</span></td>
</tr>
"-->

<!--#set var="notfound_field" value="
<tr>
    <td colspan="2">##tpl_type##: ##value## (%%not_found%%)</td>
</tr>
"-->

<!--#set var="content_default_field" value="
<tr>
    <td colspan="2"><br />
        <span class="text_button" onclick="openModulesTemplates('##module##', ##id##, '##tpl_type## (##side##): ##value##', 1);">%%content_default%%</span>
##if(content_is_default == 0)##
&nbsp;<img title="%%from_content_not_default%%" src="skins/vanilla/icons/icon-content_not_default.png" style="width: 9px; height: 9px;" />
(<span class="text_button" onclick="openModulesTemplates('##module##', ##id##, '##tpl_type## (##side##): ##value##', 1, 1);">%%content_diff%%</span>)
##endif##<br />
    </td>
</tr>
"-->

<!--#set var="input_field(name=header)" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td><input type="text" name="##name##" class="field field50##IF(is_invalid)## fieldInvalid##ENDIF##" value="##value##" maxlength="255"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## /><b>.tpl</b></td>
</tr>
"-->

<!--#set var="form_buttons" value="<div id="form-buttons"> ##restore_btn## ##cancel_btn## ##add_btn## ##save_btn##  ##apply_btn##</div>"-->

<!--#set var="apply_btn" value="<input type="submit"##--  name="apply"--## value="%%apply_btn%%" class="but" onclick="this.form.elements['ami_full'].value = 1;this.form.action.value='apply'"##attributes## />##if(copy_button)## <input type="submit" value="%%copy_button%%" class="but but-350" onclick="copySelectedTpl(); return false;" /> <input type="submit" value="%%close_button%%" class="but" onclick="closeLastPopup();" />##endif##"-->

<!--#set var="restore_btn" value="##if(allow_restore_by_default)##<input type="button" value="%%btn_restore%%" class="but" id="buttonRestore" onclick="restoreTemplate();"/>##endif##"-->

<!--#set var="highlighted_field" value="
<tr>
    <td colspan="2">##--element_caption##IF(validator_filled)##*##ENDIF##:<br />--##
        <div style="overflow: hidden">
            <label style="display: block; float: right; margin-top:6px;"><input type="checkbox" name="ta_highlight_##name##_flag" value="1" onChange="hl_##name##_highlight();"> %%highlight_code%%</label>
            <div id="_hl_##name##_search_bar" style="float:right; padding-right:16px;">
                %%hl_search_for%%: <input type="text" id="_hl_##name##_search" class="field field10" onkeypress="return hl_##name##_searchEnterKeyPress(event);"/>
                <img class="imgButton" align="absmiddle" src="##skin_path##/images/ed_search_continue.gif" onclick="oTextEditor_##name##.search(AMI.find('#_hl_##name##_search').value);" title="%%hl_search%%">
                &nbsp;&nbsp;&nbsp;
                %%hl_replace_with%%: <input type="text" id="_hl_##name##_replace"  class="field field10" onkeypress="return hl_##name##_replaceEnterKeyPress(event);"/>
                <img class="imgButton" align="absmiddle" src="##skin_path##/images/ed_replace.gif" onclick="oTextEditor_##name##.replace(AMI.find('#_hl_##name##_search').value, AMI.find('#_hl_##name##_replace').value, '%%hl_confirm_replace%%');" title="%%hl_replace%%">
                <img class="imgButton" align="absmiddle" src="##skin_path##/images/ed_replace_all.gif" onclick="oTextEditor_##name##.replaceAll(AMI.find('#_hl_##name##_search').value, AMI.find('#_hl_##name##_replace').value, '%%hl_confirm_replace_all%%');" title="%%hl_replace_all%%">
                &nbsp;&nbsp;&nbsp;
                <label><input type="checkbox" name="ta_highlight_##name##_wrap" value="1" onChange="hl_##name##_wrap();"> %%wrap_lines%%</label>
            </div>
        </div>
        <textarea name="##name##" id="##name##" class="field##IF(is_invalid)## fieldInvalid##ENDIF##" wrap="OFF" style="width:100%;height:##if(height)####height####else##500##endif##px;font-family:'Courier New';font-size:13px;background-color:rgb(240,240,240);"  ##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##value##</textarea>
        <script type="text/javascript">
            function hl_##name##_highlight(){
                var cb = document.getElementsByName("ta_highlight_##name##_flag")[0];
                var fl = document.getElementsByName('ta_highlight')[0];
                oTextEditor_##name##.highlight(cb.checked, true);
                fl.value = cb.checked ? 'yes' : 'no';
                AMI.Cookie.set('ta_highlight', fl.value);
                AMI.find('#_hl_##name##_search_bar').style.display = cb.checked ? 'block' : 'none';
            }

            function hl_##name##_wrap(){
                var cb = document.getElementsByName("ta_highlight_##name##_wrap")[0];
                var fl = document.getElementsByName('ta_wrap')[0];
                oTextEditor_##name##.highlight(false, true);
                oTextEditor_##name##.options.lineWrapping = cb.checked;
                oTextEditor_##name##.highlight(true, true);
                fl.value = cb.checked ? 'yes' : 'no';
                AMI.Cookie.set('ta_wrap', fl.value);
            }

            function hl_##name##_searchEnterKeyPress(e){
                var evt=(e)?e:(window.event)?window.event:null;
                if(evt){
                    var key=(evt.charCode)?evt.charCode:
                        ((evt.keyCode)?evt.keyCode:((evt.which)?evt.which:0));
                    if(key=="13"){
                        oTextEditor_##name##.search(AMI.find('#_hl_##name##_search').value);
                        AMI.find('#_hl_##name##_search').focus();
                        return false;
                    }
                }
                return true;
            }

            function hl_##name##_replaceEnterKeyPress(e){
                var evt=(e)?e:(window.event)?window.event:null;
                if(evt){
                    var key=(evt.charCode)?evt.charCode:
                        ((evt.keyCode)?evt.keyCode:((evt.which)?evt.which:0));
                    if(key=="13"){
                        oTextEditor_##name##.replace(AMI.find('#_hl_##name##_search').value, AMI.find('#_hl_##name##_replace').value, '%%hl_confirm_replace%%');
                        AMI.find('#_hl_##name##_replace').focus();
                        return false;
                    }
                }
                return true;
            }

            var options = {
                mode: "amitpl",
                tabMode: "shift",
                indentUnit: 4,
                lineWrapping: AMI.Cookie.get('ta_wrap') == 'yes',
                // onChange: function(_this){return function(){_this.formChanged(window.event)}}(this),
                extraKeys: {
                    'Ctrl-F': function(_this){
                        return function(){
                            return focusedAlert(document.getElementById('_hl_##name##_search'), '%%hl_ctrlf_warning%%');
                        }
                    }(this)
                }
            };

            var oTextEditor_##name## = new AMI.TextEditor('##name##', true, options, false);
            if(document.getElementsByName('ta_highlight')[0].value == 'yes'){
                document.getElementsByName("ta_highlight_##name##_flag")[0].checked = true;
                if(typeof(window['tplLastScrollTop' + $('form input[type=hidden][name=id]').val()]) !== 'undefined'){

                    setTimeout(function(size){
                        return function(){
                            if(oTextEditor_##name##.oEditor){
                                AMI.$(oTextEditor_##name##.oEditor.getScrollerElement()).scrollTop(window['tplLastScrollTop' + $('form input[type=hidden][name=id]').val()]);
                                return true;
                            }
                            setTimeout(this, 500);
                        }
                    }(window['tplLastScrollTop' + $('form input[type=hidden][name=id]').val()]), 500);
                }
            }else{
                if(typeof(window['tplLastScrollTop' + $('form input[type=hidden][name=id]').val()]) !== 'undefined'){
                    setTimeout(function(size){
                        return function(){
                            if(AMI.$('#content').length){
                                AMI.$('#content').scrollTop(window['tplLastScrollTop' + $('form input[type=hidden][name=id]').val()]);
                                return true;
                            }
                            setTimeout(this, 100);
                        }
                    }(window['tplLastScrollTop' + $('form input[type=hidden][name=id]').val()]), 100);
                }
            }
            if(document.getElementsByName('ta_wrap')[0].value == 'yes'){
                document.getElementsByName("ta_highlight_##name##_wrap")[0].checked = true;
            }
            hl_##name##_highlight();
            AMI.Message.addListener('ON_FORM_SUBMIT', function(oComponent, parameters){
                if(document.getElementsByName("ta_highlight_##name##_flag")[0].checked){
                    window['tplLastScrollTop' + $('form input[type=hidden][name=id]').val()] = AMI.$(oTextEditor_##name##.oEditor.getScrollerElement()).scrollTop();
                }else{
                    window['tplLastScrollTop' + $('form input[type=hidden][name=id]').val()] = AMI.$('#content').scrollTop();
                }
                oTextEditor_##name##.save();
                parameters['content'] = oTextEditor_##name##.oTextarea.value;
                return true;
            });
        </script>
    </td>
</tr>
"-->

<!--#set var="highlighted_field(form_mode=show)" value="
<tr>
    <td colspan="2">##element_caption####IF(validator_filled)##*##ENDIF##:<br />
        <div style="overflow: hidden">
            <label style="display: block; float: right; padding-bottom:6px;"><input type="checkbox" name="ta_highlight_##name##_flag" value="1" onChange="hl_##name##_highlight();"> %%highlight_code%%</label>
            <div id="_hl_##name##_search_bar" style="float:right; padding-right:16px;">
                %%hl_search_for%%: <input type="text" id="_hl_##name##_search" class="field field10" onkeypress="return hl_##name##_searchEnterKeyPress(event);"/>
                <img class="imgButton" align="absmiddle" src="##skin_path##/images/ed_search_continue.gif" onclick="oTextEditor_##name##.search(AMI.find('#_hl_##name##_search').value);" title="%%hl_search%%">
                &nbsp;&nbsp;&nbsp;
                <label><input type="checkbox" name="ta_highlight_##name##_wrap" value="1" onChange="hl_##name##_wrap();"> %%wrap_lines%%</label>
            </div>
        </div>
        <textarea name="##name##" id="##name##" class="field##IF(is_invalid)## fieldInvalid##ENDIF##" wrap="OFF" style="width:100%;height:##if(height)####height####else##500##endif##px;font-family:'Courier New';font-size:13px;background-color:rgb(240,240,240);"  ##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##value##</textarea>
        <script type="text/javascript">
            function hl_##name##_highlight(){
                var cb = document.getElementsByName("ta_highlight_##name##_flag")[0];
                var fl = document.getElementsByName('ta_highlight')[0];
                oTextEditor_##name##.highlight(cb.checked, true);
                fl.value = cb.checked ? 'yes' : 'no';
                AMI.Cookie.set('ta_highlight', fl.value);
                AMI.find('#_hl_##name##_search_bar').style.display = cb.checked ? 'block' : 'none';
            }

            function hl_##name##_wrap(){
                var cb = document.getElementsByName("ta_highlight_##name##_wrap")[0];
                var fl = document.getElementsByName('ta_wrap')[0];
                oTextEditor_##name##.highlight(false, true);
                oTextEditor_##name##.options.lineWrapping = cb.checked;
                oTextEditor_##name##.highlight(true, true);
                fl.value = cb.checked ? 'yes' : 'no';
                AMI.Cookie.set('ta_wrap', fl.value);
            }

            function hl_##name##_searchEnterKeyPress(e){
                var evt=(e)?e:(window.event)?window.event:null;
                if(evt){
                    var key=(evt.charCode)?evt.charCode:
                        ((evt.keyCode)?evt.keyCode:((evt.which)?evt.which:0));
                    if(key=="13"){
                        oTextEditor_##name##.search(AMI.find('#_hl_##name##_search').value);
                        AMI.find('#_hl_##name##_search').focus();
                        return false;
                    }
                }
                return true;
            }

            var options = {
                mode: "amitpl",
                tabMode: "shift",
                indentUnit: 4,
                lineWrapping: AMI.Cookie.get('ta_wrap') == 'yes',
                readOnly: true,
                nocursor: true,
                extraKeys: {
                    'Ctrl-F': function(_this){
                        return function(){
                            return focusedAlert(document.getElementById('_hl_##name##_search'), '%%hl_ctrlf_warning%%');
                        }
                    }(this)
                }
            };

            var oTextEditor_##name## = new AMI.TextEditor('##name##', true, options, false);
            if(document.getElementsByName('ta_highlight')[0].value == 'yes'){
                document.getElementsByName("ta_highlight_##name##_flag")[0].checked = true;
            }
            if(document.getElementsByName('ta_wrap')[0].value == 'yes'){
                document.getElementsByName("ta_highlight_##name##_wrap")[0].checked = true;
            }
            hl_##name##_highlight();
            AMI.Message.addListener('ON_FORM_SUBMIT', function(oComponent, parameters){
                return false;
            });
        </script>
    </td>
</tr>
"-->

<!--#set var="section_form(form_mode=show)" value="<script type="text/javascript">
##scripts##

var
    _cms_document_form = 'ami_form_##_component_id##',
    _cms_document_form_changed = false;


for(var moduleId in AMI.Page.aModules) break;
if(typeof(AMI.Page.fullEnvWorkaround) == 'undefined'){
    AMI.HTTPRequest.getContent(
        'GET',
        amiModuleLink,
        {
            mod_id: moduleId,
            mod_action: 'set_templates_permissions',
            ami_full: 1
        },
        function(state, content){
            if((content != 'OK') && (content != 'NOTHING TO DO')){
                console.log('Unexpected content: ' + content);
            }
        }
    );
    AMI.Page.fullEnvWorkaround = true;
}

AMI.Page.getComponent('##_component_id##').hashDataFilter = '.*';

function importTemplates(){
    if(confirm('%%do_import%%')){
        var sync_type = 2;
        ##if(isChooseImportSyncType)##
            sync_type = (!confirm('%%choose_import_type%%')) ? 1 : 2;
        ##endif##
        var oModule = AMI.Page.getModule(moduleId);
        oModule.scheduleListReload = true;
        AMI.Page.doModuleAction(moduleId, '##_component_id##', 'form_import', {ami_full: 1, sync_type: sync_type});
    }
}

function exportTemplates(){
    if(confirm('%%do_export%%')){
        var sync_type = 2;
        ##if(isChooseExportSyncType)##
            sync_type = (!confirm('%%choose_export_type%%')) ? 1 : 2;
        ##endif##
        var oModule = AMI.Page.getModule(moduleId);
        oModule.scheduleListReload = true;
        AMI.Page.doModuleAction(moduleId, '##_component_id##', 'form_export', {ami_full: 1, sync_type: sync_type});
    }
}

function restoreTemplate(){
    if(confirm('##if(content_is_default == 1)##%%do_restore_confirm%%##else##%%do_restore%%##endif##')){
        var sync_type = 2;
        var oModule = AMI.Page.getModule(moduleId);
        oModule.scheduleListReload = true;
        AMI.Page.doModuleAction(moduleId, '##_component_id##', 'form_restore', {ami_full: 1, sync_type: sync_type});
    }
}

AMI.Message.addListener('ON_MODULE_ACTION', function(action, params){
    switch(action){
        case 'form_import':
        case 'form_export':
        case 'form_restore':
            params.oComponent.sync_type = params.oParameters.sync_type;
    }
    return true;
});

</script>

##if(_ENABLE_BUTTONS)##
<input type="button" value="%%btn_export%%" class="but-long" id="buttonExport" onclick="exportTemplates();" ##if(TPLS_READ_FROM_DISK)##title="%%export_not_allowed%%"##endif##/>
<input type="button" value="%%btn_import%%" class="but-long" id="buttonImport" onclick="importTemplates();" />
##if(TPLS_READ_FROM_DISK)##
<script type="text/javascript">
    document.getElementById('buttonExport').disabled = 'true';
</script>
##endif##
##endif##

<br /><br />

<div id="div_properties_form" class="main-form">
	<table ccc="1" class="properties_form_table" border="0" cellpadding="0" cellspacing="0" ##if(width != '')##width="##width##"##else##width="90%"##endif## ##if(height != '')##height="##height##"##endif## style="margin-left:auto;margin-right:auto;">
		<tr class="properties_form_title">
			<td align=left id="add_left_top_img"></td>
			<td nowrap id="add_center_top_img">
				<span id="form_title" class="form-header">##header##</span>
			</td>
			<td nowrap id="add_right_info_top_img">
				<div id=stModified style="display:none;" class=form-header> [ %%modified%% ]</div>
			</td>
			<td id="add_right_top_img"></td>
		</tr>
		<tr>
			<td id="add_left_center_img"></td>
			<td colspan=2 class="table_sticker" valign="top">
<br>
<table cellspacing="0" cellpadding="0" border="0" class="frm" width=100%>
<col class="first_column">
<col class="second_column">
##section_html##
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frm" width=100%>
<col width="150">
<col width="*">
<tr>
<td colspan="2" align="right">
<br>
##if(copy_button)##
    <div id="form-buttons">
        ##if(diff_mode == 0)##<input type="submit" value="%%copy_button%%" class="but but-350" onclick="copySelectedTpl(); return false;" />##endif## <input type="submit" value="%%close_button%%" class="but" onclick="closeLastPopup();" />
    </div>
##endif##
<br><br>
</td>
</tr>
</table>
			</td>
			<td id="add_right_center_img"></td>
		</tr>
		<tr>
			<td id="add_left_bot_img"></td>
			<td id="add_center_bot_img" colspan=2></td>
			<td id="add_right_bot_img"></td>
		</tr>
	</table>
</div>
"-->

<!--#set var="section_form" value="
<script type="text/javascript">
##scripts##

var
    _cms_document_form = 'ami_form_##_component_id##',
    _cms_document_form_changed = false;

AMI.Message.addListener('ON_FORM_FIELD_VALIDATE', function(oParameters){
    if(oParameters.oField.name == 'header'){
        var nameRX = new RegExp("^[a-zA-Z0-9_\\-\\.]+$");
        if (!nameRX.test(oParameters.oField.value)){
            oParameters.error = true;
            oParameters.message = '%%tplname_warn%%';
        }
    }
    return true;
});

for(var moduleId in AMI.Page.aModules) break;
if(typeof(AMI.Page.fullEnvWorkaround) == 'undefined'){
    AMI.HTTPRequest.getContent(
        'GET',
        amiModuleLink,
        {
            mod_id: moduleId,
            mod_action: 'set_templates_permissions',
            ami_full: 1
        },
        function(state, content){
            if((content != 'OK') && (content != 'NOTHING TO DO')){
                console.log('Unexpected content: ' + content);
            }
        }
    );
    AMI.Page.fullEnvWorkaround = true;
}

AMI.Page.getComponent('##_component_id##').hashDataFilter = '.*';

function importTemplates(){
    if(confirm('%%do_import%%')){
        var sync_type = 2;
        ##if(isChooseImportSyncType)##
            sync_type = (!confirm('%%choose_import_type%%')) ? 1 : 2;
        ##endif##
        var oModule = AMI.Page.getModule(moduleId);
        oModule.scheduleListReload = true;
        AMI.Page.doModuleAction(moduleId, '##_component_id##', 'form_import', {ami_full: 1, sync_type: sync_type});
    }
}

function exportTemplates(){
    if(confirm('%%do_export%%')){
        var sync_type = 2;
        ##if(isChooseExportSyncType)##
            sync_type = (!confirm('%%choose_export_type%%')) ? 1 : 2;
        ##endif##
        var oModule = AMI.Page.getModule(moduleId);
        oModule.scheduleListReload = true;
        AMI.Page.doModuleAction(moduleId, '##_component_id##', 'form_export', {ami_full: 1, sync_type: sync_type});
    }
}

function restoreTemplate(){
    if(confirm('##if(content_is_default == 1)##%%do_restore_confirm%%##else##%%do_restore%%##endif##')){
        var sync_type = 2;
        var oModule = AMI.Page.getModule(moduleId);
        oModule.scheduleListReload = true;
        AMI.Page.doModuleAction(moduleId, '##_component_id##', 'form_restore', {ami_full: 1, sync_type: sync_type});
    }
}

if(typeof(AMI.Page.actionHandlerAdded) == 'undefined'){
    AMI.Message.addListener('ON_MODULE_ACTION', function(action, params){
        var oComponent = AMI.Page.getComponent('##_component_id##');
        switch(action){
            case 'form_import':
            case 'form_export':
            case 'form_restore':
                oComponent.sync_type = params.oParameters.sync_type;
                oComponent.modAction = action;
                oComponent.ami_full = 1;
                oComponent.loadForm(false);
            return false;
        }
        return true;
    });
    AMI.Page.actionHandlerAdded = true;
}

</script>

##if(_ENABLE_BUTTONS)##
<input type="button" value="%%btn_export%%" class="but-long" id="buttonExport" onclick="exportTemplates();" ##if(TPLS_READ_FROM_DISK)##title="%%export_not_allowed%%"##endif##/>
<input type="button" value="%%btn_import%%" class="but-long" id="buttonImport" onclick="importTemplates();" />
##if(TPLS_READ_FROM_DISK)##
<script type="text/javascript">
    document.getElementById('buttonExport').disabled = 'true';
</script>
##endif##
##endif##

<br /><br />

<div id="div_properties_form" class="main-form">
    <table class="main-form__table properties_form_table" ccc="1" border="0" cellpadding="0" cellspacing="0" ##if(width != '')##width="##width##"##else##width="90%"##endif## ##if(height != '')##height="##height##"##endif## style="margin-left:auto;margin-right:auto;">
        <tr class="properties_form_title">
            <td align=left id="add_left_top_img"></td>
            <td nowrap id="add_center_top_img"><span id="form_title" class="form-header">##header##</span></td>
            <td nowrap id="add_right_info_top_img">
            <div id=stModified style="display:none;" class=form-header>
                [ %%modified%% ]
            </div></td>
            <td id="add_right_top_img"></td>
        </tr>
        <tr>
            <td id="add_left_center_img"></td>
            <td colspan=2 class="table_sticker" valign="top">
            <br>
            <form data-ami-component-id="##_component_id##" id="ami_form_##_component_id##" class="form" action="##action##" method="post" enctype="multipart/form-data" name="##_mod_id##form" onsubmit="AMI.Page.doModuleAction('##_mod_id##', '##_component_id##', 'form_save', this); return false;">
                <input type="hidden" name="action" value="" />
                <input type="hidden" name="ami_full" value="" />
                <table cellspacing="0" cellpadding="0" border="0" class="frm" width=100%>
                    <col class="first_column">
                    <col class="second_column">
                    ##section_html##
                </table>

                <table cellspacing="0" cellpadding="0" border="0" class="frm" width=100%>
                    <col width="150">
                    <col width="*">
                    <tr>
                        <td colspan="2" align="right">
                        <br>
                        ##form_buttons##
                        <br>
                        <br>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"><sub>%%required_fields%%</sub></td>
                    </tr>
                </table>
            </form></td>
            <td id="add_right_center_img"></td>
        </tr>
        <tr>
            <td id="add_left_bot_img"></td>
            <td id="add_center_bot_img" colspan=2></td>
            <td id="add_right_bot_img"></td>
        </tr>
    </table>
</div>

"-->

<!--#set var="diff_viewer_field" value="
<tr>
    <td colspan="2">
        <div style="display:none;">
            <textarea id="new_##name##"></textarea>
            <textarea id="src_##name##">##value|htmlentities##</textarea>
        </div>
        <div style="float: right;" id="diffNav">
            <a id="diff_up" onclick="return diffClick('up');" href="#" title="%%diff_up%%">&uarr;</a>&nbsp;
            <a id="diff_down" onclick="return diffClick('down');" href="#" title="%%diff_down%%">&darr;</a>&nbsp;
            %%diff_found%%: <span id="diff_found"></span>
        </div>
        <div class="diffTitle">
            <table border="0" cellspacing=0 cellpadding=4 width=100%>
            <tr>
                <td width="50%">%%diff_source%% (%%lines%%: <span id="diff_source_lines"></span>, %%size%%: ##diff_source_length##)</td>
                <td width="50%">%%diff_current%% (%%lines%%: <span id="diff_current_lines"></span>, %%size%%: ##diff_current_length##)</td>
            </tr>
        </table>
        </div>
        <div id="diff_##name##" class="diffViewer">
        <script type="text/javascript">
            var diffsCount = 0, diffLines = [], diffLineIndex = 0;

            function diffClick(direction){

                if(!diffLines.length){
                    return;
                }

                var lineNumber = 0;

                switch(direction){
                    case 'up':
                        if(diffLineIndex > 0){
                            lineNumber = diffLines[--diffLineIndex];
                        }else{
                            lineNumber = diffLines[0];
                        }
                        break;
                    case 'down':
                        if(diffLineIndex < (diffsCount - 1)){
                            lineNumber = diffLines[++diffLineIndex];
                        }else{
                            lineNumber = diffLines[diffLines.length-1];
                        }
                        break;
                    case 'current':
                        lineNumber = diffLines[diffLineIndex];
                        break;
                }
                if(lineNumber > 0){
                    AMI.$('#diff_content').scrollTop(AMI.$('#diff_content').scrollTop() + AMI.$('#th' + (lineNumber+1)).position().top - AMI.$('#diff_content').position().top);
                }else{
                    AMI.$('#diff_content').scrollTop(0);
                }

                return false;
            }

            AMI.$(document).ready(function(){

                var callerWindow = top;
                var topWindow = 0;
                for(var i in top.popupWindow.dialogsWindows){
                    if(top.popupWindow.dialogsWindows[i] != null){
                        if(typeof(top.popupWindow.dialogsWindows[i].contentWindow.diffMode) == 'undefined'){
                            callerWindow = top.popupWindow.dialogsWindows[i].contentWindow;
                        }
                    }
                }

                var checked = callerWindow.document.getElementsByName('ta_highlight_##name##_flag')[0].checked;
                callerWindow.oTextEditor_##name##.highlight(!checked, true);
                callerWindow.oTextEditor_##name##.highlight(checked, true);
                AMI.$('#new_##name##').val(AMI.$(callerWindow.document.getElementById('##name##')).val());

                var
                    base = difflib.stringAsLines(AMI.$("#src_##name##").val()),
                    newtxt = difflib.stringAsLines(AMI.$('#new_##name##').val()),
                    sm = new difflib.SequenceMatcher(base, newtxt),
                    opcodes = sm.get_opcodes();

                for(var i = 0, q = opcodes.length; i < q; i++){
                    if('equal' !== opcodes[i][0]){
                        diffsCount++;
                        diffLines.push((opcodes[i][0] == 'delete') ? opcodes[i][3] - 1 : opcodes[i][3]);
                    }
                }

                AMI.$('#diff_found').html(diffsCount);
                AMI.$('#diff_source_lines').html(base.length);
                AMI.$('#diff_current_lines').html(newtxt.length);

                var htmlText = diffview.buildView({
                    baseTextLines: base,
                    newTextLines: newtxt,
                    opcodes: opcodes,
                    baseTextName: "Base Text",
                    newTextName: "New Text",
                    contextSize: null,
                    viewType: 0
                });

                AMI.$('#diff_##name##').html(htmlText);

                setTimeout(function(){
                    AMI.$('#diff_content').css('max-height', AMI.$('#div_properties_form').height() - 230 + 'px');
                    diffClick('current');
                }, 500);

                AMI.$('#diffNav').fadeOut(500, function(){
                    AMI.$('#diffNav').fadeIn(500, function(){
                        AMI.$('#diffNav').fadeOut(500, function(){
                            AMI.$('#diffNav').fadeIn(500, function(){
                                AMI.$('#diffNav').fadeOut(500, function(){
                                    AMI.$('#diffNav').fadeIn(1000);
                                });
                            });
                        });
                    });
                });

            });
        </script>
    </td>
</tr>
"-->

