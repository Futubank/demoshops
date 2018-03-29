##--system info: module_owner="" module="" system="1"--##
##-- form { --##

<!--#set var="hidden_field" value="<input name="##name##" value="##value##" type="hidden"##attributes## />"-->

<!--#set var="static_field" value="
<div class="form-group input__##name## field__##name##">
    <label for="##name##" class="col-md-3 control-label">##element_caption##</label>
    <div class="col-md-8">##value##</div>
</div>
"-->

<!--#set var="input_field" value="
<div class="form-group input__##name## field__##name##">
    <label for="##name##" class="col-md-3 control-label">##IF(validator_filled)##<span class="text-danger">*</span> ##endif####element_caption##</label>
    <div class="col-md-8">
        <div class="input-text-area">
            <input ng-model="fields.##name##" type="text" placeholder="" class="form-control text-input" name="##name##" id="##name##" ami_validators="##validators##">
            <i title="%%delete_content%%" onclick="clearArea('##name##', this);return false;" class="fa fa-times close-btn"></i>
        </div>
        <div class="has-error" ng-show="ami_form.##name##.$dirty && ami_form.##name##.$invalid">
            <div id="error_msg_##name##" for="##name##" class="help-block animation-slideDown"></div>
        </div>
    </div>
</div>
"-->

<!--#set var="input_field(marker="number")" value="
<div class="form-group input__##name## field__##name##">
    <label for="##name##" class="col-md-3 control-label">##IF(validator_filled)##<span class="text-danger">*</span> ##endif####element_caption##</label>
    <div class="col-md-3">
        <div class="input-text-area number-input">
            <input ng-model="fields.##name##" type="text" placeholder="" class="form-control text-input number-input" name="##name##" id="##name##" ami_validators="##validators##">
            <i title="%%delete_content%%" onclick="clearArea('##name##', this);return false;" class="fa fa-times close-btn"></i>
        </div>
        <div class="has-error" ng-show="ami_form.##name##.$dirty && ami_form.##name##.$invalid">
            <div id="error_msg_##name##" for="##name##" class="help-block animation-slideDown"></div>
        </div>
    </div>
</div>
"-->
<!--#set var="input_field(marker="number")" value="
<div class="form-group input__##name## field__##name##">
    <label for="##name##" class="col-md-3 control-label">##IF(validator_filled)##<span class="text-danger">*</span> ##endif####element_caption##</label>
    <div class="col-md-3">
        <div class="input-text-area number-input">
            <input ng-model="fields.##name##" type="text" placeholder="" class="form-control text-input number-input" name="##name##" id="##name##" ami_validators="##validators##">
            <i title="%%delete_content%%" onclick="clearArea('##name##', this);return false;" class="fa fa-times close-btn"></i>
        </div>
        <div class="has-error" ng-show="ami_form.##name##.$dirty && ami_form.##name##.$invalid">
            <div id="error_msg_##name##" for="##name##" class="help-block animation-slideDown"></div>
        </div>
    </div>
</div>
"-->

<!--#set var="date_field" value="
<div class="form-group date__##name## field__##name##">
    <label class="col-md-3 control-label" for="##name##">##IF(validator_filled)##<span class="text-danger">*</span> ##endif####element_caption##</label>
    <div class="col-md-3">
        <div class="input-group">
            <input ng-model="fields.##name##" class="form-control form-style-input input-data-type number-input" type="date" name="##name##" ami_validators="##validators##">
        </div>
        <div class="has-error" ng-show="ami_form.##name##.$dirty && ami_form.##name##.$invalid">
            <div id="error_msg_##name##" for="##name##" class="help-block animation-slideDown"></div>
        </div>
    </div>
</div>
"-->

