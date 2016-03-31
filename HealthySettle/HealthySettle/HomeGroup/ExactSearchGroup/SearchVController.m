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
#import "SearchResultTVController.h"
@interface SearchVController ()<HYMDatePickerDelegate,CDCityPickerDelegate> {
    NSDate * end_begain;
    NSDate * end_end;
}
@property (weak, nonatomic) IBOutlet UIImageView * topImageV;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet UIView *fourthView;
@property (weak, nonatomic) IBOutlet UIView *fivthView;
@property (weak, nonatomic) IBOutlet UIButton *serch_messagebtn;
@property (weak, nonatomic) IBOutlet UIImageView *first_markPic;
@property (weak, nonatomic) IBOutlet UIImageView *second_markPic;
@property (weak, nonatomic) IBOutlet UIImageView *third_markPic;
@property (weak, nonatomic) IBOutlet UIImageView *four_markPic;
@property (weak, nonatomic) IBOutlet UIImageView *fivth_markPic;
@property (weak, nonatomic) IBOutlet UILabel *city_label;
@property (weak, nonatomic) IBOutlet UILabel *sellectOn_label;
@property (weak, nonatomic) IBOutlet UILabel *seletOff_label;
@property (weak, nonatomic) IBOutlet UILabel *nurseChoose_label;
@property (weak, nonatomic) IBOutlet UILabel *nurseTrue_label;
@property (weak, nonatomic) IBOutlet UILabel *position_label;
@property (weak, nonatomic) IBOutlet UILabel *priceAndCity_label;
@property (nonatomic, strong)CDDatePicker * datePicker;
@property (nonatomic, strong)CDCityPicker * city_picker;
@end

@implementation SearchVController
-(void)viewWillAppear:(BOOL)animated {
    [UIApplication sharedApplication].statusBarHidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
      [self.back_btn addTarget:self action:@selector(cancleToRootView) forControlEvents:UIControlEventTouchUpInside];
    [self.serch_messagebtn addTarget:self action:@selector(skipToSearchResultVC) forControlEvents:UIControlEventTouchUpInside];
    if ([_vc_type isEqualToString:@"L"]) {
        [self setBottomPicWithPic:[UIImage imageNamed:@"z_03"] andTitle:@"找。养老院"];
        _third_markPic.image = [UIImage imageNamed:@"z_02"];
        _four_markPic.image = [UIImage imageNamed:@"z_02"];
        _fivth_markPic.image = [UIImage imageNamed:@"z_02"];
        _city_label.text = @"杭州市";
        
        [_sellectOn_label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(45);
        }];
        [_seletOff_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
        }];
        _sellectOn_label.font = [UIFont systemFontOfSize:16];
        _sellectOn_label.text = @"区／县";
        _sellectOn_label.tag = 302;
        _sellectOn_label.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap_Counties = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countiesPickerShowWithGesture:)];
        [_sellectOn_label addGestureRecognizer:tap_Counties];
        tap_Counties.numberOfTapsRequired = 1;
        _seletOff_label.alpha = 0;
        _nurseChoose_label.text = @"护理等级";
        _nurseTrue_label.text = @"全护";
        _position_label.text = @"机构名称／位置";
        _priceAndCity_label.alpha = 1.0;
        _priceAndCity_label.text = @"价格";
        
    }else {
         [self setBottomPicWithPic:[UIImage imageNamed:@"z_02"] andTitle:@"养生。度假"];
        
        _third_markPic.image = [UIImage imageNamed:@"z_03"];
        _four_markPic.image = [UIImage imageNamed:@"z_03"];
        _fivth_markPic.image = [UIImage imageNamed:@"z_03"];
        
        _city_label.text = @"杭州市";
        
        _seletOff_label.alpha = 1.0;
        [self configDateChooseMachine];
        [_sellectOn_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(23);
        }];
        [_seletOff_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(23);
        }];
        
                [_nurseChoose_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(150);
        }];
        _nurseChoose_label.text = @"机构／位置／景点名";
        _nurseTrue_label.text = @"";
        _position_label.text = @"价格";
        _priceAndCity_label.alpha = 0;

    }
    _city_label.userInteractionEnabled = YES;
    _city_label.tag = 301;
    UITapGestureRecognizer * tap_City = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cityPickerShowWithGesture:)];
    [_city_label addGestureRecognizer:tap_City];
    tap_City.numberOfTapsRequired = 1;

}
-(void)configDateChooseMachine {
    _sellectOn_label.userInteractionEnabled = YES;
    NSString * str = [self tringFromDate:nil];
    _sellectOn_label.text = [NSString stringWithFormat:@"%@      入住",str];
    UITapGestureRecognizer * tapChoose_start = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickViewAppear:)];
    tapChoose_start.numberOfTapsRequired = 1;
    [_sellectOn_label addGestureRecognizer:tapChoose_start];
    
    _seletOff_label.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapChoose_end = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickViewAppear:)];
    tapChoose_end.numberOfTapsRequired = 1;
    [_seletOff_label addGestureRecognizer:tapChoose_end];
    _seletOff_label.text = @"－－－－－－     离店";

}
//把date转换成几月几日
- (NSString *)tringFromDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"M月dd日EE"];
    NSMutableString *dateStr;
    if (!date) {
        dateStr = [[formatter stringFromDate:[NSDate date]] mutableCopy];
    }else {
        dateStr = [[formatter stringFromDate:date] mutableCopy];
    }
    return dateStr;
}
//得到该日期的凌晨时间对对应的date
-(NSDate *)getTimeOfNightFromdate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [NSString stringWithFormat:@"%@ 00:00:00",[formatter stringFromDate:date]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *baseDate = [formatter dateFromString:str];
    return baseDate;
}
//日期选择器出来
- (void)pickViewAppear:(UITapGestureRecognizer *)tap {
     CDDatePicker * datePicker = [[CDDatePicker alloc] init];
    if (tap.view.frame.origin.y < 5) {//入住按钮
        datePicker.type = @"Z";
        datePicker.date_start = [self getTimeOfNightFromdate:[NSDate date]];
        if (end_end) {
            NSTimeInterval  timeIn =[end_end timeIntervalSinceDate:datePicker.date_start];
            NSTimeInterval  oneDay = 24*60*60;
            int days = timeIn / oneDay ;
            NSInteger day = days;
            datePicker.choose_day_count = day;
        }
        _seletOff_label.userInteractionEnabled = NO;
    }else {
        _sellectOn_label.userInteractionEnabled = NO;
        if (end_begain) {
            datePicker.type = @"L";
            NSTimeInterval  oneDay = 24*60*60;  //1天的长度
            end_begain = [NSDate dateWithTimeInterval:oneDay sinceDate:end_begain];
            datePicker.date_start = end_begain;
        }
        
    }
    datePicker.delegateDiy = self;
    [datePicker show];
    _datePicker = datePicker;

}

