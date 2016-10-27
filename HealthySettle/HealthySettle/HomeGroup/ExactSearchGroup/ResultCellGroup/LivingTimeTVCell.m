//
//  LivingTimeTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/1.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "LivingTimeTVCell.h"
#import "CDDatePicker.h"
@interface LivingTimeTVCell()<HYMDatePickerDelegate>{
    NSDate * end_begain;
    NSDate * end_end;
}

@end

@implementation LivingTimeTVCell
- (void)awakeFromNib
{
    [super awakeFromNib];
    UIView * margin_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, 13)];
    margin_view.backgroundColor =  RGB(242, 242, 242);
    [self addSubview:margin_view];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configTimes{
    if ([YYLOrder YSOrder].checkin_time) {
        self.checkIn_label.text = [NSString stringWithFormat:@" %@",[CDDatePicker getStringFromDate:[YYLOrder YSOrder].checkin_time]];
        end_begain = [YYLOrder YSOrder].checkin_time;
    }else{
        self.checkIn_label.text = [NSString stringWithFormat:@" %@",[CDDatePicker getStringFromDate:[NSDate date]]];
    }
    if ([YYLOrder YSOrder].checkout_time) {
        self.leave_label.text = [NSString stringWithFormat:@" %@",[CDDatePicker getStringFromDate:[YYLOrder YSOrder].checkout_time]];
        end_end = [YYLOrder YSOrder].checkout_time;
    }else {
        self.leave_label.text = @"----------";
    }
    UITapGestureRecognizer * tapChoose_start = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector(pickViewAppear:)];
    tapChoose_start.numberOfTapsRequired = 1;
    _checkIn_label.userInteractionEnabled = YES;
    [_checkIn_label addGestureRecognizer:tapChoose_start];
    UITapGestureRecognizer * tapChoose_end = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(pickViewAppear:)];
    tapChoose_end.numberOfTapsRequired = 1;
    _leave_label.userInteractionEnabled = YES;
    [_leave_label addGestureRecognizer:tapChoose_end];
}


//日期选择器出来
- (void)pickViewAppear:(UITapGestureRecognizer *)tap
{
    BOOL tap_where = tap.view == _checkIn_label?YES:NO;
    CDDatePicker * datePicker;
    if (tap_where) {//入住按钮
        datePicker = [[CDDatePicker alloc] initWithOff_label:_leave_label];
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
        datePicker = [[CDDatePicker alloc] initWithOff_label:_checkIn_label];
        if (end_begain) {
            NSTimeInterval  oneDay = 24*60*60;  //1天的长度
            end_begain = [NSDate dateWithTimeInterval:oneDay sinceDate:end_begain];
            datePicker.date_start = end_begain;
        }
        
    }
    datePicker.delegateDiy = self;
    [datePicker show];
    _datePicker = datePicker;
    
}
-(void)datePickerbtnDownWithDate:(NSDate *)date{
    if (date) {
        if ([_datePicker.type isEqualToString:@"Z"]) {
            _checkIn_label.text = [NSString stringWithFormat:@" %@",[CDDatePicker getStringFromDate:date]];
            [YYLOrder YSOrder].checkin_time = date;
            end_begain = date;
        }else{
            _leave_label.text = [NSString stringWithFormat:@" %@",[CDDatePicker getStringFromDate:date]];
            [YYLOrder YSOrder].checkout_time = date;
            end_end = date;
        }
    }//日期选择器的代理方法
}



@end
