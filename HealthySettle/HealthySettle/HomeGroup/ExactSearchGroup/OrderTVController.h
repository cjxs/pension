//
//  OrderTVController.h
//  HealthySettle
//
//  Created by yrc on 16/4/4.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDDatePicker,PPNumberButton;

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
@property (nonatomic,strong)NSDictionary * group_dic;//商家信息
@property (nonatomic,strong)NSString * gid;//商家id
@property (nonatomic,strong)NSString * room_index;//房间id
@property (nonatomic,strong)NSString * vc_type;//类型
@property (nonatomic,strong) CDDatePicker * datePicker;
@property (nonatomic,strong)NSArray * chargeArray; //养老单价说明
@property (nonatomic,strong)NSString * charge_price;//单价
@property (nonatomic,assign)NSInteger  person_num;//人数
@property (nonatomic,strong)PPNumberButton * number_btn;
@property (nonatomic,strong)NSString *number_sum;
@property (nonatomic,strong)NSString * balance_can;
@property (nonatomic,strong)NSString * dis_count_can;
@property (nonatomic,strong)NSString * unpaid_money;
@property (nonatomic,strong)UILabel * money_label;


@end
