##--system info: module_owner="" module="" system="1"--##

<!--#set var="no_picture" value="
    <img src="skins/vanilla/icons/icon-no_image.gif" width=13 height=11 border=0 title="%%no_picture%%">
"-->

<!--#set var="picture_col" value="
    <div class="list-image"><img src="##img_url##" border=0></div>
"-->

<!--#set var="images_add" value="<a href="javascript:" onclick="javascript:openDialog('%%add_images%%', '##url##');return false;"><img id="##id##" title="%%add_images%%" helpId="add_images" class=icon src="skins/vanilla/icons/icon-no_scrnshot.gif" style='vertical-align:middle;'></a>"-->

<!--#set var="images_edit" value="<a href="javascript:" onclick="javascript:openDialog('%%edit_images%%', '##url##');return false;"><img id="##id##" title="%%edit_images%%" helpId="edit_images" class=icon src="skins/vanilla/icons/icon-scrnshot.gif" style='vertical-align:middle;'></a>"-->

<!--#set var="section_ext_image_fields" value="
<div class="form-group">
    <div class="block image-area">
        <div class="block-title section-block">%%images%%</div>
        ##section_html##
        </div>
    </div>
</div>
"-->

<!--#set var="pictures_js_vars" value="
var pic_icon_add_##name## = '##add_value##';
var pic_icon_edit_##name## = '##edit_value##';
"-->

<!--#set var="pictures_js_script" value="
if(name=="##name##"){
    if($('#' + '##name##_img').length){
        if($('#' + '##name##').val() == ''){
            $('#' + '##name##_img').prop('src', ext_images_noimage);
            $('#' + '##name##_img').parent().addClass('no-image');
        }else{
            $('#' + '##name##_img').prop('src', '##root_path_www##' + $('#' + '##name##').val());
            $('#' + '##name##_img').parent().removeClass('no-image');
        }
        try{
            showGeneratedImages();
        }catch(e){};
    }
}
"-->

<!--#set var="pictures_js" value="
<script type="text/javascript">

##pictures_js_vars##
var ext_images_noimage = '##root_path_www##_shared/code/web/skins/ami_touch/images/no_image.png';

function updateImages(name){
    ##pictures_js_script##
    return true;
}

function showGeneratedImages(){

var hasPriorSource = ($('#' + '##prior_source_picture##').length > 0);
var priorSource = hasPriorSource ? $('#' + '##prior_source_picture##').val() : false;
var priorSourceSrc = hasPriorSource ? $('#' + '##prior_source_picture##_img').prop('src') : '';
##if(!empty(edit_ext_img_popup) && generate_ext_img_popup == '1')##
if($('#ext_img_popup').val() == '') {
    if(hasPriorSource && priorSource){
        $('#ext_img_popup_label').show();
        $('#ext_img_popup_clear').hide();
        $('#ext_img_popup_img').prop('src', priorSourceSrc);
        $('#ext_img_popup_img').parent().removeClass('no-image');
    }else{
        $('#ext_img_popup_img').prop('src', ext_images_noimage);
        $('#ext_img_popup_img').parent().addClass('no-image');
        $('#ext_img_popup_label').hide();
        $('#ext_img_popup_clear').hide();
    }
}else{
    $('#ext_img_popup_label').hide();
    $('#ext_img_popup_clear').show();
}
##endif##
##if(!empty(edit_ext_img_small) && generate_ext_img_small == '1')##
if($('#ext_img_small').val() == ''){
    if(hasPriorSource && priorSource){
        $('#ext_img_small_label').show();
        $('#ext_img_small_clear').hide();
        $('#ext_img_small_img').prop('src', priorSourceSrc);
        $('#ext_img_small_img').parent().removeClass('no-image');
    }else{
        $('#ext_img_small_img').prop('src', ext_images_noimage);
        $('#ext_img_small_img').parent().addClass('no-image');
        $('#ext_img_small_label').hide();
        $('#ext_img_small_clear').hide();
    }
}else{
    $('#ext_img_small_label').hide();
    $('#ext_img_small_clear').show();
}
##endif##
##if(!empty(edit_ext_img) && generate_ext_img == '1')##
if($('#ext_img').val() == ''){
    if(hasPriorSource && priorSource){
        $('#ext_img_label').show();
        $('#ext_img_clear').hide();
        $('#ext_img_img').prop('src', priorSourceSrc);
        $('#ext_img_img').parent().removeClass('no-image');
    }else{
        $('#ext_img_img').prop('src', ext_images_noimage);
        $('#ext_img_img').parent().addClass('no-image');
        $('#ext_img_label').hide();
        $('#ext_img_clear').hide();
    }
}else{
    $('#ext_img_label').hide();
    $('#ext_img_clear').show();
}
##endif##
}

function clearImage(name){
    $('#' + name).scope().fields[name] = '';
    $('#' + name).scope().$apply();
    $('#' + name).val('');
    updateImages(name);
    eval('Uploader_' + name + '.clear();');
}

var Uploader_ext_img_popup = new AmiUploader('ext_img_popup_upload', '');
var Uploader_ext_img_small = new AmiUploader('ext_img_small_upload', '');
var Uploader_ext_img = new AmiUploader('ext_img_upload', '');

showGeneratedImages();

$('#ext_img_popup_img_block').click(function(){
    $('[name=upload_frame_ext_img_popup_upload]').contents().find('[name=file]').click();
});

$('#ext_img_small_img_block').click(function(){
    $('[name=upload_frame_ext_img_small_upload]').contents().find('[name=file]').click();
});

$('#ext_img_img_block').click(function(){
    $('[name=upload_frame_ext_img_upload]').contents().find('[name=file]').click();
});
</script>
"-->

<!--#set var="ext_img_field" value="
<div class="col-md-3">
    <div class="##name##_block ext_image_image">
        <div class="ext_img_label" id="##name##_label">%%generated%%</div>
        <div class="ext_img_name">%%##name##%%</div>
        <div class="img_block" id="##name##_img_block"><img id="##name##_img" src="##if(!empty(value))####root_path_www####value####endif##"></div>
        <input type=hidden id="##name##" ng-model="fields.##name##" name="##name##" class=field value="##value##" detectchanges="on">
        <i id="##name##_clear" onclick="clearImage('##name##');return false;" class="fa fa-times close-btn"></i>
    </div>
    <div class="img-uploader" id="##name##_upload"></div>
</div>
"-->

<!--#set var="uploader" value="
<html>
<body style="padding:0px; margin:0px;">
    <form action="##script##" method="POST" enctype="multipart/form-data">
        <input type="file" name="file" size="36" style="width: 310px;" onchange="window.frameElement.uploader.setLoading(); this.parentNode.submit();"/>
    </form>
    <script type="text/javascript">
        function uploadedCallback(uploader, code, filename, size, link){
            var name = uploader.name.replace('_upload', '');
            var path = link;
            if(name.indexOf('ext_') === 0){
                var scope = parent.$(parent.document.getElementById(name)).scope();
                scope.fields[name] = path;
                scope.$apply();
                parent.document.getElementById(name).value = path;
                parent.updateImages(name);
            }else{
                if(typeof(uploader.onUpload) !== 'undefined'){
                    uploader.onUpload(name, path);
                }
            }
        }

        ##uploader_js##
    </script>
</body>
</html>
"-->