- (void)datePickerBtnDownCancel {
    _sellectOn_label.userInteractionEnabled = YES;
    _seletOff_label.userInteractionEnabled = YES;
    _datePicker = nil;
}
-(void)datePickerbtnDown
{
    _sellectOn_label.userInteractionEnabled = YES;
    _seletOff_label.userInteractionEnabled = YES;
    if ([_datePicker.type isEqualToString:@"Z"]) {
        _sellectOn_label.text = [NSString stringWithFormat:@"%@      入住",[self tringFromDate:_choosingDate]];
    }else if ([_datePicker.type isEqualToString:@"L"]){
        _seletOff_label.text = [NSString stringWithFormat:@"%@      离店",[self tringFromDate:_choosingDate]];
    }
    _datePicker = nil;

}
-(NSDate *)choosingDate {
    if (!_choosingDate) {
        _choosingDate = [NSDate date];
    }
    return _choosingDate;
}
//选择器的代理方法
- (void)currentSelectedDate:(NSDate *)a{
    _choosingDate = a;
    if ([_datePicker.type isEqualToString:@"Z"]) {
        end_begain = a;
    }else if ([_datePicker.type isEqualToString:@"L"]){
        end_end = a;
    }

}
- (void)countiesPickerShowWithGesture:(UITapGestureRecognizer *)ges {
    if (_chosed_cityArray) {
        [self cityPickerShowWithGesture:ges];
    }else {
        
        [self cityPickerShowWithGesture:nil];
    }
}


- (void)cityPickerShowWithGesture:(UITapGestureRecognizer *)ges{
    CDCityPicker * city_picker = [[CDCityPicker alloc] init];
    if (ges.view.tag == 301) {
         city_picker.type = @"S";
    }else if(ges.view.tag == 302){
        city_picker.districtArray = _chosed_cityArray;
    }else {
         city_picker.type = @"S";
    }
    city_picker.delegate = self;
    [city_picker showPickerView];
    _city_picker = city_picker;
}
- (void)currentSelectedName:(NSString *)name Array:(NSArray *)array
{
    if ([_city_picker.type isEqualToString:@"S"]) {
        _chosedCity = name;
        _chosed_cityArray = [NSArray arrayWithArray:array];
    }else {
        _chosed_districtStr = name;
    }
}
-(void)cityPickerBtnDownCancel {
    _city_picker = nil;
}
-(void)cityPickerbtnDown {
    if ([_city_picker.type isEqualToString:@"S"]) {
        _city_label.text = _chosedCity;
        NSLog(@"%@",_chosedCity);
    }else {
        _sellectOn_label.text = _chosed_districtStr;
    }
    _city_picker = nil;
}
//配置上方图片和标题信息
- (void)setBottomPicWithPic:(UIImage *)imageP andTitle:(NSString *)string {
    _topImageV.image = imageP;
    _textLabel.text = string;
}
-(void)cancleToRootView {
    [self.navigationController popToRootViewControllerAnimated:YES];
    for (UIView * view in self.view.subviews) {
//        if (!(view.bounds.size.height ==self.view.bounds.size.height)) {
            [view removeFromSuperview];
//        }
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)skipToSearchResultVC {
    SearchResultTVController * searchResultVC = [[SearchResultTVController alloc] init];
    searchResultVC.vc_type = self.vc_type;
    [self.navigationController pushViewController:searchResultVC animated:YES];
}
-(void)dealloc {
    
}
@end
