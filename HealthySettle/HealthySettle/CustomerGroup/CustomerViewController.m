//
//  CustomerViewController.m
//  HealthySettle
//
//  Created by yrc on 16/3/17.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "CustomerViewController.h"
#import "YTKBatchRequest.h"
#import "DDFindGet.h"
#import "DDGetCity.h"
@interface CustomerViewController ()<UIWebViewDelegate,UIGestureRecognizerDelegate>
@end
@implementation CustomerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"客服";
   
    NSArray * dataArray = @[@"custom_online",@"custom_number"];
    for (int i = 0; i< dataArray.count; i++)
    {
        UIImageView * image_view = [[UIImageView alloc] initWithFrame:CGRectMake(1, screenHeight * 0.338 *i  + 65, screenWide, screenHeight * 0.333)];
        image_view.userInteractionEnabled = YES;
        image_view.image = [UIImage imageNamed:dataArray[i]];
        image_view.tag = 200 +i;
        UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callCostomerWithimage:)];
        tap1.numberOfTouchesRequired = 1;
        tap1.delegate = self;
        [image_view addGestureRecognizer:tap1];
        [self.view addSubview:image_view];
    }
//    DDGetCity * getcity = [[DDGetCity alloc] init];
//    [getcity startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
//        NSArray * arr = [DDLogin arrayWithJsonString:request.responseString];
//        if (arr) {
//            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//            NSString *path=[paths  objectAtIndex:0];
//            NSLog(@"path = %@",path);
//            NSString *filename=[path stringByAppendingPathComponent:@"city_01.plist"];
//            NSFileManager* fm = [NSFileManager defaultManager];
//            [fm createFileAtPath:filename contents:nil attributes:nil];
//            [arr writeToFile:filename atomically:YES];
//            NSLog(@"已经全部写入%@",filename);
//        }
//    } failure:^(__kindof YTKBaseRequest *request) {
//        
//    }];

}
- (void)callCostomerWithimage:(UITapGestureRecognizer *)gesture{
    if (gesture.view.tag == 200) {
        
        if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
        {
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
            NSURL *url = [NSURL URLWithString:@"mqq://im/chat?chat_type=wpa&uin=3395209105&version=1&src_type=web"];//uin=123456为你要跳转的QQ号码
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            webView.delegate = self;
            [webView loadRequest:request];
            [self.view addSubview:webView];                                                                                                                                                                                                      
        }
    }else {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4006405199"];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
        


    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
