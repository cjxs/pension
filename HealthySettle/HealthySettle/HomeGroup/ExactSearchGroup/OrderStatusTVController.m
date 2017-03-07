//
//  OrderStatusTVController.m
//  HealthySettle
//
//  Created by yrc on 17/2/14.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "OrderStatusTVController.h"
#import "ConLabelTVCell.h"
#import "TravelPLabelTVCell.h"
#import "SumAndPayTVCell.h"
#import "SumAndPayLTVCell.h"
#import "Order_ed.h"
#import "DDOrder.h"
#import "PayViewController.h"

@interface OrderStatusTVController ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel * home_label;
    NSArray * user_arr;

}

@end

@implementation OrderStatusTVController
-(UIView *)tableHeadView
{
    if (!_tableHeadView)
    {
        _tableHeadView = [[UIView alloc]
                          initWithFrame:CGRectMake(0, 0, screenWide, screenHeight *0.54)];
        
        UIView * view_0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.165)];
        [_tableHeadView addSubview:view_0];
        
        UILabel * prompt_label = [[UILabel alloc] initWithFrame:CGRectMake(15, 1, screenWide - 30, screenHeight * 0.04)];
        prompt_label.backgroundColor = UIColorFromHex(@"#fdfbc0");
        prompt_label.text = @"  请及时付款，不然就被抢光啦!";
        prompt_label.font = [UIFont systemFontOfSize:12];
        prompt_label.textAlignment = NSTextAlignmentCenter;
        [view_0 addSubview:prompt_label];

        
        UILabel * status_label = [[UILabel alloc]
                                  initWithFrame:CGRectMake(10,screenHeight * 0.03 , screenWide-20 , 0.06 * screenHeight)];

        if ([_order.dd_status intValue] == 19 )
        {
            if ([_order.pay_type isEqualToString:@"线下支付"]) {
                status_label.text = _order.pay_type;

            }else{
                status_label.text = @"待付款";
            }
        }else if ([_order.dd_status intValue] == 20 ){
            status_label.text = @"已关闭";
            
        }else{
            if ([_order.status integerValue] == 1) {
                status_label.text = @"已付款";

            }else{
                status_label.text = @"使用中";

            }
            
        }
        status_label.textColor = [UIColor greenColor];
        [view_0 addSubview:status_label];
        
        UILabel * order_sn_label = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.1, screenWide*0.45, screenHeight * 0.04)];
        order_sn_label.text = [NSString stringWithFormat:@"订单号: %@",_order.order_sn];
        
        order_sn_label.adjustsFontSizeToFitWidth = YES;
        order_sn_label.textColor = RGB(190, 190, 190);
        [view_0 addSubview:order_sn_label];
        
        UILabel * money_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.5, screenHeight * 0.1, screenWide * 0.5-10, screenHeight * 0.04)];
        money_label.textColor = [UIColor redColor];
        money_label.textAlignment = NSTextAlignmentRight;
        money_label.text =  [NSString stringWithFormat:@"合计支付：%@",_order.total_money];
        if (IS_IPHONE6EARLY) {
            money_label.font = [UIFont systemFontOfSize:14];
            order_sn_label.font = [UIFont systemFontOfSize:12];
        }
        [view_0 addSubview:money_label];
        
        UIView * line_view = [[UIView alloc]
                                initWithFrame:CGRectMake(0, screenHeight * 0.15, screenWide, screenHeight * 0.015)];
        line_view.backgroundColor = GRAYCOLOR;
        [view_0 addSubview:line_view];

        
        
        UIView *view_1 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.165, screenWide, screenHeight * 0.165)];
        [_tableHeadView addSubview:view_1];

        UILabel * organ_label = [[UILabel alloc]
                                 initWithFrame:CGRectMake(10,0 , screenWide-20 , 0.1 * screenHeight)];
        organ_label.text = _order.order_name;
        organ_label.numberOfLines = 2;
        organ_label.font = [UIFont systemFontOfSize:18];
        [view_1 addSubview:organ_label];
        
        UILabel * price_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.7, screenHeight * 0.105, screenWide * 0.3-40, screenHeight * 0.04)];
        price_label.text = [NSString stringWithFormat:@"¥ %@",_order.price];
        price_label.adjustsFontSizeToFitWidth = YES;
        [view_1 addSubview:price_label];
        
        price_label.textColor = [UIColor redColor];
        price_label.textAlignment = NSTextAlignmentRight;
        UILabel * unit_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide-40, screenHeight * 0.11, 30, screenHeight * 0.04)];
        unit_label.text = [_order.cat_id intValue]==2? @"/间":@"/人";
        unit_label.font = [UIFont systemFontOfSize:10];
        [view_1 addSubview:unit_label];
        
        UIView * line_view_0 = [[UIView alloc]
                                initWithFrame:CGRectMake(0, screenHeight * 0.15, screenWide, screenHeight * 0.015)];
        line_view_0.backgroundColor = GRAYCOLOR;
        [view_1 addSubview:line_view_0];
        
        
        
        
        UIView * title_view_0 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.33, screenWide , screenHeight * 0.07)];
        [_tableHeadView addSubview:title_view_0];
        UILabel * address_title = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.015, screenWide * 0.2, screenHeight * 0.04)];
        [title_view_0 addSubview:address_title];
        address_title.textAlignment = NSTextAlignmentLeft;
        if (IS_IPHONE6EARLY) {
            address_title.font = [UIFont systemFontOfSize:13];
        }
        if ([_order.cat_id intValue] == 3) {
            address_title.text = @"目的地";
            UILabel * address_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.015, screenWide * 0.68, screenHeight * 0.04)];
            [title_view_0 addSubview:address_label];
            address_label.text = _order.area_name;
            address_label.textAlignment = NSTextAlignmentLeft;
            
        }else{
            address_title.text = @"服务细则";
            
            home_label = [[UILabel alloc]
                          initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.015, screenWide*0.65, screenHeight * 0.04)];
            home_label.font = [UIFont systemFontOfSize:12];
            home_label.textAlignment = NSTextAlignmentLeft;
            [title_view_0 addSubview:home_label];
            home_label.text = _order.order_spec;
        }
        
        
        UIView * line_view_1 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.4-1, screenWide, 1)];
        line_view_1.backgroundColor = GRAYCOLOR;
        [_tableHeadView addSubview:line_view_1];
        UIView * title_view_1 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.4, screenWide, screenHeight * 0.07)];
        [_tableHeadView addSubview:title_view_1];
        UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.015, screenWide * 0.25, screenHeight * 0.04)];
        [title_view_1 addSubview:title_label];
        if (IS_IPHONE6EARLY) {
            title_label.font = [UIFont systemFontOfSize:13];
        }
        if ([_order.cat_id intValue] == 3) {
            title_label.text = @"出发日期";
            title_label.textAlignment = NSTextAlignmentLeft;
            UILabel * date_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.015, screenWide*0.65, screenHeight *0.04 )];
            date_label.text = [DDLogin timeStrWithstr:_order.group_date];
            date_label.textAlignment = NSTextAlignmentLeft;
            [title_view_1 addSubview:date_label];
        }else{
            title_label.text = @"住离日期";
            NSArray * array = @[@"入住",@"离店"];
            for (int i = 0; i < 2; i ++)
            {
                UILabel * label = [[UILabel alloc]
                                   initWithFrame:CGRectMake(screenWide * 0.27 + screenWide/3 * i, screenHeight * 0.015, screenWide * 0.1, screenHeight *0.04)];
                label.text = array[i];
                label.font = [UIFont systemFontOfSize:15];
                label.textColor = RGB(190, 190, 190);
                [title_view_1 addSubview:label];
            }
            
            UILabel *checkIn_timelabel = [[UILabel alloc]
                                 initWithFrame:CGRectMake(screenWide * 0.27 + screenWide * 0.1, screenHeight * 0.015, screenWide /3 - screenWide * 0.1, screenHeight * 0.04)];
            checkIn_timelabel.font = [UIFont systemFontOfSize:13];
            checkIn_timelabel.text = [DDLogin timeStrWithstr:_order.checkin_time];
            [title_view_1 addSubview:checkIn_timelabel];
            UILabel *leave_timelabel = [[UILabel alloc]
                               initWithFrame:CGRectMake(screenWide * 0.27+ screenWide *0.1 + screenWide /3, screenHeight * 0.015, screenWide /3 - screenWide * 0.1, screenHeight * 0.04)];
            leave_timelabel.font = [UIFont systemFontOfSize:13];
            leave_timelabel.text = [DDLogin timeStrWithstr:_order.checkout_time];
            [title_view_1 addSubview:leave_timelabel];
        }
        
        UIView * line_view_2 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.47-1, screenWide, 1)];
        line_view_2.backgroundColor = GRAYCOLOR;
        [_tableHeadView addSubview:line_view_2];
        UIView * title_view_2 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.47, screenWide, screenHeight * 0.07)];
        [_tableHeadView addSubview:title_view_2];
        UILabel * title_label_2 = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.015, screenWide * 0.25, screenHeight * 0.04)];
        [title_view_2 addSubview:title_label_2];
        if (IS_IPHONE6EARLY) {
            title_label_2.font = [UIFont systemFontOfSize:13];
        }
        
        UILabel * number_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.015, screenWide*0.65, screenHeight *0.04 )];
        number_label.textAlignment = NSTextAlignmentLeft;
        [title_view_2 addSubview:number_label];
        switch ([_order.cat_id intValue]) {
            case 1:
                title_label_2.text = @"入住人数:";
                number_label.text = _order.beds;
                break;
            case 2:
                title_label_2.text = @"预订房间:";
                number_label.text = _order.lived_num;

                break;
            case 3:
                title_label_2.text = @"参加人数:";
                number_label.text = _order.num;
                
                break;
            default:
                break;
        }

        UIView * line_view_3 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.375-1, screenWide, 1)];
        line_view_3.backgroundColor = GRAYCOLOR;
        //[_tableHeadView addSubview:line_view_3];
        
    }
    return _tableHeadView;
}

