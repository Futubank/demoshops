%%include_language "templates/lang/_payments_docs.lng"%%


<!--#set var="doc_bill_fake_row_ru" value=""-->

<!--#set var="doc_bill_fake_body_ru" value=""-->


<!--#set var="doc_sf_row_ru" value=""-->


<!--#set var="doc_sf_body_ru" value=""-->

<!--#set var="doc_bill_person_ru" value="СекцияДокумент=Квитанция
Номер=##doc_num##
Дата=##doc_date##
Сумма=##total_price##
Налог=##total_tax##
Получатель=##contractor_name##
ПолучательИНН=##contractor_inn##
ПолучательКПП=##contractor_kpp##
Плательщик=##client_name##
ПлательщикПаспорт##client_passport##
Услуга=##service_description##
КонецДокумента
"-->


<!--#set var="doc_bill_company_row_ru;doc_bill_ip_row_ru;" value="
Услуга=##service_description##
Количество=1
ЕдиницаИзмерения=шт
Цена=##price##
Ставка=Налога##tax##
Налог=##tax_value##
ЦенаСНалогом=##price_with_tax##"-->

<!--#set var="doc_bill_company_body_ru;doc_bill_ip_body_ru" value="СекцияДокумент=Счет
Номер=##doc_num##
Дата=##doc_date##
Сумма=##total_price##
Налог=##total_tax##
СуммаСНалогом=##total_price_with_tax##
Плательщик=##client_name##
ПлательщикИНН=##if(client_inn!='772900164552')####client_inn##
##endif##
ПлательщикКПП=##client_kpp##
Получатель=##contractor_name##
ПолучательИНН=##contractor_inn##
ПолучательКПП=##contractor_kpp##
СекцияУслуги##doc_rows##
КонецУслуги
КонецДокумента
"-->


<!--#set var="doc_act_row_ru" value="
Услуга=##service_description##
Количество=1
ЕдиницаИзмерения=шт
Цена=##price##
Ставка=Налога##tax##
Налог=##tax_value##
ЦенаСНалогом=##price_with_tax##"-->

<!--#set var="doc_act_body_ru" value="СекцияДокумент=Акт
Номер=##doc_num##
Дата=##doc_date##
Сумма=##total_price##
Налог=##total_tax##
СуммаСНалогом=##total_price_with_tax##
Плательщик=##client_name##
ПлательщикИНН=##if(client_inn!='772900164552')####client_inn##
##endif##
ПлательщикКПП=##client_kpp##
Получатель=##contractor_name##
ПолучательИНН=##contractor_inn##
ПолучательКПП=##contractor_kpp##
СекцияУслуги##doc_rows##
КонецУслуги
КонецДокумента
"-->

<!--#set var="html_body_block_ru" value="##content##"-->

<!--#set var="page_splitter" value=""-->

<!--#set var="body" value="##document_list##"-->



