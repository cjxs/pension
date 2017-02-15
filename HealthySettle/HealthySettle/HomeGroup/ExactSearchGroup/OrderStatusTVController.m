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
#import "Order.h"

@interface OrderStatusTVController ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel * home_label;

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
        
        UILabel * status_label = [[UILabel alloc]
                                  initWithFrame:CGRectMake(10,screenHeight * 0.02 , screenWide-20 , 0.06 * screenHeight)];
        status_label.text = @"待支付";
        status_label.textColor = [UIColor redColor];
        [view_0 addSubview:status_label];
        
        UILabel * order_sn_label = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.1, screenWide*0.45, screenHeight * 0.04)];
        order_sn_label.text = [NSString stringWithFormat:@"订单号：2436543563633"];
        order_sn_label.adjustsFontSizeToFitWidth = YES;
        order_sn_label.textColor = RGB(190, 190, 190);
        [view_0 addSubview:order_sn_label];
        
        UILabel * money_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.5, screenHeight * 0.1, screenWide * 0.5-10, screenHeight * 0.04)];
        money_label.textColor = [UIColor redColor];
        money_label.textAlignment = NSTextAlignmentRight;
        money_label.text =  [NSString stringWithFormat:@"合计支付：2332.00"];
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
        organ_label.text = @"科技护肤";
        organ_label.numberOfLines = 2;
        organ_label.font = [UIFont systemFontOfSize:18];
        [view_1 addSubview:organ_label];
        
        UILabel * price_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.7, screenHeight * 0.105, screenWide * 0.3-40, screenHeight * 0.04)];
        price_label.text = @"1232";
        price_label.adjustsFontSizeToFitWidth = YES;
        [view_1 addSubview:price_label];
        
        price_label.textColor = [UIColor redColor];
        price_label.textAlignment = NSTextAlignmentRight;
        UILabel * unit_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide-40, screenHeight * 0.11, 30, screenHeight * 0.04)];
        unit_label.text = [_vc_type intValue]==2? @"/间":@"/人";
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
        if ([_vc_type intValue] == 3) {
            address_title.text = @"目的地";
            UILabel * address_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.015, screenWide * 0.4, screenHeight * 0.04)];
            [title_view_0 addSubview:address_label];
            address_label.text = @"杭州";
            address_label.textAlignment = NSTextAlignmentLeft;
            
        }else{
            address_title.text = @"服务细则";
            
            home_label = [[UILabel alloc]
                          initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.015, screenWide*0.65, screenHeight * 0.04)];
            home_label.font = [UIFont systemFontOfSize:12];
            home_label.textAlignment = NSTextAlignmentLeft;
            [title_view_0 addSubview:home_label];
            /*homeLabel上的显示
            if ([_vc_type intValue]== 2) {
                NSDictionary * dic = _group_dic[@"room"][_room_index intValue];
                
                NSString * is_catered;
                switch ([dic[@"is_catered"] integerValue]) {
                    case 0:
                        is_catered = @"不包餐";
                        break;
                    case 1:
                        is_catered = @"包早餐";
                        break;
                    case 2:
                        is_catered = @"包三餐";
                        break;
                    default:
                        break;
                }
                NSString * is_wifi = [dic[@"is_wifi"] isEqualToString:@"1"]?@"免费WiFi":@"";
                
                home_label.text = [NSString stringWithFormat:@"%@ | %@ | %@ | %@",dic[@"room_type"],dic[@"bed_type"],is_wifi,is_catered];
            }else{
                home_label.text = [NSString stringWithFormat:@"%@ | %@ | %@ | %@",_chargeArray[0],_chargeArray[1],_chargeArray[2],_chargeArray[3]];
            }
             */
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
        if ([_vc_type intValue] == 3) {
            title_label.text = @"出发日期";
            title_label.textAlignment = NSTextAlignmentLeft;
            UILabel * date_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.015, screenWide*0.65, screenHeight *0.04 )];
            date_label.text = @"2017-04-23";
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
            [title_view_1 addSubview:checkIn_timelabel];
            UILabel *leave_timelabel = [[UILabel alloc]
                               initWithFrame:CGRectMake(screenWide * 0.27+ screenWide *0.1 + screenWide /3, screenHeight * 0.015, screenWide /3 - screenWide * 0.1, screenHeight * 0.04)];
            leave_timelabel.font = [UIFont systemFontOfSize:13];
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
        title_label_2.text = [_vc_type intValue] == 3?@"出行人数":@"入住人数";
        
        UILabel * number_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.015, screenWide*0.65, screenHeight *0.04 )];
        number_label.text = @"2";
        number_label.textAlignment = NSTextAlignmentLeft;
        [title_view_2 addSubview:number_label];

        
        
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
        UITableView * tableView = [[UITableView alloc]
                                   initWithFrame:CGRectMake(0, 0, screenWide, screenHeight-64)
                                   style:UITableViewStylePlain];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.tableFooterView = [UIView new];
        _tableView = tableView;
        
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
    [self.view addSubview:self.tableView];
    _tableView.tableHeaderView = self.tableHeadView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ConLabelTVCell class] forCellReuseIdentifier:@"contact"];
    [self.tableView registerClass:[TravelPLabelTVCell class] forCellReuseIdentifier:@"travel"];
    [self.tableView registerClass:[SumAndPayTVCell class] forCellReuseIdentifier:@"pay_no"];
    [self.tableView registerClass:[SumAndPayLTVCell class] forCellReuseIdentifier:@"paied"];
    UIButton * back_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [back_btn addTarget:self action:@selector(backBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    back_btn.frame = CGRectMake(0, 0, 10, 18);
    [back_btn setBackgroundImage:[UIImage imageNamed:@"leftop_w"] forState:UIControlStateNormal];
    UIBarButtonItem * back_item = [[UIBarButtonItem alloc] initWithCustomView:back_btn];
    self.navigationItem.leftBarButtonItem = back_item;
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate =self;

}
-(void)backBtnPressed{
    if ([_vc_type isEqualToString:@"unnormal"]){
        //present到详情页
        UIViewController * viewctl = self.navigationController.viewControllers[2];
        [self.navigationController popToViewController:viewctl animated:YES];
    }else{
        //pop啊
        UIViewController * viewctl = self.navigationController.viewControllers[2];
        [self.navigationController popToViewController:viewctl animated:YES];

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
        return 2;
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
        return cell;
    }else if (indexPath.section==1){
        TravelPLabelTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"travel" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else{
        if (!_order) {
            SumAndPayLTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"paied" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

        }else{
            SumAndPayTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"pay_no" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        if (!_order) {
            return screenHeight * 0.425;
        }else{
            return screenHeight * 0.35;

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
