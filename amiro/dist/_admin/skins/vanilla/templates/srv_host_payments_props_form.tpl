%%include_language "templates/lang/_currency.lng"%%
%%include_language "templates/lang/srv_host_payments.lng"%%
%%include_language "templates/lang/srv_host_payments_props.lng"%%
%%include_template "templates/_payments_docs.tpl"%%

<!--#set var="prop_form_ru" value="

<script>

  function setBlock(block){
          document.getElementById('block_company').style.display='none';
          document.getElementById('block_ip').style.display='none';
          document.getElementById('block_person').style.display='none';
          document.getElementById('block_company').disabled = true;
          document.getElementById('block_ip').disabled = true;
          document.getElementById('block_person').disabled = true;
                if (block!=''){
                  document.getElementById('block_'+block).style.display='block';
                  document.getElementById('block_'+block).disabled = false;
                        if (document.getElementById('block_bank')){
                          document.getElementById('block_bank').style.display='block';
                        }
                }else{
                        if (document.getElementById('block_bank')){
                          document.getElementById('block_bank').style.display='none';
                        }
                }

        var aBlocks = new Array('company', 'ip', 'person');
        for(i = 0; i < aBlocks.length; i++){
            var oBlock = document.getElementById('block_' + aBlocks[i]);
            if(oBlock != null){
                var aInputs = oBlock.getElementsByTagName('input');
                for(ii = 0; ii < aInputs.length; ii++){
                    aInputs[ii].disabled = !(aBlocks[i] == block);
                }
                var aTextareas = oBlock.getElementsByTagName('textarea');
                for(ii = 0; ii < aTextareas.length; ii++){
                    aTextareas[ii].disabled = !(aBlocks[i] == block);
                }
            }
        }
  }


var _cms_document_form = 'propsform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

        function checkForm(form){
                var oForm = document.forms[_cms_document_form];
                if (oForm.elements["props_type"].value==''){
                        alert('Укажите форму собственности');
                        oForm.elements["props_type"].focus();
                        return false;
                }
                if (oForm.elements["props_type"].value=='person'){
                        i = 0;
                }else if (oForm.elements["props_type"].value=='ip'){
                        i = 1;
                }else if (oForm.elements["props_type"].value=='company'){
                        i = 2;
                }


                if (oForm.elements["props_name"][i].value.length < 3){
                        if (oForm.elements["props_type"].value=='company'){
                                alert('Введите название компании');
                        }else{
                                alert('Введите ФИО');
                        }
                        oForm.elements["props_name"][i].focus();
                        return false;
                }

                if (oForm.elements["props_type"].value!='person'){
                        if (oForm.elements["props_inn"][i].value.length < 10){
                                alert('Введите ИНН');
                                oForm.elements["props_inn"][i].focus();
                                return false;
                        }
                }

                if (oForm.elements["props_type"].value=='company'){
                        if (oForm.elements["ext_kpp"].value.length < 8){
                                alert('Введите КПП');
                                oForm.elements["ext_kpp"].focus();
                                return false;
                        }
                        if (oForm.elements["props_address"].value.length < 20){
                                alert('Введите юридический адрес');
                                oForm.elements["props_address"].focus();
                                return false;
                        }
                }else if(oForm.elements["props_type"].value=='ip'){
                        /*
                        if ((oForm.elements["props_inn"][i].value.length < 12) && (oForm.elements["ext_passport"][i].value.length < 20)){
                                alert('Введите паспортные данные или ИНН');
                                oForm.elements["props_inn"][i].focus();
                                return false;
                        }
            if (oForm.elements["ext_birthday"][i].value.length < 10){
                                alert('Введите дату рождения');
                                oForm.elements["ext_birthday"][i].focus();
                                return false;
                        }
            */
                }


                if (oForm.elements["props_type"].value!='person'){
                        if (oForm.elements["props_post_address"][i].value.length < 20){
                                alert('Введите почтовый адрес');
                                oForm.elements["props_post_address"][i].focus();
                                return false;
                        }
                        if (oForm.elements["props_fiz_address"][i-1].value.length < 20){
                                alert('Введите адрес грузополучателя');
                                oForm.elements["props_fiz_address"][i-1].focus();
                                return false;
                        }
                        if (oForm.elements["props_phone"][i].value.length < 14){
                                alert('Введите телефон');
                                oForm.elements["props_phone"][i].focus();
                                return false;
                        }
                }


                if (oForm.elements["props_email"][i].value.length < 8){
                        alert('Введите адрес электронной почты');
                        oForm.elements["props_email"][i].focus();
                        return false;
                }
##--
                if (oForm.elements["props_type"].value=='company'){
                        if (oForm.elements["ext_fio"].value.length < 5){
                                alert('Введите ФИО ответственного лица');
                                oForm.elements["ext_fio"].focus();
                                return false;
                        }
                }
--##
    ##if(read_only)##
                if ((!oForm.elements["update_docs"].checked)||(oForm.elements["update_docs_date"].value=="")){
        alert('Подтвердите дату изменения реквизитов.');
                                return false;
                }
    ##endif##

                if (oForm.elements["action"].value!="add"){
                        if (!confirm('Вы уверены, что хотите изменить реквизиты?')){
                                return false;
                        }
                }
        }

