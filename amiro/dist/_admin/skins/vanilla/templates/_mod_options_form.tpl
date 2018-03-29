%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/_buttons.lng"%%
%%include_language "templates/lang/options_form.lng"%%
%%include_template "templates/_sublink_validator.tpl"%%

<table cellspacing=0 cellpadding=3 border=0 width=100% height=100%>
    <tr>
        <td valign=top>
        <table cellspacing=0 cellpadding=3 class="options_tab seo_options_table">
            <tr>
                <td colspan=2>
                <br />
                </td>
            </tr>
            ##if(USE_SPECIAL_LIST_VIEW)##
            <tr>
                <td colspan=2 valign=top>
                <script type="text/javascript">
                    function OnObjectChanged__mod_options_form(sObjectName, bChangedFirst, evt) {
                        errFunc = OnObjectChanged__mod_options_form;

                        if (sObjectName == 'html_keywords' || sObjectName == 'html_description') {
                            var oElement = document.forms[_cms_document_form].elements[sObjectName];
                            if (oElement.value.indexOf('"') > -1) {
                                baseTabs.showTab('options');
                                alert('%%warn_invalid_meta_tag_content%%');
                                var re = /"/g;
                                oElement.value = oElement.value.replace(re, '');
                                oElement.focus();
                                oElement = null;
                                return false;
                            }
                        }
                        if (sObjectName != 'urgent') {
                            return true;
                        }
                        var oForm = document.forms[_cms_document_form], bUrgentChecked = oForm.urgent.checked;
                        oForm.public_direct_link.disabled = bUrgentChecked;
                        if (bUrgentChecked) {
                            oForm.public_direct_link.srcChecked = oForm.public_direct_link.checked;
                            oForm.public_direct_link.checked = true;
                        } else {
                            oForm.public_direct_link.checked = oForm.public_direct_link.srcChecked;
                        }
                        oForm = null;
                        document.getElementById('urgent_date').disabled = !bUrgentChecked;
                        return true;
                    }

                    addFormChangedHandler(OnObjectChanged__mod_options_form);
                </script>
                <input class=check type="checkbox" name="public_direct_link" id="public_direct_link" ##public_direct_link## value="1"##public_direct_link_disabled## srcChecked="##public_direct_link##" />
                <label for=public_direct_link>%%public_direct_link%%</label></td>
            </tr>
            <tr>
                <td colspan="2" valign="top">
                <table cellpadding="0" cellspacing="0" border="0" style="padding:0px">
                    <tr>
                        <td style="padding:0px">
                        <input class="check" type="checkbox" name="urgent" id="urgent" value="1"##urgent## />
                        </td>
                        <td style="padding:0px 0px 0px 4px"><label for="urgent">%%urgent%%</label></td>
                        <td style="padding-left:15px">%%urgent_date%%:</td>
                        <td style="padding:0px">
                        <input type="text" id="urgent_date" name="urgent_date" class="field fieldDate" value="##urgent_date##" maxlength="30"##urgent_date_disabled## />
                        <a href="javascript:void(0);" onclick="if (document.forms[_cms_document_form].urgent.checked) { return getCalendar(event, document.forms[_cms_document_form].urgent_date); } else {alert('%%warn_check_urgent_first%%'); return false;}"><img class="clnd_img" src="skins/vanilla/images/spacer.gif"></a></td>
                    </tr>
                </table></td>
            </tr>
            ##endif##
            ##if(EXTENSION_FORUM=="1")##
            <tr>
                <td colspan="2" valign="top">
                <input class="check" type="checkbox" name="disable_comments" id="disable_comments" value="1"##disable_comments## />
                <label for="disable_comments">%%disable_comments%%</label></td>
            </tr>
            ##endif##
            ##if(USE_SUBLINKS=="1")##
            ##check_url##
            <tr>
                <td class="seo_options_title">%%sublink%%: </td>
                <td>
                <input type=text name=sublink class="field field56" value="##sublink##" maxlength="128">
                <input type=hidden name=original_sublink collect_link_ignore=1 value="##sublink##">
                </td>
            </tr>
            ##endif##
            ##--
            <tr>
                <td colspan=2 valign=top>
                <input class=check type="checkbox" name="html_title_inherit" ##html_title_inherit## value="1">
                %%title_inherit%% </td>
            </tr>
            --##
            <tr>
                <td class="seo_options_title" valign=top>%%title%%: </td>
                <td class="seo">
                <input type=text name="html_title" class="field field56" value="##html_title##" prop="on">
                <span class=input_opt id=html_title_prop>&nbsp;</span>
                <input type=hidden name=original_html_title collect_link_ignore=1 value="##html_title##">
                </td>
            </tr>
            ##--if(USE_ID_PAGE=="1")##
            <tr>
                <td>%%page%%: </td>
                <td>
                <select name=id_page>
                    <option value=0>%%all%%</option>
                    ##page_rows##
                </select></td>
            </tr>
            ##endif--##
            <tr>
                <td class="seo_options_title" valign=top>%%keywords%%: </td>
                <td class="seo">                <textarea rows=4 cols=40 name="html_keywords" class=field prop="on">##html_keywords##</textarea><span class=input_opt id=html_keywords_prop>&nbsp;</span>
                <input type=hidden name=original_html_keywords collect_link_ignore=1 value="##html_keywords##">
                <input type=hidden name=is_keywords_manual collect_link_ignore=1 value="##is_keywords_manual##">
                </td>
            </tr>
            <tr>
                <td class="seo_options_title" valign=top>%%description%%: </td>
                <td class="seo">                <textarea rows=4 cols=40 name="html_description" class=field prop="on">##html_description##</textarea>
                <input type=hidden name=original_html_description collect_link_ignore=1 value="##html_description##">
                <span class=input_opt id=html_description_prop>&nbsp;</span></td>
            </tr>
            <tr>
                <td></td>
                <td><span class=text_button onclick="clearHTMLFields( document.forms[_cms_document_form])">%%clear_fields%%</span></td>
            </tr>
            ##if(USE_DETAILS_NOINDEX=="1")##
            <tr>
                <td colspan="2" valign="top">
                <input class="check" type="checkbox" name="details_noindex" id="details_noindex" value="1"##details_noindex## />
                <label for="details_noindex">%%details_noidex%%</label></td>
            </tr>
            ##endif##
            ##if(USE_ID_EXTERNAL=="1")##
            <tr>
                <td colspan=2 height=100%></td>
            </tr>
            <tr>
                <td class="seo_options_title" valign=top>%%id_external%%: </td>
                <td>
                <input type=hidden name=id_external_manual value="1">
                <input type=text name=id_external class="field field56" value="##id_external##" >
                </td>
            </tr>
            ##endif##
            ##if(USE_ID_EXTERNAL_LINK=="1")##
            <tr>
                <td colspan=2 height=100%></td>
            </tr>
            <tr>
                <td valign=top>%%external_links%%: </td>
                <td><a href="javascript:void(0);" onClick="openExtDialog('%%external_links%%', 'external_link_popup.php?flt_id_target=##id##&flt_module_name=##module_name##', 1); return false;"><img title="%%external_links%%" border="0" src="skins/vanilla/icons/icon_external_link.gif" helpId="external_links" align=absmiddle class=icon></a> [%%link_sources%%:
                <input name="num_external_links" type="text" value="##num_external_links##" readonly style="width: 20px;text-align: right;font-size:11px; BORDER: #FFFFFF 0px solid;">
                ] </td>
            </tr>
            ##endif##
            <tr>
                <td colspan=2 height=100%></td>
            </tr>
        </table></td>
    </tr>
    <tr>
        <td>
        <br />
        </td>
    </tr>
</table>
