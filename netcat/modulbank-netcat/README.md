# modulbank-netcat

1. распаковать в папку `netcat/modules/payment/classes/system`

2. перейти в раздел "разработка" и в спиcке "Платёжные системы" добавить новый элемент, 
в котором его названием будет название  вашей платежной системы (`ModulBank`), а 
значением поле "Дополнительное значение" - полное название ее класса (`nc_payment_system_modulbank`).

3. теперь добавленную платежную систему можно включить и настроить на странице 
"настройки" - "модули" - "прием платежей" - "платежные системы". 

## Настройка в панели управления

В разделе «Уведомления об успешных транзакциях» выберите «Уведомления с помощью POST-запросов»
на страницу сайта:

`ВАШСАЙТ/netcat/modules/payment/callback.php?paySystem=nc_payment_system_modulbank`


## Настройка

merchant_id и secret_key надо взять в личном кабинете.

is_test — в обычном состоянии пустое. true = режим оплаты тестовыми картами

Если вы хотите, чтобы электронные чеки отправлялись через Модульбанк, а не через NetCat, надо выставить reciept_enabled в true и указать значение nds:

1 = без НДС

2 = НДС по ставке 0%

3 = НДС чека по ставке 10%

4 = НДС чека по ставке 18%

5 = НДС чека по расчетной ставке 10/110

6 = НДС чека по расчетной ставке 18/118

(если не хотите, оставьте эти два поля пустыми)

## Инструкция с картинками

https://docs.google.com/document/d/1tnwXiiXOehOgs7fNiP9R1zIHyu-1MWc943WF4-O2_IY/edit?usp=sharing