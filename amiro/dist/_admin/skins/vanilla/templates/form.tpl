##--!ver=0200 rules="-SETVAR|-IF"--##
%%include_language "templates/lang/main.lng"%%
<div ##--form_align--## style="display:##display_form##;" id="div_properties_form" class="main-form">

    <table ccc="1" border="0" cellpadding="0" cellspacing="0" ##if(width != '')##width="##width##"##endif## ##if(height != '')##height="##height##"##endif## class="main-form__table properties_form_table" style="margin-left:auto;margin-right:auto;" >
        <tr>
            <td valign=top>
            <table border="0" class="properties_form_table ##ACTIVE_MODULE##_table" cellpadding="0" cellspacing="0" width=100%>
                <tr height=35 class="properties_form_title">
                    <td style="line-height:0px;" align=left></td>

                    <td nowrap height="35"><span id="form_title" class="form-header">##header##</span></td>
                    <td nowrap height="35" style="text-align:right;">
                    <div id=stModified style="display:none;" class=form-header>
                        [ %%modified%% ]
                    </div></td>

                    <td style="line-height:0px;"></td>
                </tr>
                <tr>
                    <td width="11"></td>
                    <td colspan=2 class="table_sticker" valign="top"> ##content## </td>
                    <td width="11"></td>
                </tr>
                <tr>
                    <td style="line-height:0px;"></td>
                    <td style="line-height:0px;" colspan=2  height="11"></td>
                    <td style="line-height:0px;"></td>
                </tr>
            </table></td>
        </tr>
    </table>
</div>