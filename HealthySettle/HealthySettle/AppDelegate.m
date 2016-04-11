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
#import <iVersion.h>
@interface AppDelegate ()
@property (nonatomic, strong)TabbarController * tabbarController;
@end

@implementation AppDelegate
+ (void)initialize{
    
  //  [iVersion sharedInstance].applicationBundleID = @"com.beik.zhuanla";
//    [iVersion sharedInstance].appStoreID = 939985150;
    [iVersion sharedInstance].downloadButtonLabel = @"更新";
    [iVersion sharedInstance].remindButtonLabel = @"以后提醒";
    [iVersion sharedInstance].ignoreButtonLabel = @"忽略";
    [iVersion sharedInstance].updateAvailableTitle = @"有新版本";
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

//    [NSThread sleepForTimeInterval:1.5f];
    // Override point for customization after application launch.
    //配置服务器信息
    YTKNetworkConfig * config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = @"http://api.meilijia.com/";
    config.cdnUrl = @"www.zhihu.com/";
    
    //百度地图
//    _mapManager = [[BMKMapManager alloc] init];
//    BOOL ret = [_mapManager start:APPKEY generalDelegate:nil];
//    if (!ret) {
//        NSLog(@"启动失败");
//    }
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSArray * array = @[@"Guide_01",@"Guide_02",@"Guide_03"];
        GuideVController * guideVC = [[GuideVController alloc] init];
        self.window.rootViewController = guideVC;
        [guideVC initGuideWithArray:array];
        [guideVC.enter_btn addTarget:self action:@selector(firstPressed) forControlEvents:UIControlEventTouchUpInside];
    }else {
        self.tabbarController = [[TabbarController alloc] init];
        self.window.rootViewController = self.tabbarController;

    }
    
    return YES;
}
- (void)firstPressed {
    self.tabbarController = [[TabbarController alloc] init];
    self.window.rootViewController = self.tabbarController;

}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
