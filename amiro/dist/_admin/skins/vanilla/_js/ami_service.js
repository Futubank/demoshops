_cms_track_form_changes = false;

// service action
function doServiceAction(action){
	var oForm = document.forms['ami_serviceform'];
	oForm.elements['ami_full'].value = 1;
	oForm.elements['service_action'].value = action;
	oForm.action.value='apply';
	AMI.Page.doModuleAction('ami_service', 'ami_service_0', 'form_save', oForm);
	return false;
}

function doRepairAction(oForm){
    var
        modId = oForm.taget_mod_id.value,
        action = oForm.target_action.value,
        tail, params,
        re = new RegExp('^repair_');

    AMI.$('#do_action').prop('disabled', true);
    AMI.$('#do_action').addClass('button-disabled');

    if(re.test(action)){
        tail = {type: action.substr(7)};
        action = 'repair';
    }else{
        tail = {grp_target : 'all'};
    }

    params = {
        mod_id:        'ami_service',
        componentId:   'ami_service_0',
        service:       'repair',
        ami_full:      1,
        target_mod_id: modId,
        mod_action:    action,
        _amits:        _amits,
        _amitsh:       _amitsh
    };
    for(var i in tail){
        params[i] = tail[i];
    }

    AMI.HTTPRequest.getContent(
        'GET',
        amiModuleLink,
        params,
        function(state, content){
            content = AMI.$.parseJSON(content);
            if(
                'object' == typeof(content) &&
                'undefined' != typeof(content.data) &&
                'undefined' != typeof(content.data.messages)
            ){
                var message = [], q = content.data.messages.length;

                for(var i = 0; i < q; i++){
                    message.push(content.data.messages[i].msg);
                }
                if(q > 0){
                    alert(message.join("\n"));
                }else{
                    alert(AMI.Template.Locale.get('no_messages'));
                }
            }

            AMI.$('#do_action').prop('disabled', false);
            AMI.$('#do_action').removeClass('button-disabled');
        }
    );

    return false;
}

var aSupportedModActions = {};

AMI.$('#taget_mod_id').on('change', function(){
    var
        oSelect = AMI.$('#target_action'),
        modId = $(this).val(),
        value, caption;

    AMI.$('#target_action option').each(function(){
        $(this).remove();
    });

    oSelect.prop('disabled', true);
    AMI.$('#do_action').prop('disabled', true);
    AMI.$('#do_action').addClass('button-disabled');
    if('' == modId){

        return;
    }

    for(var i in aSupportedModActions){
        var aSelected = aSupportedModActions[i];

        if(aSelected.modId == modId){
            for(var j in aSelected.actions){
                if('undfefined' == typeof(aSelected.actions[j].action)){
                    continue;
                }
                switch(aSelected.actions[j].action){
                    case 'repair':
                        value = aSelected.actions[j].action + '_' + aSelected.actions[j].type;
                        caption = value;
                        break;
                    default:
                        value = aSelected.actions[j].action;
                        caption = value;
                        break;
                }
                caption = AMI.Template.Locale.get(caption);
                oSelect.append(AMI.$('<option>', {value: value}).text(caption));
            }
            oSelect.prop('disabled', false);
            AMI.$('#do_action').prop('disabled', false);
            AMI.$('#do_action').removeClass('button-disabled');
            break;
        }
    }
});

AMI.$(document).ready(function(){
    AMI.HTTPRequest.getContent(
        'GET',
        amiModuleLink,
        {
            mod_id:      'ami_service',
            ami_browser_cache: 1,
            service:     'repair',
            ami_full:    1,
            mod_action:  'get_mod_actions',
            componentId: 'ami_service_0',
            _amits:      _amits,
            _amitsh:     _amitsh,
            _cv:         cms_version,
            _rv:         rights_version,
            _ah:         amiAccessHash
        },
        function(state, content){
            var oSelect = AMI.$('#taget_mod_id');

            content = AMI.$.parseJSON(content);
            aSupportedModActions = content.data.supportedActions;
            for(var i in aSupportedModActions){
                var aData = aSupportedModActions[i];

                oSelect.append(AMI.$('<option>', {value: aData.modId}).text(aData.caption));
            }
            oSelect.prop('disabled', false);
            oSelect.prop('title', '');
            AMI.$('#target_action').prop('title', '');
            AMI.$('#do_action').prop('title', '');
        }
    );
});