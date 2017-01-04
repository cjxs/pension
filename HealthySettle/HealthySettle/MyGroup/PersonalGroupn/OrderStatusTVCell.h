//
//  OrderStatusTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/12/8.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderStatusTVCell : UITableViewCell
@property (nonatomic,strong)UILabel * order_sn_label;
@property (nonatomic,strong)UILabel * order_addtime_label;
@property (nonatomic,strong)UILabel * order_balance_money_label;
@property (nonatomic,strong)UILabel * order_status_label;
@property (nonatomic,strong)UILabel * prompt_label;
@end
