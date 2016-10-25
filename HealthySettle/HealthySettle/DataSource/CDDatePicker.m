//
//  CDDatePicker.m
//  HealthySettle
//
//  Created by yrc on 16/3/24.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "CDDatePicker.h"
#define CHOOSE_DAY_COUNT 365 //可选时间天数

@interface HYMDatePicker : UIView<UIPickerViewDataSource,UIPickerViewDelegate>//pickerView数据源

@end


@implementation CDDatePicker

-(UIView *)titleView
{
    if (_titleView!=nil) {
        return _titleView;
    }
    CGFloat size_h;
    if (IS_IPHONE5) {
        size_h = 2.8;
    }else{
        size_h = 3;
    }
    CGRect rect;
    rect.origin.x = kMargin;
    rect.origin.y = screenHeight /size_h ;
    rect.size.width = screenWide - kMargin *2 ;
    rect.size.height = kMargin * 4;
    _titleView = [[UIView alloc] initWithFrame:rect];
    _titleView.backgroundColor = RGB(249, 249, 249);
    _titleView.layer.cornerRadius = kMargin;
    
    UIButton * quxiaobtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quxiaobtn.frame = CGRectMake(5, rect.size.height* 0.2, 55,CGRectGetHeight(_titleView.frame) * 0.6 );
    quxiaobtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [quxiaobtn setTitle:@"取消" forState:UIControlStateNormal];
    [quxiaobtn setTitleColor:ALLGRAYCOLOR forState:UIControlStateNormal];
    quxiaobtn.backgroundColor = [UIColor clearColor];
    quxiaobtn.layer.cornerRadius = 5;
    
    [quxiaobtn addTarget:self action:@selector(datePickerBtnDownCancel) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:quxiaobtn];
    [_titleView bringSubviewToFront:quxiaobtn];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(screenWide - 2 * kMargin-60, rect.size.height* 0.2, 55, CGRectGetHeight(_titleView.frame)* 0.6);
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:ALLOrangeCOLOR forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(datePickerbtnDown) forControlEvents:UIControlEventTouchUpInside];
    
    [_titleView addSubview:btn];
    
    [_titleView bringSubviewToFront:btn];
    
    
    return _titleView;
}

- (void)show {
    CGFloat size_h;
    if (IS_IPHONE5) {
        size_h = 2.8;
    }else{
        size_h = 3;
    }
    UIWindow * window = [UIApplication  sharedApplication].keyWindow;
    [window addSubview:self];
    [window addSubview:self.pick_view];
    [window addSubview:self.titleView];
    if (_off_label) {
        _off_label.userInteractionEnabled = NO;
    }
}
-(instancetype)initWithOff_label:(UILabel *)label {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.alpha = 0.3;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(datePickerbtnDown)];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
        _off_label = label;
    }
    return self;
}
- (UIPickerView *)pick_view {
    if (!_pick_view) {
        UIPickerView * pick_view = [[UIPickerView alloc] init];
        pick_view.backgroundColor = RGB(252, 252, 252);
        pick_view.frame = [self getMainViewFrame];
        pick_view.clipsToBounds = YES;
        pick_view.dataSource = self;
        pick_view.delegate = self;
        pick_view.layer.cornerRadius = kMargin;
        _pick_view = pick_view;
    }
    return _pick_view;
}

-(CGRect)getMainViewFrame
{
    CGFloat size_h;
    if (IS_IPHONE5) {
        size_h = 2.8;
    }else{
        size_h = 3;
    }

    CGRect rect = self.frame;
    rect.origin.x = kMargin;
    rect.origin.y = screenHeight /size_h;
    rect.size.width = screenWide - kMargin *2;
    rect.size.height = screenHeight /size_h;
    return rect;
}


#pragma mark - 初始化
- (NSString *)day{
    if(!_day){
        if(self.hour.length > 0)
            _day = self.dataSourceForDayComponent[0];
    }
    return _day;
}
- (NSString *)hour{
    if(!_hour){
        _hour = @"12时";
    }
    return _hour;
}
- (NSString *)minute{
    if(!_minute){
        _minute = @"00分";
    }
    return _minute;
}
- (NSDate *)date_start {
    if (!_date_start) {
        _date_start = [NSDate date];
    }
    return _date_start;
}
- (NSInteger )choose_day_count {
    if (!_choose_day_count) {
        _choose_day_count = 365;
    }
    return _choose_day_count;
}
- (NSArray *)dataSourceForDayComponent{
    if(!_dataSourceForDayComponent){
        NSMutableArray *arr = [NSMutableArray array];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *str = [NSString stringWithFormat:@"%@ 00:00:00",[formatter stringFromDate:self.date_start]];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *baseDate = [formatter dateFromString:str];
        
        for (NSInteger i = 0; i < self.choose_day_count; i++) {
            NSDate *date = [NSDate dateWithTimeInterval:24*60*60*i sinceDate:baseDate];
            [formatter setDateFormat:@"M月dd日EE"];
            NSMutableString *dateStr = [[formatter stringFromDate:date] mutableCopy];
            
            [arr addObject:dateStr];
            
        }
        _dataSourceForDayComponent = [arr copy];
    }
    return _dataSourceForDayComponent;
}

#pragma mark - UIPickerViewDataSource,UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.dataSourceForDayComponent.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return self.dataSourceForDayComponent[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.day = self.dataSourceForDayComponent[row];
    [self selectedDate];
    
}
- (void)selectedDate{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy年"];
    NSString *str = [formatter stringFromDate:self.date_start];
    
    NSString *dateStr = [NSString stringWithFormat:@"%@%@ %@%@",str,self.day,self.hour,self.minute];
    
    
    [formatter setDateFormat:@"yyyy年MM月dd日EE HH时mm分"];
    _current_date = [formatter dateFromString:dateStr];
    
    if ([_current_date timeIntervalSince1970] < [_date_start timeIntervalSince1970]) {
        NSTimeInterval  oneYear = 365 *24*60*60;  //1年的长度
        _current_date = [_current_date initWithTimeIntervalSinceNow: +oneYear ];
        
    }//下一年的时候加一年
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return [UIScreen mainScreen].bounds.size.width*0.5;
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return screenHeight * 0.08;
}

-(void)datePickerBtnDownCancel {
    [self dismiss];
}
-(void)datePickerbtnDown {
    [self dismiss];
    if(self.delegateDiy && [self.delegateDiy respondsToSelector:@selector(datePickerbtnDownWithDate:)]&& _current_date){
        [self.delegateDiy datePickerbtnDownWithDate:_current_date];
    }
}
- (void)dismiss {
    [self removeFromSuperview];
    [_titleView removeFromSuperview];
    _titleView = nil;
    [_pick_view removeFromSuperview];
    _pick_view = nil;
    _off_label.userInteractionEnabled = YES;

}
//得到该日期的凌晨时间对对应的date
+(NSDate *)getTimeOfNightFromdate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [NSString stringWithFormat:@"%@ 00:00:00",[formatter stringFromDate:date]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *baseDate = [formatter dateFromString:str];
    return baseDate;
}
//把date转换成几月几日
+ (NSString *)getStringFromDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"M月dd日"];
    NSMutableString *dateStr;
    if (!date) {
        dateStr = [[formatter stringFromDate:[NSDate date]] mutableCopy];
    }else {
        dateStr = [[formatter stringFromDate:date] mutableCopy];
    }
    return dateStr;
}



@end
