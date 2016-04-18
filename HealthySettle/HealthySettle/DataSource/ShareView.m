//
//  ShareView.m
//  HealthySettle
//
//  Created by yrc on 16/4/18.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "ShareView.h"
#import "UMSocial.h"

@implementation ShareView
-(instancetype)init {
    self = [super init];
    if (self ) {
        self.frame = [UIScreen mainScreen].bounds;
        UIView * view = [[UIView alloc] init];
        view.frame = self.frame;
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5;
        [self addSubview:view];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tap.numberOfTapsRequired = 1;
        [view addGestureRecognizer:tap];
        for (int i = 0; i < 3; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(screenWide/3 * i, 500, screenWide/3, 167);
            switch (i) {
                case 0:
                    btn.backgroundColor = [UIColor redColor];
                    break;
                case 1:
                    btn.backgroundColor = [UIColor greenColor];
                    break;
                default:
                    btn.backgroundColor = [UIColor blueColor];
                    break;
            }
            [btn addTarget:self action:@selector(shareSomeThingsBegin) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];

        }
           }
    return self;
}
- (void)shareSomeThingsBegin {
    
    UMSocialData *data = [[UMSocialData alloc] initWithIdentifier:@"Invite"];
    UMSocialExtConfig *config = [[UMSocialExtConfig alloc]init];
    data.extConfig = config;
//
//    //微信朋友
//    UMSocialWechatSessionData * sessionData = [[UMSocialWechatSessionData alloc] init];
//    sessionData.url = @"http://www.baidu.com";
////    sessionData.title = @"看看";
//    sessionData.shareText = @"说到减肥哈时间段发回事";
//    [UMSocialData defaultData].extConfig.wechatSessionData = sessionData;
//    
//    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:nil image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            NSLog(@"分享成功！");
//        }
//    }];
    
    //朋友圈
    UMSocialWechatTimelineData *timelineData = [[UMSocialWechatTimelineData alloc] init];
    timelineData.url = @"http://www.baidu.com";
    timelineData.title = @"....";
    timelineData.shareImage = [UIImage imageNamed:@"right_02"];
    
    [UMSocialData defaultData].extConfig.wechatTimelineData = timelineData;
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:nil image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }else {
            NSLog(@"+++++-----");
        }
    }];
    
    //qq
    
//    UMSocialQQData *qqData = [[UMSocialQQData alloc] init];
//    qqData.url = @"http://www.baidu.com";
//    qqData.title = @"看看！看看！";
//    qqData.shareText = @"dsghfasghjdfaghjfaeg";
//    qqData.shareImage = [UIImage imageNamed:@"right_02"];
//    config.qqData = qqData;
//    
//   [UMSocialData defaultData].extConfig.qqData = config.qqData;
//    
//    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:nil image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
//                if (response.responseCode == UMSResponseCodeSuccess) {
//                    NSLog(@"分享成功！");
//                }else {
//                    NSLog(@"+++++-----");
//                }
//            }];
    
    //qqZone
    
//    UMSocialQzoneData *qzoneData = [[UMSocialQzoneData alloc] init];
//    qzoneData.url = @"http://www.baidu.com";
//    qzoneData.title = @"看看！看看！";
//    qzoneData.shareText = @"dhfjasasfhasfajadshgfjhsdjf";
//    qzoneData.shareImage = [UIImage imageNamed:@"icon"];
//    config.qzoneData = qzoneData;
//    
//    [UMSocialData defaultData].extConfig.qzoneData = config.qzoneData;
//    
//    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:nil image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
//                    if (response.responseCode == UMSResponseCodeSuccess) {
//                        NSLog(@"分享成功！");
//                    }else {
//                        NSLog(@"+++++-----");
//                    }
//                }];

   //xinlang
    
//    UMSocialSinaData *sinaData = [[UMSocialSinaData alloc] init];
//    sinaData.shareImage = [UIImage imageNamed:@"icon"];
//    sinaData.shareText = @"dsfhgdfdfgds";
//    config.sinaData = sinaData;
//    
//    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:nil image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            NSLog(@"分享成功！");
//        }else {
//            NSLog(@"+++++-----");
//        }
//    }];

    //sms
    
//    UMSocialSmsData *smsData = [[UMSocialSmsData alloc] init];
//    smsData.shareText = @"dsahgfadsjhgf asdgfhasfasdjd";
//    smsData.shareImage = nil;
//    config.smsData = smsData;
//    [UMSocialData defaultData].extConfig.smsData = smsData;
//    
//        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSms] content:nil image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
//            if (response.responseCode == UMSResponseCodeSuccess) {
//                NSLog(@"分享成功！");
//            }else {
//                NSLog(@"+++++-----");
//            }
//        }];
    
//    [[UMSocialDataService defaultDataService] postSNSWithTypes:<#(NSArray *)#> content:<#(NSString *)#> image:<#(id)#> location:<#(CLLocation *)#> urlResource:<#(UMSocialUrlResource *)#> completion:<#^(UMSocialResponseEntity *response)completion#>]
    
    [self dismiss];
}
- (void)dismiss {
    for (UIView * view  in self.subviews) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}
@end