-(UITableView *)tableView
{
    if (!_tableView)
    {
            _tableView = [[UITableView alloc]
                         initWithFrame:CGRectMake(0, 0, screenWide, screenHeight-64)
                         style:UITableViewStylePlain];
        [_tableView registerClass:[ConLabelTVCell class] forCellReuseIdentifier:@"contact"];
        [_tableView registerClass:[TravelPLabelTVCell class] forCellReuseIdentifier:@"travel"];
        [_tableView registerClass:[SumAndPayTVCell class] forCellReuseIdentifier:@"pay_no"];
        [_tableView registerClass:[SumAndPayLTVCell class] forCellReuseIdentifier:@"paied"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.dataSource = self;
        _tableView.delegate =self;

        
    }
    return _tableView;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)] && [_vc_type isEqualToString:@"unnormal"]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]&&[_vc_type isEqualToString:@"unnormal"]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"订单详情"];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([_vc_type isEqualToString:@"unnormal"]) {
        [self setData];

    }else{
        user_arr = [_order.checkin_name componentsSeparatedByString:@";"];
        [self loadData];
        if ([_order.paid intValue] == 0 && [_order.status intValue] == 6 && [_order.pay_type length] == 0) {
            [self creatBackFootView];
        }
    }


    UIButton * back_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [back_btn addTarget:self action:@selector(backBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    back_btn.frame = CGRectMake(0, 0, 10, 18);
    [back_btn setBackgroundImage:[UIImage imageNamed:@"leftop_w"] forState:UIControlStateNormal];
    UIBarButtonItem * back_item = [[UIBarButtonItem alloc] initWithCustomView:back_btn];
    self.navigationItem.leftBarButtonItem = back_item;

}
-(void)setData{
    Member * user = [Member DefaultUser];
    DDOrder * order_post = [[DDOrder alloc] initWithUid:user.uid login:user.login oid:_o_id];
    [order_post startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
        if ([dic[@"error_code"] intValue] == 6) {
            Order_ed * order;
                order = [Order_ed mj_objectWithKeyValues:dic];
                if ([order.status intValue] == 6) {
                    order.dd_status = @"19";
                }else if ([order.status intValue] == 4||[order.status intValue] == 5||[order.status intValue] == 11||[order.status intValue] == 12||[order.status intValue] == 13)
                {
                    order.dd_status = @"20";
                }else{
                    order.dd_status = @"21";
                }

            _order = order;
            user_arr = [_order.checkin_name componentsSeparatedByString:@";"];
            [self loadData];
        
        }else{
            //其他途径获取数据
            [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
    
}
-(void)loadData{
    [self.view addSubview:self.tableView];
    _tableView.tableHeaderView = self.tableHeadView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
-(void)creatBackFootView{
    UIView * backFootView = [[UIView alloc]
                    initWithFrame:CGRectMake(0, screenHeight * 0.93, screenWide, screenHeight * 0.07)];
    backFootView.backgroundColor = [UIColor whiteColor];
    UIView * line_view =[[UIView alloc]
                         initWithFrame:CGRectMake(0, 0, screenWide, 1)];
    line_view.backgroundColor = RGB(246, 246, 246);
    [backFootView addSubview:line_view];

    UILabel * _money_label = [[UILabel alloc]
                    initWithFrame:CGRectMake(10, 1, screenWide * 0.5-20, screenHeight * 0.07 -8)];
    
    
    _money_label.textAlignment = NSTextAlignmentLeft;
    _money_label.font = [UIFont systemFontOfSize:14];
    _money_label.text = [NSString stringWithFormat:@"待支付: ¥ %@",_order.payment_money];
    
    
    
    [backFootView addSubview:_money_label];
    UIButton * toPay_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    toPay_btn.frame = CGRectMake(screenWide /2, 0, screenWide/2, screenHeight * 0.07);
    toPay_btn.backgroundColor = RGB(226, 11, 24);
    [toPay_btn setTitle:@"马上支付"
               forState:UIControlStateNormal];
    [toPay_btn addTarget:self
                  action:@selector(toPay)
        forControlEvents:UIControlEventTouchUpInside];
    [toPay_btn setTitleColor:[UIColor whiteColor]
                    forState:UIControlStateNormal];
    [backFootView addSubview:toPay_btn];
    
    _tableView.tableFooterView = backFootView;
    
}
-(void)toPay{
    PayViewController * payVC = [[PayViewController alloc] init];
    payVC.order_ed = _order;
    payVC.vc_type = @"unnormal";
    payVC.order_id = _order.order_id;
    payVC.order.order_id = _order.order_id;

    [self.navigationController pushViewController:payVC animated:YES];

}


-(void)backBtnPressed{
    if ([_vc_type isEqualToString:@"unnormal"]){
        //present到详情页
        UIViewController * viewctl = self.navigationController.viewControllers[0];
        [self.navigationController popToViewController:viewctl animated:YES];
    }else{
        //pop啊
        [self.navigationController popViewControllerAnimated:YES];

    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{   return 3;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (section == 1)
    {
        return user_arr.count;
    }else
    {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ConLabelTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"contact" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithname:_order.contact_name number:_order.contact_phone];
        return cell;
    }else if (indexPath.section==1){
        TravelPLabelTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"travel" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithStr:user_arr[indexPath.row]];
        
        return cell;
        
    }else{
        
        if ([_order.dd_status intValue] == 19 )
        {
            SumAndPayTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"pay_no" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.num_sum_label.text = [NSString stringWithFormat:@"¥ %@",_order.total_money];
            cell.balan_label.text = [NSString stringWithFormat:@"¥ %@",_order.balance_pay];
            cell.vocher_label.text = [NSString stringWithFormat:@"¥ %@",_order.coupon];
            cell.unpaid_label.text = [NSString stringWithFormat:@"¥ %@",_order.payment_money];
            return cell;

        }else{
            SumAndPayLTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"paied" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            

            if ([_order.dd_status intValue] == 20 ){
                NSString * str = [NSString stringWithFormat:@"= (现金账户¥%@ + 在线支付¥%@ + 优悠券%@)",_order.balance_pay,_order.payment_money,_order.coupon];
                [cell configWithtype:@"" total:_order.total_money vocher:@"0.00" realize:str time:_order.add_time];
                cell.title_label.text = @"未付款:";
            }else{
                NSString * str = [NSString stringWithFormat:@"= (现金账户¥%@ + 在线支付¥%@)",_order.balance_pay,_order.payment_money];
                [cell configWithtype:_order.pay_type total:_order.total_money vocher:_order.coupon realize:str time:_order.add_time];
                cell.title_label.text = @"实付款:";
            }
            return cell;


        }
        
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return screenHeight * 0.31;
    }else if (indexPath.section==1){
        return screenHeight * 0.28;
        
    }else{
    if ([_order.dd_status intValue] == 19 )
            {
            return screenHeight * 0.35;
        }else{
            return screenHeight * 0.425;

        }
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
