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
-(UIView *)backgroundView {
    if (!_backgroundView) {
        UIView * view = [[UIView alloc] init];
        view.frame = self.frame;
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tap.numberOfTapsRequired = 1;
        [view addGestureRecognizer:tap];
        _backgroundView = view;
    }
    
    return _backgroundView;
}
-(UIView *)white_view {
    if (!_white_view) {
        UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight, screenWide, screenHeight * 0.45)];
        view2.backgroundColor = [UIColor whiteColor];
        _white_view = view2;
    }
    return _white_view;
}
-(NSMutableArray *)some_btns {
    if (!_some_btns) {
        NSMutableArray * some_btns = [NSMutableArray arrayWithCapacity:0];
        NSArray * images_array = @[@"choose_44_@2x",@"choose_46_",@"choose_48_",@"choose_72_",@"choose_74_",@"choose_76_"];
        NSArray * name_array = @[@"微信",@"微信朋友圈",@"短信",@"Qzone",@"腾讯QQ",@"新浪微博"];
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 3; j++) {
                static int k = 0;
                if (k == 6) {
                    k = 0;
                }

                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake((screenWide/3 -50)/2 + screenWide/3 * j , screenHeight * 0.105 + 90 * i, 50, 50);
                [btn setImage:[UIImage imageNamed:images_array[k]] forState:UIControlStateNormal];
                btn.clipsToBounds = YES;
                btn.layer.cornerRadius = 25;
                [self.white_view addSubview:btn];
                
                UILabel * label = [[UILabel alloc] init];
                label.frame = CGRectMake((screenWide/3 -70)/2 + screenWide/3 * j , screenHeight * 0.105 +50 + 90 * i, 70, 25);
                label.text = name_array[k];
                label.font = [UIFont systemFontOfSize:12];
                label.textAlignment = NSTextAlignmentCenter;
                [self.white_view addSubview:label];
               
                k++;
                
                [some_btns addObject:btn];
                
            }
        }
        _some_btns = some_btns;

    }
    return _some_btns;
}

+ (ShareView *)showShareViewInViewController:(UIViewController *)viewController {
    
        ShareView *shareView = [[ShareView alloc] init];
        shareView.frame = [UIScreen mainScreen].bounds;
        shareView.sourceViewController = viewController;
    
        [shareView initView];
        [[UIApplication sharedApplication].keyWindow addSubview:shareView];
    
        [UIView animateWithDuration:0.5f animations:^{
        shareView.white_view.frame = CGRectMake(0, screenHeight * 0.55, screenWide, screenHeight * 0.45);
    }];
    return shareView;
    
}

- (void)initView {
    [self performBackgroundView];
    [self configButtons];
}
- (void)performBackgroundView {
    [self addSubview:self.backgroundView];

    [self addSubview:self.white_view];
    UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide/3, 5, screenWide/3, 30)];
    title_label.text = @"分享到";
    title_label.font = [UIFont systemFontOfSize:15];
    title_label.textColor = RGB(156, 156, 156);
    title_label.textAlignment = NSTextAlignmentCenter;
    [self.white_view addSubview:title_label];
    UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(0, 39, screenWide, 1)];
    line_view.backgroundColor = RGB(232, 232, 232);
    [self.white_view addSubview:line_view];

}

