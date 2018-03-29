##--system info: module_owner="" module="" system="1"--##
%%include_template "_shared/code/skins/ami_touch/templates/_form.tpl"%%

<!--#set var="input_field(name="scripts")" value="
<script type="text/javascript">

var thousandsSeparator = '##thousandsSeparator##';

if(typeof(window.formWatchersAdded) == 'undefined'){
    oFormView.addValidator('price', function(name, value, oldValue, scope, error){
        return '' == value || value.toString().replace(thousandsSeparator, '').match(/^[0-9]*(\.|\,)?[0-9]+?$/);
    });
    window.formWatchersAdded = true;
}
</script>
"-->

<!--#set var="section_special_flags" value="
<fieldset>
    <legend>%%section_special_flags%%</legend>
    ##section_html##
</fieldset>
"-->

<!--#set var="input_field(name="extra_price_opener")" value="
<script type="text/javascript">
var
    json1 = '##usedExtraPrices##',
    json2 = '##rates##',
    usedExtraPrices = JSON && JSON.parse(json1) || $.parseJSON(json1),
    rates = JSON && JSON.parse(json2) || $.parseJSON(json2),
    baseCurrency = '##baseCurrency##',
    decimalPoint = '##decimalPoint##',
    numberOfDecimals = '##numberOfDecimals##';

oFormView.counters = {};
oFormView.resetCounter = function(name){
    oFormView.counters[name] = 0;
}
oFormView.increaseCounter = function(name){
    if(!oFormView.counters[name]){
        oFormView.counters[name] = 0;
    }
    oFormView.counters[name]++;
    // console.log('increaseCounter ' + name + ': ' + oFormView.counters[name]);///
}
oFormView.decreaseCounter = function(name){
    var res;

    if(oFormView.counters[name]){
        res = oFormView.counters[name]--;
    }else{
        oFormView.counters[name] = 0;
        res = 0;
    }
    // console.log('decreaseCounter ' + name + ': ' + res);///

    return res;
}

oFormView.watchPriceField = function(field, value, oldValue, scope){
    var watchChanges = scope.watchChanges;

    scope.watchChanges = false;

    for(var i = 0, q = usedExtraPrices.length; i < q; i++){
        var priceId = usedExtraPrices[i];

        if(
            scope.fields['use_formula' + priceId] &&
            'undefined' != typeof(extraPriceCurrencies[priceId])
        ){
            var
                formula = $('#formula' + priceId).val(),
                result =
                    parseFloat(
                        eval(
                            formula.replace('price', value)
                            .replace(thousandsSeparator, '')
                            .replace(',', '.')
                        )
                    ) * rates[extraPriceCurrencies[priceId]];
            if(isNaN(result)){
                // console.log('bad #formula' + priceId, formula);///
            }else{
                result = formatNumber(
                    result,
                    numberOfDecimals,
                    decimalPoint,
                    thousandsSeparator
                );
                if($('#price' + priceId).val() != result){
                    oFormView.increaseCounter('price' + priceId);
                    scope.fields['price' + priceId] = result;
                    $('#price' + priceId).val(result);
                }
            }
        }
    }

    scope.watchChanges = watchChanges;
};

