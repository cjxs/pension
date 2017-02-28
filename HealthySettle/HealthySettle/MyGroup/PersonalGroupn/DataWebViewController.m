//
//  DataWebViewController.m
//  HealthySettle
//
//  Created by yrc on 17/2/27.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "DataWebViewController.h"

@interface DataWebViewController ()<UIWebViewDelegate>

@end

@implementation DataWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    
    // Do any additional setup after loading the view.
    UIWebView * web_view = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/phone#/upgrade",BASEURL]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.view addSubview:web_view];
    web_view.delegate = self;

    [web_view loadRequest:request];
    

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.uid = %@;",[Member DefaultUser].uid]];

    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString * str = [[request.URL absoluteString] stringByRemovingPercentEncoding];
    NSArray  * arr = [str componentsSeparatedByString:@"/phone#/"];
    if ([arr[1] isEqualToString:@"personal"]) {
        [self.navigationController popViewControllerAnimated:YES];

        return NO;
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
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
