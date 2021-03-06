//
//  YYLOrder.h
//  HealthySettle
//
//  Created by yrc on 16/7/14.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYLOrder : NSObject
@property (nonatomic,strong)NSString * order_id;
@property (nonatomic,strong)NSString * order_sn;
@property (nonatomic,strong)NSString * order_name;
@property (nonatomic,strong)NSString * group_date;
@property (nonatomic,strong)NSString * group_id;         //机构id
@property (nonatomic,strong)NSString * cat_id;           //类别
@property (nonatomic,strong)NSString * lived_num;       //数量
@property (nonatomic,strong)NSString * num;
@property (nonatomic,strong)NSString * total_money;     //总金额
@property (nonatomic,strong)NSString * subsidy_money_m;   //机构补贴
@property (nonatomic,strong)NSString * subsidy_money_u;   //用户补贴
@property (nonatomic,strong)NSString * money_score;       //积分兑换
@property (nonatomic,strong)NSString * contact_name;      //联系人姓名
@property (nonatomic,strong)NSString * contact_phone;     //联系人电话
@property (nonatomic,strong)NSString * card_id;          //优惠券ID
@property (nonatomic,strong)NSString * wx_cheap;         //微信优惠
@property (nonatomic,strong)NSString * balance_pay;     //余额支付金额
@property (nonatomic,strong)NSString * payment_money;   //在线支付金额
@property (nonatomic,strong)NSString * add_time;   //下单时间
@property (nonatomic,strong)NSString * pay_time;     //支付时间
@property (nonatomic,strong)NSString * pay_type;       //支付方式
@property (nonatomic,strong)NSString * third_id;      //三房id
@property (nonatomic,strong)NSString * is_mobile_pay;    //是否是移动端支付
@property (nonatomic,strong)NSString * paid;           //是否支付
@property (nonatomic,strong)NSString * status;       //订单状态
@property (nonatomic,strong)NSString * checkin_time;   //入住时间
@property (nonatomic,strong)NSString * checkout_time;  //退房时间
@property (nonatomic,strong)NSString * beds;           //床位数 （养老专用）
@property (nonatomic,strong)NSString * checkin_name;    //入住人信息
@property (nonatomic,strong)NSString * room_id;         //房型ID （养生专用）
@property (nonatomic,strong)NSArray * order_spec;       //订单信息
@property (nonatomic,strong)NSString * coupon; //使用抵用券



+(YYLOrder *)YSOrder;
+(YYLOrder *)PreOrder;



@end
