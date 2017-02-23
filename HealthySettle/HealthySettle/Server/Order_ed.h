//
//  Order_ed.h
//  HealthySettle
//
//  Created by yrc on 16/10/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order_ed : NSObject
@property(nonatomic,strong)NSString * order_sn,*order_id,*cat_id;
@property (nonatomic,strong)NSString * order_name,*total_money,*balance_pay,*coupon,*payment_money;
@property (nonatomic,strong)NSString * pay_type,*paid,*status,*add_time,*price,*checkin_name,*contact_name,*contact_phone;
@property (nonatomic,strong)NSString *lived_num,*num,*beds,*order_spec,*group_date,*area_name,*pic,*checkin_time,*checkout_time;
@property (nonatomic,strong)NSString * dd_status;





//"order_sn":"YL147001716341","order_name":"优悠乐养老院","price":"1400.00","subsidy_money_u":"50.00","cat_id":"1","pic":null,"add_time":"1468465200","group_id":"587","order_spec":"str","paid":"0","status":"13"
@end
