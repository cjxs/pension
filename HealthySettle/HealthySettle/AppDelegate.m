//
//  AppDelegate.m
//  HealthySettle
//
//  Created by yrc on 16/3/17.
//  Copyright © 2016年 yrc. All rights reserved.
//
/**
 *
 * 　　┏┓      ┏┓
 * 　　┏┛   ┻━━━┛  ┻┓
 * 　　┃            ┃
 * 　　┃　　　━      ┃
 * 　　┃　┳┛　  ┗┳   ┃
 * 　　┃            ┃
 * 　　┃　　　┻      ┃
 * 　　┃            ┃
 * 　　┗━┓　　　   ┏━┛
 * 　　　　┃　　　 神兽保佑
 * 　　　　┃　　　┃代码无BUG！
 * 　　　　┃　　　┗━━━┓
 * 　　　　┃         ┣┓
 * 　　　　┃        ┏┛
 * 　　　　┗┓┓┏━┳┓┏┛
 * 　　　　 ┃┫┫ ┃┫┫
 * 　　　　 ┗┻┛ ┗┻┛
 * ━━━━━━神兽出没━━━━━━
 */


#import "AppDelegate.h"
#import "GuideVController.h"
#import "TabbarController.h"
#import "YTKNetworkConfig.h"
#import "MobClick.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"
#import "UMessage.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"



#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define _IPHONE80_ 80000


static NSString * const UMDEVICETOKEN      = @"UMDeviceToken";// 友盟推送的设备Tokenhttps://app.yinxihttps://app.yinxiang.com/shard/s65/nl/2147483647/8e6041d0-0d64-4416-af62-6e0009025806/ang.com/shard/s65/nl/2147483647/8e6041d0-0d64-4416-af62-6e0009025806/


@interface AppDelegate ()<WXApiDelegate>




@property (nonatomic, strong)TabbarController * tabbarController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //配置服务器信息
    YTKNetworkConfig * config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = BASEURL;
    config.cdnUrl = BASEURL;
    
    /*-----------------------全局设置返回按钮-------------------------*/
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setBackButtonTitlePositionAdjustment:UIOffsetMake(1000, -60) forBarMetrics:UIBarMetricsDefault];
    UIImage *backButtonImage = [[UIImage imageNamed:@"leftop_r"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[UINavigationBar appearance] setBackIndicatorImage:backButtonImage];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:backButtonImage];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];

    
    
    //百度地图
//    _mapManager = [[BMKMapManager alloc] init];
//    BOOL ret = [_mapManager start:APPKEY generalDelegate:nil];
//    if (!ret) {
//        NSLog(@"启动失败");
//    }
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES
                                                forKey:@"firstLaunch"];
        NSArray * array = @[@"Guide_01",@"Guide_02",@"Guide_03"];
        GuideVController * guideVC = [[GuideVController alloc]
                                      init];
        self.window.rootViewController = guideVC;
        [guideVC initGuideWithArray:array];
        [guideVC.enter_btn addTarget:self
                              action:@selector(firstPressed)
                    forControlEvents:UIControlEventTouchUpInside];
    }else {
        self.tabbarController = [[TabbarController alloc]
                                 init];
        self.window.rootViewController = self.tabbarController;

    }
    //友盟统计
    NSString * version = [[[NSBundle mainBundle] infoDictionary]
                          objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    [MobClick startWithAppkey:UMAppkey
                 reportPolicy:BATCH
                    channelId: nil];
    
    //友盟分享
    [UMSocialData setAppKey:UMAppkey];
  //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:WXAPPID
                         appSecret:WXAPPSECRET
                               url:@"http://www.umeng.com/social"];
   //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"

    [UMSocialQQHandler setQQWithAppId:QAPPID appKey:QAPPKEY url:@"http://www.umeng.com/social"];

   //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"

    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:SinaAPPID
                                              secret:SinaAPPSECRET
                                         RedirectURL:@"http://www.5199yl.com"];
    
    //友盟推送
    /*------------------------友盟推送----------------------------*/
    [UMessage startWithAppkey:UMAppkey
                launchOptions:launchOptions];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //register remoteNotification types
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc]
                                                    init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc]
                                                    init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc]
                                                        init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2]
                   forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } 
