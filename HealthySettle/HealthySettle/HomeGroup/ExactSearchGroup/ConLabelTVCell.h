//
//  ConLabelTVCell.h
//  HealthySettle
//
//  Created by yrc on 17/2/14.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConLabelTVCell : UITableViewCell
@property (nonatomic,strong)UILabel * name_label;
@property (nonatomic,strong)UILabel * phone_label;
-(void)configWithname:(NSString *)name number:(NSString *)number;
@end