oFormView.skipIdCatWatcher = true;
if(typeof(window.formWatchersAdded) == 'undefined'){
    oFormView.watchField('price', oFormView.watchPriceField);

    for(var i = 0, q = usedExtraPrices.length; i < q; i++){
        var priceId = usedExtraPrices[i];

        oFormView.resetCounter('price' + priceId);
        oFormView.resetCounter('use_formula' + priceId);

##---
        console.log('price' + priceId);///
        oFormView.addValidator('price' + priceId, function(name, value, oldValue, scope, error){
            console.log(
                parseFloat(value.replace(thousandsSeparator, '').replace(',', '.')),
                !isNaN(parseFloat(value.replace(thousandsSeparator, '').replace(',', '.')))
            );///
            return
                '' == value ||
                !isNaN(parseFloat(value.replace(thousandsSeparator, '').replace(',', '.')));
        });
--##
        oFormView.watchField('price' + priceId, function(field, value, oldValue, scope){
            if(oFormView.decreaseCounter(field)){

                return;
            }

            // console.log('field ' + field + '.data-ami-value set to', value);///
            $('#' + field).attr('data-ami-value', value);
        });

        oFormView.watchField('use_formula' + priceId, function(field, value, oldValue, scope){
            if(oFormView.decreaseCounter(field)){

                return;
            }

            var priceId = parseInt(field.substring(11));

            $('#price' + priceId).prop('disabled', value > 0);
            if(value){
                oFormView.watchPriceField(
                    'price',
                    scope.fields['price'],
                    scope.fields['price'],
                    scope
                );
            }else{
                var priceValue = $('#price' + priceId).attr('data-ami-value');
                if($('#price' + priceId).val() != priceValue){
                    oFormView.increaseCounter('price' + priceId);
                    scope.fields['price' + priceId] = priceValue;
                    $('#price' + priceId).val(priceValue);
                }
            }

            var priceMask = 0;
            for(var i = 0, q = usedExtraPrices.length; i < q; i++){
                var curPriceId = usedExtraPrices[i];
                priceMask =
                    priceMask |
                    (
                        (1 << (curPriceId - 1)) *
                        (
                            curPriceId != priceId
                                ? scope.fields['use_formula' + curPriceId]
                                : value
                        )
                    );
            }
            scope.fields['price_mask'] = priceMask;
            $('[name=price_mask]').val(priceMask);
        });
    }

    oFormView.watchField('id_cat', function(name, value, oldValue, scope){
        if(oFormView.skipIdCatWatcher){
            oFormView.skipIdCatWatcher = false;

            return;
        }

        if(!value){

            return;
        }

        if(!confirm(oActiveModule.aLocale['extra_prices_wont_be_saved'])){
            oFormView.skipIdCatWatcher = true;
            scope.fields.id_cat = oldValue;

            return;
        }

        var oReuqest = new amiRequest(
            parent.amiSkinController.getURL('base'),
            'GET',
            'json',
            {
                ami_svc: parent.amiSkinController.service,
                ami_env: 'fast',
                action:  'get_raw_data',
                mod_id:  'eshop_cat',
                id:      value
            },
            function(aData){
                if(aData.data){
                    extraPriceCurrencies = {};
                    var re1 = /^price/, re2 = /^price_caption(\d+)/, re3 = /^price(\d+)$/;
                    for(var field in aData.data){
                        if(re1.test(field) && 'price' != field){
                            if(re2.test(field)){
                                // price_caption
                                var
                                    aPrice = re2.exec(field), priceId = parseInt(aPrice[1]);

                                $('#price_caption' + priceId).html(aData.data[field]);
                            }else if(re3.test(field)){
                                var
                                    aPrice = re3.exec(field), priceId = parseInt(aPrice[1]),
                                    aCatPriceData = {
                                        formula: '',
                                        display: '',
                                        store:   ''
                                    },
                                    aPriceData = aData.data[field] ? aData.data[field].split('#') : false,
                                    aCurrencies, aField = {};

                                if(aPriceData){
                                    aCatPriceData['formula'] = aPriceData[0];
                                    var aCurrencies = aPriceData[1].split(':');
                                    if(aCurrencies.length){
                                        aCatPriceData['display'] = aCurrencies[0];
                                        aCatPriceData['store'] = aCurrencies[0];
                                        extraPriceCurrencies[priceId] = aCatPriceData['store'];
                                        if(aCurrencies.length > 1){
                                            aCatPriceData['store'] = aCurrencies[1];
                                            extraPriceCurrencies[priceId] = aCatPriceData['store'];
                                        }
                                    }
                                }

                                scope.fields['formula' + priceId] = aCatPriceData['formula'];
                                var useFormula;
                                if('undefined' != typeof(scope.fields['price_mask'])){
                                    useFormula = (1 << (priceId - 1)) & scope.fields['price_mask'] ? 1 : 0;
                                }else{
                                    useFormula = '' != aCatPriceData['formula'] ? 1 : 0;
                                }
                                if(
                                    'undefined' != scope.fields['price' + priceId] &&
                                    scope.fields['price' + priceId] !=
                                    parseFloat(
                                        eval(
                                            aCatPriceData['formula'].replace('price', scope.fields['price'])
                                            .replace(thousandsSeparator, '')
                                            .replace(',', '.')
                                        )
                                    ) * rates[extraPriceCurrencies[priceId]]
                                ){
                                    useFormula = false;
                                }
                                if(scope.fields['use_formula' + priceId] != useFormula){
                                    oFormView.increaseCounter('use_formula' + priceId);
                                    scope.fields['use_formula' + priceId] = useFormula;
                                }
                                var sourceValue = $('#price' + priceId).attr('data-ami-source-value');
                                if(scope.fields['price' + priceId] != sourceValue){
                                    oFormView.increaseCounter('price' + priceId);
                                    scope.fields['price' + priceId] = sourceValue;
                                    $('#price' + priceId).val(sourceValue);
                                }

                                $('#formula' + priceId).val(aCatPriceData['formula']);
                                $('#price' + priceId).prop('disabled', '' != aCatPriceData['formula']);
                                $('#use_formula' + priceId).prop('disabled', '' == aCatPriceData['formula']);
                                $('#use_formula' + priceId).prop('checked', useFormula);

                                $('#extra_price_currency' + priceId).html(aCatPriceData['store']);
                            }
                        }
                    }
                    oFormView.watchPriceField('price', scope.fields.price, scope.fields.price, scope);
                }
            }
        );
    });
}