#else
    
    //register remoteNotification types
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    
    //for log
    [UMessage setLogEnabled:NO];
    //注册微信
    [WXApi registerApp:WXAPPID withDescription:@"weixin"];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    if ([[user valueForKey:@"username"] length] != 0 && [[user valueForKey:@"password"] length] != 0) {
        [self defaultLoginWithUserName:[user valueForKey:@"username"] password:[user valueForKey:@"password"]];

    }

    return YES;
}
-(void)defaultLoginWithUserName:(NSString *)username password:(NSString *)pwd {
    
    DDLogin * loginApi = [[DDLogin alloc] initWithUsername:username password:pwd];
    __block NSDictionary * dic;
    
    [loginApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSString *str = [request.responseString stringByReplacingOccurrencesOfString:@":null" withString:@":\"\""];
        dic = [DDLogin dictionaryWithJsonString: str];
        if ([dic[@"error_code"] intValue] == 0) {
            [Member DefaultUser].uid = dic[@"uid"];
            [Member DefaultUser].nickname = dic[@"nickname"];
            [Member DefaultUser].sex = dic[@"gender"];
            [Member DefaultUser].birthday = dic[@"birthday"];
            [Member DefaultUser].email = dic[@"email"];
            [Member DefaultUser].phone = dic[@"phone"];
            [Member DefaultUser].avatar = dic[@"avatar"];
            [Member DefaultUser].now_money = dic[@"now_money"];
            [Member DefaultUser].score_count = dic[@"score_count"];
            [Member DefaultUser].login = @"online";
            [Member DefaultUser].pay_can = dic[@"pay_can"];
        }else{
            [Member DefaultUser].login = @"";

        }
            } failure:^(__kindof YTKBaseRequest *request) {
                [Member DefaultUser].login = @"";
    }];
}
- (void)firstPressed
{
    self.tabbarController = [[TabbarController alloc] init];
    self.window.rootViewController = self.tabbarController;

}

- (void)application:(UIApplication *)application
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 保存友盟推送的设备token
    NSString *UMDeviceToken  = [[[[deviceToken description]
                                  stringByReplacingOccurrencesOfString: @"<" withString: @""] stringByReplacingOccurrencesOfString: @">" withString: @""]                 stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:UMDeviceToken forKey:UMDEVICETOKEN];
    [userDefaults synchronize];
    
    [UMessage registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application
    didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //关闭友盟对话框
    [UMessage setAutoAlert:NO];
    //此方法不要删除
    [UMessage didReceiveRemoteNotification:userInfo];
    NSLog(@"%@",userInfo);
    
    
    // 定制自定的的弹出框
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                            message:userInfo[@"aps"][@"alert"]
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
        [[alertView rac_buttonClickedSignal] subscribeNext:^(id x) {
            [UMessage sendClickReportForRemoteNotification:userInfo];
        }];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //已经进入后台
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    //即将进入前台
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [UMSocialSnsService  applicationDidBecomeActive];
}
-(BOOL)application:(UIApplication *)application
     handleOpenURL:(NSURL *)url {
    
    return  [WXApi handleOpenURL:url delegate:self];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)application
           openURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
            annotation:(id)annotation
{
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        
        [[AlipaySDK defaultService] processAuthResult:url
                                      standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"result = %@",resultDic);
        }];
        return YES;
    }else{
        if ([url.host isEqualToString:@"pay"]){
            [WXApi handleOpenURL:url delegate:self];
        }
        return YES;
        if ([UMSocialSnsService handleOpenURL:url]) {
            return [UMSocialSnsService handleOpenURL:url wxApiDelegate:self];
        }else{
            return [WXApi handleOpenURL:url delegate:self];
        }
    }
    return YES;
}
#pragma mark - 微信支付代理方法
-(void) onResp:(BaseResp*)resp {
    NSString *strTitle = nil;
    NSString *strMsg = nil;
    
    if([resp isKindOfClass:[PayResp class]]){
        
        if (resp.errCode == WXSuccess) {
            //支付返回结果，实际支付结果需要去微信服务器端查询
            NSString *result = nil;
            NSString *hintInfo = nil;
            result = @"Pay for results";
            hintInfo = @"Pay result: success!";
            
            strTitle = result;
            strMsg = hintInfo;
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:strTitle
                                  message:strMsg delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil, nil];
            [alert show];
        }else {
            NSLog(@"%d",resp.errCode);
        }
    }
}

@end
