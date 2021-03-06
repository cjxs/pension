//
//  SearchVController.m
//  HealthySettle
//
//  Created by yrc on 16/3/22.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "SearchVController.h"
#import "CDDatePicker.h"
#import "CDCityPicker.h"
#import "ResultListVController.h"
#import "FiltView.h"
@interface SearchVController ()<HYMDatePickerDelegate,CDCityPickerDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate> {
    NSDate * end_begain;
    NSDate * end_end;
    UITextField * text_field;
    NSString *price_range;
    NSString * keyword;
}
@property (weak, nonatomic) IBOutlet UIImageView * topImageV;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *fourthView;
@property (weak, nonatomic) IBOutlet UIView *fivthView;
@property (weak, nonatomic) IBOutlet UIButton *serch_messagebtn;
@property (weak, nonatomic) IBOutlet UIImageView *first_markPic;
@property (weak, nonatomic) IBOutlet UIImageView *second_markPic;
@property (weak, nonatomic) IBOutlet UIImageView *four_markPic;
@property (weak, nonatomic) IBOutlet UIImageView *fivth_markPic;
@property (weak, nonatomic) IBOutlet UILabel *city_label;
@property (weak, nonatomic) IBOutlet UILabel *sellectOn_label;
@property (weak, nonatomic) IBOutlet UILabel *seletOff_label;
@property (weak, nonatomic) IBOutlet UILabel *position_label;
@property (nonatomic, strong)CDDatePicker * datePicker;
@property (nonatomic, strong)CDCityPicker * city_picker;
@end

@implementation SearchVController
#pragma mark - LazyLoading
- (UIButton *)back_button
{
    if (_back_button == nil)
    {
        _back_button = [UIButton buttonWithType:UIButtonTypeCustom];
        _back_button.frame = CGRectMake(10, 15, 40, 40);
        [_back_button addTarget:self
                         action:@selector(cancleToRootView)
               forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _back_button;
    
}
- (UIImageView *)back_imageView
{
    if (_back_imageView == nil)
    {
        _back_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 8, 10, 18)];
    }
    return _back_imageView;
}
#pragma mark - auto_view
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self.navigationController.view sendSubviewToBack:self.navigationController.navigationBar];
    // 下个页面准备
    UIBarButtonItem * returnBarButtonItem = [[UIBarButtonItem alloc] init];
    returnBarButtonItem.title = @"";
    [returnBarButtonItem setBackgroundImage:[UIImage imageNamed:@"leftop_r"]
                                   forState:UIControlStateNormal
                                 barMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = returnBarButtonItem;
    [self.serch_messagebtn addTarget:self
                              action:@selector(skipToSearchResultVC)
                    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.back_button];
    [self.back_button addSubview:self.back_imageView];
    
    
    if ([_vc_type isEqualToString:@"1"]) {
        self.back_imageView.image = [UIImage imageNamed:@"black_w"];
        [self setBottomPicWithPic:
         [UIImage imageNamed:@"pension_preview"]
                         andTitle:@"找·养老院"];
        _four_markPic.image  = [UIImage imageNamed:@"search_4_"];
        _fivth_markPic.image = [UIImage imageNamed:@"search_5_"];
        _city_label.text = @"杭州市";
        
        
        text_field = [[UITextField alloc] initWithFrame:CGRectMake(70, 1, screenWide-90, 68)];
        [_seletOff_label removeFromSuperview];
        [_sellectOn_label removeFromSuperview];
        text_field.placeholder = @"机构关键字";
        text_field.delegate = self;
        text_field.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.secondView addSubview:text_field];
        _position_label.text = @"价格";
        [self.fivthView removeFromSuperview];
        
    }else {
        self.back_imageView.image = [UIImage imageNamed:@"leftop_w"];
        [self setBottomPicWithPic:
         [UIImage imageNamed:@"regimen_preview"]
                         andTitle:@"候鸟基地"];
        _four_markPic.image = [UIImage imageNamed:@"search_4_"];
        _fivth_markPic.image = [UIImage imageNamed:@"search_5_"];
        _city_label.text = @"杭州市";
        
        _seletOff_label.alpha = 1.0;
        [self configDateChooseMachine];
        [_sellectOn_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(35);
        }];
        [_seletOff_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(35);
        }];
        
        _position_label.text = @"价格";
        NSArray * array = @[@"三亚",@"厦门",@"青岛",@"海口",@"巴马",@"桂林"];
        for (int i = 0; i < array.count; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(70 + 50*i, 8, 40, 25);
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button setTitleColor:RGB(248, 69, 69) forState:UIControlStateNormal];
            button.tag = 900+i;
            [button addTarget:self action:@selector(skipToCityWithButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.fivthView addSubview:button];
        }
        
        
    }
    _position_label.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap_pri = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(priceViewAppear)];
    tap_pri.numberOfTapsRequired = 1;
    [_position_label addGestureRecognizer:tap_pri];
    
    _city_label.userInteractionEnabled = YES;
    _city_label.tag = 301;
    UITapGestureRecognizer * tap_City = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(cityPickerShowWithGesture:)];
    [_city_label addGestureRecognizer:tap_City];
    tap_City.numberOfTapsRequired = 1;
    self.serch_messagebtn.clipsToBounds = YES;
    self.serch_messagebtn.layer.cornerRadius = 5;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    keyword = text_field.text;
}

