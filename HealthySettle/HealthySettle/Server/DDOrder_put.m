//
//  DDOrder_put.m
//  HealthySettle
//
//  Created by yrc on 17/2/16.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "DDOrder_put.h"
#import "RSAEncryptor.h"
#import "YYLOrder.h"


@implementation DDOrder_put{
    NSString * _uid;
    NSString * _login;
    NSDictionary* _data;
}
-(id)initWithUid:(NSString *)uid login:(NSString *)login data:(YYLOrder *)data{
    self = [super init];
    if (self)
    {
        _uid = uid;
        _login = login;
//        for (NSString * str in data.mj_keyValues) {
//            NSLog(@"%@",str);
//
//        }
        _data = data.mj_keyValues;
        
    }
    return self;

    
}
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
                                              @"login" : _login,
                                              @"controller":@"order_put",
                                              @"data":_data,
                                              @"uid" : _uid
                                              }]};
}
@end
