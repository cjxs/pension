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
#import "CDDatePicker.h"
#import "PayWayTVC.h"
#import "OrderStatusTVController.h"
#import "YYLUser.h"
#import "Order_ed.h"
#import "DDUpdatePay.h"
#import "OrderSuccessController.h"



@interface PayViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    int pay_way;


}

@end

@implementation PayViewController
-(UITableView *)tableView
{
    if (!_tableView)
    {
        UITableView * tableView = [[UITableView alloc]
                                   initWithFrame:CGRectMake(0, 0, screenWide, screenHeight*0.5)
                                   style:UITableViewStylePlain];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.tableFooterView = [UIView new];
        _tableView = tableView;
        
    }
    return _tableView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = RGB(205, 8, 20);
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.tabBarController.tabBar.translucent = NO;//不透明 0 开始的位置
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    pay_way = 0;

    [Member DefaultUser].pay_id = _order_id;

    [self.navigationItem setTitle:@"支付中心"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    UIButton * back_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [back_btn addTarget:self action:@selector(backBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    back_btn.frame = CGRectMake(0, 0, 10, 18);
    [back_btn setBackgroundImage:[UIImage imageNamed:@"leftop_w"] forState:UIControlStateNormal];
    UIBarButtonItem * back_item = [[UIBarButtonItem alloc] initWithCustomView:back_btn];
    self.navigationItem.leftBarButtonItem = back_item;
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate =self;
    [self.tableView registerClass:[PayWayTVC class] forCellReuseIdentifier:@"cellway"];
    
    [self creatBackFootView];

}
-(void)backBtnPressed{
    if ([_vc_type isEqualToString:@"unnormal"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        OrderStatusTVController * order_status_VC = [[OrderStatusTVController alloc] init];
        order_status_VC.vc_type = @"unnormal";
        order_status_VC.o_id = _order_id;
        [self.navigationController pushViewController:order_status_VC animated:YES];
    }


}

-(void)creatBackFootView{
    UIButton * toPay_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    toPay_btn.frame = CGRectMake(screenWide * 0.075, screenHeight * 0.5, screenWide * 0.85, screenHeight * 0.07);
    toPay_btn.layer.masksToBounds = YES;
    toPay_btn.layer.cornerRadius = 10;
    toPay_btn.backgroundColor = RGB(226, 11, 24);
    NSString * title_str;
    if ([_vc_type isEqualToString:@"unnormal"]) {
        title_str = [NSString stringWithFormat:@"去支付：¥ %.2lf",[_order_ed.payment_money floatValue]];
    }else{
        title_str = [NSString stringWithFormat:@"去支付：¥ %.2lf",[_order.payment_money floatValue]];
    }
    [toPay_btn setTitle:title_str
               forState:UIControlStateNormal];
    [toPay_btn addTarget:self
                  action:@selector(payToThird)
        forControlEvents:UIControlEventTouchUpInside];
    [toPay_btn setTitleColor:[UIColor whiteColor]
                    forState:UIControlStateNormal];
    [self.view addSubview:toPay_btn];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayWayTVC * cell_way;
    int b = indexPath.row;
    BOOL pay_can = NO;

    cell_way = [tableView dequeueReusableCellWithIdentifier:@"cellway" forIndexPath:indexPath];
    switch (b) {
        case 0:
            pay_can = pay_way==b?YES:NO;
            [cell_way configWithimageName:@"choose_44_" title:@"微信支付" aliPay:pay_can];
            break;
        case 1:
            pay_can = pay_way==b?YES:NO;
            [cell_way configWithimageName:@"ali_btn" title:@"支付宝支付" aliPay:pay_can];
            break;
        case 2:
            pay_can = pay_way==b?YES:NO;
            [cell_way configWithimageName:@"under_line" title:@"线下支付" aliPay:pay_can];
            break;
        default:
            break;

    }
    cell_way.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell_way;
    
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"选择支付方式";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    pay_way = indexPath.row;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
    [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PAY
- (void)payToThird{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        if ([_vc_type isEqualToString:@"unnormal"]) {
            [dic setValue:_order_ed.order_sn forKey:@"order_sn"];
            [dic setValue:_order_ed.order_name forKey:@"order_name"];
            [dic setValue:_order_ed.payment_money forKey:@"payment_money"];
        }else{
            [dic setValue:_order.order_sn forKey:@"order_sn"];
            [dic setValue:_order.order_name forKey:@"order_name"];
            [dic setValue:_order.payment_money forKey:@"payment_money"];
        }
    
    if (pay_way==0){
        WXApiRequestHandler *wxapi = [[WXApiRequestHandler  alloc] init];
        [wxapi httpService:dic];
    }else if (pay_way==1) {
        [self payToAlipay];
    }else{
        [self under_linePayWithdic:dic];
    }
    
}
-(void)under_linePayWithdic:(NSDictionary *)dictionary{
    
    Member * menber = [Member DefaultUser];
    DDUpdatePay * pay_update = [[DDUpdatePay alloc] initWithUid:menber.uid login:menber.login type:@"线下支付"];
    
    [pay_update startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
        if ([dic[@"error_code"] intValue] == 6) {
            [SVProgressHUD showSuccessWithStatus:@"恭喜您，订单预订成功！"];
            OrderSuccessController * order_SVC = [[OrderSuccessController alloc] init];
            order_SVC.order_sn = dictionary[@"order_sn"];
            order_SVC.money = dictionary[@"payment_money"];
            [self.navigationController pushViewController:order_SVC animated:YES];
            
        }else{
            [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD showSuccessWithStatus:@"网络错误"];
        
    }];

    
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
    order.partner = partner; // 合作商号
    order.seller = seller; // 支付宝账号
    if ([_vc_type isEqualToString:@"unnormal"]) {
        order.tradeNO =  _order_ed.order_sn; //订单ID（由商家自行制定）
        order.productName = [NSString stringWithFormat:@"优悠乐--%@",_order_ed.order_name];//product.subject; //商品标题
        order.productDescription = [NSString stringWithFormat:@"优悠乐--%@",_order_ed.order_name];//product.body; //商品描述
        order.amount = [NSString stringWithFormat:@"%.2lf",[_order_ed.payment_money floatValue]]; //商品价格
    }else{
        order.tradeNO =  _order.order_sn; //订单ID（由商家自行制定）
        order.productName = [NSString stringWithFormat:@"优悠乐--%@",_order.order_name];//product.subject; //商品标题
        order.productDescription = [NSString stringWithFormat:@"优悠乐--%@",_order.order_name];//product.body; //商品描述
        order.amount = [NSString stringWithFormat:@"%.2lf",[_order.payment_money floatValue]]; //商品价格

    }
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";// 使用的编码格式
    order.itBPay = @"30m";//允许的最晚付款时间
    order.showUrl = @"m.alipay.com";
    //应用注册scheme,在Info.plist定义URL types
    NSString *appScheme = @"yyl123";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    //NSLog(@"%@",orderSpec);

    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(AliPRIKEY);
    NSString *signedString = [signer signString:orderSpec];
    
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil)
    {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            if ([resultDic[@"resultStatus"] intValue] == 9000) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    Member * menber = [Member DefaultUser];
                    
                    DDUpdatePay * pay_update = [[DDUpdatePay alloc] initWithUid:menber.uid login:menber.login type:@"wx"];
                    
                    [pay_update startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
                        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
                        
                        if ([dic[@"error_code"] intValue] == 6) {
                            [SVProgressHUD showSuccessWithStatus:@"恭喜您，支付成功！"];
                        }else{
                            [SVProgressHUD showSuccessWithStatus:@"付款成功，稍后在订单中查询结果！"];
                        }
                    } failure:^(__kindof YTKBaseRequest *request) {
                        [SVProgressHUD showSuccessWithStatus:@"网络错误，请稍后在订单中查询！"];
                        
                    }];
                    
                    [self backBtnPressed];
                });


            }else if ([resultDic[@"resultStatus"] intValue] == 6001) {
                [SVProgressHUD showErrorWithStatus:@"用户取消支付"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"支付失败!"];
            }


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