-(void)priceViewAppear{
    FiltView * timefilt_view = [[FiltView alloc] init];
    if ([_vc_type intValue] == 1) {
        timefilt_view.data_arr1 = @[@"5000元/月 以上",@"3000-5000元/月",@"2000-3000元/月",@"1000-2000元/月",@"1000元/月 以下"];
    }else{
        timefilt_view.data_arr1 = @[@"150元/天 以下",@"150－300元/天",@"300-450元/天",@"450-600元/天",@"600元/月 以上"];

    }
    timefilt_view.viewType = DDNormalView;
    timefilt_view.listType = DDListTYpeSingle;
    timefilt_view.selectType = DDSelectTYpeSingle;
    @weakify(timefilt_view);
    timefilt_view.sureBtn = ^(NSString * str){
        @strongify(timefilt_view);
        if (str.length ==0) {
            price_range = @"";
            _position_label.text = @"价格";
        }else{
            NSString *str_ = timefilt_view.data_arr1[str.intValue];
            _position_label.text = str_;
            
            NSArray * str_arr;
            if ([_vc_type intValue] == 1) {
                str_arr = [str_ componentsSeparatedByString:@"元/月"];
            }else{
                str_arr = [str_ componentsSeparatedByString:@"元/天"];
            }
            if ([str_arr.firstObject length] < 5) {
                if ([str_arr.firstObject intValue] == 5000||[str_arr.firstObject intValue] == 600) {
                    price_range = [NSString stringWithFormat:@"%@-10000",str_arr.firstObject];
                }else if ([str_arr.firstObject intValue] == 1000||[str_arr.firstObject intValue] ==150){
                    price_range = [NSString stringWithFormat:@"0-%@",str_arr.firstObject];
                }
            }else{
                price_range = str_arr.firstObject;
            }

        }
    };

    [timefilt_view addFirstView];
    
    [UIView animateWithDuration:0.5f animations:^{
        [self.view addSubview:timefilt_view];
    }];
    
}
-(void)skipToCityWithButton:(UIButton *)btn{
    NSArray * array = @[@"807",@"303",@"2268",@"789",@"3515",@"617"];
    ResultListVController * ResultLVC = [[ResultListVController alloc] init];
    ResultLVC.vc_type = self.vc_type;
    ResultLVC.area_id = array[btn.tag-900];
    ResultLVC.title_l = btn.titleLabel.text;
    if (price_range) {
        ResultLVC.priceRange = price_range;
    }
    [self.navigationController pushViewController:ResultLVC
                                         animated:YES];

    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - DateChoose,CityChoose
-(void)configDateChooseMachine
{
    _sellectOn_label.userInteractionEnabled = YES;
    NSString * str = [CDDatePicker getStringFromDate:nil];
    _sellectOn_label.text = [NSString stringWithFormat:@"%@     入住",str];
    UITapGestureRecognizer * tapChoose_start = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector(pickViewAppear:)];
    tapChoose_start.numberOfTapsRequired = 1;
    [_sellectOn_label addGestureRecognizer:tapChoose_start];
    
    _seletOff_label.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapChoose_end = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(pickViewAppear:)];
    tapChoose_end.numberOfTapsRequired = 1;
    [_seletOff_label addGestureRecognizer:tapChoose_end];
    _seletOff_label.text = @"－－－－      离店";

}

