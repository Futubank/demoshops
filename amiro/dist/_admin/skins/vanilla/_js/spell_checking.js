var spWordRange;
var spSentenceRange;
var spNewWordRange;
var spEditorRange;
var spSkipWords;
var oWord;
var checkedObjName;
var bChanged = false;
var langNames;
var oDoc;
var bIgnoreCaps;
var iError = 0;
var blinkTimer;
var tbTimer = false;
var repStr = '';
var iProgress = 0;

function Init(){
  errFunc = Init;  

  window.document.body.onkeypress = function() {
    if (window.event.keyCode == 27) {
      if (oForm.elements["btnCancelChanges"].style.display == "block"){
        spellCancelChanges();
      }else{
        window.returnValue=false;
        window.close();
      }
    }
  }

  window.opener=window.dialogArguments.oWindow;

  var cSuggests = window.dialogArguments.cSuggests;
  spWordRange = window.dialogArguments.spWordRange;
  spEditorRange = window.dialogArguments.spEditorRange;
  spSkipWords = window.dialogArguments.spSkipWords;
  spLanguage = window.dialogArguments.spLanguage;
  bIgnoreCaps = window.dialogArguments.bIgnoreCaps;
  oWord = window.dialogArguments.oWord;
  oDoc = window.dialogArguments.oDoc;
  langNames = window.dialogArguments.langNames;
  checkedObjName = window.dialogArguments.checkedObjName;



  oForm = document.forms["spell_form"];
  oForm.elements["sp_word"].value=spWordRange.text;
  //oForm.elements["sp_suggests"].disabled=false;

  //document.all['sp_language'].innerHTML = langNames[spLanguage];

  for(var i=0;i<cSuggests.length;i++){
    var oOption = document.createElement("OPTION");
    oForm.elements["sp_suggests"].options.add(oOption);
    oOption.value = cSuggests[i];
    oOption.innerHTML = cSuggests[i];
  }
  if (cSuggests.length > 0){
    oForm.elements["sp_suggests"].selectedIndex = 0;
    //oForm.elements["sp_suggests"].focus();
  }
  window.setTimeout ("checkSpell()", 300); 

  spWordRange = spEditorRange.duplicate();

  //setSentence(true);
}


function setSentence(bHiLight){
  errFunc = setSentence;  
  if (bHiLight == null)
    bHiLight = false;
  spSentenceRange = spWordRange.duplicate();
  spSentenceRange.expand("sentence");
  if (spSentenceRange.htmlText.search('TD') >= 0) {
    spSentenceRange = spWordRange.duplicate();
  }
  var tempRange = spWordRange.duplicate();
  var startPoint = 0;
  var endPoint = 0;
  while (tempRange.compareEndPoints("StartToStart", spSentenceRange) > 0){
    tempRange.moveStart("character", -1);
    startPoint++;
  }
  while (tempRange.compareEndPoints("EndToStart", spSentenceRange) > 0){
    tempRange.moveEnd("character", -1);
    endPoint++;
  }
  //endPoint = startPoint + spWordRange.text.length;

  //checkpoint
  document.all["sp_sentence"].innerHTML = spSentenceRange.htmlText;
  spNewWordRange = document.body.createTextRange();
  spNewWordRange.moveToElementText(document.all["sp_sentence"]);
  //spNewWordRange.pasteHTML(spSentenceRange.htmlText);

  spNewWordRange.collapse(true);
  spNewWordRange.moveEnd("character", endPoint);
  spNewWordRange.moveStart("character", startPoint);

  if (bHiLight){
    spNewWordRange.pasteHTML('<font color=red><b>'+spNewWordRange.htmlText+'</b></font>');
  }

  //spWordRange.select();
  spNewWordRange.collapse(false);
  spNewWordRange.select();
}

