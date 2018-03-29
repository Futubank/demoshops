%%include_language "templates/lang/_sublink_validator.lng"%%

<!--#set var="check_url" value="
<script>
<!--

function checkUrl(testValue) {
    www_root = editorBaseHref;
    var res = true;
    var re = new RegExp("^[a-zA-Z0-9_\/\.\-]*$");

    if ((typeof(www_root)!='undefined' && (testValue.toLowerCase() + '/').substr(0, www_root.length)==www_root.toLowerCase())
        || !re.test(testValue)){
      alert('%%invalid_symbol%%');
      res = false;
    }

    return res;
}
//-->
</script>
"-->
