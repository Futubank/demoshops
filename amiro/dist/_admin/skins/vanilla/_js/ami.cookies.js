var amiCookies = {

    getDate : function(days, hours){
        var oDate = new Date();
        if(typeof(days) == "undefined" && typeof(hours) == "undefined"){
            days = 30;
        }
        if(typeof(days) != "undefined"){
            oDate.setDate(oDate.getDate() + days);
        }
        if(typeof(hours) != "undefined"){
            oDate.setHours(oDate.getHours() + hours)
        }
        return oDate;
    },

    set : function(sName, sValue, path, days, hours){
        var expDate = this.getDate(days, hours);
        var expire = Math.floor(expDate.getTime() / 1000);
        var Now = Math.round(new Date().getTime() / 1000);
        var expireSeconds = expire - Now;
        if(path == undefined) path = '';
        AMI.Cookie.set(sName, sValue, expireSeconds, path);
    },

    get : function(sName){
        return AMI.Cookie.get(sName);
    },

    del : function(sName, path){
        if(path == undefined) path = '';
        AMI.Cookie.del(sName, path);
    },

    store : function(){
        // For compatibility purposes only
    },

    load : function(){
        // For compatibility purposes only
    }
}
