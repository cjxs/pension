//
//  PayWayTVC.h
//  HealthySettle
//
//  Created by yrc on 16/12/2.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayWayTVC : UITableViewCell
@property (nonatomic,strong)UIImageView * pay_way_imageView;
@property (nonatomic,strong)UILabel * pay_way_label;
@property (nonatomic,strong)UIImageView * select_status_btn;
-(void)configWithimageName:(NSString *)image_name title:(NSString *)title aliPay:(BOOL)ali_pay;

@end
