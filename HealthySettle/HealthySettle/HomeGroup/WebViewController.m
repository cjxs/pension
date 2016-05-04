//
//  WebController.m
//  HealthySettle
//
//  Created by yrc on 16/3/29.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "WebViewController.h"
#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>
@interface WebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
{
    UIButton * btn;
    UIImageView * image_view;
}
@property (nonatomic, strong)UIWebView * webView;
@property (nonatomic, strong) NJKWebViewProgress *progressProxy;
@property (nonatomic, strong) NJKWebViewProgressView *progressView;
@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.progressProxy = [[NJKWebViewProgress alloc] init]; // instance variable
    self.webView =  [[UIWebView alloc]
                     initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    self.webView.delegate = _progressProxy;
    self.progressProxy.webViewProxyDelegate = self;
    self.progressProxy.progressDelegate = self;
    CGFloat progressBarHeight = 3.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, 20, navigaitonBarBounds.size.width, progressBarHeight);
    self.progressView = [[NJKWebViewProgressView alloc]
                         initWithFrame:barFrame];
    self.progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        NSURLRequest * request = [NSURLRequest requestWithURL:_urlLoad];
    [_webView loadRequest:request];
    image_view = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin * 1,screenHeight * 0.01, kMargin * 2, kMargin * 2/10*18)];
    image_view.image = [UIImage imageNamed:@"leftop_r"];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kMargin * 1,screenHeight * 0.03, kMargin * 4, kMargin * 4/10*18);
    btn.alpha = 0.4;
    [btn addTarget:self
            action:@selector(backTolastVC)
  forControlEvents:UIControlEventTouchUpInside];
    [btn addSubview:image_view];
    [self.view addSubview:btn];
}
- (void)backTolastVC
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES
                                             animated:YES];
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_webView stopLoading];
    [self.progressView removeFromSuperview];
    [btn removeFromSuperview];
    [self.webView removeFromSuperview];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    self.webView = nil;
    self.webView.delegate = nil;
    self.urlLoad = nil;
    self.progressView = nil;
}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress
        updateProgress:(float)progress
{
    [self.progressView setProgress:progress
                          animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (!_webView)
    {
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[NSURLCache sharedURLCache] setDiskCapacity:0];
        [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    }
}
@end
