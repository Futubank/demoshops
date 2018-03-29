<script>
  document.write( "<scr" + "ipt src='jsapi.php?_cv=" + top.cms_version + "'></sc" + "ript>");
  document.write('<scr' + 'ipt src="skins/vanilla/_js/ami.jquery.js?_cv=' + top.cms_version + '" type="text/javascript"></sc' + 'ript>');
  document.write('<scr' + 'ipt src="skins/vanilla/_js/ami.admin.js?_cv=' + top.cms_version + '" type="text/javascript"></sc' + 'ript>');
</script>
<style>
    body {
        background: url(/_admin/skins/images/custom_/loading.gif) 50% 50% no-repeat transparent;
    }

    .but {
        display:none;
    }
</style>
<div id="gadget_body" style="display:none;background:white;">
<input type="hidden" name="content" id="content" value="" />
<div class="tab-control" id="tab-control-imagetape" onselectstart="return false;"></div>
<div class="tabs-container" style="margin-bottom:6px;">
    <div class="tab-page" id="tab-page-images">
        <div style="position:relative; height:1px;top:-32px;left:330px;width:250px;text-align: right;">
            <span id="group_itemlist_reset" onclick="addNewImage();" class="text_button">%%imagetape_add_image%%</span>
        </div>
        <div id="imageContainer" style="overflow:auto;height:295px;padding-top:10px;padding-left:10px;"></div>
    </div>
    <div class="tab-page" id="tab-page-options" style="height:305px;">
        <table style="margin:15px;">
            <tr><td>%%imagetape_settings_rows%%:</td><td><input name="rows" id="rows" type="text" class="spin-control" size="3" value="1" /></td></tr>
            <tr><td>%%imagetape_settings_cols%%:</td><td><input name="cols" id="cols" type="text" class="spin-control" size="3" value="3"/></td></tr>
            <tr><td>%%imagetape_settings_scroll%%:</td><td><select getter="getScroll" setter="setScroll" id="scroll" name="scroll"><option value="2">%%imagetape_settings_scroll_h%%</option><option value="1">%%imagetape_settings_scroll_v%%</option></select></td></tr>
            <tr><td>%%imagetape_settings_template%%:</td><td><select getter="getTemplate" setter="setTemplate" name="template" id="template"></select></td></tr>
            <tr><td>%%imagetape_settings_group%%:</td><td><input name="group_name" id="group_name" type="text" class="field field45" value=""/></td></tr>
        </table>
    </div>
</div>
</div>

<script type="text/javascript">
var ext_images_addimage = 'skins/vanilla/images/imagetape_add.png';
var oImages = {};

//workaround for tabs
var module_name = false;
var editorBaseHref = '';

var timerID = 0;

var delClicked = false;

function addImage(name, hash){
    var aParts = hash.split('|');
    var src = aParts[0];
    if( src.substr(0,7) != 'http://' ){
        src = top.editorBaseHref + src;
    }
    oImages[name] = {
        name: name,
        src:  src,
        hash: hash
    };
}

function deleteImage(name){
    // delete oImages[name];
    oImages[name] = {
        name: '',
        src: '',
        hash: ''
    }
}

function removeImageAndReload(name){
    delClicked = true;
    if(confirm('%%imagetape_confirm_delete%%')){
        deleteImage(name);
        drawImages();
        updateContentField();
    }
}

function drawImages(){
    document.getElementById('imageContainer').innerHTML = '';
    var imagesHTML = '';
    // Existing images
    for(var name in oImages){
        imagesHTML += getImageHTML(name);
    }
    // Add image button
    var oDate = new Date();
    imagesHTML += getImageHTML('picture' + oDate.getTime());
    document.getElementById('imageContainer').innerHTML = imagesHTML;
}


function getImageHTML(name){

    if(oImages[name] && oImages[name].hash == ''){
        return '<input data-ami-hash="" setter="setPicture" getter="getPicture" type="hidden" id="'+name+'" name="'+name+'" value="">';
    }

    var pictureHtml = '';

    pictureHtml += '<div style="float:left; margin-bottom:10px;">';
    pictureHtml += '<div class="ext_picture_block" style="width:110px">';
    pictureHtml += '<div class="ext_picture_preview" onclick="if(!delClicked){openDialog(\'%%choose_image%%\', \'ce_img_proc.php?obj=body&cat=pages&fld='+name+'&imagetape=1&lang=ru\', Math.max(800, top.document.body.offsetWidth-40), Math.max(450, top.document.body.offsetHeight-40));} delClicked=false;" title="%%click_to_change%%">';
    if(typeof(oImages[name]) != 'undefined'){
        pictureHtml += '<img id="ext_'+name+'_img" src="' + oImages[name].src + '" style="max-height:60px;max-width:80px;">';
        pictureHtml += '<input data-ami-hash="' + oImages[name].hash + '" setter="setPicture" getter="getPicture" type="hidden" id="'+name+'" name="'+name+'" class="field" value="' + oImages[name].src + '" onchange="showImage(this.name)">';
        pictureHtml += '<div class="ext_picture_name">%%imagetape_change%%</div>';
        pictureHtml += '<div id="imagetape_delete_'+name+'" class="imagetape_delete" onclick="removeImageAndReload(\'' + name + '\');"></div>';
    }else{
        pictureHtml += '<img id="ext_'+name+'_img" src="' + ext_images_addimage + '" style="max-height:60px;max-width:80px;">';
        pictureHtml += '<input setter="setPicture" getter="getPicture" type="hidden" id="'+name+'" name="'+name+'" class="field addNewImage" value="" onchange="showImage(this.name)">';
        pictureHtml += '<div class="ext_picture_name">%%imagetape_add%%</div>';
    }
    pictureHtml += '</div></div></div>';

    return pictureHtml;
}