function OnObjectChanged_srv_host_payments_props_form(name, first_change, evt){
        if (name=='props_type' ){
                setBlock(document.forms[_cms_document_form].elements["props_type"].value);
        }
  ##if(read_only)##
  document.getElementById("changes_date").style.display='block';
  ##endif##
  return true;
}
addFormChangedHandler(OnObjectChanged_srv_host_payments_props_form);

</script>
<form name=propsform action=##script_link## method=post onsubmit="return checkForm(this)">
<input type="hidden" name="action" value="##action##">
<input type="hidden" name="activate" value="##is_active##">
<input type="hidden" name="id" value="##id##">
##filter_hidden_fields##
<br>
<TABLE cellSpacing=5 width="100%" border=0 cellpadding="5">
<TBODY>
<tr>
<td class="tooltip"><table><tr><td valign="top">%%attention_note%%</td><td>%%properties_note%%</td></tr></table></td>
<tr>
##if(!read_only)##
<td valign="top" bgcolor="#f0f0f0" style="font-size:11px;"><br>
<b>Форма собственности:</b>&nbsp;&nbsp;&nbsp;
<select name="props_type">
<option value=>Укажите форму собственности</option>
<option value=company>Юридическое лицо</option>
<option value=ip>Индивидуальный предприниматель</option>
<option value=person>Частное лицо</option>
</select>
<br><br></td>
##else##
<td><input type=hidden name="props_type" value=""></td>
##endif##
</tr></TBODY></TABLE>

<div id=block_person style="display:none">
<TABLE cellSpacing=5 width="100%" border=0 cellpadding="5">
<TBODY>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Фамилия, имя, отчество*</b>: заполняется по-русски в соответствии с паспортными данными, для нерезидентов допускается заполнение на английском языке. <br><br>Пример: <i>Сидоров Сидор Сидорович</i></td><td valign="top">
##if(!read_only)##
<input type="text" class="field" name="props_name" value="##name##" style="width: 240px;">
##else##
<b>##name##</b>
<input type=hidden name="props_name" value="##name##">
##endif##
</td></tr>
##if(host)##
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Альтернативное наименование организации</b>:  Может использоваться при формировании счетов. Поле заполняется по-русски. <br><br>Пример: <i>Компания "Новое время"</i></td><td valign="top"><textarea name="ext_alt_name" class="field" wrap="soft" style="width: 240px;" rows="4">##alt_name##</textarea></td></tr>
##endif##
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>ИНН</b>: заполняется при наличии ИНН<br><br>Пример: <i>772900164552</i></td><td valign="top">
##if((!read_only)||(inn==""))##
<input type="text" class="field" name="props_inn" value="##inn##" style="width:120px;" maxlength=12>
##else##
<b>##inn##</b>
<input type="hidden" name="props_inn" value="##inn##" >
##endif##
</td></tr>
##--
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Паспортные данные</b>: серия, номер, кем выдан, дата выдачи, место регистрации с указанием города, улицы, номера дома и квартиры, если частный дом, должно быть указано "частный дом". Поле заполняется по-русски, для нерезидентов допускается заполнение на английском языке. <br><br><i>Пример:<br>12 34 567890 выдан 123 отделением милиции г.Москвы, 30.01.1990 <br>зарегистрирован по адресу: Москва, ул.Кошкина, д.15, кв.4</i>	</td><td valign="top"><textarea name="ext_passport" class="field" wrap="soft" style="width: 240px;" rows="4">##passport##</textarea></td></tr>
--##
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Дата рождения</b>: указывается цифрами через точку в формате DD.MM.YYYY, где DD - число, MM - месяц, YYYY - год. <br><br>Пример: <i>18.10.1965</i></td><td valign="top">
##if(!read_only||(birthday==""))##
<input type="text" class="field" name="ext_birthday" value="##birthday##" style="width:80px;" maxlength=10>
<a href="javascript: void(0);" onclick="return getCalendar(event, document.propsform.ext_birthday[0]);">
         <img class="clnd_img" src="skins/vanilla/images/spacer.gif" helpId= "clnd_date"/></a>
