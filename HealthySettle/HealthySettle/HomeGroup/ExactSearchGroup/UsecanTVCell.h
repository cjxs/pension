//
//  ;
//  HealthySettle
//
//  Created by yrc on 17/2/13.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsecanTVCell : UITableViewCell
@property (nonatomic,strong)UILabel * cash_use_label;
@property (nonatomic,strong)UILabel * dis_count_label;
@property (nonatomic,strong)UISwitch * cash_switch_btn;
@property (nonatomic,strong)UISwitch *dis_count_switch_btn;
-(void)configWithCash:(NSString *)cash dis_count:(NSString *)dis_count cashUse:(BOOL )cashuse dis_countUse:(BOOL)dis_countUse;
@end