// Format a number with grouped thousands
//
// +   original by: Jonas Raoni Soares Silva (http://www.jsfromhell.com)
// +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
// +     bugfix by: Michael White (http://crestidg.com)
function formatNumber(number, decimals, dec_point, thousands_sep){
    var i, j, kw, kd, km;

    // input sanitation & defaults
    if(isNaN(decimals = Math.abs(decimals))){
        decimals = 2;
    }
    if(dec_point == undefined){
        dec_point = '.';
    }
    if( thousands_sep == undefined){
        thousands_sep = ' ';
    }
    i = parseInt(number = (+number || 0).toFixed(decimals)) + '';
    if((j = i.length) > 3){
        j = j % 3;
    }else{
        j = 0;
    }
    km = (j ? i.substr(0, j) + thousands_sep : '');
    kw = i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousands_sep);
    kd = (decimals ? dec_point + Math.abs(number - i).toFixed(decimals).replace(/-/, 0).slice(2) : '');

    return km + kw + kd;
}
</script>
<div class="form-group input__##name## field__##name## extra_price__title">
    <div class="col-md-2">%%exta_price_caption%%</div>
    <div class="col-md-3">%%exta_price_fixed_price%%</div>
    <div class="col-md-1"></div>
    <div class="col-md-3">%%exta_price_use_formula%%</div>
</div>
"-->

<!--#set var="input_field(marker="extra_price")" value="
<div class="form-group input__##name## field__##name## prices-elements">
    <label id="price_caption##price_id##" ng-model="fields.##price_caption####price_id##" for="cb_##name##" class="col-md-2 control-label">##extra_price_caption##</label>
    <div class="mobile-view-mode exta_price_fixed_price">%%exta_price_fixed_price%%</div>
    <div class="col-md-3 input-price-value">
        <div class="input-text-area">
            <input
                ng-model="fields.##name##"
                type="text"
                placeholder=""
                class="form-control text-input number-input ng-dirty ng-valid ng-valid-ami-validators"
                name="##name##"
                id="##name##"
                data-ami-source-value="##value##"
                data-ami-value="##value##"ami_validators=" price"##-- price_disabled--## />
            <i title="%%delete_content%%" onclick="clearArea('##name##', this);return false;" class="fa fa-times close-btn"></i>
        </div>
        <div class="has-error" ng-show="ami_form.##name##.$dirty && ami_form.##name##.$invalid">
            <div id="error_msg_##name##" for="##name##" class="help-block animation-slideDown"></div>
        </div>
    </div>
    <span class="mobile-view-mode exta_price_use_formula">%%exta_price_use_formula%%</span>
    <div class="col-md-1">
        <div class="checkbox">
            <input
                ng-model="fields.use_formula##price_id##"
                type="checkbox"
                value="1"
                name="use_formula##price_id##"
                id="use_formula##price_id##"
                ##use_formula_disabled##
                ##-- ng-disabled="fields.formula##price_id##" --##
            />
        </div>
    </div>
    <div class="col-md-3 input-price-value">
        <div class="input-text-area">
            <input ##--ng-model="fields.formula##price_id##"--## type="text" placeholder="" class="form-control text-input" name="formula##price_id##" id="formula##price_id##" value="##formula##"disabled="yes" />
        </div>
    </div>
    <div class="col-md-1" id="extra_price_currency##price_id##">##currency##</div>
</div>
"-->

<!--#set var="checkbox_field(marker="none")" value="
"-->

<!--#set var="input_field(name="extra_price_closer")" value="
<script type="text/javascript">
var
    json1 = '##extraPriceCurrencies##'
    extraPriceCurrencies = JSON && JSON.parse(json1) || $.parseJSON(json1);
</script>
"-->

<!--#set var="select_field(name="discount")" value="
<div class="form-group input__##name## field__##name##">
    <label for="##name##" class="col-md-3 control-label">##IF(validator_filled)##<span class="text-danger">*</span> ##endif####element_caption##</label>
    <div class="col-md-3">
        <div class="input-text-area">
            <input ng-model="fields.##name##" type="text" placeholder="" class="form-control text-input" name="##name##" id="##name##" ami_validators="price ##validators##">
            <i title="%%delete_content%%" onclick="clearArea('##name##', this);return false;" class="fa fa-times close-btn"></i>
        </div>
        <div class="has-error" ng-show="ami_form.##name##.$dirty && ami_form.##name##.$invalid">
            <div id="error_msg_##name##" for="##name##" class="help-block animation-slideDown"></div>
        </div>
    </div>
    <div class="col-md-1">
        <select ng-model="fields.discount_type" id="discount_type" name="discount_type" class="select-chosen form-control form-style-input" data-placeholder="">
            ##select##
        </select>
    </div>
</div>
"-->

<!--#set var="input_field(name="discount_type")" value="
"-->