function spellChange(bAll){
  errFunc = spellChange;  

  var newWord, oldWord;
  var bSentenceChanged = false;
  var bBadHTML = false;

  oForm = document.forms["spell_form"];
  window.opener.makeUndoStep(checkedObjName,unSpell, false);
  window.opener.updateUndoButtons(checkedObjName);

  if (oForm.elements["sp_suggests"].value != ""){
    oldWord = spWordRange.text;
    spWordRange.text = oForm.elements["sp_suggests"].value;
    newWord = oForm.elements["sp_suggests"].value;
  }else{
    spNewWordRange.expand("word");
    if (spNewWordRange.text.charAt(spNewWordRange.text.length - 1) == " ")
      spNewWordRange.moveEnd("character", -1);

    if (spNewWordRange.text != spWordRange.text ){
      oldWord = spWordRange.text;
      spWordRange.pasteHTML(spNewWordRange.htmlText);
      newWord = spNewWordRange.text;
    }
    spSentenceRange = spWordRange.duplicate();
    spSentenceRange.expand("sentence");

    if (spSentenceRange.htmlText.search('TD') >= 0){
      bBadHTML = true;
    }

    if (spSentenceRange.text != document.all['sp_sentence'].innerText){
      if (bBadHTML){
        alert(spmsg_bad_html);
      }else{
        spSentenceRange.pasteHTML(document.all['sp_sentence'].innerHTML);
        //window.opener.GetText(checkedObjName, oDoc);
        bSentenceChanged = true;
      }
    }
  }

  if (bAll){
    if (bSentenceChanged){
      alert(spmsg_sentence_changed);
      oForm.elements["btnChangeAll"].disabled=true;
      return false;
    }else if (newWord != null){
      var sText = oldWord;
      var tempRange = spEditorRange.duplicate();
      while (tempRange.findText(sText)){
        tempRange.text = newWord;
        tempRange.collapse(false);
        tempRange.setEndPoint('EndToEnd',spEditorRange);
      }
      tempRange.setEndPoint('StartToStart',spEditorRange);
      tempRange.setEndPoint('EndToEnd',spEditorRange);
    }

  }
  resetButtons();
  //oForm.elements["sp_suggests"].length=0;
  //document.all["sp_sentence"].innerHTML = '';
  window.setTimeout ("checkSpell()", 300); 
}


function spellSkip(bAll){
  errFunc = spellSkip;  
  if (bAll){
    spSkipWords[spSkipWords.length] = spWordRange.text;
		//alert(spWordRange.text);
	}
  resetButtons();
  //oForm.elements["sp_suggests"].length=0;
  //document.all["sp_sentence"].innerHTML = '';
  window.setTimeout ("checkSpell()", 300); 
}

function spellWordChanged(){
  errFunc = spellWordChanged;  
  oForm = document.forms["spell_form"];
  if ( oForm.elements["btnCancelChanges"].style.display == "none"){
    oForm.elements["sp_suggests"].selectedIndex=-1;
    oForm.elements["btnCancelChanges"].style.display="block";
    oForm.elements["btnSkip"].style.display="none";
    oForm.elements["btnSkipAll"].disabled=true;
    oForm.elements["sp_suggests"].disabled=true;

    oForm.elements["btnChange"].disabled = false;

    setSentence(false);
  }
}