##else##
<b>##birthday##</b>
<input type="hidden" name="ext_birthday" value="##birthday##">
##endif##
         </td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Почтовый адрес</b>: будет использоваться для рассылки возможных уведомлений и официальных документов. Поле заполняется по-русски, для нерезидентов допускается заполнение на английском языке. <br><br>Пример: <i>123456, Москва, ул.Кошкина, д.15, кв.4 <br>Сидорову Сидору Сидоровичу</i></td><td valign="top"><textarea name="props_post_address" style="width: 240px;" class="field" rows="4" >##post_address##</textarea></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Телефон</b>: с обязательным указанием международного кода и кода города. Информация по каждому телефону должна быть представлена отдельной строкой. <br> <br>Пример: <i>+7 495 1234567<br> +7 495 1234568<br> +7 495 1234569</i>	</td><td valign="top"><textarea name="props_phone" class="field" wrap="soft" style="width: 240px;" rows="4">##phone##</textarea></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Телефон для SMS уведомлений</b>: номер телефон оператора мобильной связи для уведомлений о балансе. <br> <br>Пример: <i>+7 913 1234567</i>	</td><td valign="top"><input type="text" name="ext_mob_phone" class="field" wrap="soft" style="width: 240px;" value="##mob_phone##"></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Адрес электронной почты*</b>: адреса из этого поля будут использоваться для отправки электронных копий квитанций для оплаты.<br> <br>Пример: <i>adm-group@my-internet-name.ru <br>sidor@test.my-provider.ru</i></td>
<td valign="top"><textarea name="props_email" class="field" wrap="soft" style="width: 240px;" rows="4">##email##</textarea></td>
</tr>
</TBODY></TABLE>
</div>

<div id=block_ip style="display:none">
<TABLE cellSpacing=5 width="100%" border=0 cellpadding="5">
<TBODY>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Фамилия, имя, отчество*</b>: заполняется по-русски в соответствии с паспортными данными, для нерезидентов допускается заполнение на английском языке. <br><br> Пример: <i>ИП Сидоров Сидор Сидорович</i></td><td valign="top">
##if(!read_only)##
<input type="text" class="field" name="props_name" value="##name##" style="width: 240px;">
##else##
<b>##name##</b>
<input type=hidden name="props_name" value="##name##">
##endif##
</td></tr>
##if(host)##
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Альтернативное наименование организации</b>:  Может использоваться при формировании счетов. Поле заполняется по-русски. <br><br>Пример: <i>Компания "Новое время"</i></td><td valign="top"><textarea name="ext_alt_name" class="field" wrap="soft" style="width: 240px;" rows="4">##alt_name##</textarea></td></tr>
##endif##
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>ИНН предпринимателя*</b>: обязательно для заполнения. Данные из этого поля будут использоваться при формировании счетов на оплату и счетов-фактур. <br><br>Пример: <i>772900164552</i></td><td valign="top">
##if(!read_only)##
<input type="text" class="field" name="props_inn" value="##inn##" style="width:120px;" maxlength=12>
##else##
<b>##inn##</b>
<input type="hidden" name="props_inn" value="##inn##" >
##endif##
</td></tr>
##--
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Паспортные данные</b>: серия, номер, кем выдан, дата выдачи, место регистрации с указанием города, улицы, номера дома и квартиры, если частный дом, должно быть указано "частный дом". Поле заполняется по-русски, для нерезидентов допускается заполнение на английском языке. <br><br>Пример: <i><br>12 34 567890 выдан 123 отделением милиции г.Москвы, 30.01.1990 <br>зарегистрирован по адресу: Москва, ул.Кошкина, д.15, кв.4</i>	</td><td valign="top"> <textarea name="ext_passport" class="field" wrap="soft" style="width: 240px;" rows="4">##passport##</textarea></td></tr>
--##
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Дата рождения</b>: указывается цифрами через точку в формате DD.MM.YYYY, где DD - число, MM - месяц, YYYY - год. <br><br>Пример: <i>18.10.1965</i></td><td valign="top">
##if(!read_only||(birthday==""))##
<input type="text" class="field" name="ext_birthday" value="##birthday##" style="width:80px;" maxlength=10>
<a href="javascript: void(0);" onclick="return getCalendar(event, document.propsform.ext_birthday[1]);">
         <img class="clnd_img" src="skins/vanilla/images/spacer.gif" helpId= "clnd_date"/></a>
