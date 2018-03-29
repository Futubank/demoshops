%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/sys_modules_popup.lng"%%

<!--#set var="owner" value="
<tr><td valign=middle>
<div style="border:1px #FFFFFF solid;padding:2px;">
<table style="cursor:pointer;" onclick="changeOwnerRWD('##name##')"
width="100%" cellspacing="0" cellpadding="0" border="0" height=55><tr><td width=55><img   src="skins/vanilla/images/owner_##name##_icon##type##.gif" border="0" width="55" height="60"></td>
<td style="vertical-align:middle;width:125px;height:55px;font-size:11px;font-family:Tahoma;white-space:nowrap;background: url(skins/vanilla/images/owner_##name##_label_bg.gif) no-repeat left top;">##caption##</td>
<td background="skins/vanilla/images/owner_##name##_line_bg.gif" style="padding-top:12px">&nbsp;</td>
<td width=19><img src="skins/vanilla/images/owner_##name##_line_end.gif"></td>
</table>

<div style="padding-left:50px" id=block_##name## class="##name##_block_popup">
##modules##
</span>

</div></td></tr>
"-->

<!--#set var="HSplitter" value=""-->
<!--#set var="VSplitter" value=""-->

<!--#set var="module" value="

<label for="fmod_##name##">
<div class="start-module-block-1">
  <div class="start-module-block" id="mod-cap-##name##">
    <div class="mod-cap"
    onclick="changeRWD('##name##');"
    onmouseover="document.getElementById('mod-cap-##name##').className='start-module-block-over';"
    onmouseout="document.getElementById('mod-cap-##name##').className='start-module-block';">
    <nobr>
    ##if(module_icon)##
      <img src="##module_icon##" align=absmiddle class="module-icon">
    ##else##
      <img src="skins/vanilla/images/##name##_icon##type##.gif" align=absmiddle  class="module-icon">
    ##endif##
    <label for="modacc_r_##name##"><input type="checkbox" name="modacc_r_##name##" id="modacc_r_##name##" value=1 onClick="cbChanged(this)">&nbsp;##caption##&nbsp;</label>
    </nobr>
    </div>
  </div>
</div>
</label>
"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
##metas##
<title>%%site_title%% - %%title%%</title>
<link rel="stylesheet" href="##skin_path##_css/style.css" type="text/css" />
<link rel="stylesheet" href="##skin_path##_css/scroll_bars.css" type="text/css" />
<script type="text/javascript">
var editorBaseHref = '##root_path_www##';
</script>
##scripts##
<script type="text/javascript">

var SYS_RIGHTS = Array();
SYS_RIGHTS['d'] = 1;
SYS_RIGHTS['w'] = 2;
SYS_RIGHTS['r'] = 4;

var checkOn = '#00CC99';
var checkOff = '#D00000';

function Init() {
  var editorBaseHref = top.editorBaseHref;
  var rightsCount = 0;
  var modCount = 0;

    var inputs = document.getElementsByTagName("input");
    for(var i=0; i<inputs.length; i++) {
        var name = inputs[i].name;
        if(inputs[i].type == "checkbox" && name.substr(0,7) == "modacc_") {
            var modname = name.substr(9);
            var r = name.substr(7,1);
            if('undefined' === typeof(top.document.forms['groupsform'].elements['modacc_'+modname])){
                if('undefined' !== typeof(console)){
                    console.log('init: missing module ' + modname);
                }
                continue;
            }
            var rights = parseInt(top.document.forms['groupsform'].elements['modacc_'+modname].value);
            if(rights & SYS_RIGHTS[r]) {
                inputs[i].checked = true;
                inputs[i].style.backgroundColor = checkOn;
                rightsCount += 1;
            } else {
                inputs[i].style.backgroundColor = checkOff;
            }
            modCount += 1;
        }
    }

    if ((rightsCount > 0) && (modCount == rightsCount)) {
        document.getElementById('selectall1').checked = true;
        document.getElementById('selectall2').checked = true;
    }

}

function changeOwnerRWD(name){

    var state = true;
    var aInputs = document.getElementById('block_'+name).getElementsByTagName("INPUT");
    for (i=0;i<aInputs.length;i++){
      if ((aInputs[i].type=="checkbox") && aInputs[i].checked){
        state = false;
        break;
      }
    }
    for (i=0;i<aInputs.length;i++){
      if ((aInputs[i].type=="checkbox")){
        aInputs[i].checked = state;
        if (state) {
            aInputs[i].style.backgroundColor = checkOn;
        } else {
            aInputs[i].style.backgroundColor = checkOff;
        }
      }
    }

    if (!state) {
        document.getElementById('selectall1').checked = false;
        document.getElementById('selectall2').checked = false;
    }
}


function changeRWD(modname){
    state = !document.modulesform.elements['modacc_r_'+modname].checked;
    document.modulesform.elements['modacc_r_'+modname].checked = state;

    if (state) {
        document.modulesform.elements['modacc_r_'+modname].style.backgroundColor = checkOn;
    } else {
        document.modulesform.elements['modacc_r_'+modname].style.backgroundColor = checkOff;
        document.getElementById('selectall1').checked = false;
        document.getElementById('selectall2').checked = false;
    }
}


