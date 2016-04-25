//
//  CDDatePicker.h
//  HealthySettle
//
//  Created by yrc on 16/3/24.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HYMDatePickerDelegate;
@interface CDDatePicker : UIView
@property (weak, nonatomic) id<HYMDatePickerDelegate> delegateDiy;
//已选择时间
@property (strong, nonatomic) NSString *day;
@property (strong, nonatomic) NSString *hour;
@property (strong, nonatomic) NSString *minute;
@property (strong,nonatomic)NSDate * date_start;
@property (assign,nonatomic)NSInteger choose_day_count;
@property (strong ,nonatomic)NSString * type;
@property (nonatomic, strong)UIView * titleView;
@property (strong,nonatomic)UIPickerView * pick_view;
@property (strong, nonatomic) NSArray *dataSourceForDayComponent;
- (void)show ;
@end

@protocol HYMDatePickerDelegate <NSObject>
@optional
- (void)currentSelectedDate:(NSDate *)a;
-(void)datePickerBtnDownCancel;
-(void)datePickerbtnDown;
@end

