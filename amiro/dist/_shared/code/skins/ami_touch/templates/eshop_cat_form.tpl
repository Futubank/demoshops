##--system info: module_owner="" module="" system="1"--##
%%include_template "_shared/code/skins/ami_touch/templates/_form.tpl"%%

<!--#set var="section_extra_prices" value="
<div class="form-group input__##name## field__##name## extra_prices_name">    
    <div class="col-md-8"></div>
    <div class="col-md-3 text-center price-header-name"><b>%%currency%%</b></div>
</div>
<div class="form-group input__##name## field__##name##">    
    <div class="col-md-8"></div>
    <div class="col-md-1 text-center">%%currency_db%%</div>
    <div class="col-md-1 text-center">%%currency_site%%</div>
</div>
##section_html##
<script type="text/javascript">

if(typeof(window.extraPriceFieldsWatchersAdded) == 'undefined'){

    oFormView.extraPriceFormulaValidator = function(field, value, scope, error){
        var hasError = false;
        var origin = field.replace('_formula', '');
        var price = $('#price').val();
        var ext_price = price;
        try{
            if(value){
                eval('var ext_price = ' + value + ';');
            }
        }catch(e){
            error.message = '%%wrong_expression%%';
            hasError = true;
        }
        return !hasError;
    };

    oFormView.extraPricePartsWatcher = function(field, value, oldValue, scope){
        var price = field.split('_')[0];
        oFormView.updatePrice(price);
    };

    oFormView.updatePrice = function(field){
        var scope = $('#' + field).scope();
        var formula = scope.fields[field + '_formula'];
        var price = parseFloat(scope.fields.price);
        var currencySite = scope.fields[field + '_currency_site'];
        var currencyDB = scope.fields[field + '_currency_db'];
        var ratio = aCurrencies[currencySite];

        var ext_price = price;
        try{
            for(var i=1; i<33; i++){
                eval('var price' + i + ' = ' + ((Math.round(parseFloat($('#price' + i + '_price').val())) * 100 ) / 100) + ';');
            }
            if(formula){
                eval('var ext_price = Math.round((' + formula + ') * ratio * 100 ) / 100;');
            }
        }catch(e){};
        if(isNaN(ext_price)){
            ext_price = 0;
        }

        if(!isNaN(parseFloat(formula)) && isFinite(formula)){
            $('#' + field + '_currency_db').prop('disabled', '');
        }else{
            $('#' + field + '_currency_db').prop('disabled', 'disabled');
        }

        $('#' + field + '_price').val(ext_price);

        if((formula != null && formula !== undefined) && formula.length){
            value = formula;
            if(!$('#' + field + '_currency_db').prop('disabled')){
                var curStAdded = false;
                if(currencySite != baseCurrency){
                    curStAdded = true;
                    value += '#';
                    value += currencySite;
                }
                if(currencyDB && currencyDB.length){
                    if(!curStAdded){
                        value += '#';
                        value += currencySite;
                    }
                    value += ':';
                    value += currencyDB;
                }
            }
            scope.fields[field] = value;
        }
    };

    for(var i=1; i<33; i++){
        var field = 'price' + i;
        if($('#' + field).length){
            var scope = $('#' + field).scope();
            var priceFull = scope.fields[field];
            var aPriceParts = priceFull.split('#');
            var currencyFull = typeof(aPriceParts[1]) != 'undefined' ? aPriceParts[1] : '';
            var aCurrencyParts = currencyFull.split(':');
            var hasDBCur = aCurrencyParts.length > 1;
            for(var currency in aCurrencies){
                $('#' + field + '_currency_site').append('<option value=' + currency + '>' + currency + '</option>');
                $('#' + field + '_currency_db').append('<option value=' + currency + '>' + currency + '</option>');
            }
            $('#' + field + '_currency_site').val(scope.fields[field + '_currency_site']);
            if(hasDBCur){
                $('#' + field + '_currency_db').val(scope.fields[field + '_currency_db']);
            }else{
                $('#' + field + '_currency_db').val("");
            }

            oFormView.updatePrice('price' + i);
            oFormView.watchField('price' + i + '_formula', oFormView.extraPricePartsWatcher);
            oFormView.watchField('price' + i + '_currency_site', oFormView.extraPricePartsWatcher);
            oFormView.watchField('price' + i + '_currency_db', oFormView.extraPricePartsWatcher);
        }
    }

    oFormView.addValidator('ext_price_formula', oFormView.extraPriceFormulaValidator);

    window.extraPriceFieldsWatchersAdded = true;
}else{
    // Redraw prices
    for(var i=1; i<33; i++){
        var field = 'price' + i;
        if($('#' + field).length){
            var scope = $('#' + field).scope();

            var priceFull = scope.fields[field];
            var aPriceParts = priceFull.split('#');
            var currencyFull = typeof(aPriceParts[1]) != 'undefined' ? aPriceParts[1] : '';
            var aCurrencyParts = currencyFull.split(':');
            var hasDBCur = aCurrencyParts.length > 1;
            
            for(var currency in aCurrencies){
                $('#' + field + '_currency_site').append('<option value=' + currency + '>' + currency + '</option>');
                $('#' + field + '_currency_db').append('<option value=' + currency + '>' + currency + '</option>');
            }
            $('#' + field + '_currency_site').val(scope.fields[field + '_currency_site']);
            if(hasDBCur){
                $('#' + field + '_currency_db').val(scope.fields[field + '_currency_db']);
            }else{
                $('#' + field + '_currency_db').val("");
            }

            oFormView.updatePrice('price' + i);
        }
    }
}

</script>
"-->

<!--#set var="input_field(marker="extra_price")" value="
<div class="form-group input__##name## field__##name## field-group-prices">
    <label for="##name##" class="col-md-3 control-label">##IF(validator_filled)##<span class="text-danger">*</span> ##endif####element_caption##</label>
    <input id="##name##" name="##name##" value="##value##" type="hidden" />
    <div class="col-md-3 formula-prices-input">
        <input ng-model="fields.##name##_formula" type="text" id="##name##_formula" name="##name##_formula" class="form-control text-input" ami_validators="ext_price_formula" />
        <div class="has-error" ng-show="ami_form.##name##_formula.$dirty && ami_form.##name##_formula.$invalid">
            <div id="error_msg_##name##_formula" for="##name##_formula" class="help-block animation-slideDown"></div>
        </div>
    </div>
    <div class="col-md-2 formula-prices">
        <input type="text" id="##name##_price" class="form-control text-input" readonly />
    </div>
    <div class="mobile-view-mode price-header-name-mobile"><b>%%currency%%</b></div>
    <div class="col-md-1 price-enter">
        <span class="mobile-view-mode currency_db__mobile">%%currency_db%%</span>
        <select ng-model="fields.##name##_currency_db" id="##name##_currency_db" class="select-chosen form-control form-style-input">
            <option value="">%%db_currency_no%%</option>
        </select>
    </div>
    <div class="col-md-1 price-save">
        <span class="mobile-view-mode currency_site__mobile">%%currency_site%%</span>
        <select ng-model="fields.##name##_currency_site" id="##name##_currency_site" class="select-chosen form-control form-style-input"></select>
    </div>
</div>
"-->

