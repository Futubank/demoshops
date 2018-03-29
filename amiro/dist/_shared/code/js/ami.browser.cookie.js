AMI.Browser.Cookie = {
    set : function(sName, sValue, iHours){
      var oDate = new Date();
      if(typeof(iHours) == "undefined"){
        iHours = 1;
      }
      oDate.setHours(oDate.getHours() + iHours);
      this.del(sName);
      document.cookie = sName + "=" + escape(sValue) + "; path=/; expires="+oDate.toGMTString();
    },

    del : function(sName) {
        if(this.get(sName)){
            document.cookie = sName + "=" + "; path=/ ;expires=Thu, 01-Jan-1970 00:00:01 GMT";
        }
    },

    get : function(sName){
        var cookiePairs = document.cookie.split('; ');
        for(var i=0;i<cookiePairs.length;i++){
            var cookieName = cookiePairs[i].substr(0, cookiePairs[i].indexOf('='));
            var cookieValue = cookiePairs[i].substr(cookiePairs[i].indexOf('=') + 1);
            if(cookieName == sName){
                return unescape(cookieValue);
            }
        }
        return null;
    }
}
