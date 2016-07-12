//
//  OrderBtnTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/4/4.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderBtnTVCell : UITableViewCell
@property (nonatomic,strong) UILabel  * title_label;
@property (nonatomic,strong) UISwitch * switch_btn;
-(void)configWithtitle:(NSString *)title text:(NSString *)text next:(BOOL)next;
@end
