//
//  RefundViewController.h
//  HealthySettle
//
//  Created by yrc on 16/3/30.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefundViewController : UIViewController
@property (nonatomic, strong) NSString    * titleName;
@property (nonatomic, strong) NSString    * type;
@property (nonatomic, strong) UIView      * tableHeadView;
@property (nonatomic, strong) UITableView * tableView;
@end
