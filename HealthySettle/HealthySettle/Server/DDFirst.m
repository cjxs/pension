//
//  DDFirst.m
//  HealthySettle
//
//  Created by yrc on 16/7/14.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDFirst.h"

@implementation DDFirst {
    NSString * _uid;
    BOOL _login;
}
-(id)initWithUid:(NSString *)uid login:(BOOL)login {
    self = [super init];
    if (self) {
        _uid = uid;
        _login = login;
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
    return @ {
        @"controller":@"getdata",
        @"uid" : _uid,
        @"login" : @(_login)
    };
}
@end
