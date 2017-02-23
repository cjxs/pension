//
//  OrderStatusTVController.h
//  HealthySettle
//
//  Created by yrc on 17/2/14.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Order_ed;

@interface OrderStatusTVController : UIViewController
@property (nonatomic,strong)UIView * tableHeadView;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSString * vc_type;
@property (nonatomic,strong)NSString *o_id;
@property (nonatomic,strong)Order_ed * order;


@end
