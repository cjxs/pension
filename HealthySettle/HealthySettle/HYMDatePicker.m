//
//  HYMDatePicker.m
//  HYMDatePicker
//
//  Created by 我家有福 on 16/3/10.
//  Copyright © 2016年 我家有福. All rights reserved.
//

#import "HYMDatePicker.h"

#define CHOOSE_DAY_COUNT 365 //可选时间天数


@interface HYMDatePicker ()<UIPickerViewDataSource,UIPickerViewDelegate>
//pickerView数据源
@property (strong, nonatomic) NSArray *dataSourceForDayComponent;
@end

@implementation HYMDatePicker


- (instancetype)init{
    self = [super init];
    if(self){
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = PINKCOLOR;
    }
    return self;
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
    NSDate *date = [formatter dateFromString:dateStr];
    
    if ([date timeIntervalSince1970] < [_date_start timeIntervalSince1970]) {
        NSTimeInterval  oneYear = 365 *24*60*60;  //1年的长度
        date = [date initWithTimeIntervalSinceNow: +oneYear ];
        
    }//下一年的时候加一年
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if(self.delegateDiy && [self.delegateDiy respondsToSelector:@selector(currentSelectedDate:)]){
        [self.delegateDiy currentSelectedDate:date];
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
   
    return [UIScreen mainScreen].bounds.size.width*0.5;
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
