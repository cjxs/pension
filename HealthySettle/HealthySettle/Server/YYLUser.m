//
//  YYLUser.m
//  HealthySettle
//
//  Created by yrc on 16/7/12.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "YYLUser.h"
#import "MJExtension.h"

@implementation YYLUser
-(NSString *)description {
  return  [NSString stringWithFormat:@"姓名：%@ 用户手机号：%@ 密码：%@ 支付密码 ： %@ 平台余额： %@  积分 ： %@",self.nickname,self.phone,self.pwd,self.pay_pwd,_now_money,_score_count];
}
@end
