//
//  TravelDetailVController.h
//  HealthySettle
//
//  Created by yrc on 17/1/5.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelDetailVController : UIViewController{
    int person_num;
    int order;
}
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIView * tableHeadView;
@property (nonatomic,strong)NSString * group_id;
@property (nonatomic,strong)NSDictionary * data_dic;
@property (nonatomic,strong)NSMutableArray * date_arr;
@property (nonatomic,strong)NSMutableArray * price_arr;
@property (nonatomic,strong)NSMutableArray * number_arr;



@end