<!--#set var="datetime_field" value="
<div class="form-group datetime-field field__##name##">
    <label class="col-md-3 control-label" for="##name##">##IF(validator_filled)##<span class="text-danger">*</span> ##endif####element_caption##</label>
    <div class="col-md-2 data-area">
        <div class="input-group">
            <input ng-model="fields.##name##" class="form-control form-style-input input-data-type" type="date" name="##name##"  ##IF(validator_filled)##required##endif## ami_validators="##validators##">
        </div>
        <div class="has-error" ng-show="ami_form.##name##.$dirty && ami_form.##name##.$invalid">
            <div id="error_msg_##name##" for="##name##" class="help-block animation-slideDown"></div>
        </div>
    </div>
    <div class="col-md-1 data-time-area">
        <div class="input-group">
            <input class="form-control form-style-input" ng-model="fields.##name##_time" type="time" name="##name##_time" step="1" ##IF(validator_filled)##required##endif## ami_validators="##validators##">
        </div>
        <div class="has-error" ng-show="ami_form.##name##_time.$dirty && ami_form.##name##_time.$invalid">
            <div id="error_msg_##name##_time" for="##name##_time" class="help-block animation-slideDown"></div>
        </div>
    </div>
</div>
"-->

<!--#set var="checkbox_field" value="
<div class="form-group checkbox-field checkbox__##name## field__##name##">
    <div class="checkbox-field checkbox-field__area">
        <label for="cb_##name##" class="col-md-3 control-label">##element_caption##</label>
        <div class="col-md-3 control-label-input">
            <div class="checkbox">
                <label for="cb_##name##">
                    <input ng-model="fields.##name##" type="checkbox" value="1" name="##name##" id="cb_##name##" ami_validators="##validators##"##attributes## />
                </label>
            </div>
        </div>
    </div>
</div>
"-->

<!--#set var="checkbox_field(name=sticky)" value="
<div class="form-group checkbox-field checkbox__##name## field__##name##">
    <div class="checkbox-field checkbox-field__area">
        <label for="cb_##name##" class="col-md-3 control-label">##element_caption##</label>
        <div class="col-md-1 control-label-input control_sticky">
            <div class="checkbox">
                <label for="cb_##name##">
                    <input ng-model="fields.##name##" type="checkbox" value="1" name="##name##" id="cb_##name##" ami_validators="##validators##">
                </label>
            </div>
        </div>
"-->

<!--#set var="date_field(name=date_sticky_till)" value="
        <label class="col-md-1 control-label control_sticky" for="##name##">##IF(validator_filled)##<span class="text-danger">*</span> ##endif####element_caption##</label>
        <div class="col-md-3 control_sticky_data">
            <div class="input-group">
                <input ng-model="fields.##name##" class="form-control form-style-input" type="date" name="##name##"  ##IF(validator_filled)##required##endif## ami_validators="##validators##">
            </div>
            <div class="has-error" ng-show="ami_form.##name##.$dirty && ami_form.##name##.$invalid">
                <div id="error_msg_##name##" for="##name##" class="help-block animation-slideDown"></div>
            </div>
        </div>
    </div>
</div>
"-->

<!--#set var="htmleditor_field" value="
<div class="announce-block textarea__##name## field__##name##">
##--
    <div class="block-title">
        <h2>##element_caption##</h2>
    </div>
--##
    <div class="form-group">
        <div class="col-xs-12">
            <textarea ui-tinymce="{}" ng-model="fields.##name##" id="##name##" name="##name##" rows="9" class="form-control textarea-editor" ##IF(validator_filled)##required##endif## ami_validators="##validators##"></textarea>
            <div class="has-error" ng-show="ami_form.##name##.$dirty && ami_form.##name##.$invalid">
                <div id="error_msg_##name##" for="##name##" class="help-block animation-slideDown"></div>
            </div>
        </div>
    </div>
</div>
"-->

<!--#set var="textarea_field" value="
<div class="form-group textarea-input textarea__##name## field__##name##">
    <label for="html_title" class="col-md-3 control-label">##element_caption##</label>
    <div class="col-md-8">
        <div class="textarea-block">
            <textarea ng-model="fields.##name##" id="##name##" name="##name##" rows="##if((name=="html_keywords")||(name=="html_description"))##3##else##6##endif##" class="form-control textarea-editor textarea-input" ##IF(validator_filled)##required##endif## ami_validators="##validators##"></textarea>
            <i title="%%delete_content%%" onclick="clearArea('##name##', this);return false;" class="fa fa-times close-btn"></i>
        </div>
        <div class="has-error" ng-show="ami_form.##name##.$dirty && ami_form.##name##.$invalid">
            <div id="error_msg_##name##" for="##name##" class="help-block animation-slideDown"></div>
        </div>
    </div>
