var browserDetector = {
    browser: '',
    version: '',

    aSupportedBrowsers: [
        {
            string:    navigator.userAgent,
            subString: 'Chrome',
            identity:  'Chrome'
        },
        {
            string:        navigator.vendor,
            subString:     'Apple',
            identity:      'Safari',
            versionSearch: 'Version'
        },
        {
            prop:          window.opera,
            identity:      'Opera',
            versionSearch: 'Version'
        },
        {
            string:    navigator.userAgent,
            subString: 'Firefox',
            identity:  'Firefox'
        },
        {
            string:        navigator.userAgent,
            subString:     'MSIE',
            identity:      'Explorer',
            versionSearch: 'MSIE'
        },
        {
            string:        navigator.userAgent,
            subString:     'Mobile Safari',
            identity:      'Android Phone',
            versionSearch: 'Android'
        }
    ],

    versionSearchString: '',

    isValid: false,

    detect: function(){
        this.browser = this.search(this.aSupportedBrowsers)
            || 'Unknown';
        this.version = this.searchVersion(navigator.userAgent)
            || this.searchVersion(navigator.appVersion)
            || 'Unknown';


        switch(this.browser){
            case 'Explorer':
                this.isValid = this.version >= 8;
                break;
            case 'Firefox':
                this.isValid = this.version >= 3;
                break;
            case 'Opera':
                this.isValid = this.version >= 9;
                break;
            case 'Chrome':
                this.isValid = true;
                break;
            case 'Safari':
                this.isValid = (this.version >= 3.2) || (this.version == 'Unknown'); // Apple substring, but not Safari
                break;
            case 'Android Phone':
                this.isValid = this.version >= 4;
                break;
            default:
                // Unknown browser is a good browser
                this.isValid = true;
        }
    },

    search: function(data){
        for(var i = 0; i < data.length; i++){
            var str = data[i].string, dataProp = data[i].prop;
            this.versionSearchString = data[i].versionSearch || data[i].identity;
            if(str){
                if(str.indexOf(data[i].subString) != -1){
                    return data[i].identity;
                }
            }else if(dataProp){
                return data[i].identity;
            }
        }
    },

    searchVersion: function(str){
        var
            index = str.indexOf(this.versionSearchString),
            version = index == -1 ? null : parseFloat(str.substring(index + this.versionSearchString.length + 1));

        if(this.browser == 'Opera' && version === null){
            // Old format 'Opera/XX.XX ...' support
            // instead of 'Opera/X.XX ... Version/XX.XX'
            var
                re = /Opera\/\d+\.\d+ /,
                index = str.search(re);

            if(index > -1){
                version = str.substring(index + 6);
                version = parseFloat(version.substring(0, version.indexOf(' ')));
            }
        }
        return version;
    }
};
browserDetector.detect();


function showInputProperties(oInput, isBlur){///
    if(!document.getElementById(oInput.name+'_prop')){
        return;
    }
    if(typeof(isBlur) == 'undefined'){
        isBlur = false;
    }
    var sMsg = oInput.value.length, cursorPos = -1;
    if(!isBlur && oInput.offsetHeight > 0){
        if(typeof(oInput.selectionStart) == 'number'){
            cursorPos = oInput.selectionStart;
        }else if(document.selection && (document.selection.type != 'Control')){
            var selRange = document.selection.createRange(), objRange = oInput.createTextRange();
            if(objRange.inRange(selRange)){
                selRange.setEndPoint('StartToStart', objRange);
                cursorPos = selRange.text.length;
            }
        }
    }

    if(cursorPos >= 0 && oInput.name != 'html_keywords' && oInput.name != 'html_description'){
        sColor = '#00a000';
        if(cursorPos > 60){
            sColor = '#e02000';
        }else if(cursorPos > 30){
            sColor = '#dba02d';
        }
        sMsg = '<font color="' + sColor + '">' + cursorPos + '</font>' + ':' + oInput.value.length;
    }

    document.getElementById(oInput.name + '_prop').innerHTML = sMsg;
}