##else##
<b>##birthday##</b>
<input type="hidden" name="ext_birthday" value="##birthday##">
##endif##
</td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Почтовый адрес*</b>: будет использоваться для рассылки возможных уведомлений и официальных документов. Поле заполняется по-русски, для нерезидентов допускается заполнение на английском языке. <br><br>Пример: <i>123456, Москва, ул.Кошкина, д.15, кв.4 <br>Сидорову Сидору Сидорович</i>у</td><td valign="top"><textarea name="props_post_address" style="width: 240px;" rows="4" type="text" class="field">##post_address##</textarea></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Адрес грузополучателя*</b>: почтовый адрес без названия организации и указания лиц, получающих корреспонденцию. Данные из этого поля будут использоваться при формировании счетов- фактур в поле "Грузополучатель и его адрес". <br><br>Пример: <i>123456, Москва, ул.Собачкина, д.13а<br>Пример для филиалов: 248600, г. Калуга, ул. Театральная, д. 36</i><br>(почтовый адрес филиала)	</td><td valign="top"><textarea name="props_fiz_address" class="field" wrap="soft" style="width: 240px;" rows="4">##fiz_address##</textarea></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Телефон*</b>: с обязательным указанием международного кода и кода города. Информация по каждому телефону должна быть представлена отдельной строкой. <br> <br>Пример: <i>+7 495 1234567<br> +7 495 1234568<br> +7 495 1234569</i>	</td><td valign="top"><textarea name="props_phone" class="field" wrap="soft" style="width: 240px;" rows="4">##phone##</textarea></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Телефон для SMS уведомлений</b>: номер телефон оператора мобильной связи для уведомлений о балансе. <br> <br>Пример: <i>+7 913 1234567</i>	</td><td valign="top"><input type="text" name="ext_mob_phone" class="field" wrap="soft" style="width: 240px;" value="##mob_phone##"></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Факс</b>: с обязательным указанием международного кода и кода города. Информация по каждому факсу должна быть представлена отдельной строкой. <br> <br>Пример: <i>+7 495 1234560	</i></td><td valign="top"><textarea name="props_fax" class="field" wrap="soft" style="width: 240px;" rows="4">##fax##</textarea></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Адрес электронной почты*</b>: адреса из этого поля будут используется для отправки электронных копий счетов, счетов-фактур и актов.<br> <br>Пример: <i>adm-group@my-internet-name.ru <br>sidor@test.my-provider.ru	</i></td><td valign="top"><textarea name="props_email" class="field" wrap="soft" style="width: 240px;" rows="4">##email##</textarea></td></tr>
##if(host_user)##
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Период выставления актов (счетов-фактур)</b>: акты (счета-фактуры) выставляются до 10-го числа месяца следующего за отчетным периодом на сумму соответствующую стоимости услуг оказанных за прошедший период.<br> <br>Пример: <i>если вы оплатили первый счет 10-го мая и указали отчетный период "Квартал", первый акт (счет-фактура) ( от 30-го июня ) будет выставлен в начале следующего квартала, т.е. до 10-го июля на сумму соответствующую стоимости оказанных услуг за период с 10-го мая по 30-е июня</td><td valign="top"><select name="ext_period"><option value=month>Месяц</option><option value=quarter>Квартал</option><option value=year>Год</option></select></td></tr>
##else##
<input type=hidden name="ext_period" value="##period##">
##endif##
</TBODY></TABLE>
</div>

