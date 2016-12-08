//
//  SpecialLabelTVC.h
//  HealthySettle
//
//  Created by yrc on 16/12/2.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialLabelTVC : UITableViewCell
-(void)configWithData:(NSArray *)data_arr color:(UIColor *)color font:(UIFont *)font vc_type:(NSString *)type;
@end