function addNewImage(){
    var name = AMI.$('.addNewImage').attr('name');
    openDialog('%%choose_image%%', 'ce_img_proc.php?obj=body&cat=pages&fld='+name+'&imagetape=1&lang=ru', Math.max(800, top.document.body.offsetWidth-40), Math.max(450, top.document.body.offsetHeight-40));
}

function showImage(name){
    if(document.getElementById('ext_'+name+'_img')){
        var hash = document.getElementById(name).value;
        var aParts = hash.split('|');
        if(aParts[0] == ''){
            deleteImage(name);
        }else{
            addImage(name, hash);
        }
        drawImages();
    }
    updateContentField();
    return true;
}

function getPicture(val, oObj){
    val = oObj.getAttribute('data-ami-hash');
    return val;
}

function setPicture(arr){
    for(var i in arr){
        if(aMatches = i.match(/^picture([0-9]+)$/)){
            addImage('picture' + aMatches[1], arr[i]);
            drawImages();
            updateContentField();
        }
    }
}

var tplValue = '';
function getTemplate(val){
    return AMI.$('#template').val();
}

function setTemplate(arr){
    tplValue = arr['template'];
}

function getScroll(val){
    return AMI.$('#scroll').val();
}

function setScroll(arr){
    // AMI.$('#scroll').val(arr['scroll']);
    var SelectObject = document.getElementById('scroll');
    for(var i = 0; i < SelectObject.length; i++) {
    if(SelectObject[i].value == arr['scroll'])
        SelectObject.selectedIndex = i;
    }
}

function generateContent(){

    var aPostFields = {
        template:   getTemplate(),
        scroll:     getScroll(),
        group_name: AMI.find('#group_name').value,
        cols:       AMI.find('#cols').value,
        rows:       AMI.find('#rows').value
    };

    for(var img in oImages){
        if(oImages[img].hash != ''){
            aPostFields[oImages[img].name] = oImages[img].hash;
        }
    }

    AMI.HTTPRequest.getContent('POST', 'gadget_imagetape.php', aPostFields, function(status, data){
        AMI.find('#content').value = data;
    });
}

function updateContentField(){
    if(timerID > 0){
        clearTimeout(timerID);
    }
    timerID = setTimeout(generateContent, 500);
}

var baseTabs;

drawImages();

if(document.swapNode){
    // IE
    setTimeout(initGadgetSettings, 2000);
}else{
    // Normal browsers
    initGadgetSettings();
    
    // ...and Firefox
    setTimeout(showButtons, 500);
}

function initGadgetSettings(){   

    baseTabs = new cTabs('tab-control-imagetape', {
        'images': ['%%tab_images%%', 'active', '', false],
        'options': ['%%tab_settings%%', 'normal', '', false],
        '':''
    });

    AMI.HTTPRequest.getContent('POST', 'gadget_imagetape.php', {action: 'getTemplates'}, function(status, data){
        var aTemplates = data.split("|");
        var select = AMI.find("#template");
        for(var i=0; i<aTemplates.length; i++){
            if(aTemplates[i]){
                select.options[select.options.length] = new Option(aTemplates[i], aTemplates[i], false, (aTemplates[i] == tplValue));
            }
        }
    });

    AMI.Browser.Event.addHandler(AMI.find("#rows"), 'change', function(){
        generateContent();
    });

    AMI.Browser.Event.addHandler(AMI.find("#cols"), 'change', function(){
        generateContent();
    });

    AMI.Browser.Event.addHandler(AMI.find("#scroll"), 'change', function(){
        generateContent();
    });

    AMI.Browser.Event.addHandler(AMI.find("#template"), 'change', function(){
        generateContent();
    });

    AMI.Browser.Event.addHandler(AMI.find("#group_name"), 'change', function(){
        generateContent();
    });

    if(AMI.find('#group_name').value == ''){
        AMI.find('#group_name').value = getDefaultGroupName();
    }

    amiSpin.addFields([AMI.find('#cols'), AMI.find('#rows')], 10, 1, 1, '');

    AMI.$('#gadget_body').show();
    AMI.$('.but').show();
}

function showButtons(){
    AMI.$('#gadget_body').show();
    AMI.$('.but').show();
}

function getDefaultGroupName(){
    var groupName = '';
    var oForm = top.document.forms[top._cms_document_form];
    if(typeof(oForm) == 'object'){
        if(typeof(oForm.elements.header) != 'undefined'){
            groupName = oForm.elements.header.value;
        }else if(typeof(oForm.elements.name) != 'undefined'){
            groupName = oForm.elements.name.value;
        }
    }
    return groupName;
}

</script>