<div id=block_company style="display:none">
<TABLE cellSpacing=5 width="100%" border=0 cellpadding="5">
<TBODY>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Полное наименование организации в соответствии с учредительными документами*</b>: включает организационно-правовую форму и полное (без сокращений!) наименование юридического лица в соответствии с учредительными документами. Используется при формировании счетов и счетов- фактур. Поле заполняется по-русски, для нерезидентов допускается заполнение на английском языке. <br><br>Пример: <i>ООО "Новое время"<br>Пример для филиалов: Калужский филиал ЗАО "Новое время"</i><br>(наименование филиала)	</td><td valign="top">
##if(!read_only)##
<textarea name="props_name" class="field" wrap="soft" style="width: 240px;" rows="4">##name##</textarea>
##else##
<b>##name##</b>
<input type=hidden name="props_name" value="##name##">
##endif##
</td></tr>
##if(host)##
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Альтернативное наименование организации</b>:  Может использоваться при формировании счетов. Поле заполняется по-русски. <br><br>Пример: <i>Компания "Новое время"</i></td><td valign="top"><textarea name="ext_alt_name" class="field" wrap="soft" style="width: 240px;" rows="4">##alt_name##</textarea></td></tr>
##endif##
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Наименование головной организации</b>: заполняется только филиалами. Указывается полное наименование головной организации. Используется при формировании счетов-фактур. <br><br>Пример: <i>Закрытое Акционерное Общество "Новое время"</i><br>(название головной организации)</td>	<td valign="top"><textarea name="ext_name_parent" class="field" wrap="soft" style="width: 240px;" rows="4">##name_parent##</textarea></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>ИНН*</b>: обязательно для организаций, зарегистрированных в РФ. Данные из этого поля будут использоваться при формировании счетов на оплату и счетов-фактур в поле "ИНН/КПП покупателя". <br><br>Пример: <i>1234567891</i></td><td valign="top">
##if(!read_only)##
<input type="text" class="field" name="props_inn" value="##inn##" style="width:120px;" maxlength=10>
##else##
<b>##inn##</b>
<input type="hidden" name="props_inn" value="##inn##" >
##endif##
</td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>КПП*</b>: код причины постановки на учет налогоплательщика покупателя. Обязательно для организаций, зарегистрированных в РФ. Данные из этого поля будут использоваться при формировании счетов-фактур в поле "ИНН/КПП покупателя". <br><br>Пример: <i>123456789</i></td><td valign="top"><input type="text" class="field" name="ext_kpp" value="##kpp##" style="width:80px;" maxlength=9></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Юридический адрес организации*</b>: место нахождения юридического лица в соответствии с учредительными документами. Данные из этого поля будут использоваться при формировании счетов и счетов-фактур. Для организаций, зарегистрированных в РФ, поле заполняется по-русски, для иностранных организаций - по-английски. <br><br>Пример: <i>123456, Москва, ул.Собачкина, д.13а,<br>Пример для филиалов: 123456, Москва, ул.Собачкина, д.13а</i><br>(место нахождения головной организации)</td>	<td valign="top"><textarea name="props_address" class="field" wrap="soft" style="width: 240px;" rows="4">##address##</textarea></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Почтовый адрес*</b>: будет использоваться для рассылки возможных уведомлений и официальных документов. Поле заполняется по-русски, для нерезидентов допускается заполнение на английском языке. <br><br>Пример: <i>123456, Москва, ул.Собачкина, д.13а, АО "Новое Время", Отдел телекоммуникаций, <br> Сидорову Сидору Сидоровичу.</i> </td><td valign="top"><textarea name="props_post_address" style="width: 240px;" rows="4" type="text" class="field">##post_address##</textarea></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Адрес грузополучателя*</b>: почтовый адрес без названия организации и указания лиц, получающих корреспонденцию. Данные из этого поля будут использоваться при формировании счетов- фактур в поле "Грузополучатель и его адрес". <br><br>Пример: <i>123456, Москва, ул.Собачкина, д.13а<br>Пример для филиалов: 248600, г. Калуга, ул. Театральная, д. 36</i><br>(почтовый адрес филиала)	</td><td valign="top"><textarea name="props_fiz_address" class="field" wrap="soft" style="width: 240px;" rows="4">##fiz_address##</textarea></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Телефон*</b>: с обязательным указанием международного кода и кода города. Информация по каждому телефону должна быть представлена отдельной строкой.<br> <br>Пример: <i>+7 495 1234567<br> +7 495 1234568<br> +7 495 1234569	</i></td><td valign="top"><textarea name="props_phone" class="field" wrap="soft" style="width: 240px;" rows="4">##phone##</textarea></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Телефон для SMS уведомлений</b>: номер телефон оператора мобильной связи для уведомлений о балансе. <br> <br>Пример: <i>+7 913 1234567</i>	</td><td valign="top"><input type="text" name="ext_mob_phone" class="field" wrap="soft" style="width: 240px;" value="##mob_phone##"></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Факс</b>: с обязательным указанием международного кода и кода города. Информация по каждому факсу должна быть представлена отдельной строкой.<br> <br>Пример: <i>+7 495 1234560</i>	</td><td valign="top"><textarea name="props_fax" class="field" wrap="soft" style="width: 240px;" rows="4">##fax##</textarea></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Адрес электронной почты*</b>: адреса из этого поля будут использоваться для отправки электронных копий счетов, счетов-фактур и актов.<br> <br>Пример: <i>adm-group@my-internet-name.ru <br>sidor@test.my-provider.ru</i>	</td><td valign="top"><textarea name="props_email" class="field" wrap="soft" style="width: 240px;" rows="4">##email##</textarea></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>ФИО ответственного лица*</b>: данные из этого поля будут использоваться для расшифровки подписи в актах. Можно не указывать.<br> <br>Пример: <i>Сидоров C.C.</i>	</td><td valign="top"><input type="text" class="field" name="ext_fio" value="##fio##" style="width: 240px;"></td></tr>
##if(host_user&&host!="1")##
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Период выставления актов (счетов-фактур)</b>: акты (счета-фактуры) выставляются до 10-го числа месяца следующего за отчетным периодом на сумму соответствующую стоимости услуг оказанных за прошедший период.<br> <br>Пример: <i>если вы оплатили первый счет 10-го мая и указали отчетный период "Квартал", первый акт (счет-фактура) ( от 30-го июня ) будет выставлен в начале следующего квартала, т.е. до 10-го июля на сумму соответствующую стоимости оказанных услуг за период с 10-го мая по 30-е июня</td><td valign="top"><select name="ext_period"><option value=month>Месяц</option><option value=quarter>Квартал</option><option value=year>Год</option></select></td></tr>
##else##
<input type=hidden name="ext_period" value="##period##">
##endif##
</TBODY></TABLE>
</div>
<br>
##if(host)##
<div id=block_bank style="display:none">
<b>&nbsp;Платежные реквизиты:</b>
<TABLE cellSpacing=5 width="100%" border=0 cellpadding="5">
<TBODY>
<tr><td colspan="2">
    <fieldset>
        <legend>Банк</legend>
        <table cellpadding="2" cellspacing="2" border="0" width="100%">
        <tr>
            <td valign="top" bgcolor="#f0f0f0" width="100%"><b>Банк</b>:</td>
            <td valign="top"><textarea name="bank_bank" class="field" wrap="soft" style="width: 240px;" rows="4">##bank##</textarea></td>
        </tr>
        <tr>
            <td valign="top" bgcolor="#f0f0f0" width="100%"><b>БИК</b>: </td><td valign="top"><input type="text" class="field" name="bank_bik" value="##bik##" style="width:80px;"></td></tr>
            <tr>
                <td valign="top" bgcolor="#f0f0f0" width="100%"><b>Расчетный счет</b>: </td>
                <td valign="top"><input type="text" class="field" name="bank_rs" value="##rs##" style="width: 240px;" maxlength=20></td>
            </tr>
            <tr>
                <td valign="top" bgcolor="#f0f0f0" width="100%"><b>Корр. счет</b>: </td>
                <td valign="top"><input type="text" class="field" name="bank_ks" value="##ks##" style="width: 240px;" maxlength=20></td>
            </tr>
            <tr>
                <td valign="top" bgcolor="#f0f0f0" width="100%"><b>Комиссия Банк %</b>:</td>
                <td valign="top"><input type="text" name="bank_bank_commission" class="field" wrap="soft" style="width: 40px;" value="##bank_commission##"></td>
            </tr>
        </table>
    </fieldset>
