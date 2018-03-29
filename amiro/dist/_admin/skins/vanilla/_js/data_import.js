function showDriverFields(){
    var driverName = AMI.$("select[name=driver_name]").val();
    var className = '.' + driverName + '_fields';

    // hide ALL fields of drivers
    AMI.$(".driver_fields").each(function() {
        AMI.$(this).parents('tr:first').hide();
    });

    // show fields only for selected driver
    var aDriverFields = [];
    AMI.$(className).each(function() {
        AMI.$(this).parents('tr:first').show();
        aDriverFields.push(AMI.$(this).attr('name'));
    });

    AMI.$('input[name=driver_settings]').val(aDriverFields.toString());

    switch(driverName){
        case 'ami_rss':
            AMI
                .$('input[name=source_url]')
                .attr('data-ami-validators', 'filled required url custom');
            AMI
                .$('select[name=file_name]')
                .attr('data-ami-validators', '');
            break;
        case 'ami_csv':
            AMI
                .$('input[name=source_url]')
                .attr('data-ami-validators', '');
            AMI
                .$('select[name=file_name]')
                .attr('data-ami-validators', 'filled file_name');
            break;
    }

    return true;
}

// check start frequency
function checkFrequency(){
    if(0 === AMI.$('select[name=frequency]').val){
        AMI.$('input[name=update_start]').parent().parent().hide();
        AMI.$('input[name=update_start2]').parent().parent().hide();
    }
}

// write default values if task == add
function writeDefaultValues(){
    // add default driver fields
    if(AMI.$('select[name=driver_name]').val() == 'ami_rss'
        && AMI.$('input[name=import_fields]').val() == ''
    ){
        AMI.$('input[name=import_fields]').val('pubDate, title, description, yandex:full-text');
    }

    // add default table fields
    if(AMI.$('input[name=table_fields]').val() == ''){
        AMI.$('input[name=table_fields]').val('date_created, header, announce, body');
    }
}

// show field for the default driver
AMI.$(document).ready(function(){
    checkFrequency();
    showDriverFields();
    writeDefaultValues();

    // add default fields for drivers when it's change
    AMI.$('select[name=driver_name]').change(function(){
        if(AMI.$('select[name=driver_name]').val() == ''){
            if(AMI.$(this).value == 'ami_rss'){
                AMI.$('input[name=import_fields]').val('title, link, description, text');
            }else{
                AMI.$('input[name=import_fields]').val('');
            }
        }
    });

    // hide time selector when frequency = 0
    AMI.$('select[name=frequency]').change(function(){
        if(AMI.$(this).val() == '0'){
            AMI.$('input[name=update_start]').parent().parent().hide();
            // AMI.$('input[name=update_start2]').parent().parent().hide();
        }else{
            AMI.$('input[name=update_start]').parent().parent().show();
            // AMI.$('input[name=update_start2]').parent().parent().show();
        }
    });
    AMI.$('select[name=frequency]').change();

    // hide id_cat field depends on categories usage
    AMI.$('select[name=table_name]').change(function(){
        var element = $(this);

        if(element){
            var
                hasCategory = '1' === AMI.$(this.options[this.selectedIndex]).attr('ami-data-has-category'),
                oInput = AMI.$('input[name=id_cat]');

            hasCategory
                ? oInput.parent().parent().show()
                : oInput.parent().parent().hide();

            oInput.attr('data-ami-validators', hasCategory ? 'filled file_name int' : '');
        }
    });
    AMI.$('select[name=table_name]').change();
});

AMI.Message.addListener(
    'ON_FORM_FIELD_VALIDATE',
    function(oParameters){

        // check for update start
        if(AMI.$('select[name=frequency]').val() != 0){

            var updateStartValue = AMI.$('input[name=update_start_first]').val();
            var updateStartValue2 = AMI.$('input[name=update_start_second]').val();

            if((updateStartValue == '' || updateStartValue2 == '')
                || (!updateStartValue.match(/^[0-9]{1,2}\:[0-9]{1,2}$/) || !updateStartValue2.match(/^[0-9]{1,2}\:[0-9]{1,2}$/))
            ){
                oParameters.message = AMI.Template.Locale.get('form_validate_update_start_not_valid');
                oParameters.error = true;
            }
        }

        // check for source_url
        if(AMI.$('select[name=driver_name]').val() == 'ami_rss'
            && AMI.$('input[name=source_url]').val() == ''
        ){
            // oParameters.error = true;
            // oParameters.message = AMI.Template.Locale.get('form_validate_source_url_empty');
        }else if(AMI.$('select[name=driver_name]').val() == 'ami_csv'
            && (AMI.$('select[name=file_name]').val() == '' || AMI.$('select[name=file_name]').val() == null)
        ){
            oParameters.error = true;
            oParameters.message = AMI.Template.Locale.get('form_validate_file_name_empty');
        }

        return true;
    }
);
