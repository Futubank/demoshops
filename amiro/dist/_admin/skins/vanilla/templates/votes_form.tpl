%%include_language "templates/lang/votes.lng"%%

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'votesform';
var _cms_script_link = '##script_link##?';

var rowOffset = 1;
var selectedItemId = 0;
var pictureCell = '##item_pictureTemplate##';

##pictures_js_vars##

function CheckForm(evt, form) {
    var errmsg = "";

    editor_updateHiddenField("question");

    if (form.question.value=="") {
        return focusedAlert(null, '%%question_warn%%', 'question');
    }
    var
        singleSelect = form.qtype.value == 'single_select',
        imageIsFound = false, textIsFound = false,
        answers = document.getElementById('idAnswers');

    if (!form.allow_other.checked) {
        var answerIsFound = false;
        for(i = 0; i < answers.rows.length - rowOffset; i++) {
            var id = answers.rows[i + rowOffset].getAttribute("clearid");
            if (document.getElementById('answer_' + id)) {
                var hasImage = document.getElementById('picture_' + id) && document.getElementById('picture_' + id).value.length > 0;
                imageIsFound = imageIsFound || hasImage;
                textIsFound = textIsFound || document.getElementById('answer_' + id).value.length > 0;
                if (textIsFound || hasImage) {
                    answerIsFound = true;
                }
            }
        }
        if (!answerIsFound || (singleSelect && !textIsFound)) {
            if (singleSelect && imageIsFound) {
                errmsg += '%%answers_text_only_warn%%\n\n';
            }
           errmsg+='%%answers_warn%%';
           alert(errmsg);
           return false;
        }
    }
    if (singleSelect) {
        if (!imageIsFound) {
            for(i = 0; i < answers.rows.length - rowOffset; i++) {
                var id = answers.rows[i + rowOffset].getAttribute("clearid");
                if (
                    document.getElementById('picture_' + id) &&
                    document.getElementById('picture_' + id).value.length > 0
                ) {
                    imageIsFound = true;
                    break;
                }
            }
        }
        if (imageIsFound) {
            if (!confirm('%%answers_text_only_confirm%%')) {
                return false;
            }
            for(i = 0; i < answers.rows.length - rowOffset; i++) {
                var id = answers.rows[i + rowOffset].getAttribute("clearid");
                if (document.getElementById('picture_' + id)) {
                    document.getElementById('picture_' + id).value = '';
                }
            }
        }
    }

    if(!(typeof(form.sublink) == 'undefined') && !checkUrl(form.sublink.value)) {
        return false;
    }

    updateAnswersOrder(evt);
##if(OTHER_ANSWERS_COUNT=="1")##
    if (form.reset_other.checked) {
        return confirm('%%other_warn%%');
    }
##endif##
    return true;
}

function OnObjectChanged_votes_form(name, first_change, evt) {
    if (name == 'allow_other') {
        var answers = document.getElementById('idAnswers');
        if (!window.document.forms.votesform.allow_other.checked && answers.rows.length == rowOffset) {
            insertFieldRow(event);
        }
    }
    ##pictures_js_script##
    return true;
}
addFormChangedHandler(OnObjectChanged_votes_form);


function insertFieldRow(evt) {
    var fieldId, oRow, oCelll, answers = document.getElementById('idAnswers');

    fieldId = answers.rows.length - rowOffset + 1;
    oRow = answers.insertRow(fieldId, undefined);
    oRow.setAttribute("id", "answers_"+fieldId);
    oRow.setAttribute("clearid", fieldId);
    oCell = oRow.insertCell(0);
    oCell.innerHTML = fieldId;
    oCell.setAttribute("align", "right");
    oCell = oRow.insertCell(1);
    oCell.innerHTML = pictureCell.replace(/pictureTemplate/g, 'picture_' + fieldId);
    oCell = oRow.insertCell(2);
    oCell.innerHTML = '<input type="text" class="field field50"  name="answer_' + fieldId + '" id="answer_' + fieldId + '"value="" />';
    oCell = oRow.insertCell(3);
    oCell.innerHTML = '<input type="text" class="field field4"  name="answer_val_' + fieldId + '" value="" />';
    oCell = oRow.insertCell(4);
    oCell.innerHTML = '<img src="skins/vanilla/icons/icon-pos_control.gif" width=19 height=19 border=0 onmouseover="this.style.cursor=\'pointer\'" onmouseout="this.style.cursor=\'default\'" onclick="moveField(event, this, \''+fieldId+'\')">';
    oCell = oRow.insertCell(5);
    oCell.innerHTML = '<a id="delField_' + fieldId + '" href="javascript:void('+fieldId+');" onClick="deleteFld(event, \''+fieldId+'\');return false;"><img class=icon src="skins/vanilla/icons/icon-del.gif" title="%%delete%%" border="0" /></a>';
    answers = null;
    updateAnswersOrder(evt);
}

