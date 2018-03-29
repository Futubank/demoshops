##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_list.tpl"%%

<!--#set var="javascript" value="
var refresh_list = document.getElementsByClassName('refreshListButton');
if(refresh_list !== null){
    refresh_list[0].addEventListener('click', function(){
        var recount_button = document.getElementById('recount_button');
        if(recount_button !== null){
            recount_button.style.display = 'none';

            var list_table = document.getElementsByClassName('componentList');
            if(list_table != 'null'){
                var list_table_rows = list_table[0].getElementsByTagName('TR');
                if(list_table_rows !== null && list_table_rows.length > 1){
                    recount_button.style.display = 'show';
                }
            }
        }
    });
}

var recount_button_visibility = false;
var recount_button_asked = false;
AMI.Message.addListener('ON_AMI_LIST_ROW', function(oComponent, oParameters){
    if(!recount_button_visibility && !recount_button_asked){
        var recount_button = document.getElementById('recount_button');
        if(recount_button !== null){
            recount_button.style.display = 'block';
            recount_button_visibility = true;
        }else if(!recount_button_asked){
            AMI.Message.addListener('ON_AMI_LIST_SHOW_ADD_BUTTON', function(){
                var recount_button = document.getElementById('recount_button');
                if(recount_button !== null){
                    recount_button.style.display = 'block';
                }
            });
            recount_button_asked = true;
        }
    }
});
"-->