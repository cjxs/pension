//
//  PayViewController.h
//  HealthySettle
//
//  Created by yrc on 16/11/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Order_ed;

@interface PayViewController : UIViewController
@property (nonatomic,strong)NSString * vc_type;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)YYLOrder * order;
@property (nonatomic,strong)Order_ed * order_ed;

@end
