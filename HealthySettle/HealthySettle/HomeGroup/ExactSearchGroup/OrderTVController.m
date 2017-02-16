//
//  OrderTVController.m
//  HealthySettle
//
//  Created by yrc on 16/4/4.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "OrderTVController.h"
#import "CDDatePicker.h"
#import "PayViewController.h"
#import "PPNumberButton.h"
#import "ContentsTVCell.h"
#import "TravelPersonTVCell.h"
#import "UsecanTVCell.h"
#import "SumAndPayTVCell.h"
#import "YYLUser.h"


@interface OrderTVController ()<HYMDatePickerDelegate, UITextFieldDelegate>
{
    NSDate * end_begin;
    NSDate * end_end;
    UILabel * checkIn_timelabel;
    UILabel * leave_timelabel;
    UILabel * home_label;
    UITextField * current_field;
    YYLOrder * order;
    NSString * cash_str,*dis_count_str;
    BOOL cashUse,vocherUse;
    UIView * backFootView;
    NSString * contact_name;
    NSString * contact_phone;
    NSMutableArray * _user_arr;
}

@end

@implementation OrderTVController
#pragma mark - LazyLoading
- (PPNumberButton *)number_btn
{
    if (!_number_btn) {
        PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(screenWide * 0.718, screenHeight * 0.01, screenWide/4, screenHeight * 0.05)];
        numberButton.shakeAnimation = YES;
        numberButton.increaseImage = [UIImage imageNamed:@"increase_taobao"];
        numberButton.decreaseImage = [UIImage imageNamed:@"decrease_taobao"];
        numberButton.backgroundColor = [UIColor colorWithHexString:@"#ebebeb"];
        numberButton.textField.text = [NSString stringWithFormat:@"%ld",_person_num];
        
        _number_btn = numberButton;
    }
    return _number_btn;
}
-(UIView *)tableHeadView
{
    if (!_tableHeadView)
    {
        _tableHeadView = [[UIView alloc]
                          initWithFrame:CGRectMake(0, 0, screenWide, screenHeight *0.525)];
        /*_tableHeadView.backgroundColor = RGB(252, 229, 229);
        UIView * backHeadView = [[UIView alloc]
                          initWithFrame:CGRectMake(8, 8, screenWide - 16, screenHeight * 0.203 - 16)];
        backHeadView.backgroundColor = [UIColor whiteColor];
        backHeadView.layer.masksToBounds = YES;
        backHeadView.layer.cornerRadius = 5;
        [_tableHeadView addSubview:backHeadView];
         */
        UILabel * organ_label = [[UILabel alloc]
                                 initWithFrame:CGRectMake(10,0 , screenWide-20 , 0.1 * screenHeight)];
        organ_label.text = _group_dic[@"name"];
        organ_label.numberOfLines = 2;
        organ_label.font = [UIFont systemFontOfSize:18];
        [_tableHeadView addSubview:organ_label];
        
        UILabel * price_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.7, screenHeight * 0.105, screenWide * 0.3-40, screenHeight * 0.04)];
        price_label.text = [NSString stringWithFormat:@"¥ %@",_charge_price];
        price_label.adjustsFontSizeToFitWidth = YES;
        [_tableHeadView addSubview:price_label];
        price_label.textColor = [UIColor redColor];
        price_label.textAlignment = NSTextAlignmentRight;
        UILabel * unit_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide-40, screenHeight * 0.11, 30, screenHeight * 0.04)];
        unit_label.text = [_vc_type intValue]==2? @"/间":@"/人";
        unit_label.font = [UIFont systemFontOfSize:10];
        [_tableHeadView addSubview:unit_label];
        
        
        UIView * line_view_0 = [[UIView alloc]
                              initWithFrame:CGRectMake(0, screenHeight * 0.15, screenWide, screenHeight * 0.015)];
        line_view_0.backgroundColor = GRAYCOLOR;
        [_tableHeadView addSubview:line_view_0];
        UIView * title_view_0 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.165, screenWide , screenHeight * 0.07)];
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
            address_label.text = _group_dic[@"area_name"];
            address_label.textAlignment = NSTextAlignmentLeft;
            
        }else{
            address_title.text = @"服务细则";

            home_label = [[UILabel alloc]
                          initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.015, screenWide*0.65, screenHeight * 0.04)];
            home_label.font = [UIFont systemFontOfSize:12];
            home_label.textAlignment = NSTextAlignmentLeft;
            [title_view_0 addSubview:home_label];
            if ([_vc_type intValue]== 2) {
                NSDictionary * dic = _group_dic[@"room"][[_room_index intValue]];
                
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
        }
        
        
        UIView * line_view_1 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.235-1, screenWide, 1)];
        line_view_1.backgroundColor = GRAYCOLOR;
        [_tableHeadView addSubview:line_view_1];
        UIView * title_view_1 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.235, screenWide, screenHeight * 0.07)];
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
            date_label.text = _room_index;
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
            
            checkIn_timelabel = [[UILabel alloc]
                                 initWithFrame:CGRectMake(screenWide * 0.27 + screenWide * 0.1, screenHeight * 0.015, screenWide /3 - screenWide * 0.1, screenHeight * 0.04)];
            checkIn_timelabel.font = [UIFont systemFontOfSize:13];
            [title_view_1 addSubview:checkIn_timelabel];
            leave_timelabel = [[UILabel alloc]
                               initWithFrame:CGRectMake(screenWide * 0.27+ screenWide *0.1 + screenWide /3, screenHeight * 0.015, screenWide /3 - screenWide * 0.1, screenHeight * 0.04)];
            leave_timelabel.font = [UIFont systemFontOfSize:13];
            [title_view_1 addSubview:leave_timelabel];
            
            checkIn_timelabel.userInteractionEnabled = YES;
            UITapGestureRecognizer * tapChoose_start = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(pickViewAppear:)];
            tapChoose_start.numberOfTapsRequired = 1;
            [checkIn_timelabel addGestureRecognizer:tapChoose_start];

            if ([_vc_type intValue] == 2) {
                if (order.checkin_time) {
                    checkIn_timelabel.text = [CDDatePicker getStringFromDate:[YYLOrder YSOrder].checkin_time];
                    end_begin = order.checkin_time;
                }else{
                    checkIn_timelabel.text = [CDDatePicker getStringFromDate:[NSDate date]];
                }
                if (order.checkout_time) {
                    leave_timelabel.text = [CDDatePicker getStringFromDate:[YYLOrder YSOrder].checkout_time];
                    end_end = order.checkout_time;
                }else{
                    leave_timelabel.text = @"--------";
                }
                UITapGestureRecognizer * tapChoose_end = [[UITapGestureRecognizer alloc]
                                                          initWithTarget:self
                                                          action:@selector(pickViewAppear:)];
                tapChoose_end.numberOfTapsRequired = 1;
                leave_timelabel.userInteractionEnabled = YES;
                [leave_timelabel addGestureRecognizer:tapChoose_end];
            }else{
                if (order.checkin_time) {
                    checkIn_timelabel.text = [CDDatePicker getStringFromDate:order.checkin_time];
                    NSDate * date = [self getPriousorLaterDateFromDate:order.checkin_time withMonth:1];
                    leave_timelabel.text = [CDDatePicker getStringFromDate:date];
                }else{
                    checkIn_timelabel.text = [CDDatePicker getStringFromDate:[NSDate date]];
                    NSDate * date = [self getPriousorLaterDateFromDate:[NSDate date] withMonth:1];
                    leave_timelabel.text = [CDDatePicker getStringFromDate:date];
                }

            }



        }
        UIView * line_view_2 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.305-1, screenWide, 1)];
        line_view_2.backgroundColor = GRAYCOLOR;
        [_tableHeadView addSubview:line_view_2];
        UIView * title_view_2 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.305, screenWide, screenHeight * 0.07)];
        [_tableHeadView addSubview:title_view_2];
        UILabel * title_label_2 = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.015, screenWide * 0.25, screenHeight * 0.04)];
        [title_view_2 addSubview:title_label_2];
        if (IS_IPHONE6EARLY) {
            title_label_2.font = [UIFont systemFontOfSize:13];
        }
        title_label_2.text = [_vc_type intValue] == 3?@"出行人数":@"入住人数";
        [title_view_2 addSubview:self.number_btn];
        
        
        
        
        
        UIView * line_view_3 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.375-1, screenWide, 1)];
        line_view_3.backgroundColor = GRAYCOLOR;
        [_tableHeadView addSubview:line_view_3];
        UIView * title_view_3 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.375, screenWide, screenHeight * 0.07)];
        [_tableHeadView addSubview:title_view_3];
        UILabel * text_label = [[UILabel alloc] init];
        [title_view_3 addSubview:text_label];
        UILabel * money_sum_label = [[UILabel alloc] init];
        [title_view_3 addSubview:money_sum_label];
        [money_sum_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(title_view_3);
            make.size.mas_equalTo(CGSizeMake(screenWide * 0.2, screenHeight * 0.04));
            make.right.equalTo(title_view_3).offset(-10);
        }];
        money_sum_label.textColor = [UIColor redColor];
        [text_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(screenWide * 0.4, screenHeight * 0.03));
            make.centerY.equalTo(title_view_3);
            make.right.mas_equalTo(money_sum_label.mas_left);
        }];
        text_label.textAlignment = NSTextAlignmentRight;
        text_label.text = [NSString stringWithFormat:@"共%ld人    合计：",_person_num];
        
        [RACObserve(self, number_sum) subscribeNext:^(NSString * x) {
            money_sum_label.text = x ;
        }];
        
        @weakify(self);

        _number_btn.numberBlock = ^(NSString *num){
            @strongify(self);
            _person_num = [num integerValue];
            text_label.text = [NSString stringWithFormat:@"共%@人    合计：",num];
            if ([_vc_type intValue] != 2) {
                self.number_sum = [NSString stringWithFormat:@"%ld",[_charge_price intValue]* _person_num];

            }
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
            
        };
        [RACObserve(self, number_sum) subscribeNext:^(NSString * x) {
            NSInteger paid = [_number_sum intValue]- [_balance_can intValue]-[_dis_count_can intValue];
            self.unpaid_money = [NSString stringWithFormat:@"%ld",paid];
        }];
        [RACObserve(self, balance_can) subscribeNext:^(NSString *x){
            NSInteger paid = [_number_sum intValue]- [_balance_can intValue]-[_dis_count_can intValue];
            self.unpaid_money = [NSString stringWithFormat:@"%ld",paid];
        }];
        [RACObserve(self, dis_count_can) subscribeNext:^(NSString *x) {
            NSInteger paid = [_number_sum intValue]- [_balance_can intValue]-[_dis_count_can intValue];
            self.unpaid_money = [NSString stringWithFormat:@"%ld",paid];
        }];
        [RACObserve(self, unpaid_money) subscribeNext:^(NSString * x) {
            _money_label.text = x;
        }];



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
    if (!_person_num) {
        _person_num = 1;
    }
    if ([_vc_type intValue] == 2) {
        _charge_price = _group_dic[@"room"][[_room_index intValue]][@"room_price"];

    }
    if ([_vc_type isEqualToString:@"2"]) {
        order = [YYLOrder YSOrder];
        if (order.checkout_time) {
            if (!order.checkin_time) {
                order.checkin_time = [NSDate date];
            }
            NSTimeInterval oneDay = 24*60*60;
            NSTimeInterval time = [order.checkout_time timeIntervalSinceDate:order.checkin_time];
            int number = round(time/oneDay * 1.0);
            self.number_sum = [NSString stringWithFormat:@"%ld",[self.charge_price integerValue] * number];
        }else{
            self.number_sum = _charge_price;
        }
    }else{
        self.number_sum = [NSString stringWithFormat:@"%ld",[_charge_price intValue]* _person_num];
    }
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.title = @"订单填写";
    [self creatBackFootView];

    order = [YYLOrder YSOrder];
    self.tableView.tableHeaderView = self.tableHeadView;
    

    
    [self.tableView registerClass:[ContentsTVCell class] forCellReuseIdentifier:@"content"];
    [self.tableView registerClass:[TravelPersonTVCell class] forCellReuseIdentifier:@"travel"];
    [self.tableView registerClass:[UsecanTVCell class] forCellReuseIdentifier:@"use"];
    [self.tableView registerClass:[SumAndPayTVCell class] forCellReuseIdentifier:@"pay"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.tableView addGestureRecognizer:tapGestureRecognizer];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController.navigationBar.tintColor == [UIColor whiteColor]) {
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        self.navigationController.navigationBar.tintColor = [UIColor redColor];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
        [self.navigationController setNavigationBarHidden:NO animated:animated];

    }

    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (backFootView) {
        for (UIView * view in backFootView.subviews) {
            [view removeFromSuperview];
        }
        [backFootView removeFromSuperview];
    }

}

