//
//  GraceTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/4/11.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraceTVCell : UITableViewCell {
    UILabel * money_label,*moneyuse_label,*timeFrom_label,*timeTo_label;
}
@property (nonatomic,strong)NSString * money_str,*moneyuse_str;
@property (nonatomic,strong)NSString * timeFrom_str,*timeTo_str;
- (void)configWithMoneystr:(NSString *)money use:(NSString *)use timeF:(NSString *)timeF timeT:(NSString *)timeT;
@end
