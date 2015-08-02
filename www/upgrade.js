var exec = require('cordova/exec');


module.exports = {
    checkUpgrade: function(onSuccess,onError){
        exec(onSuccess, onError, "Upgrade", "checkUpgrade");
    },

    getAppName: function(onSuccess,onError){
        exec(onSuccess, onError, "Upgrade", "getAppName");
    },

    getPackageName: function(onSuccess,onError){
        exec(onSuccess, onError, "Upgrade", "getPackageName");
    },

    getVersionNumber: function(onSuccess,onError){
        exec(onSuccess, onError, "Upgrade", "getVersionNumber");
    },

    getVersionCode: function(onSuccess,onError){
        exec(onSuccess, onError, "Upgrade", "getVersionCode");
    },
};