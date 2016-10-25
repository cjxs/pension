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
@property (strong, nonatomic) NSString     *day;
@property (strong, nonatomic) NSString     *hour;
@property (strong, nonatomic) NSString     *minute;
@property (strong,nonatomic ) NSDate       * date_start;
@property (assign,nonatomic ) NSInteger    choose_day_count;
@property (strong ,nonatomic) NSString     * type;
@property (nonatomic, strong) UIView       * titleView;
@property (strong,nonatomic ) UIPickerView * pick_view;
@property (strong, nonatomic) NSArray      *dataSourceForDayComponent;
@property (strong,nonatomic)  NSDate *current_date;
@property (nonatomic,strong) UILabel * off_label;
- (void)show ;
-(instancetype)initWithOff_label:(UILabel *)label;
+(NSDate *)getTimeOfNightFromdate:(NSDate *)date;
+(NSString *)getStringFromDate:(NSDate *)date;
@end

@protocol HYMDatePickerDelegate <NSObject>
@optional
-(void)datePickerbtnDownWithDate:(NSDate *)date;
@end

