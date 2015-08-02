//
//  CDVUpgrade.m
//  upgradeTest
//
//  Created by sope on 15/8/2.
//
//

#import "CDVUpgrade.h"
#import "CJSONDeserializer.h"

@implementation CDVUpgrade

-(void)pluginInitialize{
    //CDVViewController *viewController = (CDVViewController *)self.viewController;
    //self.appInfoUrl = [viewController.settings objectForKey:@"appInfoUrl"];
    //self.appUpgradeUrl = [viewController.settings objectForKey:@"appUpgradeUrl"];
    // 修改成你自己app的信息
    self.appInfoUrl = @"http://itunes.apple.com/cn/lookup?id=284910350";
    self.appUpgradeUrl = @"http://itunes.apple.com/cn/lookup?id=284910350";
}

- (void)checkUpgrade:(CDVInvokedUrlCommand*)command{
    NSString *newVersion;
    NSURL *url = [NSURL URLWithString:self.appInfoUrl];
    
    //通过url获取数据
    NSString *jsonResponseString =   [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"通过appStore获取的数据是：%@",jsonResponseString);
    
    //解析json数据为数据字典
    NSDictionary *loginAuthenticationResponse = [self dictionaryFromJsonFormatOriginalData:jsonResponseString];
    
    //从数据字典中检出版本号数据
    NSArray *configData = [loginAuthenticationResponse valueForKey:@"results"];
    for(id config in configData)
    {
        newVersion = [config valueForKey:@"version"];
    }
    
    NSLog(@"通过appStore获取的版本号是：%@",newVersion);
    //获取本地软件的版本号
    NSString *localVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleVersion"];
    //NSString *localVersion = @"9.10.0";
    
    NSString *msg = [NSString stringWithFormat:@"你当前的版本是V%@，发现新版本V%@，是否下载新版本？",localVersion,newVersion];
    
    //对比发现的新版本和本地的版本
    if ([newVersion floatValue] > [localVersion floatValue])
    {
        UIAlertView *createUserResponseAlert = [[UIAlertView alloc] initWithTitle:@"升级提示!" message:msg delegate:self cancelButtonTitle:@"下次再说" otherButtonTitles: @"现在升级", nil];
        [createUserResponseAlert show];
        [createUserResponseAlert release];
    }
}

//响应升级提示按钮
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //如果选择“现在升级”
    if (buttonIndex == 1)
    {
        //打开iTunes  方法一
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.appUpgradeUrl]];
    }
}

- (void)getAppName:(CDVInvokedUrlCommand*)command{
    NSString * callbackId = command.callbackId;
    NSString * version =[[[NSBundle mainBundle]infoDictionary]objectForKey :@"CFBundleDisplayName"];
    CDVPluginResult * pluginResult =[CDVPluginResult resultWithStatus : CDVCommandStatus_OK messageAsString : version];
    [self.commandDelegate sendPluginResult : pluginResult callbackId : callbackId];
}

- (void)getPackageName:(CDVInvokedUrlCommand*)command{
    NSString* callbackId = command.callbackId;
    NSString* packageName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:packageName];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)getVersionNumber:(CDVInvokedUrlCommand*)command{
    NSString* callbackId = command.callbackId;
    NSString* version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (version == nil) {
        NSLog(@"CFBundleShortVersionString was nil, attempting CFBundleVersion");
        version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        if (version == nil) {
            NSLog(@"CFBundleVersion was also nil, giving up");
            // not calling error callback here to maintain backward compatibility
        }
    }
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:version];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)getVersionCode:(CDVInvokedUrlCommand*)command{
    NSString* callbackId = command.callbackId;
    NSString* version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:version];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

#pragma mark - 辅助方法：将json 格式的原始数据转解析成数据字典
//将json 格式的原始数据转解析成数据字典
-(NSDictionary *)dictionaryFromJsonFormatOriginalData:(NSString *)jsonString
{
    //定义一个NSError对象，用于捕获错误信息
    NSError *error;
    
    NSDictionary *rootDic = [[CJSONDeserializer deserializer] deserialize:[jsonString dataUsingEncoding:NSUTF8StringEncoding] error:&error];
    return rootDic;
}

@end
