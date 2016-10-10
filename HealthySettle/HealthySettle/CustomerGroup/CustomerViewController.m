//
//  CustomerViewController.m
//  HealthySettle
//
//  Created by yrc on 16/3/17.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "CustomerViewController.h"
#import "YTKBatchRequest.h"
#import "DDLogin.h"
@interface CustomerViewController ()<UIWebViewDelegate>
@end
@implementation CustomerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"客服";
   
//    NSArray * dataArray = @[@"custom_online",@"custom_number"];
//    for (int i = 0; i< dataArray.count; i++)
//    {
//        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(1, screenHeight * 0.338 *i + 65, screenWide, screenHeight * 0.333);
//        [button setBackgroundImage:[UIImage imageNamed:dataArray[i]] forState:UIControlStateNormal];
//        button.tag = 200 + i;
//        button.highlighted = NO;
//        [button addTarget:self action:@selector(callCostomerWithBtn:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:button];
//    }
//    DDGet *test = [[DDGet alloc] init];
//    [test startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
//        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
//
//        NSLog(@"sucess:%@",dic);
//        
//    } failure:^(__kindof YTKBaseRequest *request) {
//        NSLog(@"error: %@",request);
//    }];
}
- (void)callCostomerWithBtn:(UIButton *)button {
    if (button.tag == 200) {
        
        if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
        {
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
            NSURL *url = [NSURL URLWithString:@"mqq://im/chat?chat_type=wpa&uin=123456&version=1&src_type=web"];//uin=123456为你要跳转的QQ号码
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            webView.delegate = self;
            [webView loadRequest:request];
            [self.view addSubview:webView];                                                                                                                                                                                                      
        }
    }else {
        NSLog(@"+++++++++");
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4006405199"];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
        
//        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"186xxxx6979"];
//        //            NSLog(@"str======%@",str);
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];


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
