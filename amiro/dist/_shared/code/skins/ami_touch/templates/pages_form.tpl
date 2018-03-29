##--system info: module_owner="" module="" system="1"--##
%%include_template "_shared/code/skins/ami_touch/templates/_form.tpl"%%

<!--#set var="section_common" value="
<fieldset>
    <legend>%%section_common%%</legend>
    ##section_html##
</fieldset>
"-->

<!--#set var="section_navigation" value="
<fieldset>
    <legend>%%section_navigation%%</legend>
    ##section_html##
</fieldset>
"-->

<!--#set var="section_menu" value="
<fieldset>
    <legend>%%section_menu%%</legend>
    ##section_html##
</fieldset>
"-->

<!--#set var="section_extra" value="
<fieldset>
    <legend>%%section_extra%%</legend>
    ##section_html##
</fieldset>
"-->

<!--#set var="checkbox_field(marker="navigation")" value="
<div class="form-group checkbox-field checkbox__##name## field__##name##">
    <div class="checkbox-field__area">
        <label for="cb_##name##" class="col-md-5 control-label">##element_caption##</label>
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
