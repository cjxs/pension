//
//  ResultListVController.h
//  HealthySettle
//
//  Created by yrc on 16/4/9.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDDatePicker;

@interface ResultListVController : UIViewController
@property (nonatomic,strong)NSString * tab_show;
@property (nonatomic, strong) NSString    * vc_type; 
@property (nonatomic, strong) NSString    *area_id;
@property (nonatomic,strong)  NSString    * title_l;
@property (nonatomic, strong) NSString    * searchPlace_name;
@property (nonatomic, strong) UILabel     * checkIn_label;
@property (nonatomic, strong) UILabel     * leave_label;
@property (nonatomic, strong) UITextField * textField;
@property (nonatomic, strong) UIView      * tableHeadView;
@property (nonatomic,strong ) UIView      * filter_view;
@property (nonatomic,strong ) UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * data_arr;
@property (nonatomic, strong)CDDatePicker * datePicker;

@end
