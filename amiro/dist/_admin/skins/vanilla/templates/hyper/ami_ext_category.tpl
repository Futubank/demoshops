##--system info: module_owner="" module="" system="1"--##
<!--#set var="cat_header_column" value="<a href="#" onclick="var oFilter = document.getElementById('flt_form');oFilter.elements['category'].value = ##id##;oFilter.onsubmit();return false;">##header## &raquo;</a>"-->

<!--#set var="select_field(name=id_cat)" value="

<script type="text/javascript">
var skipCategoryOnBlur = [];
if(typeof(document.forms[_cms_document_form].id_page) == 'object'){
    document.forms[_cms_document_form].id_page.disabled = true;
}

var backupValidators = false;

function OnObjectKeyUp(oElement){
  if(oElement.name == 'catname'){
    if(typeof(oElement.form.id_cat) == 'object'){
     oElement.form.id_cat.disabled = oElement.value != '';
     if(oElement.value){
	if(!backupValidators){
	    backupValidators = oElement.form.id_cat.getAttribute('data-ami-validators');
            oElement.form.id_cat.setAttribute('data-ami-validators', '');
	}
     }else{
	if(backupValidators){
            oElement.form.id_cat.setAttribute('data-ami-validators', backupValidators);
            backupValidators = false;
	}
     }
    }
    if(typeof(oElement.form.catname_id_page) == 'object'){
        oElement.form.catname_id_page.disabled = oElement.value == '';
        var o = document.getElementById('div_add_subcategory_id_page');
        makeElementVisible(o, 'block');
    }
  }
  return true;
}

function categoryOnBlur(form)
{
    var catname = form.catname.value;

    if(!_cms_document_form_changed && catname){
    	_cms_document_form_changed = true;
    }

    if (catname.length && typeof(form.id_cat) == 'object' && skipCategoryOnBlur.indexOf(catname) < 0 && catname == fromHTMLToText(form.id_cat.options[form.id_cat.selectedIndex].innerHTML)){
        if (confirm('%%warn_same_category_name%%')){
            skipCategoryOnBlur.push(catname);
        } else {
            form.catname.value = '';
            form.id_cat.disabled = false;
        }
    }

    if (typeof(document.getElementById('div_add_subcategory_id_page')) == 'object' && document.getElementById('div_add_subcategory_id_page') != null){
        AMI.find('#div_add_subcategory_id_page').style.display = catname.length < 1 ? 'none' : '';
    }

    var mod = AMI.Page.aModules['##_mod_id##'];

    if (typeof(document.getElementById('div_add_subcategory')) == 'object' && document.getElementById('div_add_subcategory') != null){
        if (catname.length < 1){
            AMI.find('#div_add_subcategory').style.display='none';
            AMI.find('#img_add_subcategory').style.display='';
            mod.refreshFilterAfterSubmit = false;
        } else {
        	AMI.find('#div_add_subcategory').style.display='';
            AMI.find('#img_add_subcategory').style.display='none';
            mod.refreshFilterAfterSubmit = true;
        }
    }

    if(typeof(form.id_page) == 'object'){
    	if(form.id_page.disabled){
            form.id_page.value = getElementAttribute(form.id_cat.options[form.id_cat.selectedIndex], 'id_page', false);
            form.id_page.disabled = false;
    	}
    }
}

</script>

<tr>
    <td>%%form_field_##caption##%%##IF(validator_filled)##*##ENDIF##:</td>
    <td>
        <select name="##name##" data-ami-validators="##validators##"##ENDIF####attributes##>##select##</select> <a onclick="AMI.find('#img_add_subcategory').style.display = 'none'; AMI.find('#div_add_subcategory').style.display='block'; return false;"><img id="img_add_subcategory" class="icon" src="skins/vanilla/icons/icon-add.gif" title="%%create_subcategory%%" align="absmiddle" /></a><br />
        <table cellspacing="5" cellpadding="0" border="0" class="frm" id="div_add_subcategory" style="display: none;">
        <col width="150">
        <col width="*">
        <tr>
            <td style="font-size: 10px">%%create_subcategory%%<sup>##new_category_required##</sup>:</td>
            <td><input type="text" name="catname" class="field field40"  maxlength="255" onkeyPress="syncWithSelect(event, this.form.id_cat, this);" onBlur="categoryOnBlur(this.form);" />
            <a onclick="var form = document.forms[_cms_document_form]; form.catname.value=''; categoryOnBlur(form); form.id_cat.disabled=false; if(AMI.find('#div_add_subcategory')){ AMI.find('#div_add_subcategory_id_page').style.display='none'; AMI.find('#div_add_subcategory').style.display='none'; AMI.find('#img_add_subcategory').style.display='inline'; } return false;"><img id="img_hide" src="skins/vanilla/icons/icon-notinstalled.gif" title="%%hide%%" align="absmiddle" style="cursor: pointer;" class="icon"></a><script>if(typeof(document.forms[_cms_document_form].id_cat)=='undefined'){document.getElementById('img_hide').style.display='none';}</script></td>
        </tr>
##if(catname_id_page)##
##else##
        <tr id="div_add_subcategory_id_page" style="display: none;"></tr>
        </table>
    </td>
</tr>
##endif##
"-->

<!--#set var="select_field(name=catname_id_page)" value="
<tr id="div_add_subcategory_id_page" style="display: none;">
    <td align="right" style="font-size: 10px;">%%select_page%%:</td>
    <td><select name="##name##" data-ami-validators="##validators##"##ENDIF####attributes##>##select##</select></td>
</tr>
</table>
</td>
</tr>
"-->

<!--#set var="cat_header_column" value="<a href="#" onclick="if(AMI.Page.aModules['##_mod_id##']){var oFilter = AMI.Page.aModules['##_mod_id##'].getComponentsByType('form_filter')[0].oDOMElement; oFilter.elements['category'].value = ##id##; oFilter.onsubmit();} return false;">##header## &raquo;</a>"-->
