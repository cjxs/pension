//
//  SearchResultTVController.h
//  HealthySettle
//
//  Created by yrc on 16/3/31.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultTVController : UITableViewController
@property (nonatomic, strong)NSString * vc_type;
@property (nonatomic, strong)NSString * searchPlace_name;
@property (nonatomic, strong)UILabel * checkIn_label;
@property (nonatomic, strong)UILabel * leave_label;
@property (nonatomic, strong)UITextField * textField;
@property (nonatomic, strong)UIView * tableHeadView;
//@property (nonatomic, strong)
@end