</td></tr>
<tr><td colspan="2" width="100%">
    <fieldset>
        <legend>Яндекс.Деньги</legend>
        <table cellpadding="2" cellspacing="2" border="0" width="100%">
        <tr>
            <td valign="top" bgcolor="#f0f0f0" width="100%"><b>Номер счета в Яндекс.Деньги</b>: </td>
            <td valign="top"><input type="text" class="field" name="bank_yandex" value="##yandex##" style="width: 240px;"></td>
        </tr>
        <tr>
            <td valign="top" bgcolor="#f0f0f0" width="100%"><b>Комиссия Яндекс.Деньги %</b>: </td>
            <td valign="top"><input type="text" class="field" name="bank_yandex_commission" value="##yandex_commission##" style="width: 40px;"></td>
        </tr>
        <tr>
            <td valign="top" bgcolor="#f0f0f0" width="100%"><b>Секретное слово Яндекс.Деньги</b>: </td>
            <td valign="top"><input type="text" class="field" name="bank_yandex_key" value="##yandex_key##" style="width: 240px;"></td>
        </tr>
        </table>
    </fieldset>
</td></tr>
<tr><td colspan="2">
    <fieldset>
        <legend>WebMoney</legend>
        <table cellpadding="2" cellspacing="2" border="0" width="100%">
        <tr>
            <td valign="top" bgcolor="#f0f0f0" width="100%"><b>WMR кошелек WebMoney</b>: </td>
            <td valign="top"><input type="text" class="field" name="bank_wmr" value="##wmr##" style="width: 240px;"></td>
        </tr>
        <tr>
            <td valign="top" bgcolor="#f0f0f0" width="100%"><b>WMZ кошелек WebMoney</b>: </td>
            <td valign="top"><input type="text" class="field" name="bank_wmz" value="##wmz##" style="width: 240px;"></td>
        </tr>
        <tr>
            <td valign="top" bgcolor="#f0f0f0" width="100%"><b>WME кошелек WebMoney</b>: </td>
            <td valign="top"><input type="text" class="field" name="bank_wme" value="##wme##" style="width: 240px;"></td>
        </tr>
        <tr>
            <td valign="top" bgcolor="#f0f0f0" width="100%"><b>Комиссия WebMoney %</b>: </td>
            <td valign="top"><input type="text" class="field" name="bank_wm_commission" value="##wm_commission##" style="width: 40px;"></td>
        </tr>
        <tr>
            <td valign="top" bgcolor="#f0f0f0" width="100%"><b>Секретное слово WebMoney</b>: </td>
            <td valign="top"><input type="text" class="field" name="bank_wm_key" value="##wm_key##" style="width: 240px;"></td>
        </tr>
        </table>
    </fieldset>