function moveField(evt, oImage, fieldId){
    var mousePos = amiCommon.getMousePosition(evt);
    var elementPos = amiCommon.getElementPosition(oImage);
    elementHalfX = oImage.offsetWidth / 2;
    elementHalfY = oImage.offsetHeight / 2;
    isOneStep = (mousePos[0] > elementPos[0] + elementHalfX);
    isUp = (mousePos[1] < elementPos[1] + elementHalfY);
    if(isUp){
        moveFldUp(evt, fieldId, !isOneStep);
    }else{
        moveFldDown(evt, fieldId, !isOneStep);
    }
}

function moveFldUp(evt, curId, isTop){
    if(curId != ''){
        var answers = document.getElementById('idAnswers');
        for(i = rowOffset ; i < answers.rows.length ; i++){
            if("answers_"+curId == answers.rows[i].getAttribute("id")){
                if(i > rowOffset){
                    lastElem = isTop ? rowOffset + 1: i;
                    for(j = i; j >= lastElem; j--){
                        crossSwapNodes(answers.rows[j-1], answers.rows[j]);
                    }
                    updateAnswersOrder(evt);
                }
                break;
            }
        }
    }
}

function moveFldDown(evt, curId, isBottom){
    if(curId != '') {
        var answers = document.getElementById('idAnswers');
        for(i = rowOffset; i < answers.rows.length; i++) {
            if("answers_"+curId == answers.rows[i].getAttribute("id")) {
                if(i < answers.rows.length - 1){
                    lastElem = isBottom ? answers.rows.length - 2 : i;
                    for(j = i; j <= lastElem; j++) {
                        crossSwapNodes(answers.rows[j], answers.rows[j + 1]);
                    }
                    updateAnswersOrder(evt);
                }
                break;
            }
        }
    }
}

function deleteFld(evt, curId){
    var answers = document.getElementById('idAnswers');
    if(curId != '' && answers.rows.length  > rowOffset + (window.document.forms.votesform.allow_other.checked ? 0 : 1)) {
        for(i = 0; i < answers.rows.length - rowOffset; i++){
            if("answers_"+curId == answers.rows[i + rowOffset].getAttribute("id")){
                if(document.getElementById('answer_' + curId).value.length && !confirm('%%remove_answer%%')) {
                    answers = null;
                    return;
                }
                answers.rows[i + rowOffset].parentNode.removeChild(answers.rows[i + rowOffset]);
                updateAnswersOrder(evt);
                break;
            }
        }
    }
    answers = null;
}

function updateAnswersOrder(evt){
    var answers = document.getElementById('idAnswers');
    document.forms.votesform.answersOrder.value = '';
    for(i = 0; i < answers.rows.length - rowOffset; i++){
        document.forms.votesform.answersOrder.value += (document.forms.votesform.answersOrder.value == '' ? '' : ';')+answers.rows[i + rowOffset].getAttribute('clearid');
        answers.rows[i + rowOffset].cells[0].innerHTML = i + 1;
    }
    var o = document.getElementById('idAnswers');
    if (answers.rows.length > rowOffset) {
        o.style.visibility = 'visible';
        o.style.display = 'block';
    } else {
        o.style.visibility = 'hidden';
        o.style.display = 'none';
    }
    var answers = null;
    FormChanged(evt);
}

-->
</script>

<!--#set var="pictureTemplate" value="
         <input type=hidden name=pictureTemplate class=field value="" detectchanges="on">
         <span id="div_img_pictureTemplate">##edit_pictureTemplate##</span>
         ##if(!empty(GENERATED_PICTURE_URL))##<a href="javascript: void(0);" onClick="show_picture('##GENERATED_PICTURE_URL##', '', '##GENERATED_PICTURE_W##', '##GENERATED_PICTURE_H##', 1); return false;">%%picture_generated%%</a>##endif##
"-->


<!--#set var="picture" value="
         <input type=hidden name=picture_##num## class=field value="##picture##" detectchanges="on">
         <span id="div_img_picture_##num##">##edit_picture##</span>
         ##if(!empty(GENERATED_PICTURE_URL))##<a href="javascript: void(0);" onClick="show_picture('##GENERATED_PICTURE_URL##', '', '##GENERATED_PICTURE_W##', '##GENERATED_PICTURE_H##', 1); return false;">%%picture_generated%%</a>##endif##
"-->


