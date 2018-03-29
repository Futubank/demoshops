%%include_language "templates/ce/spell_js.lng"%%
%%include_language "templates/lang/main.lng"%%

<!--#set var="disabled"      value="
function Spell(doc) {
  alert('%%paid_feature_disabled%%');
}
"-->

var wdDialogToolsSpellingAndGrammar     = 828;
var wdDoNotSaveChanges                  = 0;
var wdEnglishUS                         = 1033;
var wdFrench                            = 1036;
var wdGerman                            = 1031; 
var wdItalian                           = 1040; 
var wdNoProofing                        = 1024; 
var wdRussian                           = 1049; 
var wdSpanish                           = 1034; 

var wdAnagram                           = 2;

var langNames = Array();

langNames[1033]                     = '%%lang_1033%%';
langNames[1036]                     = '%%lang_1036%%';
langNames[1031]                     = '%%lang_1031%%'; 
langNames[1040]                     = '%%lang_1040%%'; 
langNames[1024]                     = '%%lang_1024%%'; 
langNames[1049]                     = '%%lang_1049%%'; 
langNames[1034]                     = '%%lang_1034%%'; 

var oWord;
var oDoc;
var spWordRange;
var spEditorRange;
var spSkipWords = Array();
var origRange;
var checkedObjName
var bSpellCanceled = false;
var bIgnoreCaps = true;

function GetText(objname, oDoc){
  errFunc = GetText;

  doc = globalEditor[objname].contentWindow.document;
  origRange = doc.selection.createRange();
  var oDiv = document.createElement('DIV');
  if (doc.selection.type == "Text"){
    spEditorRange = origRange.duplicate();
    //oDoc.Content.Text = origRange.text;
    oDiv.innerHTML = origRange.htmlText.replace(/<\/TD>/g, '. </TD>');
    //oDiv.innerHTML = oDiv.innerHTML.replace(/<\/P>/g, ' </P>');
  }else{
    spEditorRange = doc.body.createTextRange();
    spSentenceRange = spEditorRange.duplicate();
    spSentenceRange.expand("textedit");
    //oDoc.Content.Text = spSentenceRange.text;
    oDiv.innerHTML = spSentenceRange.htmlText.replace(/<\/TD>/g, '. </TD>');
    //oDiv.innerHTML = oDiv.innerHTML.replace(/<\/P>/g, ' </P>');
  }

  oDiv = document.body.appendChild(oDiv);
  oDiv.style.display='none';
  var tRange = document.body.createTextRange();
  tRange.moveToElementText(oDiv);
  oDoc.Content.Text = tRange.text;
  document.body.removeChild(oDiv);
  //oDoc.Content.Text = oDiv.innerText;
  //alert('html\n'+tRange.text+'\nword\n'+oDoc.Content.Text);

}

function Spell(objname){
  errFunc = Spell;

  checkedObjName = objname;
  doc = globalEditor[objname].contentWindow.document;

  if (startSpell()){
   GetText(objname, oDoc);
   if (!oDoc.Content.LanguageDetected){
     oDoc.Content.DetectLanguage();
   }
   spWordRange = spEditorRange.duplicate();
   spWordRange.collapse();
   spSkipWords = Array();
   window.setTimeout("checkSpell()", 300);
  }
}


function checkSpell() {
errFunc = checkSpell;

var bSkip = false;
var bNext = 1;
var bContinue = true;
var bSpellCompleted = false;

  var vParams = new Object();
  vParams.spWordRange = spWordRange;
  vParams.spEditorRange = spEditorRange;
  vParams.spSkipWords = spSkipWords;
  vParams.checkedObjName = checkedObjName;
  vParams.spLanguage = oDoc.Content.LanguageID;
  vParams.langNames = langNames;
  vParams.bIgnoreCaps = bIgnoreCaps;
  vParams.oWord = oWord;
  vParams.oDoc = oDoc;
  vParams.oWindow = window;
  vParams.cSuggests = Array();

  //for (var i=1;i<=oDoc.SpellingErrors.Count ;i++ ){
    //alert(oDoc.SpellingErrors(i));
  //}

  msgStat = '%%statistic%%\n\n'
  msgStat += '%%sentences%%: '+oDoc.Sentences.Count+'\n';
  msgStat += '%%words%%: '+oDoc.Words.Count;

  if (oDoc.SpellingErrors.Count > 0){
    if (confirm(msgStat + '\n\n' + String('%%check_spell_alert%%').replace('_num_', oDoc.SpellingErrors.Count))){
      bSpellCompleted = openSpellPopup(vParams);
    }
    if (bSpellCompleted){
      alert("%%completed%%");
    }else{
      alert("%%canceled%%");
    }
  }else{
    alert(msgStat += '\n\n%%no_errors%%');
  }
  endSpell();
}

function startSpell(){
  errFunc = startSpell;

  if (oWord)
    try
    {
        oDoc = oWord.Documents.Add();
        return true;
    }
    catch(e)
    {
    }

  try
  {
    oWord = new ActiveXObject("Word.Application");
    oDoc = oWord.Documents.Add();
  }
  catch(e)
  {
    alert("%%word_not_installed%%");
    return false;
  }
  return true;
}


function endSpell(){
  errFunc = endSpell;
  oDoc.Close(wdDoNotSaveChanges);
  //updateUndoButtons(checkedObjName);
  _editor_focus(globalEditor[checkedObjName]);
}

function closeWord(){
  errFunc = closeWord;

  try
  {
    if (typeof(oDoc)=='object'){
      oDoc.Close(wdDoNotSaveChanges);
    }
  }
  catch(e)
  {
    //alert("%%cannot_close_doc%%");
  }

  try
  {
    if (typeof(oWord)=='object'){
      oWord.Quit(0);
    }
  }
  catch(e)
  {
    //alert("%%cannot_close_word%%");
  }
}

function openSpellPopup(vParams){
  errFunc = openSpellPopup;
  return window.showModalDialog("spell.php?"+cms_version+"&lang=##lang##", vParams, "dialogWidth:480px;dialogHeight:356px;center:yes;scroll:no;status:no;help:no;");
}

