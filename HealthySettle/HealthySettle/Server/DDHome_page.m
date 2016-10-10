//
//  DDHome_page.m
//  HealthySettle
//
//  Created by yrc on 16/9/30.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDHome_page.h"

@implementation DDHome_page {
    NSString * _uid;
    BOOL _login;
}
-(id)initWithUid:(NSString *)uid login:(BOOL)login {
    self = [super init];
    if (self ) {
        _uid = uid;
        _login = login;
    }
    return self;
}
-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

// 请求的URL
- (NSString *)requestUrl
{
    return @"/Api.html"; 
}

// 请求的参数列表
-(id)requestArgument
{
    return @ {
        @"controller":@"home_page",
        @"phone" : _uid,
        @"login" : @(_login)
    };
}


@end
