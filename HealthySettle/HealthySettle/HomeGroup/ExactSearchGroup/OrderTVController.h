//
//  OrderTVController.h
//  HealthySettle
//
//  Created by yrc on 16/4/4.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDDatePicker;

@interface Product : NSObject
{
@private
    float     _price;
    NSString *_subject;
    NSString *_body;
    NSString *_orderId;
}

@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *orderId;

@end


@interface OrderTVController : UITableViewController
@property (nonatomic,strong)UIView * tableHeadView;
@property(nonatomic, strong)NSMutableArray *productList;
@property (nonatomic,strong)NSDictionary * group_dic;
@property (nonatomic,strong)NSString * room_index;
@property (nonatomic,strong)NSString * vc_type;
@property (nonatomic,strong) CDDatePicker * datePicker;
@property (nonatomic,strong)NSArray * chargeArray;
@property (nonatomic,strong)NSString * charge_price;
@end
