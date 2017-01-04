//
//  PerOrderDetailVC.h
//  HealthySettle
//
//  Created by yrc on 16/12/8.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Order_ed;

@interface PerOrderDetailVC : UIViewController
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)Order_ed * order;

@end
