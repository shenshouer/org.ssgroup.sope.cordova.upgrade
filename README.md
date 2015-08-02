# org.ssgroup.sope.cordova.upgrade

此插件为一个cordova ios版本插件，用户检查本地app的一些信息以及从app store中检查是否有新版本，并提示更新

## 安装
	
	cordova plugin add https://github.com/shenshouer/org.ssgroup.sope.cordova.upgrade

	修改org.ssgroup.sope.cordova.upgrade/src/ios/CDVUpgrade.m中：

	// 修改成你自己app的信息
	self.appInfoUrl = @"http://itunes.apple.com/cn/lookup?id=284910350";
    self.appUpgradeUrl = @"http://itunes.apple.com/cn/lookup?id=284910350";

## 接口

	somai.upgrade.getAppName(successHandler, errorHandler);
    somai.upgrade.getPackageName(successHandler, errorHandler);
    somai.upgrade.getVersionNumber(successHandler, errorHandler);
    somai.upgrade.getVersionCode(successHandler, errorHandler);

    // 从app store中对比当前版本，并弹出提示是否更新
    somai.upgrade.checkUpgrade(successHandler, errorHandler);

 ## 例子参考

 	https://github.com/shenshouer/upgradeTest1