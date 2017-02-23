//
//  DDOrder.m
//  HealthySettle
//
//  Created by yrc on 17/2/23.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "DDOrder.h"

@implementation DDOrder{
    NSString * _uid;
    NSString * _login;
    NSString * _o_id;
}
-(id)initWithUid:(NSString *)uid login:(NSString *)login oid:(NSString *)oid {
    self = [super init];
    if (self) {
        _uid = uid;
        if (!login) {
            _login = @"";
        }else{
            _login = login;
        }
        _o_id = oid;
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
                                              @"controller":@"order",
                                              @"uid" : _uid,
                                              @"login" : _login,
                                              @"order_id":_o_id
                                              }]};
}


@end