function checkSpell() {
  errFunc = checkSpell;  

  var bSkip = false;

  while (iError < oDoc.SpellingErrors.Count){

    iError++; 

    spWordRange.setEndPoint('EndToEnd', spEditorRange);
    
    if (String((oDoc.SpellingErrors(iError)).length > 1)){
      var bFound = spWordRange.findText(oDoc.SpellingErrors(iError), 0, 6);    
    }else{
      var bFound = false;
    }
    
    // search debug
    repStr += iError+" word: '"+oDoc.SpellingErrors(iError).text+"' html: '"+spWordRange.text+"'\n";
    window.clipboardData.setData("Text", repStr);

    if (bFound) {
      for(var i=0;i<spSkipWords.length;i++ ){
        if (spWordRange.text == spSkipWords[i]) bSkip = true;
      }
      if (!bSkip){
//alert("found in word: '"+oDoc.SpellingErrors(iError).text+"'");
        if (spWordRange.text.charAt(spWordRange.text.length - 1) == " "){
          spWordRange.moveEnd('character', -1);
        }
        spWordRange.select();
        oDoc.SpellingErrors(iError).LanguageDetected = false;
        //oDoc.SpellingErrors(iError).DetectLanguage();
        var sLang = langNames[oDoc.SpellingErrors(iError).LanguageID];
        if (!oDoc.SpellingErrors(iError).LanguageDetected){
          oDoc.SpellingErrors(iError).DetectLanguage();
          var sLang = langNames[oDoc.SpellingErrors(iError).LanguageID];
          if (!oDoc.SpellingErrors(iError).LanguageDetected){
            var sLang = langNames[window.opener.wdNoProofing];
          }
        }

        document.all['sp_language'].innerHTML = sLang;
        var cSuggests = oDoc.SpellingErrors(iError).getSpellingSuggestions();

        if (cSuggests.SpellingErrorType == 0){
          //alert(oDoc.SpellingErrors(iError).GrammaticalErrors.Count);
          document.all['sp_description'].innerHTML = gramm_err;
        }else{
          document.all['sp_description'].innerHTML = spell_err;
        }

        oForm = document.forms["spell_form"];
        oForm.disabled = false;
        oForm.elements["sp_word"].value=spWordRange.text;
        oForm.elements["sp_suggests"].disabled=false;

        document.all['sp_wnd_status'].innerHTML=spmsg_status;
        iProgress = Math.round(iError/oDoc.SpellingErrors.Count*100);
        document.all['sp_wnd_progress'].innerHTML=iProgress+'%';
        document.all['sp_wnd_progress'].style.width=iProgress+'%';

        var elNum = oForm.elements["sp_suggests"].options.length;
        for(var i=elNum; i>=0; i--){
          oForm.elements["sp_suggests"].options.remove(i);
        }

        for(var i=1;i<=cSuggests.count;i++){
          var oOption = document.createElement("OPTION");
          oForm.elements["sp_suggests"].options.add(oOption);
          oOption.value = cSuggests(i);
          oOption.innerHTML = cSuggests(i);
        }

        if (cSuggests.count > 0){
          oForm.elements["sp_suggests"].selectedIndex = 0;
          oForm.elements["btnChangeAll"].disabled = false;
          oForm.elements["btnChange"].disabled = false;
        }else{
          oForm.elements["btnChangeAll"].disabled = true;
          oForm.elements["btnChange"].disabled = true;
        }
        setSentence(true);
        return true;
      }
    }
    if (iProgress < Math.round(iError/oDoc.SpellingErrors.Count*100)){
      iProgress = Math.round(iError/oDoc.SpellingErrors.Count*100);
      document.all['sp_wnd_progress'].innerHTML=iProgress+'%';
      document.all['sp_wnd_progress'].style.width=iProgress+'%';
      tbTimer = window.setTimeout ("checkSpell()",1);
      return;
    }
  }
  spWordRange.select();
  window.returnValue = true;
  window.close();
}


function spellCancelChanges(){
  errFunc =spellCancelChanges ;  

  oForm = document.forms["spell_form"];
  oForm.elements["sp_word"].value=spWordRange.text;
  resetButtons();
  setSentence(true);
}

function resetButtons(){
  errFunc = resetButtons;  
  oForm.elements["btnCancelChanges"].style.display="none";
  oForm.elements["btnSkip"].style.display="block";
  oForm.elements["btnSkipAll"].disabled=false;
  oForm.elements["btnChange"].disabled=false;
  if (oForm.elements["sp_suggests"].options.length > 0){
    oForm.elements["btnChange"].disabled = false;
    oForm.elements["btnChangeAll"].disabled=false;
    oForm.elements["sp_suggests"].disabled=false;
  }else{
    oForm.elements["btnChange"].disabled = true;
    oForm.elements["btnChangeAll"].disabled=true;
    oForm.elements["sp_suggests"].disabled=true;
  }
}

function setOperationTimeout(sOp, iTime){
  errFunc = setOperationTimeout;  
  document.all['sp_wnd_status'].innerHTML=sp_wnd_status_process;
  window.setTimeout(sOp, iTime);
}

