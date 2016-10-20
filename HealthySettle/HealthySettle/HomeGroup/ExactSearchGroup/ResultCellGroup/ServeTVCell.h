//
//  ServeTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/4/3.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServeTVCell : UITableViewCell
@property (nonatomic, strong) UIView * commonServe_view;
@property (nonatomic,strong ) UIView * tollServe_view;
@property (nonatomic,strong)NSString * common_t;
@property (nonatomic,strong)NSString * charge_t;
-(void)configwithCommon:(NSString *)common charge:(NSString *)charge;
@end
