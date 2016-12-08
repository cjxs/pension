//
//  CashStatusTVC.h
//  HealthySettle
//
//  Created by yrc on 16/12/6.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashStatusTVC : UITableViewCell
@property (nonatomic,strong)UILabel * cash_label;
@property (nonatomic,strong)UILabel * cash_use_label;
@property (nonatomic,strong)UISwitch * cash_switch_btn;
@property (nonatomic,strong)UITextField * cash_use_field;
-(void)configWithUse:(BOOL )use;
@end
