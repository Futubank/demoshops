(function (window) {

    var $ = window.jQuery;

    /**
     * Загружает скрипт из script_src (если checked_object отсутствует/ложно),
     * затем выполняет callback.
     *
     * @param is_already_loaded
     * @param script_src
     * @param callback
     */
    function load_script(is_already_loaded, script_src, callback) {
        if (!is_already_loaded) {
            // jQuery UI использует define(), но в стандартном макете ИМ jQuery загружается отдельно.
            // В итоге при подключении jQuery UI загружается вторая копия jQuery, из-за чего могут
            // становиться недоступными уже загруженные плагины и т. п.
            // Чтобы обойти это, временно меняем свойство define.amd, которое существует специально
            // для jQuery (https://github.com/jquery/jquery/pull/331#issue-779774)
            var original_define_amd_value;
            if (window.define) {
                original_define_amd_value = define.amd;
                define.amd = null;
            }

            var script = document.createElement('script'),
                loaded;
            script.setAttribute('src', script_src);
            script.onreadystatechange = script.onload = function () {
                if (!loaded) {
                    callback();
                }
                loaded = true;

                if (window.define) {
                    define.amd = original_define_amd_value;
                }
            };
            document.getElementsByTagName('head')[0].appendChild(script);
        } else {
            callback();
        }
    }

    // ключи в data для поля ввода города
    var is_location_confirmed = 'ncLocationConfirmed',
        is_location_selected = 'ncLocationSelected',
        last_result = 'ncLocationLastResult';
    // последний полученный ответ
    var last_request;
    // минимальная длина для срабатывания поиска
    var min_search_length = 2; // есть населённые пункты с названием из 2 букв, в т. ч. с неуникальными названиями

    /**
     * Запрос данных с сервера (actions/location.php)
     * @param {object} data  данные от jQuery.ui.autocomplete, значение для поиска —
     *      в свойстве term
     * @param {Function} callback  callback после успешного запроса
     * @returns {object} jQuery request object
     */
    function request_data(data, callback) {
        var input = $(this.element);

        if (last_request) {
            last_request.abort();
        }

        last_request = $.ajax({
            url: NETCAT_PATH + 'modules/netshop/actions/location.php',
            method: 'post',
            dataType: 'json',
            data: {
                location: data.term
            },
            success: callback
        }).always(function(response, status) {
            input.data(last_result, status === 'success' ? response || [] : []);
            input.removeClass('tpl-state-loading');
        });

        input.addClass('tpl-state-loading');
        return last_request;
    }

    /**
     * Установка валидности поля города.
     * @param {HTMLInputElement} element
     * @param {Boolean} is_valid
     */
    function set_element_validity(element, is_valid) {
        if (element.setCustomValidity) {
            element.setCustomValidity(is_valid ? '' : get_string('NetshopLocationIsInvalid', 'Неизвестный населённый пункт'));
        }
    }

    /**
     * Проверка значения поля
     * @param {jQuery} input  поле ввода города
     */
    function check_location_input_value(input) {
        var term = input.val();
        if (term.length) {
            request_data({ term: term }, function(response) {
                var is_match = !!(response && response[0] && response[0].is_exact_match);
                input.data(is_location_confirmed, is_match);
                set_element_validity(input[0], is_match);
            });
        } else {
            input.data(is_location_confirmed, false);
            set_element_validity(input, true);
        }
    }

    /**
     * Обработчик выбора города из выпадающего списка
     * @param event
     * @param ui
     * @returns {boolean}
     */
    function select_location(event, ui) {
        var item = ui.item,
            location = item.name,
            add_suffix_placeholder = item.is_suffix_allowed && location.indexOf(',') === -1;
        set_location(this, location, add_suffix_placeholder);
        $(this).data(is_location_selected, true);
        return false;
    }

    /**
     * Устанавливает значения поля выбора города
     * @param {HTMLInputElement} input
     * @param {String} location
     * @param {Boolean} [add_suffix_placeholder]
     */
    function set_location(input, location, add_suffix_placeholder) {
        var value = location + (add_suffix_placeholder ? ', ' + get_string('NetshopLocationSuffixPlaceholder', 'введите город') : '');
        $(input).val(value)
            .trigger('change', { from_set_location: true })
            .data(is_location_confirmed, true);
        set_element_validity(input, true);
        if (add_suffix_placeholder) {
            input.setSelectionRange(location.length + 2, value.length);
        }
    }

    /**
     * Обработчик изменения значения поля ввода города
     */
    function on_input_change(event, extra_parameters) {
        if (extra_parameters && extra_parameters.from_set_location) {
            return;
        }

        var input = $(this);
        // значение не было выбрано из выпадающего списка
        if (!input.data(is_location_selected)) {
            input.data(is_location_confirmed, false);
        } else {
            input.data(is_location_selected, false);
        }
    }

    /**
     * Обработчик потери фокуса полем ввода города
     */
    function on_input_blur() {
        var input = $(this);
        if (!input.data(is_location_confirmed)) {
            if (input.val().length) {
                var items = input.data(last_result) || [];
                if (items && items[0] && items[0].name) {
                    set_location(this, items[0].name);
                } else {
                    set_element_validity(this, false);
                }
            } else {
                set_element_validity(this, true);
            }
        }
    }

    /**
     * Создание виджета выбора города на основе jQuery.ui.autcomplete
     */
    function define_autocomplete_widget() {
        if ($.fn.ncLocationAutocomplete) {
            return;
        }

        $.widget('custom.ncLocationAutocomplete', $.ui.autocomplete, {
            options: {
                source: request_data,
                select: select_location,
                // пробуем использовать собственные классы, чтобы в случае
                // необходимости была возможность отказаться от jQuery UI
                focus: function(event, ui) {
                    var ul = $(event.currentTarget);
                    ul.find('li').each(function() {
                        var li = $(this);
                        li.toggleClass('nc--focus', li.data('value') === ui.item.name);
                    });
                }
            },

            _renderMenu: function (ul, items) {
                ul.addClass('nc-autocomplete-dropdown nc-netshop-location-autocomplete-dropdown');
                var that = this;
                $.each(items, function (index, item) {
                    that._renderItemData(ul, item);
                });
            },

            _renderItem: function (ul, item) {
                return $('<li>')
                    .addClass('nc-autocomplete-dropdown-item nc-netshop-location-autocomplete-dropdown-item')
                    .attr('data-value', item.name)
                    .append(item.name)
                    .appendTo(ul);
            },

            _resizeMenu: function() {
                this.menu.element.outerWidth(this.element.outerWidth());
            }
        });
    }

    /**
     * Возвращает строку из ncLang или значение по умолчанию
     * @param {String} key  ключ в ncLang
     * @param {String} default_value  значение, если нет ncLang или свойства key в нём
     * @returns {*}
     */
    function get_string(key, default_value) {
        var string;
        if (window.ncLang) {
            string = ncLang[key];
        }
        return string || default_value;
    }

    // GLOBAL:

    /**
     * Добавляет выпадающий список для выбора города к текстовому полю
     * @param {String} selector селектор для выбора текстового поля
     */
    window.nc_netshop_init_location_input = function(selector) {
        // (1) проверяем, что у нас загружен jQuery
        load_script(window.jQuery, 'https://code.jquery.com/jquery-1.12.4.min.js', function() {
            $ = window.jQuery;
            // добавляем стили
            var stylesheet_id = 'nc_netshop_location_selector_styles';
            if (!$('#' + stylesheet_id).length) {
                $('head').prepend(
                    '<link rel="stylesheet" href="' + NETCAT_PATH + 'modules/netshop/js/location_selector.css" id="' + stylesheet_id + '">'
                );
            }

            // (2) проверяем, что у нас загружен jQuery UI AutoComplete
            load_script(($.ui && $.ui.autocomplete), NETCAT_PATH + 'modules/search/suggest/jquery-ui.custom.min.js', function() {
                // (3) когда всё загружено, инициализируем выпадающий список для текстового поля
                define_autocomplete_widget();
                var input = $(selector);
                input.ncLocationAutocomplete({
                    minLength: min_search_length
                });
                // если в поле есть какое-то значение, проверяем его
                check_location_input_value(input);
                input
                    // установка значения (если есть) при потере фокуса
                    .on('blur', on_input_blur)
                    // сброс подтверждения значения при изменении значения поля
                    .on('change', on_input_change);
            });
        });
    };

})(window);