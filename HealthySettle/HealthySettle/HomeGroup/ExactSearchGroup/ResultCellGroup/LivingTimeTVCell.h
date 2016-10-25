//
//  LivingTimeTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/4/1.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDDatePicker;

@interface LivingTimeTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leave_label;
@property (weak, nonatomic) IBOutlet UILabel *checkIn_label;
@property (nonatomic,strong) CDDatePicker * datePicker;

-(void)configTimes;
@end
