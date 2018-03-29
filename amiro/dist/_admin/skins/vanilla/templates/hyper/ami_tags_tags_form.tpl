##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="section_form" value="
<div id="recount_button" style="display:none;">
    <br />
    <input type="button" name="reindex" value="  %%recount_btn%%  " class="but-mid" OnClick="javascript:openExtDialog('%%recount%%', '##script_link##?action=repair', 0, 0, 550, 330, -1, -1, 0, 1); document.location.reload();" />
    <br /><br />
</div>

<script type="text/javascript">
AMI.PartialAsync.init({
    actions: {
        list_edit:                'edit',
        list_delete:              'del'
    },
    groupActions: {
        grp_delete:               'del',
        grp_gen_html_meta:        'gen_keywords',
        grp_gen_html_meta_force:  'gen_keywords_force',
    },
    blankActions: ['print'],
    confirms: {
        list_delete: AMI.Template.Locale.get('list_confirm_deletion')
    },
    scrollToForm: ['edit', 'save']
});
</script>
"-->
