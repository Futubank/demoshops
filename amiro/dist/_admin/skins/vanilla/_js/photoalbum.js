AMI.Message.addListener(
    'ON_FORM_SUBMIT',
    function(oComponent, oParameters){
        if(
            typeof(oParameters.ext_img) != 'undefined' &&
            typeof(oParameters.ext_img_popup) != 'undefined' &&
            oParameters.ext_img == '' &&
            oParameters.ext_img_popup == ''
        ){
            alert(AMI.Template.Locale.get('form_image_warn'));
            return false;
        }
        return true;
    }
);