//日期选择器出来
- (void)pickViewAppear:(UITapGestureRecognizer *)tap
{
    CDDatePicker * datePicker;
    if (tap.view.frame.origin.y < 5) {//入住按钮
        datePicker = [[CDDatePicker alloc] initWithOff_label:_seletOff_label];
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
        datePicker = [[CDDatePicker alloc] initWithOff_label:_sellectOn_label];
        if (end_begain) {
            NSTimeInterval  oneDay = 24*60*60;  //1天的长度
            datePicker.date_start = [NSDate dateWithTimeInterval:oneDay sinceDate:end_begain];
        }
        
    }
    datePicker.delegateDiy = self;
    [datePicker show];
    _datePicker = datePicker;

}
-(void)datePickerbtnDownWithDate:(NSDate *)date{
    if (date) {
        if ([_datePicker.type isEqualToString:@"Z"]) {
            _sellectOn_label.text = [NSString stringWithFormat:@"%@      入住",[CDDatePicker getStringFromDate:date]];
            [YYLOrder YSOrder].checkin_time = [DDLogin timeStrWithDate:date];;
            end_begain = date;
        }else{
            _seletOff_label.text = [NSString stringWithFormat:@"%@      离店",[CDDatePicker getStringFromDate:date]];
            [YYLOrder YSOrder].checkout_time = [DDLogin timeStrWithDate:date];;
            end_end = date;
        }
    }//日期选择器的代理方法
}







- (void)countiesPickerShowWithGesture:(UITapGestureRecognizer *)ges
{
    if (_chosed_cityArray) {
        [self cityPickerShowWithGesture:ges];
    }else {
        
        [self cityPickerShowWithGesture:nil];
    }
}


- (void)cityPickerShowWithGesture:(UITapGestureRecognizer *)ges
{
    CDCityPicker * city_picker = [CDCityPicker currentCity];
    if (ges.view.tag == 301) {
         city_picker.type = @"2";
    }else if(ges.view.tag == 302){
        city_picker.districtArray = _chosed_cityArray;
    }else {
         city_picker.type = @"2";
    }
    city_picker.delegate = self;
    [city_picker showPickerView];
    _city_picker = city_picker;
}
- (void)currentSelectedName:(NSString *)name code:(NSString *)code Array:(NSArray *)array{
    if ([_city_picker.type isEqualToString:@"2"]) {
        _chosedCity = name;
        _chosed_code = code;
        _chosed_cityArray = [NSArray arrayWithArray:array];
    }else {
        _chosed_districtStr = name;
    }

}
-(void)cityPickerBtnDownCancel
{
    _city_picker = nil;
}
-(void)cityPickerbtnDown
{
    if ([_city_picker.type isEqualToString:@"2"]) {
        _city_label.text = _chosedCity;
    }else {
        _sellectOn_label.text = _chosed_districtStr;
    }
    _city_picker = nil;
}
//配置上方图片和标题信息
- (void)setBottomPicWithPic:(UIImage *)imageP
                   andTitle:(NSString *)string
{
    _topImageV.image = imageP;
    if (string) {
        _textLabel.text = string;
        _textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [text_field resignFirstResponder];
}
#pragma mark - VTOF
-(void)cancleToRootView
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    for (UIView * view in self.view.subviews) {
//        if (!(view.bounds.size.height ==self.view.bounds.size.height)) {
            [view removeFromSuperview];
//        }
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
-(void)skipToSearchResultVC
{
    ResultListVController * ResultLVC = [[ResultListVController alloc] init];
    ResultLVC.vc_type = self.vc_type;
    if (!_chosed_code) {
        ResultLVC.area_id = @"3134";
    }else{
        ResultLVC.area_id = _chosed_code;
    }
    if (!_chosedCity) {
        ResultLVC.title_l = @"杭州";
    }else{
        ResultLVC.title_l = _chosedCity;
    }
    if (price_range) {
        ResultLVC.priceRange = price_range;
    }
    if (keyword) {
        ResultLVC.keyword = keyword;
    }

    [self.navigationController pushViewController:ResultLVC
                                animated:YES];
}

@end