- (void)configButtons {
    NSMutableArray *buttonSignals = [NSMutableArray array];

    [self.some_btns enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop){
        button.tag = idx;
        [buttonSignals addObject:[button rac_signalForControlEvents:UIControlEventTouchUpInside]];
        
    }];
    
    NSArray *platformArray = @[UMShareToWechatSession, UMShareToWechatTimeline,UMShareToSms , UMShareToQzone,UMShareToQQ,  UMShareToSina];
    @weakify(self);
    [[[RACSignal merge:[buttonSignals copy]] flattenMap:^RACStream *(UIButton *button) {
        return [RACSignal return:@(button.tag)];
    }] subscribeNext:^(NSNumber *index) {
        @strongify(self);
        NSString *snsName = platformArray[index.integerValue];
        
        NSString *url = @"http:www.5199yl.com";
        NSString * shareText = @"优游乐苹果端产品正式上线了，快来看看吧！";
        
        [UMSocialConfig setFinishToastIsHidden:NO position:UMSocialiToastPositionTop];
        
        UMSocialData *data = [[UMSocialData alloc] initWithIdentifier:@"Invite"];
        UMSocialExtConfig *config = [[UMSocialExtConfig alloc]init];
        data.extConfig = config;
        
        /*----------微信会话微信朋友圈------------*/
        if ([snsName isEqualToString:UMShareToWechatTimeline]) {
            UMSocialWechatTimelineData *timelineData = [[UMSocialWechatTimelineData alloc] init];
            timelineData.url = url;
            timelineData.shareText = @"老大， 我这边分享功能做完了，你看看！";
            timelineData.shareImage = [UIImage imageNamed:@"p_02"];
            config.wechatTimelineData = timelineData;
        }
        /*----------微信会话------------*/
        else if ([snsName isEqualToString:UMShareToWechatSession]){
            UMSocialWechatSessionData *sessionData = [[UMSocialWechatSessionData alloc] init];
            sessionData.url = url;
            sessionData.title = @"看看！看看！";
            sessionData.shareText = @"老大， 我这边分享功能做完了，你看看！";
            sessionData.shareImage = [UIImage imageNamed:@"p_02"];
            config.wechatSessionData = sessionData;
        }
        /*----------QQ会话------------*/
        else if ([snsName isEqualToString:UMShareToQQ]){
            UMSocialQQData *qqData = [[UMSocialQQData alloc] init];
            qqData.url = url;
            qqData.title = @"看看！看看！";
            qqData.shareImage = [UIImage imageNamed:@"p_02"];
            config.qqData = qqData;
        }
        /*----------QQ空间------------*/
        else if ([snsName isEqualToString:UMShareToQzone]){
            UMSocialQzoneData *qzoneData = [[UMSocialQzoneData alloc] init];
            qzoneData.url = url;
            qzoneData.title = @"看看！看看！";
            qzoneData.shareText = shareText;
            qzoneData.shareImage = [UIImage imageNamed:@"p_02"];
            config.qzoneData = qzoneData;
        }
        /*----------新浪微博------------*/
        else if ([snsName isEqualToString:UMShareToSina]){
            UMSocialSinaData *sinaData = [[UMSocialSinaData alloc] init];
            sinaData.shareImage = [UIImage imageNamed:@"p_02"];
            config.sinaData = sinaData;
        }
        else if ([snsName isEqualToString:UMShareToSms]){
            UMSocialSmsData *smsData = [[UMSocialSmsData alloc] init];
            smsData.shareText = [shareText stringByAppendingString:url];
            smsData.shareImage = nil;
            config.smsData = smsData;
        }
        
        //!!!: 新浪微博在未授权的情况下先授权再设置分享
        if ([index integerValue] == 5 && ![UMSocialAccountManager isOauthAndTokenNotExpired:UMShareToSina]) {
            
            [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].loginClickHandler(self.sourceViewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                //!!!: 授权成功后弹出分享界面
                if (response.responseCode == UMSResponseCodeSuccess) {
                    
                    [[UMSocialControllerService defaultControllerService] setSocialData:data];
                    [[UMSocialControllerService defaultControllerService] setShareText:shareText shareImage:[snsName isEqualToString:UMShareToSms] ?  nil : [UIImage imageNamed:@"icon"] socialUIDelegate:self.sourceViewController];
                    
                    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
                    snsPlatform.snsClickHandler(self.sourceViewController,[UMSocialControllerService defaultControllerService],YES);
                }
            });
        }
        else{
            [[UMSocialControllerService defaultControllerService] setSocialData:data];
            
            [[UMSocialControllerService defaultControllerService] setShareText:shareText shareImage:[snsName isEqualToString:UMShareToSms] ?  nil : [UIImage imageNamed:@"icon"] socialUIDelegate:self.sourceViewController];
            
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
            
            snsPlatform.snsClickHandler(self.sourceViewController,[UMSocialControllerService defaultControllerService],YES);
        }
        
        [self dismiss];
    }];

}
- (void)dismiss {
    [UIView animateWithDuration:0.3f animations:^{
        self.white_view.frame = CGRectMake(0, screenHeight , screenWide, screenHeight * 0.45);
    }];
     [self performSelector:@selector(remove) withObject:nil afterDelay:0.3f];

}
- (void)remove {
        for (UIView * view  in self.white_view.subviews) {
            [view removeFromSuperview];
        }
        [self removeFromSuperview];
}
@end
