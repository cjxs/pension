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
#import "CDDatePicker.h"
#import "PayViewController.h"

@interface OrderTVController ()<HYMDatePickerDelegate>
{
    NSDate * end_begin;
    NSDate * end_end;
    UILabel * checkIn_timelabel;
    UILabel * leave_timelabel;
}

@end

@implementation OrderTVController
#pragma mark - LazyLoading
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
        [_tableHeadView addSubview:backHeadView];
        UILabel * organ_label = [[UILabel alloc]
                                 initWithFrame:CGRectMake(8,0 , screenWide - 50, 0.05 * screenHeight)];
        
        organ_label.text = _group_dic[@"name"];
        organ_label.font = [UIFont systemFontOfSize:14];
        [backHeadView addSubview:organ_label];
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
        checkIn_timelabel = [[UILabel alloc]
                                       initWithFrame:CGRectMake(8 + screenWide * 0.1, screenHeight * 0.06, screenWide /3 - screenWide * 0.1, screenHeight * 0.04)];
        checkIn_timelabel.font = [UIFont systemFontOfSize:10];
        [backHeadView addSubview:checkIn_timelabel];
        leave_timelabel = [[UILabel alloc]
                                     initWithFrame:CGRectMake(8+ screenWide *0.1 + screenWide /3, screenHeight * 0.06, screenWide /3 - screenWide * 0.1, screenHeight * 0.04)];
        leave_timelabel.font = [UIFont systemFontOfSize:10];
        [backHeadView addSubview:leave_timelabel];
        UILabel * home_label = [[UILabel alloc]
                                initWithFrame:CGRectMake(8, screenHeight * 0.11, screenWide - 80, screenHeight * 0.04)];
        home_label.font = [UIFont systemFontOfSize:12];
        [backHeadView addSubview:home_label];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(screenWide - 64, screenHeight * 0.11, 40, screenHeight * 0.04);
        [btn setTitle:@"房型详情"
             forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        [btn setTitleColor:RGB(240, 71, 76)
                  forState:UIControlStateNormal];
        checkIn_timelabel.userInteractionEnabled = YES;

        if ([_vc_type isEqualToString:@"S"]) {
            home_label.text = _group_dic[@"room"][[_room_index intValue]][@"room_type"];
            if ([YYLOrder YSOrder].checkin_time) {
                checkIn_timelabel.text = [CDDatePicker getStringFromDate:[YYLOrder YSOrder].checkin_time];
                end_begin = [YYLOrder YSOrder].checkin_time;
            }else{
                checkIn_timelabel.text = [CDDatePicker getStringFromDate:[NSDate date]];
            }
            if ([YYLOrder YSOrder].checkout_time) {
                leave_timelabel.text = [CDDatePicker getStringFromDate:[YYLOrder YSOrder].checkout_time];
                end_end = [YYLOrder YSOrder].checkout_time;
            }else{
               leave_timelabel.text = @"--------";
            }
            UITapGestureRecognizer * tapChoose_start = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(pickViewAppear:)];
            tapChoose_start.numberOfTapsRequired = 1;
            [checkIn_timelabel addGestureRecognizer:tapChoose_start];
            UITapGestureRecognizer * tapChoose_end = [[UITapGestureRecognizer alloc]
                                                      initWithTarget:self
                                                      action:@selector(pickViewAppear:)];
            tapChoose_end.numberOfTapsRequired = 1;
            leave_timelabel.userInteractionEnabled = YES;
            [leave_timelabel addGestureRecognizer:tapChoose_end];

        }else{
            if ([YYLOrder YLOrder].checkin_time) {
                checkIn_timelabel.text = [CDDatePicker getStringFromDate:[YYLOrder YLOrder].checkin_time];
                NSDate * date = [self getPriousorLaterDateFromDate:[YYLOrder YLOrder].checkin_time withMonth:1];
                leave_timelabel.text = [CDDatePicker getStringFromDate:date];
            }else{
                checkIn_timelabel.text = [CDDatePicker getStringFromDate:[NSDate date]];
                NSDate * date = [self getPriousorLaterDateFromDate:[NSDate date] withMonth:1];
                leave_timelabel.text = [CDDatePicker getStringFromDate:date];
                UITapGestureRecognizer * tapChoose_start = [[UITapGestureRecognizer alloc]
                                                            initWithTarget:self
                                                            action:@selector(pickViewAppear:)];
                tapChoose_start.numberOfTapsRequired = 1;
                checkIn_timelabel.userInteractionEnabled = YES;
                [checkIn_timelabel addGestureRecognizer:tapChoose_start];
            }
            home_label.text = [NSString stringWithFormat:@"%@ | %@ | %@ | %@",_chargeArray[0],_chargeArray[1],_chargeArray[2],_chargeArray[3]];
            
            
        }
        [backHeadView addSubview:btn];
    }
    return _tableHeadView;
}
-(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month
    
{
        
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    NSTimeInterval  oneDay = 24*60*60;  //1年的长度
    NSTimeInterval current_time = [mDate timeIntervalSince1970] - oneDay;
    NSDate * currentDate = [NSDate dateWithTimeIntervalSince1970:current_time];

    return currentDate;
        
}
#pragma mark - auto_view
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.bounces = YES;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.title = @"订单填写";
    self.tableView.tableHeaderView = self.tableHeadView;
    [self.tableView registerClass:[OrderLaeblTVCell class]
           forCellReuseIdentifier:@"cellL"];
    [self.tableView registerClass:[OrderTextFieldTVCell class]
           forCellReuseIdentifier:@"cellF"];
    [self.tableView registerClass:[OrderBtnTVCell class]
           forCellReuseIdentifier:@"cellS"];
    UIView * backFootView = [[UIView alloc]
                      initWithFrame:CGRectMake(0, screenHeight * 0.94-64, screenWide, screenHeight * 0.06)];
    backFootView.backgroundColor = [UIColor whiteColor];
    UIView * line_view =[[UIView alloc]
                         initWithFrame:CGRectMake(0, 0, screenWide, 1)];
    line_view.backgroundColor = RGB(246, 246, 246);
    [backFootView addSubview:line_view];
    UILabel * label = [[UILabel alloc]
                       initWithFrame:CGRectMake(screenWide * 0.1, 1, screenWide * 0.15, screenHeight * 0.06-1)];
    label.text = @"总价:";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentRight;
    [backFootView addSubview:label];
    UILabel * money_label = [[UILabel alloc]
                             initWithFrame:CGRectMake(screenWide * 0.25, 1, screenWide * 0.2, screenHeight * 0.06 -1)];
    if ([_vc_type isEqualToString:@"S"]) {
        money_label.text = _group_dic[@"room"][[_room_index intValue]][@"room_price"];
    }else {
        money_label.text = [NSString stringWithFormat:@"  %d",_charge_price.intValue - 50];
        
    }
    money_label.textAlignment = NSTextAlignmentLeft;
    money_label.font = [UIFont systemFontOfSize:14];
    [backFootView addSubview:money_label];
    UIButton * toPay_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    toPay_btn.frame = CGRectMake(screenWide /2, 0, screenWide/2, screenHeight * 0.06);
    toPay_btn.backgroundColor = RGB(226, 11, 24);
    [toPay_btn setTitle:@"提交订单"
               forState:UIControlStateNormal];
    [toPay_btn addTarget:self
                  action:@selector(submitOrder)
        forControlEvents:UIControlEventTouchUpInside];
    [toPay_btn setTitleColor:[UIColor whiteColor]
                    forState:UIControlStateNormal];
    [backFootView addSubview:toPay_btn];
    [self.view addSubview:backFootView];
//    self.tableView.tableFooterView = backFootView;
    self.tableView.tableFooterView = [UIView new];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return 2;
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 6;
    }else
    {
        return 5;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderLaeblTVCell * cell;
    OrderTextFieldTVCell* cell1;
    OrderBtnTVCell * cell2;
    
    if (indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0:
                cell = [tableView dequeueReusableCellWithIdentifier:@"cellL"
                                                       forIndexPath:indexPath];
                [cell configWithtitle:@"房间数" text:@"1间" next:YES];
                break;
            case 1:
               cell1 = [tableView dequeueReusableCellWithIdentifier:@"cellF"
                                                       forIndexPath:indexPath];
              
                [cell1 configWithtitle:@"联系人" text:@"姓名" next:YES];
                return cell1;
                break;
            case 2:
                cell1 = [tableView dequeueReusableCellWithIdentifier:@"cellF"
                                                       forIndexPath:indexPath];
                [cell1 configWithtitle:@"联系人手机" text:@"请输入" next:YES];
                return cell1;
                break;
            case 3:
                cell1 = [tableView dequeueReusableCellWithIdentifier:@"cellF"
                                                    forIndexPath:indexPath];
                [cell1 configWithtitle:@"入住人" text:@"姓名" next:YES];
                return cell1;
                break;
            case 4:
                cell = [tableView dequeueReusableCellWithIdentifier:@"cellL"
                                                       forIndexPath:indexPath];
                [cell configWithtitle:@"证件类型" text:@"身份证" next:YES];
                break;
            case 5:
                cell1 = [tableView dequeueReusableCellWithIdentifier:@"cellF"
                                                       forIndexPath:indexPath];
                [cell1 configWithtitle:@"证件号码" text:@"3343487285234837383" next:NO];
                return cell1;
                break;
            default:
                break;
        }
    }else
    {
        switch (indexPath.row)
        {
            case 0:
                cell2 = [tableView dequeueReusableCellWithIdentifier:@"cellS"
                                                        forIndexPath:indexPath];
                [cell2 configWithtitle:@"需要发票" text:nil next:YES];
                return cell2;
                break;
            case 1:
                cell1 = [tableView dequeueReusableCellWithIdentifier:@"cellF"
                                                        forIndexPath:indexPath];
                [cell1 configWithtitle:@"发票抬头" text:@"请填写发票抬头" next:YES];
                return cell1;
                break;
            case 2:
                cell = [tableView dequeueReusableCellWithIdentifier:@"cellL"
                                                       forIndexPath:indexPath];
                [cell configWithtitle:@"发票类型" text:@"住宿费" next:YES];
                break;
            case 3:
                cell1 = [tableView dequeueReusableCellWithIdentifier:@"cellF"
                                                       forIndexPath:indexPath];
                [cell1 configWithtitle:@"收件人" text:@"张三" next:NO];
                return cell1;
                break;
            case 4:
                cell1 = [tableView dequeueReusableCellWithIdentifier:@"cellF"
                                                       forIndexPath:indexPath];
                [cell1 configWithtitle:@"地址" text:@"浙江省杭州市滨江区隆和大厦603" next:NO];
                return cell1;
                break;
            default:
                break;
        }
   }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return screenHeight * 0.06;
}
-(CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 12;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


//日期选择器出来
- (void)pickViewAppear:(UITapGestureRecognizer *)tap
{
    CDDatePicker * datePicker;

    if ([_vc_type isEqualToString:@"S"]) {
        BOOL tap_where = tap.view == checkIn_timelabel?YES:NO;
        if (tap_where) {//入住按钮
            datePicker = [[CDDatePicker alloc] initWithOff_label:leave_timelabel];
            datePicker.type = @"Z";
            datePicker.date_start = [CDDatePicker getTimeOfNightFromdate:[NSDate date]];
            if (end_end) {
                NSTimeInterval  timeIn =[end_end timeIntervalSinceDate:datePicker.date_start];
                NSTimeInterval  oneDay = 24*60*60;
                int days = timeIn / oneDay ;
                NSInteger day = days;
                datePicker.choose_day_count = day;
            }
        }else {
            datePicker = [[CDDatePicker alloc] initWithOff_label:checkIn_timelabel];
            if (end_begin) {
                NSTimeInterval  oneDay = 24*60*60;  //1天的长度
                end_begin = [NSDate dateWithTimeInterval:oneDay sinceDate:end_begin];
                datePicker.date_start = end_begin;
            }
        }
    }else{
        datePicker = [[CDDatePicker alloc] initWithOff_label:leave_timelabel];
        datePicker.date_start = [CDDatePicker getTimeOfNightFromdate:[NSDate date]];
    }
    datePicker.delegateDiy = self;
    [datePicker show];
    _datePicker = datePicker;
    
}
-(void)datePickerbtnDownWithDate:(NSDate *)date{
    if ([_vc_type isEqualToString:@"S"]) {
        if (date) {
            if ([_datePicker.type isEqualToString:@"Z"]) {
                checkIn_timelabel.text = [NSString stringWithFormat:@"   %@",[CDDatePicker getStringFromDate:date]];
                [YYLOrder YSOrder].checkin_time = date;
                end_begin = date;
            }else{
                leave_timelabel.text = [NSString stringWithFormat:@"   %@",[CDDatePicker getStringFromDate:date]];
                [YYLOrder YSOrder].checkout_time = date;
                end_end = date;
            }
        }//日期选择器的代理方法

    }else{
        checkIn_timelabel.text = [CDDatePicker getStringFromDate:date];
        NSDate * date_l = [self getPriousorLaterDateFromDate:date withMonth:1];
        leave_timelabel.text = [CDDatePicker getStringFromDate:date_l];
        [YYLOrder YLOrder].checkin_time = date;
        [YYLOrder YLOrder].checkout_time = date_l;
    }
}
- (void)submitOrder {
    YYLOrder * order;
    if ([_vc_type isEqualToString:@"S"]) {
        order = [YYLOrder YSOrder];
        order.order_name = _group_dic[@"name"];
        order.group_id = self.gid;
        order.cat_id = @"2";
        order.price = self.charge_price;
        order.subsidy_money_m = @"50";
        order.subsidy_money_u = @"50";
        OrderTextFieldTVCell * cell;
        cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        order.contact_name = [cell returnfromtextField];
        cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        order.contact_phone = [cell returnfromtextField];
        cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        NSString *str = [cell returnfromtextField];
        cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        order.checkin_name = [NSString stringWithFormat:@"%@,%@",str,[cell returnfromtextField]];
        order.beds = @"1";
        
    }else{
        order = [YYLOrder YLOrder];
        order.order_name = _group_dic[@"name"];
        order.group_id = self.gid;
        order.cat_id = @"1";
        order.price = self.charge_price;
        order.subsidy_money_m = @"50";
        order.subsidy_money_u = @"50";
        order.order_spec =  [NSString stringWithFormat:@"%@ | %@ | %@ | %@",_chargeArray[0],_chargeArray[1],_chargeArray[2],_chargeArray[3]];
        OrderTextFieldTVCell * cell;
        cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        order.contact_name = [cell returnfromtextField];
        cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        order.contact_phone = [cell returnfromtextField];
        cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        NSString *str = [cell returnfromtextField];
        cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        order.checkin_name = [NSString stringWithFormat:@"%@,%@",str,[cell returnfromtextField]];
        order.beds = @"1";
    }
    PayViewController * payVC = [[PayViewController alloc] init];
    payVC.vc_type = self.vc_type;
    [self.navigationController pushViewController:payVC animated:YES];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
