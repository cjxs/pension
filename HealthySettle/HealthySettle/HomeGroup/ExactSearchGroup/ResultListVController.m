//
//  ResultListVController.m
//  HealthySettle
//
//  Created by yrc on 16/4/9.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "ResultListVController.h"
#import "PensionSRTVCell.h"
#import "RegimenRTVCell.h"
#import "GroupDetailViewController.h"
#import "PriSeleView.h"
#import "DDListGet.h"
#import "CDDatePicker.h"

@interface ResultListVController ()<UITableViewDataSource ,UITableViewDelegate,HYMDatePickerDelegate,UIGestureRecognizerDelegate> {
    NSDate * end_begain;
    NSDate * end_end;
    BOOL hide;
    BOOL isScroll;
    UIView * begin_view;
}

@end

@implementation ResultListVController
#pragma mark - LazyLoading
-(UITableView *)tableView
{
    if (!_tableView)
    {
        UITableView * tableView = [[UITableView alloc]
                                   initWithFrame:CGRectMake(0, 0, screenWide, screenHeight -64)
                                   style:UITableViewStylePlain];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.bounces = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableView = tableView;
    }
    return _tableView;
}
-(UIView *)tableHeadView {
    if (!_tableHeadView)
    {
        UIView * view = [[UIView alloc]
                         initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.08)];
        view.backgroundColor = RGB(231, 231, 231);
        UITextField * textField = [[UITextField alloc]
                                   initWithFrame:CGRectMake(screenWide * 0.3, screenHeight * 0.01, screenWide * 0.68, screenHeight * 0.06)];
        textField.backgroundColor = [UIColor whiteColor];
        textField.clipsToBounds = YES;
        textField.layer.cornerRadius = 5;
        textField.placeholder = @"  机构名称／位置等";
        textField.font = [UIFont systemFontOfSize:14];
        _textField = textField;
        [view addSubview:_textField];
        
        if ([self.vc_type isEqualToString:@"L"])
        {
            UILabel * checkIn_label = [[UILabel alloc]
                                       initWithFrame:CGRectMake(screenWide * 0.02, screenHeight * 0.01, screenWide * 0.26, screenHeight * 0.06)];
            checkIn_label.textColor = RGB(135, 135,135);
            checkIn_label.clipsToBounds = YES;
            checkIn_label.layer.cornerRadius = 5;
            checkIn_label.backgroundColor = [UIColor whiteColor];
            _checkIn_label = checkIn_label;
            _checkIn_label.textAlignment = NSTextAlignmentCenter;
            
            if ([YYLOrder YLOrder].checkin_time) {
                checkIn_label.text = [NSString stringWithFormat:@"入 %@",[CDDatePicker getStringFromDate:[YYLOrder YLOrder].checkin_time]];;
            }else{
                checkIn_label.text = [NSString stringWithFormat:@"入 %@",[CDDatePicker getStringFromDate:[NSDate date]]];
            }

            checkIn_label.font = [UIFont systemFontOfSize:14];
            [view addSubview:_checkIn_label];
            checkIn_label.userInteractionEnabled = YES;
            UITapGestureRecognizer * tapChoose_start = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(pickViewAppear:)];
            tapChoose_start.numberOfTapsRequired = 1;
            [_checkIn_label addGestureRecognizer:tapChoose_start];
            
        }else if ([self.vc_type isEqualToString:@"S"])
        {
            UIView * label_view = [[UIView alloc]
                                   initWithFrame:CGRectMake(screenWide * 0.02, screenHeight * 0.01, screenWide * 0.26, screenHeight * 0.06)];
            label_view.clipsToBounds = YES;
            label_view.layer.cornerRadius = 5;
            label_view.backgroundColor = [UIColor whiteColor];
            
            UILabel * checkIn_label = [[UILabel alloc]
                                       initWithFrame:CGRectMake(0, 0, screenWide * 0.26, screenHeight * 0.03)];
            if ([YYLOrder YSOrder].checkin_time) {
                checkIn_label.text = [NSString stringWithFormat:@"入 %@",[CDDatePicker getStringFromDate:[YYLOrder YSOrder].checkin_time]];;
                end_begain = [YYLOrder YSOrder].checkin_time;
            }else{
                 checkIn_label.text = [NSString stringWithFormat:@"入 %@",[CDDatePicker getStringFromDate:[NSDate date]]];
            }
            checkIn_label.userInteractionEnabled = YES;
            checkIn_label.font = [UIFont systemFontOfSize:12];
            checkIn_label.textColor = RGB(135, 135,135);
            checkIn_label.textAlignment = NSTextAlignmentCenter;
            _checkIn_label = checkIn_label;
            UITapGestureRecognizer * tapChoose_start = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(pickViewAppear:)];
            tapChoose_start.numberOfTapsRequired = 1;
            [_checkIn_label addGestureRecognizer:tapChoose_start];
            [label_view addSubview:_checkIn_label];
            UILabel * leave_label = [[UILabel alloc]
                                     initWithFrame:CGRectMake(0, screenHeight * 0.03, screenWide * 0.26, screenHeight * 0.03)];
            
            if ([YYLOrder YSOrder].checkout_time) {
                leave_label.text = [NSString stringWithFormat:@"离 %@",[CDDatePicker getStringFromDate:[YYLOrder YSOrder].checkout_time]];
                end_end = [YYLOrder YSOrder].checkout_time;
            }else {
                leave_label.text = @"离 ----------";
            }
            leave_label.userInteractionEnabled = YES;
            leave_label.font = [UIFont systemFontOfSize:12];
            leave_label.textColor = RGB(135, 135,135);
            leave_label.textAlignment = NSTextAlignmentCenter;
            UITapGestureRecognizer * tapChoose_end = [[UITapGestureRecognizer alloc]
                                                      initWithTarget:self
                                                      action:@selector(pickViewAppear:)];
            tapChoose_end.numberOfTapsRequired = 1;
            [leave_label addGestureRecognizer:tapChoose_end];
            _leave_label = leave_label;
            [label_view addSubview:_leave_label];
            [view addSubview:label_view];
        }
        
        _tableHeadView = view;
    }
    return _tableHeadView;
}