</td></tr>
<tr><td colspan="2">
    <fieldset>
        <legend>RBK Money</legend>
        <table cellpadding="2" cellspacing="2" border="0" width="100%">
        <tr>
            <td valign="top" bgcolor="#f0f0f0">
                <label><input type="checkbox" name="bank_rbk_used" value="1"##IF(rbk_used)## checked="yes"##ENDIF## /> <b>Использовать RBK Money</b>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td valign="top" bgcolor="#f0f0f0" width="100%"><b>Счет RBK Money</b>: </td>
            <td valign="top"><input type="text" class="field" name="bank_rbk" value="##rbk##" style="width: 240px;"></td>
        </tr>
        <tr>
            <td valign="top" bgcolor="#f0f0f0" width="100%"><b>Комиссия RBK Money %</b>: </td>
            <td valign="top"><input type="text" class="field" name="bank_rbk_commission" value="##rbk_commission##" style="width: 40px;"></td>
        </tr>
        <tr>
            <td valign="top" bgcolor="#f0f0f0" width="100%"><b>Секретное слово RBK Money</b>: </td>
            <td valign="top"><input type="text" class="field" name="bank_rbk_key" value="##rbk_key##" style="width: 240px;"></td>
        </tr>
        </table>
    </fieldset>
</td></tr>
<tr><td colspan="2">
    <fieldset>
        <legend>QIWI</legend>
        <table cellpadding="2" cellspacing="2" border="0" width="100%">
        <tr>
            <td valign="top" bgcolor="#f0f0f0" width="100%"><b>Кошелек QIWI</b>: </td>
            <td valign="top"><input type="text" class="field" name="bank_qiwi" value="##qiwi##" style="width: 240px;"></td>
        </tr>
        <tr>
            <td valign="top" bgcolor="#f0f0f0" width="100%"><b>Комиссия QIWI %</b>: </td>
            <td valign="top"><input type="text" class="field" name="bank_qiwi_commission" value="##qiwi_commission##" style="width: 40px;"></td>
        </tr>
        <tr>
            <td valign="top" bgcolor="#f0f0f0" width="100%"><b>Секретное слово QIWI</b>: </td>
            <td valign="top"><input type="text" class="field" name="bank_qiwi_key" value="##qiwi_key##" style="width: 240px;"></td>
        </tr>
        </table>
    </fieldset>
</td></tr>
<tr><td colspan="2">
    <fieldset>
        <legend>PayPal</legend>
        <table cellpadding="2" cellspacing="2" border="0" width="100%">
        <tr>
            <td valign="top" bgcolor="#f0f0f0">
                <label><input type="checkbox" name="bank_paypal_used" value="1"##IF(paypal_used)## checked="yes"##ENDIF## /> <b>Использовать PayPal</b>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td bgcolor="#f0f0f0" width="100%"><b>Номер счета / e-mail PayPal</b>: </td>
            <td><input type="text" class="field" name="bank_paypal_account" value="##paypal_account##" style="width: 240px;" /></td>
        </tr>
##--
        <tr>
            <td bgcolor="#f0f0f0" width="100%"><b>Комиссия PayPal %</b>: </td>
            <td><input type="text" class="field" name="bank_paypal_commission" value="##paypal_commission##" style="width: 40px;" /></td>
        </tr>
