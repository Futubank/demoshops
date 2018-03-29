##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_list.tpl"%%

<!--#set var="javascript" value="
AMI.Message.addListener(
    'ON_COMPONENT_CONTENT_PLACED',
    function(oComponent){
        if(oComponent.componentType == 'list'){
            var generateBtnHtml =
            '<input class="amiModuleLink but-mid" type="button" style="margin-left: 4px;" value="%%generate_btn%%"           onClick="javascript:if(!categoriesIds.length){alert(' + "'" +
            '%%warn_no_categories_on_generate%%' + "'" + ');}else{openDialog(' + "'" + '%%coupons_creation%%' + "'" + ', ' + "'" +
            'eshop_coupons.php?action=generate' + "'" + ', 500, 340);}return false">';

            if(AMI.$('.group_operations_panel')[0].style.display == 'none'){
                if(document.getElementById('span_generate_coupons')){
                    document.getElementById('span_generate_coupons').style.display = '';
                }else{
                    var oGenerateButton = AMI.Browser.DOM.create('SPAN', 'span_generate_coupons', '');
                    oGenerateButton.innerHTML = generateBtnHtml; 
                    document.getElementById('component_eshop_coupons_list_eshop_coupons_1').appendChild(oGenerateButton);
                }
            }else{
                if(document.getElementById('span_generate_coupons')){
                    document.getElementById('span_generate_coupons').style.display = 'none';
                }
                if(!document.getElementById('span_grp_generate_coupons')){
                    var oGrpDelimeter = AMI.Browser.DOM.create('SPAN', '', 'list-group-delimiter');
                    oGrpDelimeter.innerHTML = '&nbsp;|&nbsp;';
                    AMI.$('.group_operations_panel')[0].appendChild(oGrpDelimeter);

                    var oGenerateButton = AMI.Browser.DOM.create('SPAN', 'span_grp_generate_coupons', '');
                    oGenerateButton.innerHTML = generateBtnHtml;
                    AMI.$('.group_operations_panel')[0].appendChild(oGenerateButton);
                }
            }
        }
        return true;
    },
    true
);
"-->