-(UIView *)filter_view
{ //筛选页面
    if (!_filter_view)
    {
        NSArray * image_array = @[@"list2_1_",@"list2_2_",@"list2_3_",@"list2_4_"];
        NSArray * title_array = @[@"所在区域",@"价格区间",@"筛选",@"排序"];
        UIView * view = [[UIView alloc]
                         initWithFrame:CGRectMake(0, screenHeight - 49-64, screenWide, 49)];
        view.backgroundColor = RGB(249, 249, 249);
        for (int i = 0; i < 4 ;i++ )
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(screenWide /4 * i, 0, screenWide /4, 49);
            [btn addTarget:self
                    action:@selector(showfilterWithButton:)
          forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
            UIImageView * image_view;
            switch (i) {
                case 0:
                    image_view  = [[UIImageView alloc]
                                   initWithFrame:CGRectMake((screenWide/4 -screenWide * 0.05)/2 + screenWide /4 * i, screenHeight * 0.01, screenWide * 0.04, screenWide * 0.04 /3 * 4)];
                    break;
                case 1:
                    image_view  = [[UIImageView alloc]
                                   initWithFrame:CGRectMake((screenWide/4 -screenWide * 0.05)/2 + screenWide /4 * i, screenHeight * 0.01, screenWide * 0.05, screenWide * 0.05 )];
                    break;
                default:
                    image_view  = [[UIImageView alloc]
                                   initWithFrame:CGRectMake((screenWide/4 -screenWide * 0.05)/2 + screenWide /4 * i, screenHeight * 0.01, screenWide * 0.04, screenWide * 0.04 /15* 16)];
                    break;
                }
         
            image_view.image = [UIImage imageNamed:image_array[i]];
            [view addSubview:image_view];
            UILabel * label = [[UILabel alloc]
                               initWithFrame:CGRectMake(screenWide/4 * i, CGRectGetMaxY(image_view.frame), screenWide /4,49 -  CGRectGetMaxY(image_view.frame))];
            label.text = title_array[i];
            label.textColor = RGB(199, 199, 199);
            label.font = [UIFont systemFontOfSize:10];
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
        }
        _filter_view = view;
    }
    return _filter_view;
}
- (void)showfilterWithButton:(UIButton *)btn
{
    int number = btn.frame.origin.x / screenWide * 4;
    if ( number ==0) {
        NSLog(@" 所在区域");
    }else if (number == 1)
    {
        NSLog(@" 价格区间");
        PriSeleView * pri_view = [[PriSeleView alloc] init];
        [[UIApplication sharedApplication].keyWindow addSubview:pri_view];
    }else if (number == 2)
    {
        NSLog(@"筛选");
    }else {
        NSLog(@"排序");
    }
}
#pragma mark - auto_view
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)setData{
    DDListGet * ddlist;
    if ([_vc_type isEqualToString:@"S"]) {
        ddlist = [[DDListGet alloc] initWithController:@"ys_g" area_id:self.area_id page:nil];
    }else{
        ddlist = [[DDListGet alloc] initWithController:@"yl_g" area_id:self.area_id page:nil];
    }
    [ddlist startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        [begin_view removeFromSuperview];
        NSArray * arr = [DDLogin arrayWithJsonString:request.responseString];
        _data_arr = arr;
        [self loadSomething];
        
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%ld",request.responseStatusCode);
    }];
}
-(void)loadSomething {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.filter_view];
    _searchPlace_name = self.title_l;
    if (_searchPlace_name)
    {
        self.navigationItem.title = _searchPlace_name;
    }
    self.tableView.tableHeaderView = self.tableHeadView;
    if ([_vc_type isEqualToString:@"S"])
    {
        [self.tableView registerNib:[UINib nibWithNibName:@"RegimenRTVCell" bundle:nil] forCellReuseIdentifier:@"cellRegimen"];
        
    }else if ([_vc_type isEqualToString:@"L"])
    {
        [self.tableView registerNib:[UINib nibWithNibName:@"PensionSRTVCell" bundle:nil] forCellReuseIdentifier:@"cellPension"];
    }
 
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    begin_view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    begin_view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:begin_view];
    [self setData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource ,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data_arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_vc_type isEqualToString:@"L"])
    {
        PensionSRTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellPension" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary * dic = _data_arr[indexPath.row];

        NSString *  str2 = [NSString stringWithFormat:@"%@/upload/group/%@",BASEURL,dic[@"pic"]];
        NSString * str3 = [str2 stringByReplacingOccurrencesOfString:@"," withString:@"/"];
        [cell configWithimage:str3 title:dic[@"s_name"] address:dic[@"address"] number:dic[@"bed_nums"] price:dic[@"price"]];
        
        return cell;
        
    }else if ([_vc_type isEqualToString:@"S"])
    {
        RegimenRTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellRegimen" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary * dic = _data_arr[indexPath.row];
        NSString *  str2 = [NSString stringWithFormat:@"%@/upload/group/%@",BASEURL,dic[@"pic"]];
        NSString * str3 = [str2 stringByReplacingOccurrencesOfString:@"," withString:@"/"];

        
        [cell configWithImage:str3 title:dic[@"s_name"] address:dic[@"address"] price:dic[@"price"] supportArray:dic[@"spec"]];
        return cell;
    }else
    {
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return screenHeight * 0.158;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupDetailViewController * resultDTVC = [[GroupDetailViewController alloc] init];
    resultDTVC.hidesBottomBarWhenPushed = YES;
    resultDTVC.vc_type = self.vc_type;
    resultDTVC.group_id = _data_arr[indexPath.row][@"group_id"];
    [self.navigationController pushViewController:resultDTVC
                                         animated:NO];
}
#pragma mark - FilterView
- (void)showFilter_view {
    self.filter_view.frame = CGRectMake(0, screenHeight - 49-64, screenWide, 49);
}
- (void)hideFilter_view {
    self.filter_view.frame = CGRectMake(0, screenHeight-64, screenWide, 49);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        static float newy = 0;
        static float oldy = 0;
        newy = scrollView.contentOffset.y ;
    if (isScroll == NO)
    {
        isScroll = YES;
        if (newy != oldy )
        {
            if (newy > oldy && hide == NO)
            {
                
                [UIView animateWithDuration:0.5 animations:^{
                    [self hideFilter_view];
                }];
                hide = YES;
            }else if(newy < oldy&& hide == YES)
            {
                [UIView animateWithDuration:0.5 animations:^{
                    [self showFilter_view];
                }];
                hide = NO;
            }
            oldy = newy;
        }
        isScroll = NO;

    }
}
//日期选择器出来
- (void)pickViewAppear:(UITapGestureRecognizer *)tap
{
    CDDatePicker * datePicker;
    if ([_vc_type isEqualToString:@"L"]) {
        datePicker = [[CDDatePicker alloc] initWithOff_label:nil];
        datePicker.type = @"Z";
        datePicker.date_start = [CDDatePicker getTimeOfNightFromdate:[NSDate date]];

    }else{
        if (tap.view.frame.origin.y < 5) {//入住按钮
            datePicker = [[CDDatePicker alloc] initWithOff_label:_leave_label];
            datePicker.type = @"Z";
            datePicker.date_start = [CDDatePicker getTimeOfNightFromdate:[NSDate date]];
            if (end_end) {
                NSTimeInterval  timeIn =[end_end timeIntervalSinceDate:datePicker.date_start];
                NSTimeInterval  oneDay = 24*60*60;
                int days = timeIn / oneDay;
                NSInteger day = days;
                datePicker.choose_day_count = day;
            }
        }else {
            datePicker = [[CDDatePicker alloc] initWithOff_label:_checkIn_label];
            if (end_begain) {
                NSTimeInterval  oneDay = 24*60*60;  //1天的长度
                end_begain = [NSDate dateWithTimeInterval:oneDay sinceDate:end_begain];
                datePicker.date_start = end_begain;
            }
        }

    }
    datePicker.delegateDiy = self;
    [datePicker show];
    _datePicker = datePicker;
    
}
-(void)datePickerbtnDownWithDate:(NSDate *)date{
    if (date) {
        if ([_datePicker.type isEqualToString:@"Z"]) {
            _checkIn_label.text = [NSString stringWithFormat:@" 入 %@",[CDDatePicker getStringFromDate:date]];
            if ([_vc_type isEqualToString:@"L"]) {
                [YYLOrder YLOrder].checkin_time = date;
            }else{
                [YYLOrder YSOrder].checkin_time = date;
                end_begain = date;
            }
        }else{
            _leave_label.text = [NSString stringWithFormat:@" 离 %@",[CDDatePicker getStringFromDate:date]];
            [YYLOrder YSOrder].checkout_time = date;
            end_end = date;
        }
    }//日期选择器的代理方法
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
