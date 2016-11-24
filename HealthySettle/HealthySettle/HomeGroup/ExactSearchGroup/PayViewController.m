//
//  PayViewController.m
//  HealthySettle
//
//  Created by yrc on 16/11/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "PayViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApiRequestHandler.h"
#import "Order.h"
#import "DataSigner.h"



@interface PayViewController ()
{
    UIView * view_pay;

}

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"支付中心"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - PAY
- (void)payToEveryOne
{
    view_pay = [[UIView alloc] init];
    view_pay.backgroundColor = [UIColor grayColor];
    view_pay.frame = CGRectMake(0, screenHeight, screenWide, screenHeight * 0.4);
    UIButton * ali_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    ali_btn.frame = CGRectMake(50, screenHeight * 0.1, (screenWide-100)/3, 50);
    [ali_btn addTarget:self
                action:@selector(payToNext:)
      forControlEvents:UIControlEventTouchUpInside];
    ali_btn.clipsToBounds = YES;
    [ali_btn setTitle:@"支付宝"
             forState:UIControlStateNormal];
    ali_btn.layer.cornerRadius = 10;
    [view_pay addSubview:ali_btn];
    UIButton * wx_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    wx_btn.frame = CGRectMake(50 + (screenWide-100)/3*2, screenHeight * 0.1, (screenWide-100)/3, 50);
    [wx_btn addTarget:self
               action:@selector(payToNext:)
     forControlEvents:UIControlEventTouchUpInside];
    [wx_btn setTitle:@"微信"
            forState:UIControlStateNormal];
    wx_btn.clipsToBounds = YES;
    wx_btn.layer.cornerRadius = 10;
    [view_pay addSubview:wx_btn];
    [self.view addSubview:view_pay];
    
    [UIView animateWithDuration:0.35 delay:0.5 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        view_pay.frame = CGRectMake(0, screenHeight * 0.6, screenWide, screenHeight * 0.4);
    } completion:^(BOOL finished) {
        
    }];

    
}
- (void)payViewdimiss
{
    [UIView animateWithDuration:0.3f animations:^
     {
         view_pay.frame = CGRectMake(0, screenHeight, screenWide, screenHeight * 0.4);
     }];
    [view_pay removeFromSuperview];
    [self performSelector:@selector(remove)
               withObject:nil
               afterDelay:0.3f];
}
- (void)remove {
    for (UIButton * btn  in view_pay.subviews)
    {
        [btn removeFromSuperview];
    }
    [view_pay removeFromSuperview];
}
- (void)payToNext:(UIButton *)btn
{
    if (btn.frame.origin.x < screenWide/2)
    {
        [self payToAlipay];
    }else
    {
        WXApiRequestHandler *wxapi = [[WXApiRequestHandler  alloc] init];
        [wxapi httpService:nil];
    }
    [self payViewdimiss];
}
-(void)payToAlipay
{
    /*=======================需要填写商户app申请的===================================*/
    NSString *partner = AliPID;
    NSString *seller = AliMID;
    NSString *privateKey = AliPRIKEY;
    /*============================================================================*/
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = @"好的设计开发";//product.subject; //商品标题
    order.productDescription = @"四大皆空会收到后给的反馈";//product.body; //商品描述
    order.amount = @"0.01";//[NSString stringWithFormat:@"%f",product.price]; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(AliPRIKEY);
    NSString *signedString = [signer signString:orderSpec];
    NSLog(@"\n%@\n",signedString);
    
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil)
    {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString
                                  fromScheme:appScheme
                                    callback:^(NSDictionary *resultDic)
         {
             NSLog(@"reslut = %@",resultDic);
         }];
    }
    
}

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
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
