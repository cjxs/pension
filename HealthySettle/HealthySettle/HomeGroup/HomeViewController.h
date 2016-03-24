//
//  HomeViewController.h
//  HealthySettle
//
//  Created by yrc on 16/3/17.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HomeViewController : UIViewController
@property (nonatomic, strong)UITableView * bottomTableV;
@property (nonatomic, strong)UIView * tableHeadView;
@property (nonatomic, strong)UISearchBar * searchWhere;
@property (nonatomic, strong)UITableView * homeTableView;
@end