<!--#set var="answer_line" value="
     <tr id="answers_##num##" clearid="##num##">
        <td align=right>
          ##num##
        </td>
        <td>##item_picture##</td>
        <td>
          <input type="text" class="field field50"  name="answer_##num##" id="answer_##num##" value="##answer##" />
        </td>
        <td>
          <input type="text" class="field field4"  name="answer_val_##num##" value="##answer_value##" />
          ##if(is_other=="1")## <font class=notice>%%is_other%%</font> ##else## &nbsp; ##endif##
        </td>
        <td><img src="skins/vanilla/icons/icon-pos_control.gif" width=19 height=19 border=0 onmouseover="this.style.cursor='pointer'" onmouseout="this.style.cursor='default'" onclick="moveField(event, this, '##num##')">
        <td><a id="delField_##num##" onClick="deleteFld(event, '##num##');return false;" href="javascript:void(1)"><img title="%%delete%%" class=icon src="skins/vanilla/icons/icon-del.gif" border=0></A></TD>
     </tr>
"-->


<!--#set var="cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="javascript:user_click('none','');">
"-->

  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="votesform" onSubmit="return CheckForm(event, window.document.forms.votesform);">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <input type="hidden" name="publish" value="">
     <input type="hidden" name="answersOrder" value="">
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
     <col width="180">
     <col width="">
     <tr>
       <td colspan="2">
         <label><input type="checkbox" name="public" ##public## value="1">
         %%public%%</label>
       </td>
     </tr>
     <tr>
       <td>
        %%date_start%%:
       </td>
       <td>
         <input type=text name="date_start" class='field fieldDate' value="##fdate_start##" maxlength="30" />
         <a href="javascript: void(0);" onclick="return getCalendar(event, document.forms.votesform.date_start);">
         <img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
       </td>
     </tr>
     <tr>
       <td>
        %%date_end%%:
       </td>
       <td>
         <input type=text name="date_end" class='field fieldDate' value="##fdate_end##" maxlength="30" />
         <a href="javascript: void(0);" onclick="return getCalendar(event, document.forms.votesform.date_end);">
         <img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
       </td>
     </tr>
     </table>
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
     <col width="180">
     <col width="">
     <tr>
       <td colspan="2">


        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-question">
              <textarea class="field" style="width:100%" rows="14" name="question" id="question">##question##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('question', cmD_STB, true, 606);}
              </script>
            </div>

            <div class="tab-page" id="tab-page-options">
              ##options_form##
            </div>
          </div>
        </div>

        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'question' : ['%%question%%', 'active', '', false],
              'options' : ['%%tab_options%%', 'normal', '', false],
          '':''});

        </script>


       </td>
     </tr>
     </table>
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
     <col width="180">
     <col width="">
     <tr>
        <td>%%total%%:</td>
        <td><input type="text" name="total" class="field field5" value="##total##"  maxLength="10" /></td>
     </tr>
     <tr>
       <td>
        %%answers_type%%:
       </td>
       <td>
          <select name="qtype">
              <label><option value="single_radio"##if(qtype=="single_radio")## selected##endif##>%%qtype_single_radio%%</label>
              <label><option value="single_select"##if(qtype=="single_select")## selected##endif##>%%qtype_single_select%%</label>
              <label><option value="multiple_checkboxes"##if(qtype=="multiple_checkboxes")## selected##endif##>%%qtype_multiple_checkboxes%%</label>
            </select>
       </td>
     </tr>
     <tr>
       <td colspan=2>
        <label>%%allow_other%%:
         <input type=checkbox name=allow_other value=1 ##allow_other##></label>
       </td>
     </tr>
     <tr>
       <td colspan=2>
         <table border="0" id="idAnswers">
           <tr>
             <td align=right> # </td>
             <td></td>
             <td>%%answers%%</td>
             <td colspan=3>%%voices%%</td>
           </tr>
           ##answers##
         </table>
         <span class=text_button onClick="insertFieldRow(event)">%%button_add_answer%%</span>
       </td>
     </tr>
     ##if(OTHER_ANSWERS_COUNT=="1")##
     <tr>
       <td colspan="2">
         <label><input type="checkbox" name="reset_other" value="1">
         %%reset_other%%</label>
         <div class=notice>%%reset_note%%</div>
       </td>
     </tr>
     ##endif##
     <tr>
       <td colSpan="2"><br>
         <label><input type="checkbox" name="special" ##special## value="1">
         %%special%%</label>
       </td>
     </tr>
     <tr>
       <td colSpan="2">
         <input type="checkbox" name="registered_users_only" ##registered_users_only## value="1">
         %%registered_users_only%%
       </td>
     </tr>
     </table>
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
     <col width="180">
     <col width="">
     <tr>
        <td colspan="2" align="right">
        <br>
        ##form_buttons##
        <br><br>
        </td>
     </tr>
     <tr>
       <td colspan="2">
         <sub>%%required_fields%%</sub>
       </td>
     </tr>
     </table>
    </form>