-(void)creatBackFootView{
    backFootView = [[UIView alloc]
                             initWithFrame:CGRectMake(0, screenHeight * 0.94, screenWide, screenHeight * 0.06)];
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
    _money_label = [[UILabel alloc]
                             initWithFrame:CGRectMake(screenWide * 0.25, 1, screenWide * 0.2, screenHeight * 0.06 -1)];
    
    
    _money_label.textAlignment = NSTextAlignmentLeft;
    _money_label.font = [UIFont systemFontOfSize:14];
    
    

    [backFootView addSubview:_money_label];
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
    [[[UIApplication sharedApplication].delegate window] addSubview:backFootView];
    self.tableView.tableFooterView = [UIView new];

}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (section == 1)
    {
        return _person_num;
    }else
    {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ContentsTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"content" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (int i = 0; i< cell.subviews.count; i++) {
            if ([cell.subviews[i] isKindOfClass:[UITextField class]] ) {
                UITextField * textfield = cell.subviews[i];
                textfield.delegate = self;
            }
        }
        [[cell.name_field rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(NSString * x) {
            contact_name = x;
        }];
        [[cell.phone_field rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(NSString * x) {
            contact_phone = x;
        }];
        [cell configWithname:contact_name phone:contact_phone];
        return cell;
    }else if (indexPath.section==1){
        TravelPersonTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"travel" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (int i = 0; i< cell.subviews.count; i++) {
            if ([cell.subviews[i] isKindOfClass:[UITextField class]] ) {
                UITextField * textfield = cell.subviews[i];
                textfield.delegate = self;
            }
        }
        if (!_user_arr) {
            _user_arr = [NSMutableArray array];
        }
        YYLUser * yyl_user;
        if (_user_arr.count<indexPath.row+1 ) {
            cell.user = [[YYLUser alloc] init];
            [_user_arr addObject:cell.user];
        }else{
            yyl_user = _user_arr[indexPath.row];
            [cell configWithYYLuser:yyl_user];
        }
        yyl_user = _user_arr[indexPath.row];
        [[cell.name_field rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(NSString * x) {
            yyl_user.travel_name = x;
            
        }];
        [[cell.phone_field rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(NSString * x) {
            yyl_user.travel_phone = x;
        }];
        [[cell.id_field rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(NSString * x) {
            yyl_user.travel_id = x;
        }];
        cell.selectSex = ^(NSString * num){
            yyl_user.travel_sex = num;
        };
        return cell;

    }else if (indexPath.section==2){
        UsecanTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"use" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Member * user = [Member DefaultUser];
        if ([user.now_money intValue] > [_number_sum intValue]) {
            cash_str = _number_sum;
        }else{
            cash_str = user.now_money;
        }
        [[cell.cash_switch_btn rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UISwitch * switch_btn) {
            cashUse = switch_btn.on;
            if (cashUse) {
                self.balance_can = cash_str;
            }else{
                self.balance_can = @"0";
            }
        }];
        
        if ([user.vocher intValue] > [_group_dic[@"can_vochers"] intValue]) {
            dis_count_str = _group_dic[@"can_vochers"];
        }else{
            dis_count_str = user.vocher;
        }
        
        [[cell.dis_count_switch_btn rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UISwitch * switch_btn){
            vocherUse = switch_btn.on;
            if (vocherUse) {
                self.dis_count_can = @"10";
            }else{
                self.dis_count_can = @"0";
            }
        }];

        [cell configWithCash:cash_str dis_count:@"10" cashUse:cashUse dis_countUse:vocherUse];
        return cell;
    }else{
        SumAndPayTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"pay" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [RACObserve(self, number_sum) subscribeNext:^(NSString * x) {
            cell.num_sum_label.text = [NSString stringWithFormat:@"¥ %@",x];
            
        }];
        [RACObserve(self, balance_can) subscribeNext:^(NSString *x){
            cell.balan_label.text = x? [NSString stringWithFormat:@"-¥ %@",x]:@"-¥ 0.00";
        }];
        [RACObserve(self, dis_count_can) subscribeNext:^(NSString *x) {
            cell.vocher_label.text = x? [NSString stringWithFormat:@"-¥ %@",x]:@"-¥ 0.00";
        }];
        [RACObserve(self, unpaid_money) subscribeNext:^(NSString * x) {
            cell.unpaid_label.text = x;
        }];

        return cell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return screenHeight * 0.31;
    }else if (indexPath.section==1){
        return screenHeight * 0.28;

    }else if (indexPath.section==2){
        return screenHeight * 0.155;
    }else{
        return screenHeight * 0.365;
    }
}


//日期选择器出来
- (void)pickViewAppear:(UITapGestureRecognizer *)tap
{
    CDDatePicker * datePicker;

    if ([_vc_type isEqualToString:@"2"]) {
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
                    datePicker.date_start = [NSDate dateWithTimeInterval:oneDay sinceDate:end_begin];
            }
        }
        datePicker.delegateDiy = self;
        [datePicker show];
        _datePicker = datePicker;
    }
    
    
}
-(void)datePickerbtnDownWithDate:(NSDate *)date{
    if ([_vc_type isEqualToString:@"2"]) {
        if (date) {
            if ([_datePicker.type isEqualToString:@"Z"]) {
                checkIn_timelabel.text = [NSString stringWithFormat:@"   %@",[CDDatePicker getStringFromDate:date]];
                order.checkin_time = date;
                end_begin = date;
            }else{
                leave_timelabel.text = [NSString stringWithFormat:@"   %@",[CDDatePicker getStringFromDate:date]];
                order.checkout_time = date;
                end_end = date;
            }
            if (order.checkout_time) {
                if (!order.checkin_time) {
                    order.checkin_time = [NSDate date];
                }
                NSTimeInterval oneDay = 24*60*60;
                NSTimeInterval time = [order.checkout_time timeIntervalSinceDate:order.checkin_time];
                int number = round(time/oneDay * 1.0);
                self.number_sum = [NSString stringWithFormat:@"%ld",[self.charge_price integerValue] * number];
                
            }
        }//日期选择器的代理方法

    }
}
-(BOOL)testOrderMassage{
    if ([_vc_type isEqualToString:@"2"]) {
        if (!order.checkout_time) {
            return NO;
        }
    }
    if (!contact_name) {
        return NO;
    }
    if (!contact_phone) {
        return NO;
    }
    for (int i = 0; i < _person_num; i++) {
        YYLUser * user = _user_arr[i];
        if (!user) {
            return NO;
        }
        if (!user.travel_name) {
            return NO;
        }
        if (!user.travel_id) {
            return NO;
        }
    }
    return YES;

}
-(BOOL)creatOrderInterNet{
    return YES;
}
- (void)submitOrder {
    if ([self testOrderMassage]) {
        YYLOrder * order_pre = [YYLOrder PreOrder];
        order_pre.cat_id = _vc_type;
        if (!order.checkin_time) {
            order_pre.checkin_time = [NSDate date];
        }else{
            order_pre.checkin_time =order.checkin_time;
        }


        if ([_vc_type intValue] == 2) {
            
            NSTimeInterval oneDay = 24*60*60;
            if (!order.checkout_time) {
                order_pre.checkout_time = [NSDate dateWithTimeInterval:oneDay sinceDate:order_pre.checkin_time];
            }else{
                order_pre.checkout_time = order.checkout_time;
            }
            
            NSTimeInterval time = [order_pre.checkout_time timeIntervalSinceDate:order_pre.checkin_time];
            int number = time/oneDay;
            order_pre.lived_num = [NSString stringWithFormat:@"%d",number];
            order_pre.num = @"1";
            order_pre.total_money = [NSString stringWithFormat:@"%ld",[self.charge_price integerValue] * number];
            order_pre.room_id = _room_index;
            
            
        }else if ([_vc_type intValue] == 1){
            order_pre.beds = [NSString stringWithFormat:@"%ld",_person_num];
            
            order_pre.total_money = [NSString stringWithFormat:@"%ld",[self.charge_price integerValue] * _person_num];
            if (!order_pre.checkout_time) {
                order_pre.checkout_time = [self getPriousorLaterDateFromDate:[NSDate date] withMonth:1];
            }
            order_pre.order_spec = [NSArray arrayWithArray:_chargeArray];
        }else{
            order_pre.group_date = _room_index;
            order_pre.total_money = [NSString stringWithFormat:@"%ld",[self.charge_price integerValue] * _person_num];

            
        }
        order_pre.order_name = _group_dic[@"name"];

        order_pre.group_id = self.gid;
        order_pre.price = _charge_price;

        order_pre.subsidy_money_m = @"0";
        order_pre.subsidy_money_u = @"0";
        order_pre.contact_name = @"ddd";
        order_pre.contact_phone = @"123445";
        order_pre.card_id = @"0";
        order_pre.wx_cheap = @"0";
        order_pre.balance_pay = _balance_can;
        order_pre.coupon = _dis_count_can;
        order_pre.payment_money = [NSString stringWithFormat:@"%@",_money_label.text];
        order_pre.add_time = [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]];
        order_pre.paid = @"0";
        order_pre.status = @"6";
        for (YYLUser * user in _user_arr) {
            if (!user.travel_sex) {
                user.travel_sex = @"0";
            }
        }
        order_pre.checkin_name = [NSArray arrayWithArray:_user_arr];

        
        if ([self creatOrderInterNet]) {
            PayViewController * payVC = [[PayViewController alloc] init];
            payVC.order = order_pre;
            payVC.vc_type = self.vc_type;
            [SVProgressHUD showSuccessWithStatus:@"订单提交成功！"];
            [self.navigationController pushViewController:payVC animated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"订单提交失败！"];

        }
       
    }else{
        [SVProgressHUD showErrorWithStatus:@"请补全订单信息！"];

    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    current_field = textField;
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    if (current_field) {
        [current_field resignFirstResponder];
    }
}
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
