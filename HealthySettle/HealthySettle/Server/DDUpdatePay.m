//
//  DDUpdatePay.m
//  HealthySettle
//
//  Created by yrc on 17/3/4.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "DDUpdatePay.h"

@implementation DDUpdatePay{
    NSString * _uid;
    NSString * _login;
    NSString * _pay_type;
    NSString * _pay_time;
    NSString * _order_id;
}
-(id)initWithUid:(NSString *)uid login:(NSString *)login type:(NSString *)type{
    self = [super init];
    if (self) {
        _uid = uid;
        if (!login) {
            _login = @"";
        }else{
            _login = login;
        }
        if (type) {
            _pay_type = type;
        }else{
            _pay_type = @"";
        }
        _pay_time = [DDLogin timeStrWithDate:[NSDate date]];
        _order_id = [Member DefaultUser].pay_id;
    }
    return self;
}
/// Http请求的方法
-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}
-(NSString *)requestUrl {
    return @"/Api.html";
}

// 请求的参数列表
-(id)requestArgument
{
    return @{@"rsa":[DDLogin RSAsignWithdic:@{
                                              @"controller":@"pay_success",
                                              @"uid" : _uid,
                                              @"login" : _login,
                                              @"pay_type":_pay_type,
                                              @"pay_time":_pay_time,
                                              @"order_id":_order_id
                                              }]};
}

@end