function cbChanged(cb) {

    var modname = cb.name.substr(9);
    var r = cb.name.substr(7,1);

    if(r=='r') {
        if(!cb.checked) {
//            document.modulesform.elements['modacc_w_'+modname].checked = false;
//            document.modulesform.elements['modacc_d_'+modname].checked = false;
              cb.style.backgroundColor = checkOff;
        }
    } else if(cb.checked) {
            document.modulesform.elements['modacc_r_'+modname].checked = true;
    }

    if (cb.checked) {
        cb.style.backgroundColor = checkOn;
    } else {
        cb.style.backgroundColor = checkOff;
        document.getElementById('selectall1').checked = false;
        document.getElementById('selectall2').checked = false;
    }
}


function applyForm() {

    var inputs = document.getElementsByTagName("input");
    var mods = Array();

    for(var i=0; i<inputs.length; i++) {
        var name = inputs[i].name;
        if(inputs[i].type == "checkbox" && name.substr(0,7) == "modacc_") {
            var modname = name.substr(9);
            var r = name.substr(7,1);
            if('undefined' === typeof(top.document.forms['groupsform'].elements['modacc_'+modname])){
                if('undefined' !== typeof(console)){
                    console.log('apply: missing module ' + modname);
                }
                continue;
            }
            var rights = parseInt(top.document.forms['groupsform'].elements['modacc_'+modname].value);
            if(inputs[i].checked) {
                rights |= SYS_RIGHTS[r];
                mods[modname] = 1;
            } else
                rights &= ~SYS_RIGHTS[r];
            top.document.forms['groupsform'].elements['modacc_'+modname].value = rights;
        }
    }
    top.document.forms['groupsform'].num_modules.value = 0;
    for(modname in mods) {
        if (modname != 'indexOf') {
            top.document.forms['groupsform'].num_modules.value++;
        }
    }

    closeDialogWindow();
    return false;
}

function selectAll(checked){
    var inputs = document.getElementsByTagName("input");
    for(var i=0;i<inputs.length;i++)
    if(inputs[i].type == "checkbox" && inputs[i].name != "selectall"){
        if(checked && !inputs[i].checked) {
            inputs[i].checked = true;
            inputs[i].style.backgroundColor = checkOn;
        } else if(!checked && inputs[i].checked) {
            inputs[i].checked = false;
            inputs[i].style.backgroundColor = checkOff;
        }
    } else if (inputs[i].name == "selectall") {
        if (checked) {
            inputs[i].checked = true;
        } else {
            inputs[i].checked = false;
        }
    }
}

function checkModulesForm(obj){
    // If one module at least should be selected remove next return
    return true;

    var inputs = obj.getElementsByTagName("input");
    var found = false;
    for(var i=0;i<inputs.length;i++)
    if(inputs[i].type == "checkbox" && inputs[i].name != "selectall"){
        if(inputs[i].checked){
            found = true;
            break;
        }
    }

    if(!found){
        alert('%%not_selected%%');
        return false;
    }

    return true;
}

</script>
</head>

<body id=bdy leftmargin="0" topmargin="0" bgcolor="#FFFFFF">

<table cellspacing="0" cellpadding="5" align="center" width=100% id="popup_content">
<form action="##script_link##" method=post name="modulesform" onSubmit="return checkModulesForm(this)">
<tr>
    <td>
    <nobr>
    <input type="button" class="but" onClick="applyForm();" value="&nbsp;&nbsp;&nbsp;%%apply_btn%%&nbsp;&nbsp;&nbsp;">&nbsp;
    <BUTTON class="but" ID=btnOK  tabIndex=50 onClick="closeDialogWindow()">&nbsp;&nbsp;&nbsp;%%close_btn%%&nbsp;&nbsp;&nbsp;</BUTTON>
    </nobr>
    </td>
</tr>

<tr><td>
<!--##filter_hidden_fields##
<input type="hidden" name="groupId" value="##group_id##">
<input type="hidden" name="module_ids" value="##module_ids##">
<input type="hidden" name="action" value="##action##">
-->
<table border=0 cellpadding=0 cellspacing=10 width=100%>
<tr><td><input type="checkbox" name="selectall" id="selectall1" onClick="selectAll(this.checked)"><label for="selectall1"><b>&nbsp;%%select_all%%</b></label></td></tr>

##list_modules##

<tr><td><input type="checkbox" name="selectall" id="selectall2" onClick="selectAll(this.checked)"><label for="selectall2"><b>&nbsp;%%select_all%%</b></label></td></tr>
</table>
</td></tr>

<tr>
    <td>
    <nobr>
    <input type="button" class="but" onClick="applyForm();" value="&nbsp;&nbsp;&nbsp;%%apply_btn%%&nbsp;&nbsp;&nbsp;">&nbsp;
    <BUTTON class="but" ID=btnOK  tabIndex=50 onClick="closeDialogWindow(); return false;">&nbsp;&nbsp;&nbsp;%%close_btn%%&nbsp;&nbsp;&nbsp;</BUTTON>
    </nobr>
    <br>&nbsp;
    </td>
</tr>
</form>
</table>

<script type="text/javascript">
Init();
</script>

</body>
</html>