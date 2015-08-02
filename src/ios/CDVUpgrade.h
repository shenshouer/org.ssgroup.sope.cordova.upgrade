//
//  CDVUpgrade.h
//  upgradeTest
//
//  Created by sope on 15/8/2.
//
//

//#import <Cordova/Cordova.h>
#import <Cordova/CDV.h>
#import <Cordova/CDVPlugin.h>

@interface CDVUpgrade : CDVPlugin

@property(nonatomic,strong)NSString *appInfoUrl;
@property(nonatomic,strong)NSString *appUpgradeUrl;

// 检查升级
- (void)checkUpgrade:(CDVInvokedUrlCommand*)command;
// 获取app名称
- (void)getAppName:(CDVInvokedUrlCommand*)command;
// 获取包名
- (void)getPackageName:(CDVInvokedUrlCommand*)command;
// 获取版本号
- (void)getVersionNumber:(CDVInvokedUrlCommand*)command;
// 获取版本code
- (void)getVersionCode:(CDVInvokedUrlCommand*)command;

@end
