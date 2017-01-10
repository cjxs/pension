//
//  TravelResultVController.h
//  HealthySettle
//
//  Created by yrc on 17/1/4.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelResultVController : UIViewController
@property (nonatomic,strong ) UIView      * filter_view;
@property (nonatomic,strong ) UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * data_arr;
@property (nonatomic, strong) NSString    *area_id;


@end
