Для того, чтобы модифицировать поведение скина ami_touch или оформление по-умолчанию, необходимо:

1) Создать каталоги:
_local/skins/ami_touch
_local/skins/ami_touch/css
_local/skins/ami_touch/js

2) Создать файлы:
_local/skins/ami_touch/css/custom.css - Пользовательсий CSS дополняющий CSS скина
_local/skins/ami_touch/js/skin_init_before.js - JS функционал исполняемый перед инициализацией скина
_local/skins/ami_touch/js/init_before.js - JS функционал исполняемый перед инициализацией контроллера модуля

3) В файле _local/common_functions.php:

Добавить следующие строки

AMI_Skin::update(
    'ami_touch',
    array(
        'path' => array(
            'css/custom.css' => AMI_Skin::getLocalPath('ami_touch') . 'css/custom.css',
            'js/skin_init_before.js' => AMI_Skin::getLocalPath('ami_touch') . 'js/skin_init_before.js',
            'js/init_before.js' => AMI_Skin::getLocalPath('ami_touch') . 'js/init_before.js'
        )
    )
);
