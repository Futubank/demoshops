##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/members.lng"%%

<script type="text/javascript">
var editor_enable = '##editor_enable##';
var _cms_document_form = 'membform';
var _cms_script_link = '##script_link##?';

##header_memeber_script##

function validateForm(form) {
    var errmsg = "";
    editor_updateHiddenField("description");
##check_member_script##
    return true;
}

##IF(disabled_allow_to_edit_at_front)##
AMI.$(document).ready(function(){
    AMI.$('#allow_to_edit_at_front').tooltip({
        bodyHandler: function(){
            return '%%edit_front_allowed_modules_disabled%%';
        },
        showURL: false
    }
    );
});
##ENDIF##
</script>

<br />
<form action="##script_link##" method="post" id="membform" cname="membform" onSubmit="return validateForm(this);" enctype="multipart/form-data" autocomplete="off">
    <input type="hidden" name="id" value="##id##" />
    <input type="hidden" name="action" value="##action##" />
    <input type="hidden" name="activate" value="" />
    ##filter_hidden_fields##
    <table cellspacing="5" cellpadding="0" border="0" class="frm">
        <col width="150">
        <col width="*">
        ##IF(AMI_ALLOW_EFNSU)##
        <tr>
            <td colspan="2">
                <label>
                    <input type="checkbox" name="allow_to_edit_at_front"##allow_to_edit_at_front####disabled_allow_to_edit_at_front## /> <span id="allow_to_edit_at_front">%%allow_to_edit_at_front%%</span>
                </label>
            </td>
        </tr>
        ##IF(!disabled_allow_to_edit_at_front)##
        <tr><td colspan="2"><div class="tooltip">%%tooltip_edit_at_front%%.</div></td></tr>
        ##ENDIF##
        <tr><td colspan="2"><div class="tooltip">
        ##IF(allow_edit_at_front)##
        %%allow_edit_at_front_on%%
        ##ELSE##
        %%allow_edit_at_front_off%%
        ##ENDIF##
        </div></td></tr>
        ##ENDIF##
        ##member_form##
        ##ext_modules_custom_fields_top##
    </table>
    <table cellspacing="5" cellpadding="0" border="0" class="frm">
        <col width="150">
        <col width="*">
        <tr>
            <td colspan="2">
                <div class="tab-control" id="tab-control" onselectstart="return false;" style="min-width: 700px"></div>
                <div class="tabs-container">
                    <div class="tab-page" id="tab-page-description">
                        <textarea class="field" style="width:100%" rows="14" name=description id="description">##info##</textarea>
                        <script type="text/javascript">
                            if (editor_enable) {
                                editor_generate('description', cmD_STB, false);
                            }
                        </script>
                    </div>

                    ##if(ext_modules_custom_fields_tab)##
                    <div class="tab-page" id="tab-page-custom-fields">
                        %%include_template "templates/ext_modules_custom_fields.tpl"%%
                    </div>
                    ##endif##

                </div>
                </div>

                <script type="text/javascript">
                    var baseTabs = new cTabs('tab-control', {
                        'description' : ['%%info%%', 'active', '', false],
                                ##if (ext_modules_custom_fields_tab)##
                                'custom-fields' : ['%%tab_custom_fields%%', 'normal', '', false],
                                ##endif##
                                '': ''});

                </script>
            </td>
        </tr>
    </table>

    <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
        <col width="150">
        <col width="*">
        ##ext_modules_custom_fields_bottom##
        <tr><td colspan="2" align="right"><br />##form_buttons##<br /><br /></td></tr>
        <tr><td colspan="2"><sub>%%required_fields%%</sub></td></tr>
    </table>

</form>
