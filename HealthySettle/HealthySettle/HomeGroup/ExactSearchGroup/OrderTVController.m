//
//  OrderTVController.m
//  HealthySettle
//
//  Created by yrc on 16/4/4.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "OrderTVController.h"
#import "OrderLaeblTVCell.h"
#import "OrderTextFieldTVCell.h"
#import "OrderBtnTVCell.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>

@interface OrderTVController ()

@end

@implementation OrderTVController
-(UIView *)tableHeadView {
    if (!_tableHeadView) {
        _tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight *0.203 )];
        _tableHeadView.backgroundColor = RGB(252, 229, 229);
        UIView  * view = [[UIView alloc] initWithFrame:CGRectMake(8, 8, screenWide - 16, screenHeight * 0.203 - 16)];
        view.backgroundColor = [UIColor whiteColor];
        [_tableHeadView addSubview:view];
        UILabel * organ_label = [[UILabel alloc] initWithFrame:CGRectMake(8,0 , screenWide - 50, 0.05 * screenHeight)];
        organ_label.text = @"巴拉巴拉小魔仙养老机构";
        organ_label.font = [UIFont systemFontOfSize:14];
        [view addSubview:organ_label];
        UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(10, screenHeight * 0.05, screenWide -36, 1)];
        line_view.backgroundColor = RGB(190, 190, 190);
        [view addSubview:line_view];
        
        NSArray * array = @[@"入住",@"离店"];
        for (int i = 0; i < 2; i ++) {
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(8 + screenWide/3 * i, screenHeight * 0.06, screenWide * 0.1, screenHeight *0.04)];
            label.text = array[i];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = RGB(190, 190, 190);
            [view addSubview:label];
        }
        UILabel * checkIn_timelabel = [[UILabel alloc] initWithFrame:CGRectMake(8 + screenWide * 0.1, screenHeight * 0.06, screenWide /3 - screenWide * 0.1, screenHeight * 0.04)];
        checkIn_timelabel.text = @"2月14日（今天）";
        checkIn_timelabel.font = [UIFont systemFontOfSize:10];
        [view addSubview:checkIn_timelabel];
        UILabel * leave_timelabel = [[UILabel alloc] initWithFrame:CGRectMake(8+ screenWide *0.1 + screenWide /3, screenHeight * 0.06, screenWide /3 - screenWide * 0.1, screenHeight * 0.04)];
        leave_timelabel.text = @"2月15日（明天）";
        leave_timelabel.font = [UIFont systemFontOfSize:10];
        [view addSubview:leave_timelabel];
        UILabel * home_label = [[UILabel alloc] initWithFrame:CGRectMake(8, screenHeight * 0.11, screenWide - 80, screenHeight * 0.04)];
        home_label.font = [UIFont systemFontOfSize:12];
        home_label.text = @"大床房";
        [view addSubview:home_label];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(screenWide - 64, screenHeight * 0.11, 40, screenHeight * 0.04);
        [btn setTitle:@"房型详情" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        [btn setTitleColor:RGB(240, 71, 76) forState:UIControlStateNormal];
        [view addSubview:btn];
        
        
        
    }
    return _tableHeadView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.navigationItem setTitle:@"订单填写"];
    self.tableView.tableHeaderView = self.tableHeadView;
    [self.tableView registerClass:[OrderLaeblTVCell class] forCellReuseIdentifier:@"cellL"];
    [self.tableView registerClass:[OrderTextFieldTVCell class] forCellReuseIdentifier:@"cellF"];
    [self.tableView registerClass:[OrderBtnTVCell class] forCellReuseIdentifier:@"cellS"];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.06)];
    UIView * line_view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, 1)];
    line_view.backgroundColor = RGB(246, 246, 246);
    [view addSubview:line_view];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.1, 1, screenWide * 0.15, screenHeight * 0.06-1)];
    label.text = @"总价:";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentRight;
    [view addSubview:label];
    UILabel * money_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.25, 1, screenWide * 0.2, screenHeight * 0.06 -1)];
    money_label.text = @"¥888";
    money_label.textAlignment = NSTextAlignmentLeft;
    money_label.font = [UIFont systemFontOfSize:14];
    [view addSubview:money_label];
    UIButton * toPay_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    toPay_btn.frame = CGRectMake(screenWide /2, 0, screenWide/2, screenHeight * 0.06);
    toPay_btn.backgroundColor = RGB(226, 11, 24);
    [toPay_btn setTitle:@"去支付" forState:UIControlStateNormal];
    [toPay_btn addTarget:self action:@selector(payToEveryOne) forControlEvents:UIControlEventTouchUpInside];
    [toPay_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view addSubview:toPay_btn];
    self.tableView.tableFooterView = view;
    
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 6;
    }else {
        return 5;
 
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderLaeblTVCell * cell;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell = [tableView dequeueReusableCellWithIdentifier:@"cellL" forIndexPath:indexPath];
                [cell configWithtitle:@"房间数" text:@"1间" next:YES];
                break;
            case 1:
                cell = (OrderTextFieldTVCell*)[tableView dequeueReusableCellWithIdentifier:@"cellF" forIndexPath:indexPath];
                [cell configWithtitle:@"联系人" text:@"姓名" next:YES];
                break;
            case 2:
                cell = [tableView dequeueReusableCellWithIdentifier:@"cellL" forIndexPath:indexPath];
                [cell configWithtitle:@"联系人手机" text:@"13746464777" next:YES];
                break;
            case 3:
                cell = (OrderTextFieldTVCell*)[tableView dequeueReusableCellWithIdentifier:@"cellL" forIndexPath:indexPath];
                [cell configWithtitle:@"入住人" text:@"姓名" next:YES];
                break;
            case 4:
                cell = [tableView dequeueReusableCellWithIdentifier:@"cellL" forIndexPath:indexPath];
                [cell configWithtitle:@"证件类型" text:@"身份证" next:YES];
                break;
            case 5:
                cell = [tableView dequeueReusableCellWithIdentifier:@"cellL" forIndexPath:indexPath];
                [cell configWithtitle:@"证件号码" text:@"3343487285234837383" next:NO];
                break;
            default:
                break;
        }
    }else {
        switch (indexPath.row) {
            case 0:
                cell = (OrderBtnTVCell *)[tableView dequeueReusableCellWithIdentifier:@"cellS" forIndexPath:indexPath];
                [cell configWithtitle:@"需要发票" text:nil next:YES];
                break;
            case 1:
                cell = (OrderTextFieldTVCell*)[tableView dequeueReusableCellWithIdentifier:@"cellL" forIndexPath:indexPath];
                [cell configWithtitle:@"发票抬头" text:@"请填写发票抬头" next:YES];
                break;
            case 2:
                cell = [tableView dequeueReusableCellWithIdentifier:@"cellL" forIndexPath:indexPath];
                [cell configWithtitle:@"发票类型" text:@"住宿费" next:YES];
                break;
            case 3:
                cell = [tableView dequeueReusableCellWithIdentifier:@"cellL" forIndexPath:indexPath];
                [cell configWithtitle:@"收件人" text:@"张三" next:NO];
                break;
            case 4:
                cell = [tableView dequeueReusableCellWithIdentifier:@"cellL" forIndexPath:indexPath];
                [cell configWithtitle:@"地址" text:@"浙江省杭州市滨江区隆和大厦603" next:NO];
                break;
            default:
                break;
 
    }
    
   }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return screenHeight * 0.06;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 12;
    }
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   

}
- (void)payToEveryOne {
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088121603474938";
    NSString *seller = @"yrc@5199yl.com";
    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBALS9wD4rlZ3MzuVe\ne9ttgzCX0o5ztkIqfUaBv8x8gCL1AOTmGZH1RMc9zsQclsmPvSuU3P3xJi78qE9e\nTocgKk900Fg869lq0Zi9H579meA104hZFIZxNvX69A52D/ZYTBZIAIH/pZGDiV5I\n4VpHS+X8oziIym8onlbCeDpIA1SnAgMBAAECgYBv+tBMtHwyFF5rRaq/PI53YNkX\nYSGexOxw7pqCevB4uAshxl45TBicyPJ+FqhloSS3B7gTrYDWw7sT0X4dwhPzsoaB\nUd/sg7kMbEIF2AISAI/CUskRwYFGK2jtGd94zpFzgh/1p8SGnZzySch8V+czojPY\nlYWUjxOEPWGh15Z0oQJBAO8eYlrOfSykhGF5KSxgkPL1DwaOjv/tzSjGtLRlbp7z\ni9k7hbnyujzrIZ80t+pgnwiCxZ2viSHHr5YDN9eh9c0CQQDBgE4MElMQuKRAHuTR\nwQbQqlpWT10VuJRzwx/JAFWM2FA0Sh5yK+c54ptX+M7Y384riV5OQNceN1kDg7eb\nIABDAkBuVmXqIvgtvmh7le4C1Thtc9kQHH4t6GxP0YkW6Osnm5g/kDC/whpf+9vS\n2/+1vgoEYluPzK0Jklwaa7e737dNAkApbV3ISdgM2WsY60RT//6EiCRFHEKylsz5\np8nTT8YBHIK3XzL7gJjFlNVrVTJ7zhamzYcqO8mSh4kALqANjyFfAkEAhoIxwxY7\nkJK8kGnKlmdbh74QM5lA1e+YoubDVELQh9sQC7ZkSQLcJv8KsTdukiVfAwn3DK4E\n8L7IA+O1QhFi6w==";
    /*============================================================================*/
    /*============================================================================*/
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
//    Order *order = [[Order alloc] init];
//    order.partner = partner;
//    order.seller = seller;
//    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
//    order.productName = product.subject; //商品标题
//    order.productDescription = product.body; //商品描述
//    order.amount = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
//    order.notifyURL =  @"http://www.xxx.com"; //回调URL
//    
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    order.showUrl = @"m.alipay.com";
//    
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *appScheme = @"alisdkdemo";
//    
//    //将商品信息拼接成字符串
//    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
//    
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderSpec];
//    
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
//    NSString *orderString = nil;
//    if (signedString != nil) {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];
//        
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSLog(@"reslut = %@",resultDic);
//        }];
//    }


}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
