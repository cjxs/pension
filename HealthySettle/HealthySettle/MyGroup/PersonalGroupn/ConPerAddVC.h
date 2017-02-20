//
//  ConPerAddVC.h
//  HealthySettle
//
//  Created by yrc on 17/2/20.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYLUser;

@interface ConPerAddVC : UIViewController
@property (nonatomic,strong) NSString    * titleName;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIView      * headView;
@property (nonatomic,strong)YYLUser * conPer;
@end
