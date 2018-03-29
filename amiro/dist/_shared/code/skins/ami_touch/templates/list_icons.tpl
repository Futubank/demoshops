##--system info: module_owner="" module="" system="1"--##

<!--#set var="icons" value="
<div class="ami-item-list-icons" id="ami-item-list-icons-##id##" data-header="##header##" data-id="##id##" data-is-cat="##isCat##">
    <span class="ami-item-list-icons__row">
        <a class="ami-item-list-icons__row-edit" href="javascript:;"><img src="##www_root##_shared/code/web/skins/ami_touch/images/list_edit.png" /></a>
        <a class="ami-item-list-icons__row-delete" href="javascript:;" onclick="amiSkinController.deleteElement('##id##', ##isCat##); return false;"><img src="##www_root##_shared/code/web/skins/ami_touch/images/list_delete.png" /></a>
    </span>
</div>
"-->

<!--#set var="icons_table" value="
<td class="ami-item-list-icons ami-item-list-icons__row" id="ami-item-list-icons-##id##" data-header="##header##" data-id="##id##" data-is-cat="##isCat##" style="text-align: center;">
    <a class="ami-item-list-icons__row-edit" href="javascript:;"><img src="##www_root##_shared/code/web/skins/ami_touch/images/list_edit.png" /></a>
    <a class="ami-item-list-icons__row-delete" href="#" onclick="amiSkinController.deleteElement('##id##', ##isCat##); return false;"><img src="##www_root##_shared/code/web/skins/ami_touch/images/list_delete.png" /></a>
</td>
"-->