//
//  Order_ed.h
//  HealthySettle
//
//  Created by yrc on 16/10/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order_ed : NSObject
@property(nonatomic,strong)NSString * order_sn;
@property (nonatomic,strong)NSString * order_name;
@property (nonatomic,strong)NSString * price;
@property (nonatomic,strong)NSString * subsidy_money_u;
@property (nonatomic,strong)NSString * cat_id,*pic,*add_time,*address,*group_id,*order_spec,*paid,*status;
@property (nonatomic,strong)NSString * dd_status;





//"order_sn":"YL147001716341","order_name":"优悠乐养老院","price":"1400.00","subsidy_money_u":"50.00","cat_id":"1","pic":null,"add_time":"1468465200","group_id":"587","order_spec":"str","paid":"0","status":"13"
@end
