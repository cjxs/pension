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
#import "SpecialLabelTVC.h"
#import "OrderLaeblTVCell.h"
#import "PayWayTVC.h"
#import "CashStatusTVC.h"



@interface PayViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UIView * view_pay;
    BOOL ali_pay;
    BOOL cash_use;
    UITextField * current_field;


}

@end

@implementation PayViewController
-(UIView *)tableHeadView
{
    if (!_tableHeadView)
    {
        _tableHeadView = [[UIView alloc]
                          initWithFrame:CGRectMake(0, 0, screenWide, screenHeight *0.203 )];
        _tableHeadView.backgroundColor = RGB(252, 229, 229);
        UIView * backHeadView = [[UIView alloc]
                                 initWithFrame:CGRectMake(8, 8, screenWide - 16, screenHeight * 0.203 - 16)];
        backHeadView.backgroundColor = [UIColor whiteColor];
        backHeadView.layer.masksToBounds = YES;
        backHeadView.layer.cornerRadius = 5;
        [_tableHeadView addSubview:backHeadView];
        UILabel * organ_label = [[UILabel alloc]
                                 initWithFrame:CGRectMake(8,0 , screenWide - 150, 0.05 * screenHeight)];
        YYLOrder * order = [_vc_type isEqualToString:@"2"]? [YYLOrder YSOrder]:[YYLOrder YLOrder];
        
        organ_label.text = order.order_name;
        organ_label.font = [UIFont systemFontOfSize:14];
        [backHeadView addSubview:organ_label];
        UILabel * price_sum_label= [[UILabel alloc] initWithFrame:CGRectMake(screenWide - 124, 0, 100, 0.05 * screenHeight)];
        CGFloat pay_mon = [order.price floatValue] - [order.subsidy_money_u floatValue];
        price_sum_label.text = [NSString stringWithFormat:@"¥%.2lf",pay_mon];
        price_sum_label.font = [UIFont systemFontOfSize:17];
        price_sum_label.textAlignment = NSTextAlignmentRight;
        price_sum_label.textColor = REDCOLOR;
        [backHeadView addSubview:price_sum_label];
        
        UIView * line_view = [[UIView alloc]
                              initWithFrame:CGRectMake(10, screenHeight * 0.05, screenWide -36, 1)];
        line_view.backgroundColor = RGB(190, 190, 190);
        [backHeadView addSubview:line_view];
        NSArray * array = @[@"入住",@"离店"];
        for (int i = 0; i < 2; i ++)
        {
            UILabel * label = [[UILabel alloc]
                               initWithFrame:CGRectMake(8 + screenWide/3 * i, screenHeight * 0.06, screenWide * 0.1, screenHeight *0.04)];
            label.text = array[i];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = RGB(190, 190, 190);
            [backHeadView addSubview:label];
        }
        UILabel * checkIn_timelabel = [[UILabel alloc]
                             initWithFrame:CGRectMake(8 + screenWide * 0.1, screenHeight * 0.06, screenWide /3 - screenWide * 0.1, screenHeight * 0.04)];
        checkIn_timelabel.font = [UIFont systemFontOfSize:10];
        checkIn_timelabel.text = [CDDatePicker getStringFromDate:order.checkin_time];
        [backHeadView addSubview:checkIn_timelabel];
        
        UILabel * leave_timelabel = [[UILabel alloc]
                           initWithFrame:CGRectMake(8+ screenWide *0.1 + screenWide /3, screenHeight * 0.06, screenWide /3 - screenWide * 0.1, screenHeight * 0.04)];
        leave_timelabel.text = [CDDatePicker getStringFromDate:order.checkout_time];

        leave_timelabel.font = [UIFont systemFontOfSize:10];
        [backHeadView addSubview:leave_timelabel];
        
        UILabel *  home_label = [[UILabel alloc]
                      initWithFrame:CGRectMake(8, screenHeight * 0.11, screenWide - 80, screenHeight * 0.04)];
        home_label.font = [UIFont systemFontOfSize:10];
        home_label.text = order.order_spec;
        [backHeadView addSubview:home_label];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(screenWide - 74, screenHeight * 0.11, 50, screenHeight * 0.04);
        [btn setTitle:@"房型详情"
             forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        [btn setTitleColor:RGB(240, 71, 76)
                  forState:UIControlStateNormal];
        checkIn_timelabel.userInteractionEnabled = YES;
        [backHeadView addSubview:btn];
    }
    return _tableHeadView;
}
-(UITableView *)tableView
{
    if (!_tableView)
    {
        UITableView * tableView = [[UITableView alloc]
                                   initWithFrame:CGRectMake(0, 0, screenWide, screenHeight -64)
                                   style:UITableViewStylePlain];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.tableFooterView = [UIView new];
        _tableView = tableView;
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ali_pay = YES;
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"支付中心"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.tableHeadView;
    self.tableView.dataSource = self;
    self.tableView.delegate =self;
    [self.tableView registerClass:[SpecialLabelTVC class] forCellReuseIdentifier:@"cellmao"];
    [self.tableView registerClass:[PayWayTVC class] forCellReuseIdentifier:@"cellway"];
    [self.tableView registerClass:[CashStatusTVC class] forCellReuseIdentifier:@"cellcash"];
    cash_use = NO;
    
    [self creatBackFootView];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.tableView addGestureRecognizer:tapGestureRecognizer];
    
}
-(void)creatBackFootView{
    UIView * backFootView = [[UIView alloc]
                             initWithFrame:CGRectMake(0, screenHeight * 0.94-64, screenWide, screenHeight * 0.06)];
    backFootView.backgroundColor = [UIColor whiteColor];
    UIView * line_view =[[UIView alloc]
                         initWithFrame:CGRectMake(0, 0, screenWide, 1)];
    line_view.backgroundColor = RGB(246, 246, 246);
    [backFootView addSubview:line_view];
    UILabel * label = [[UILabel alloc]
                       initWithFrame:CGRectMake(screenWide * 0.1, 1, screenWide * 0.15, screenHeight * 0.06-1)];
    label.text = @"还需支付:";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentRight;
    [backFootView addSubview:label];
    UILabel * money_label = [[UILabel alloc]
                             initWithFrame:CGRectMake(screenWide * 0.25, 1, screenWide * 0.2, screenHeight * 0.06 -1)];
    YYLOrder * order = [_vc_type isEqualToString:@"2"]? [YYLOrder YSOrder]:[YYLOrder YLOrder];
    [RACObserve(order, balance_money) subscribeNext:^(id x) {
        NSString *str = x;
        money_label.text = [NSString stringWithFormat:@"¥%.2lf",[str floatValue]];

    }];

    money_label.textAlignment = NSTextAlignmentLeft;
    money_label.font = [UIFont systemFontOfSize:14];
    [backFootView addSubview:money_label];
    UIButton * toPay_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    toPay_btn.frame = CGRectMake(screenWide /2, 0, screenWide/2, screenHeight * 0.06);
    toPay_btn.backgroundColor = RGB(226, 11, 24);
    [toPay_btn setTitle:@"付款"
               forState:UIControlStateNormal];
    [toPay_btn addTarget:self
                  action:@selector(payToThird)
        forControlEvents:UIControlEventTouchUpInside];
    [toPay_btn setTitleColor:[UIColor whiteColor]
                    forState:UIControlStateNormal];
    [backFootView addSubview:toPay_btn];
    [self.view addSubview:backFootView];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if (section == 1) {
        return 2;
    }else {
        return 2;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    return 50;
                    break;
                case 1:
                    if (cash_use) {
                        return 110;
                    }
                    return 50;
                    break;
                default:
                    return 150;
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    return 90;
                    break;
                default:
                    return 50;
                    break;
            }
        default:
            return 50;
            break;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * data;
    SpecialLabelTVC * cell;
    PayWayTVC * cell_way;
    CashStatusTVC * cell_cash;
    int a = indexPath.section;
    int b = indexPath.row;
    switch (a) {
        case 0:
            switch (b) {
                case 0:
                    cell  =  [tableView dequeueReusableCellWithIdentifier:@"cellmao" forIndexPath:indexPath];
                    data = @[@"优惠券",@"无可用优惠券"];
                    [cell configWithData:data color:RGB(190, 190, 190) font:[UIFont systemFontOfSize:17] vc_type:_vc_type];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                    break;
                default:
                    cell_cash = [tableView dequeueReusableCellWithIdentifier:@"cellcash" forIndexPath:indexPath];
//                    [cell_cash.cash_switch_btn addTarget:self action:@selector(reloadCashCell:) forControlEvents:UIControlEventValueChanged];
                    [[cell_cash.cash_switch_btn rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UISwitch * switch_btn) {
                        cash_use = switch_btn.on;
                        [self reloadCashCell:nil];
                    }];
                    [cell_cash configWithUse:cash_use];
                    current_field = cell_cash.cash_use_field ;
                    current_field.delegate = self;
                    cell_cash.selectionStyle = UITableViewCellSelectionStyleNone;
                    YYLOrder * order = [_vc_type isEqualToString:@"2"]? [YYLOrder YSOrder]:[YYLOrder YLOrder];
                    order.balance_pay = @"0.00";
                    return cell_cash;
                    break;
            }
            break;
        case 1:
            switch (b) {
                case 0:
                    cell  =  [tableView dequeueReusableCellWithIdentifier:@"cellmao" forIndexPath:indexPath];
                    data = @[@"优惠券",@"¥0.00",@"现金账户",@"¥0.00"];
                    [cell configWithData:data color:RGB(190, 190, 190) font:[UIFont systemFontOfSize:12] vc_type:_vc_type];
                    break;
                default:
                    cell  =  [tableView dequeueReusableCellWithIdentifier:@"cellmao" forIndexPath:indexPath];
                    data = @[@"还需支付",@"0"];
                    [cell configWithData:data color:RGB(190, 190, 190) font:[UIFont systemFontOfSize:12] vc_type:_vc_type];

                    break;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            break;
        default:
            cell_way = [tableView dequeueReusableCellWithIdentifier:@"cellway" forIndexPath:indexPath];
            switch (b) {
                case 0:
                    [cell_way configWithimageName:@"choose_44_@2x" title:@"微信支付" aliPay:ali_pay];
                    break;
                default:
                    [cell_way configWithimageName:@"ali_btn" title:@"支付宝支付" aliPay:ali_pay];
                    break;

            }
            cell_way.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell_way;
            break;
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    Member * user = [Member DefaultUser];
    NSString * text = textField.text;
    if (text.floatValue >0) {
        CGFloat y = text.floatValue< user.now_money.floatValue ?text.floatValue:user.now_money.floatValue;
        textField.text = [NSString stringWithFormat:@"%.2lf",y];

    }else{
        textField.text = @"0.00";
    }
    YYLOrder * order = [_vc_type isEqualToString:@"2"]? [YYLOrder YSOrder]:[YYLOrder YLOrder];
    order.balance_pay = textField.text;
}
-(void)reloadCashCell:(UISwitch *)switch_btn{
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @" ";
    } else if (section == 2) {
        return @"选择支付方式";
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            ali_pay = NO;
        }else{
            ali_pay = YES;
        }
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
        [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PAY
- (void)payToThird{
    if (ali_pay) {
        [self payToAlipay];
    }else{
        WXApiRequestHandler *wxapi = [[WXApiRequestHandler  alloc] init];
        wxapi.type = _vc_type;
        [wxapi httpService:nil];
    }
    
}
-(void)payToAlipay
{
     YYLOrder * order_pay = [_vc_type isEqualToString:@"2"]? [YYLOrder YSOrder]:[YYLOrder YLOrder];
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
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = order_pay.group_id;//product.subject; //商品标题
    order.productDescription = order_pay.order_name;//product.body; //商品描述
    order.amount = @"0.01";//[NSString stringWithFormat:@"%f",product.price]; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";// 使用的编码格式
    order.itBPay = @"30m";//允许的最晚付款时间
    order.showUrl = @"m.alipay.com";
    //应用注册scheme,在Info.plist定义URL types
    NSString *appScheme = @"yyl_ali";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"%@",orderSpec);

    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(AliPRIKEY);
    NSString *signedString = [signer signString:orderSpec];
    
    
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
             NSLog(@"reslut = %@,H5界面返回",resultDic);
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
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    if (current_field) {
        [current_field resignFirstResponder];
    }
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
