//
//  GroupDetailViewController.h
//  HealthySettle
//
//  Created by yrc on 16/10/19.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupDetailViewController : UIViewController
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic, strong) NSString * vc_type;
@property (nonatomic,strong ) UIView   * tableHeadView;
@property (nonatomic,strong)NSString * group_id;
@property (nonatomic,strong)NSDictionary * data_dic;

@end