--##
        <tr>
            <td bgcolor="#f0f0f0" width="100%"><b>Секретное слово PayPal</b>: </td>
            <td><input type="text" class="field" name="bank_paypal_key" value="##paypal_key##" style="width: 240px;" /></td>
        </tr>
        <tr>
            <td bgcolor="#f0f0f0" width="100%"><b>Курс доллара для PayPal</b>: </td>
            <td><input type="text" class="field" name="bank_paypal_usd_rate" value="##paypal_usd_rate##" style="width: 40px;" /></td>
        </tr>
        </table>
    </fieldset>
</td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>MainSMS API Key</b>: </td><td valign="top"><input type="text" class="field" name="bank_mainsms_api_key" value="##mainsms_api_key##" style="width: 200px;"></td></tr>
</TBODY></TABLE>
<br>
<b>&nbsp;Бухгалтерия:</b>
<TABLE cellSpacing=5 width="100%" border=0 cellpadding="5">
<TBODY>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Период выставления актов (счетов-фактур)</b>:</td><td valign="top"><select name="ext_report_period"><option value=month>Месяц</option><option value=quarter>Квартал</option><option value=year>Год</option></select></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Учитывать период выставления актов (счетов-фактур) заданный в реквизитах пользователя</b>:</td><td valign="top"><input type=checkbox name="ext_redefine_report_period" value=1></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Наименовение налога</b>: </td><td valign="top"><input type="text" class="field" name="ext_tax_name" value="##tax_name##" style="width: 200px;"></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Величина налога (в отчетной валюте или процентах)</b>: </td><td valign="top"><input type="text" class="field" name="ext_tax_value" value="##tax_value##" style="width: 40px;" maxlength=3></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Схема расчета налога (inc - включать, sum - добавлять)</b>: </td><td valign="top"><input type="text" class="field" name="ext_tax_scheme" value="##tax_scheme##" style="width: 40px;"></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Префикс для номеров счетов</b>: </td><td valign="top"><input type="text" class="field" name="ext_docnum_prefix" value="##docnum_prefix##" style="width: 40px;" maxlength=10></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Префикс для номеров актов</b>: </td><td valign="top"><input type="text" class="field" name="ext_actnum_prefix" value="##actnum_prefix##" style="width: 40px;" maxlength=10></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>ФИО руководителя</b>:</td><td valign="top"><input type="text" class="field" name="ext_fio1" value="##fio1##" style="width: 200px;"></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>ФИО бухгалтера</b>:</td><td valign="top"><input type="text" class="field" name="ext_fio2" value="##fio2##" style="width: 200px;"></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Изображение подписи руководителя</b>: (на сайте конструктора)</td><td valign="top"><input type="text" class="field" name="ext_sign1" value="##sign1##" style="width: 200px;"></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Изображение подписи бухгалтера</b>: (на сайте конструктора)</td><td valign="top"><input type="text" class="field" name="ext_sign2" value="##sign2##" style="width: 200px;"></td></tr>
<tr>
<td valign="top" bgcolor="#f0f0f0"><b>Изображение печати</b>: (на сайте конструктора)</td><td valign="top"><input type="text" class="field" name="ext_stamp" value="##stamp##" style="width: 200px;"></td></tr>
</TBODY></TABLE>
##endif##
##if(read_only)##
<TABLE cellSpacing=5 width="100%" border=0 cellpadding="5" id=changes_date>
<TBODY>
<tr>
<td align=right><input type=checkbox value=1 name=update_docs id=update_docs ><b><label for=update_docs >Подтверждаю, что данные изменения вступили в силу с даты (включительно):</label> <input type=text value="##date_now##" name=update_docs_date class=fieldclass="field10">
<a href="javascript: void(0);" onclick="return getCalendar(event, document.forms[_cms_document_form].update_docs_date);">
      <img class="clnd_img" src="skins/vanilla/images/spacer.gif" helpId="clnd_date"/></a></b></td></tr>
</TBODY>
</TABLE><br>
##endif##
</div>



<div align=right>
        ##form_buttons##
</div>
</form>


<script>
  document.forms[_cms_document_form].props_type.value='##type##';
  if (typeof(document.forms[_cms_document_form].ext_report_period)=='object'){
    document.forms[_cms_document_form].ext_report_period.value='##report_period##';
  }
  if (typeof(document.forms[_cms_document_form].ext_redefine_report_period)=='object'){
    document.forms[_cms_document_form].ext_redefine_report_period.checked=(parseInt('##redefine_report_period##')==1)?true:false;
  }
  document.forms[_cms_document_form].ext_period[0].value='##period##'==''?'quarter':'##period##';
  document.forms[_cms_document_form].ext_period[1].value='##period##'==''?'quarter':'##period##';
  setBlock('##type##');
</script>



"-->