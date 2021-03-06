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
#import "MJRefresh.h"
#import "FiltView.h"
static NSInteger page = 1;


@interface ResultListVController ()<UITableViewDataSource ,UITableViewDelegate,HYMDatePickerDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate> {
    NSDate * end_begain;
    NSDate * end_end;
    BOOL hide;
    BOOL isScroll;
    DDListGet * ddlist;//网络请求的指针
    NSString * sort;
    NSString * level;
    BOOL grade_clear;
    BOOL price_clear;
    BOOL keyword_clear;
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
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [UIView new];
        _tableView = tableView;
        
    }
    return _tableView;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    keyword_clear = YES;
    _keyword = textField.text;
    [self headerRereshing];
    [textField resignFirstResponder];
    return YES;
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
        textField.returnKeyType = UIReturnKeyDone;
        textField.clipsToBounds = YES;
        textField.layer.cornerRadius = 5;
        textField.delegate = self;
        if (_keyword) {
            textField.text = _keyword;
        }else{
            textField.placeholder = @"  机构名称／位置等";
        }
        textField.font = [UIFont systemFontOfSize:14];
        _textField = textField;
        [view addSubview:_textField];
        
        if ([self.vc_type isEqualToString:@"1"])
        {
            UILabel * checkIn_label = [[UILabel alloc]
                                       initWithFrame:CGRectMake(screenWide * 0.02, screenHeight * 0.01, screenWide * 0.26, screenHeight * 0.06)];
            checkIn_label.textColor = RGB(135, 135,135);
            checkIn_label.clipsToBounds = YES;
            checkIn_label.layer.cornerRadius = 5;
            checkIn_label.backgroundColor = [UIColor whiteColor];
            _checkIn_label = checkIn_label;
            _checkIn_label.textAlignment = NSTextAlignmentCenter;
            
            if ([YYLOrder YSOrder].checkin_time) {
                checkIn_label.text = [NSString stringWithFormat:@"入 %@",[CDDatePicker getStringFromDate:[DDLogin dateWithString:[YYLOrder YSOrder].checkin_time]]];;
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
            
        }else if ([self.vc_type isEqualToString:@"2"])
        {
            UIView * label_view = [[UIView alloc]
                                   initWithFrame:CGRectMake(screenWide * 0.02, screenHeight * 0.01, screenWide * 0.26, screenHeight * 0.06)];
            label_view.clipsToBounds = YES;
            label_view.layer.cornerRadius = 5;
            label_view.backgroundColor = [UIColor whiteColor];
            
            UILabel * checkIn_label = [[UILabel alloc]
                                       initWithFrame:CGRectMake(0, 0, screenWide * 0.26, screenHeight * 0.03)];
            if ([YYLOrder YSOrder].checkin_time) {
                NSDate * date = [DDLogin dateWithString:[YYLOrder YSOrder].checkin_time];
                checkIn_label.text = [NSString stringWithFormat:@"入 %@",[CDDatePicker getStringFromDate:date]];;
                end_begain = date;
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
                NSDate * date = [DDLogin dateWithString:[YYLOrder YSOrder].checkout_time];
                leave_label.text = [NSString stringWithFormat:@"离 %@",[CDDatePicker getStringFromDate:date]];
                end_end = date;
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
/**
 *  集成刷新控件
 */

-(UIView *)filter_view
{ //筛选页面
    if (!_filter_view)
    {
        NSArray * image_array = @[@"list2_3_",@"list2_2_",@"list2_4_"];
        NSArray * title_array = @[@"等级",@"价格区间",@"排序"];

        UIView * view = [[UIView alloc]
                         initWithFrame:CGRectMake(0, screenHeight - 49-64, screenWide, 49)];
        view.backgroundColor = RGB(249, 249, 249);
        for (int i = 0; i < 3 ;i++ )
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(screenWide /3 * i, 0, screenWide /3, 49);
            [btn addTarget:self
                    action:@selector(showfilterWithButton:)
          forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
            UIImageView * image_view;
            switch (i) {
                case 0:
                    image_view  = [[UIImageView alloc]
                                   initWithFrame:CGRectMake(screenWide/6 -screenWide * 0.02 + screenWide /3 * i, screenHeight * 0.01, screenWide * 0.04, screenWide * 0.04 /3 * 4)];
                    break;
                case 1:
                    image_view  = [[UIImageView alloc]
                                   initWithFrame:CGRectMake(screenWide/6 -screenWide * 0.02 + screenWide /3 * i, screenHeight * 0.01, screenWide * 0.05, screenWide * 0.05 )];
                    break;
                default:
                    image_view  = [[UIImageView alloc]
                                   initWithFrame:CGRectMake(screenWide/6 -screenWide * 0.02 + screenWide /3 * i, screenHeight * 0.01, screenWide * 0.04, screenWide * 0.04 /15* 16)];
                    break;
            }
            
            image_view.image = [UIImage imageNamed:image_array[i]];
            [view addSubview:image_view];
            UILabel * label = [[UILabel alloc]
                               initWithFrame:CGRectMake(screenWide/3 * i, CGRectGetMaxY(image_view.frame), screenWide /3,49 -  CGRectGetMaxY(image_view.frame))];
            label.text = title_array[i];
            label.tag = 820+i;
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
    int number = btn.frame.origin.x / screenWide * 3;
    if ( number ==0) {
        [self gradefileViewAppear];
    }else if (number == 1)
    {
        [self pricefileViewAppear];
    }else
    {
        [self orderfileViewAppear];
    }
}
-(void)gradefileViewAppear{
    FiltView * gradefilt_view = [[FiltView alloc] init];
    gradefilt_view.listType = DDListTYpeSingle;
    gradefilt_view.selectType = DDSelectTYpeSingle;
    gradefilt_view.data_arr1 = @[@"不限",@"金牌机构",@"银牌机构",@"铜牌机构",@"铁牌机构"];
    @weakify(gradefilt_view);

    gradefilt_view.sureBtn = ^(NSString *str){
        @strongify(gradefilt_view);
        for (int i = 0; i < _filter_view.subviews.count; i++) {
            
            if (_filter_view.subviews[i].tag ==820 &&[_filter_view.subviews[i] isKindOfClass:[UILabel class]]) {
                UILabel *label = _filter_view.subviews[i];
                label.text = str.length !=0? gradefilt_view.data_arr1[str.intValue]:@"不限";
            }
        }

        int re = 4 - str.intValue;
        
        level = str.intValue == 0?@"":[NSString stringWithFormat:@"%d",re];
        if (!grade_clear) {
            grade_clear = YES;
        }
        [self headerRereshing];
        
    };
    
    [gradefilt_view addFirstView];
    
    [UIView animateWithDuration:0.5f animations:^{
        [self.view addSubview:gradefilt_view];
    }];

}
-(void)pricefileViewAppear{
    FiltView * pricefilt_view = [[FiltView alloc] init];
    pricefilt_view.listType = DDListTYpeSingle;
    pricefilt_view.selectType = DDSelectTYpeSingle;
    if ([_vc_type intValue] == 1) {
        pricefilt_view.data_arr1 = @[@"5000元/月 以上",@"3000-5000元/月",@"2000-3000元/月",@"1000-2000元/月",@"1000元/月 以下"];
    }else{
        pricefilt_view.data_arr1 = @[@"150元/天 以下",@"150-300元/天",@"300-450元/天",@"450-600元/天",@"600元/天 以上"];
        
    }
    @weakify(pricefilt_view);
    pricefilt_view.sureBtn = ^(NSString * str){
        @strongify(pricefilt_view);
        
        NSString *str_ = pricefilt_view.data_arr1[str.intValue];
        for (int i = 0; i < _filter_view.subviews.count; i++) {
            if (_filter_view.subviews[i].tag ==821 &&[_filter_view.subviews[i] isKindOfClass:[UILabel class]]) {
                UILabel *label = _filter_view.subviews[i];
                if (str.length == 0) {
                    label.text =@"价格";
                }else{
                    label.text = str_;

                }
            }
        }
        if (str.length == 0) {
            self.priceRange = @"";
        }else{
            NSArray * str_arr;
            if ([_vc_type intValue] == 1) {
                str_arr = [str_ componentsSeparatedByString:@"元/月"];
            }else{
                str_arr = [str_ componentsSeparatedByString:@"元/天"];
            }
            if ([str_arr.firstObject length] < 5) {
                if ([str_arr.firstObject intValue] == 5000||[str_arr.firstObject intValue] == 600) {
                    self.priceRange = [NSString stringWithFormat:@"%@-10000",str_arr.firstObject];
                }else if ([str_arr.firstObject intValue] == 1000||[str_arr.firstObject intValue] ==150){
                    self.priceRange = [NSString stringWithFormat:@"0-%@",str_arr.firstObject];
                }
            }else{
                self.priceRange = str_arr.firstObject;
            }

        }
        
        if (!price_clear) {
            price_clear = YES;
        }
        [self headerRereshing];

        
    };
    [pricefilt_view addFirstView];
    [UIView animateWithDuration:0.5f animations:^{
        [self.view addSubview:pricefilt_view];
    }];
    
}

-(void)orderfileViewAppear{
    FiltView * orderfilt_view = [[FiltView alloc] init];
    orderfilt_view.listType = DDListTYpeSingle;
    orderfilt_view.selectType = DDSelectTYpeSingle;
    orderfilt_view.data_arr1 = @[@"综合排序",@"价格从高到低",@"价格从低到高"];
    @weakify(orderfilt_view);
    orderfilt_view.sureBtn = ^(NSString *str){
        @strongify(orderfilt_view);
        for (int i = 0; i < _filter_view.subviews.count; i++) {
            if (_filter_view.subviews[i].tag ==822 &&[_filter_view.subviews[i] isKindOfClass:[UILabel class]]) {
                UILabel *label = _filter_view.subviews[i];
                label.text = str.length !=0?orderfilt_view.data_arr1[str.intValue]:@"不限";
            }
        }

        
        switch ([str intValue]) {
            case 0:
                sort = @"";
                break;
            case 1:
                sort = @"desc";
                break;
            case 2:
                sort = @"asc";
                break;
            default:
                break;
        }
        [self headerRereshing];

    };
    [orderfilt_view addFirstView];
    [UIView animateWithDuration:0.5f animations:^{
        [self.view addSubview:orderfilt_view];
    }];
    
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


-(void)setData{
    if (grade_clear) {
        _priceRange = @"";
        sort = @"";
        _keyword = @"";
        for (int i = 0; i < _filter_view.subviews.count; i++) {
            _textField.text = @"";
            if (_filter_view.subviews[i].tag ==821 &&[_filter_view.subviews[i] isKindOfClass:[UILabel class]]) {
                UILabel *label = _filter_view.subviews[i];
                label.text = @"不限";
            }else if (_filter_view.subviews[i].tag ==822 &&[_filter_view.subviews[i] isKindOfClass:[UILabel class]]) {
                UILabel *label = _filter_view.subviews[i];
                label.text = @"综合排序";
            }
        }

    }
    
    if (price_clear) {
        level = @"";
        _keyword = @"";
        sort = @"";
        for (int i = 0; i < _filter_view.subviews.count; i++) {
            _textField.text = @"";
            if (_filter_view.subviews[i].tag ==820 &&[_filter_view.subviews[i] isKindOfClass:[UILabel class]]) {
                UILabel *label = _filter_view.subviews[i];
                label.text = @"等级";
            }else if (_filter_view.subviews[i].tag ==822 &&[_filter_view.subviews[i] isKindOfClass:[UILabel class]]) {
                UILabel *label = _filter_view.subviews[i];
                label.text = @"综合排序";
            }
        }

    }
    if (keyword_clear){
        level = @"";
        _priceRange = @"";
        sort = @"";
        for (int i = 0; i < _filter_view.subviews.count; i++) {
            if (_filter_view.subviews[i].tag ==820 &&[_filter_view.subviews[i] isKindOfClass:[UILabel class]]) {
                UILabel *label = _filter_view.subviews[i];
                label.text = @"等级";
            }else if (_filter_view.subviews[i].tag ==822 &&[_filter_view.subviews[i] isKindOfClass:[UILabel class]]) {
                UILabel *label = _filter_view.subviews[i];
                label.text = @"综合排序";
            }else if (_filter_view.subviews[i].tag ==821 &&[_filter_view.subviews[i] isKindOfClass:[UILabel class]]) {
                UILabel *label = _filter_view.subviews[i];
                label.text = @"不限";
            }
        }

    }

    ddlist = [[DDListGet alloc] initWithcat_id:_vc_type keyword:_keyword area_id:_area_id sort:sort priceRange:_priceRange level:level page:[NSString stringWithFormat:@"%ld",page]];
    [ddlist startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
        if ([dic[@"error_code"] intValue] == 4) {
            [SVProgressHUD showErrorWithStatus:@"暂时没有相应数据"];
            [self.tableView headerEndRefreshing];
        }else{
            NSArray * arr = dic[@"list"];
            if (arr && arr.count < 15) {
                self.tableView.footerHidden = YES;
            }
            if (page == 1) {
                if (_data_arr) {
                    [_data_arr removeAllObjects];
                }else{
                    _data_arr = [NSMutableArray arrayWithCapacity:0];
                }
            }
            for (NSDictionary * dic in arr) {
                [_data_arr addObject:dic];
            }
            [self.tableView reloadData];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        [self.tableView headerEndRefreshing];
    }];
    grade_clear = NO;
    price_clear = NO;
    keyword_clear = NO;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    grade_clear = NO;
    price_clear = NO;
    keyword_clear = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.filter_view];
    _searchPlace_name = self.title_l;
    if (_searchPlace_name)
    {
        self.navigationItem.title = _searchPlace_name;
    }
    self.tableView.tableHeaderView = self.tableHeadView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([_vc_type isEqualToString:@"2"])
    {
        [self.tableView registerClass:[RegimenRTVCell class] forCellReuseIdentifier:@"cellRegimen"];
        
    }else if ([_vc_type isEqualToString:@"1"])
    {
        [self.tableView registerClass:[PensionSRTVCell class] forCellReuseIdentifier:@"cellPension"];
    }



    // Do any additional setup after loading the view.

    [self setupRefresh];
}
-(void)headerRereshing {
    page = 1;
    [self setData];
    if (self.tableView.footerHidden) {
        self.tableView.footerHidden = NO;
    }
    [self.tableView headerEndRefreshing];

}
-(void)footerRereshing {
    page++;
    [self setData];
    [self.tableView footerEndRefreshing];
    
}
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @" 小优悠正在帮你刷新中,不客气";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"正在加载更多,请稍后";
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
    if (_data_arr) {
        return _data_arr.count;
    }else{
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_vc_type isEqualToString:@"1"])
    {
        PensionSRTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellPension" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary * dic = _data_arr[indexPath.row];
        [cell configWithData:dic];
        
        return cell;
        
    }else if ([_vc_type isEqualToString:@"2"])
    {
        RegimenRTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellRegimen" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary * dic = _data_arr[indexPath.row];
        [cell configWithData:dic];

        return cell;
    }else
    {
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return screenHeight * 0.17241;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupDetailViewController * resultDTVC = [[GroupDetailViewController alloc] init];
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
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (hide == YES) {
        [UIView animateWithDuration:0.5 animations:^{
            [self showFilter_view];
        }];
        hide = NO;
    }
    
}

//日期选择器出来
- (void)pickViewAppear:(UITapGestureRecognizer *)tap
{
    CDDatePicker * datePicker;
    if ([_vc_type isEqualToString:@"1"]) {
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
                datePicker.date_start = [NSDate dateWithTimeInterval:oneDay sinceDate:end_begain];
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
            [YYLOrder YSOrder].checkin_time = [DDLogin timeStrWithDate:date];

            if ([_vc_type isEqualToString:@"L"]) {
            }else{
                end_begain = date;
            }
        }else{
            _leave_label.text = [NSString stringWithFormat:@" 离 %@",[CDDatePicker getStringFromDate:date]];
            [YYLOrder YSOrder].checkout_time = [DDLogin timeStrWithDate:date];
            end_end = date;
        }
    }//日期选择器的代理方法
}
- (void)viewWillDisappear:(BOOL)animated{
    [ddlist clearCompletionBlock];
    [SVProgressHUD dismiss];
    
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
