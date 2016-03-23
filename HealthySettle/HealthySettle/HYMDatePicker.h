//
//  HYMDatePicker.h
//  HYMDatePicker
//
//  Created by 我家有福 on 16/3/10.
//  Copyright © 2016年 我家有福. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HYMDatePickerDelegate;
@interface HYMDatePicker : UIPickerView
@property (strong, nonatomic) id<HYMDatePickerDelegate> delegateDiy;
//已选择时间
@property (strong, nonatomic) NSString *day;
@property (strong, nonatomic) NSString *hour;
@property (strong, nonatomic) NSString *minute;
@property (strong,nonatomic)NSDate * date_start;
@property (assign,nonatomic)NSInteger choose_day_count;
@property (strong ,nonatomic)NSString * type;

@end

@protocol HYMDatePickerDelegate <NSObject>
@optional
- (void)currentSelectedDate:(NSDate *)a;
@end