</div>
"-->

<!--#set var="select_field" value="
<div class="form-group selectbox field__##name##">
    <label class="col-md-3 control-label" for="##name##">##IF(validator_filled)##<span class="text-danger">*</span> ##endif####element_caption##</label>
    <div class="col-md-3">
        <select ng-model="fields.##name##" id="##name##" name="##name##" class="select-chosen form-control form-style-input" data-placeholder="" ami_validators="##validators##">
            ##-- <option></option> FOR CHOSEN PLUGIN --##
            ##select##
        </select>
        <div class="has-error" ng-show="ami_form.##name##.$dirty && ami_form.##name##.$invalid">
            <div id="error_msg_##name##" for="##name##" class="help-block animation-slideDown"></div>
        </div>
    </div>
</div>
"-->

<!--#set var="select_field_row" value="
<option value="##value##" ##selected##>##caption##</option>
"-->

<!--#set var="radio_field" value="
<div class="form-group radiobox field__##name##">
    <label class="col-md-3 control-label" for="##name##">##element_caption##</label>
    <div class="col-md-8">
        ##select##
        <div class="has-error" ng-show="ami_form.##name##.$dirty && ami_form.##name##.$invalid">
            <div id="error_msg_##name##" for="##name##" class="help-block animation-slideDown"></div>
        </div>
    </div>
</div>
"-->

<!--#set var="radio_field_row" value="
<label><input ng-model="fields.##name##" ##disabled## type="radio" id="##id##" name="##name##" ##checked## value="##value##" /><span>##caption##</span></label>&nbsp;
"-->

<!--#set var="form_buttons" value="
<div id="formButtons" class="form-group form-actions amiro-form-action-btn">
    ##cancel_btn## ##add_btn## ##save_btn## ##apply_btn##
</div>
"-->

<!--#set var="add_btn" value="
<span class="amiro-form-action-btn__button">
    <input value="%%add_btn%%" id="saveActionButton" type="submit" class="btn btn-sm btn-primary" ##attributes## ng-click="submit() && ami_form.$valid && save();">
</span>
"-->

<!--#set var="apply_btn" value="
<span class="amiro-form-action-btn__button">
    <input value="%%apply_btn%%" id="saveActionButton" type="submit" class="btn btn-sm btn-primary selected" ##attributes## ng-click="submit() && ami_form.$valid && save();">
</span>
"-->

<!--#set var="save_btn" value="
<span class="amiro-form-action-btn__button">
    <input value="%%ok_btn%%" id="saveActionButton" type="submit" class="btn btn-sm btn-primary" ##attributes## ng-click="submit() && ami_form.$valid && save()">
</span>
"-->

<!--#set var="cancel_btn" value="
<span class="amiro-form-action-btn__button">
    <input value="%%cancel_btn%%" id="cancelActionButton" class="btn btn-sm btn-warning" ##attributes## ng-click="cancel();">
</span>
"-->

<!--#set var="tabset" value="
<div class="tab-container">
    <ul class="nav nav-tabs" id="tab-control-##name##">
        ##tab_array##
    </ul>
    <div class="tab-content">
        ##section_html##
    </div>
</div>
"-->

<!--#set var="tab" value="
<div id="tab##name##" class="tab-pane field__##name## fade ##state## ##if(state == 'active')##in##endif##">
    ##section_html##
</div>
"-->

<!--#set var="tab_array" value="
<li class="##state## field__##name##"><a data-toggle="tab" href="#tab##name##">##title##</a></li>
"-->

<!--#set var="section_form" value="
<script type="text/javascript">
##scripts##
</script>
<div id="debug" style="max-height:300px;overflow:auto;"></div>
<form
    id="form-validation"
    name="ami_form"
    class="form-horizontal form-bordered"
    onsubmit="return false;"
    enctype="multipart/form-data"
    method="post"
    action=""
    novalidate="true"
    ng-submit="ami_form.$valid"
>

    <div id="form_status_messages"></div>
    ##section_html##
    ##form_buttons##
</form>

<script>
$(document).ready(function(){
    parent.amiAdminFormPage.init();
    parent.amiAdminFormPage.showHideOk('stop');
});
</script>

"-->

##-- } form --##