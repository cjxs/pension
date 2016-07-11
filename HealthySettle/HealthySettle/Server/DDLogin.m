//
//  DDLogin.m
//  HealthySettle
//
//  Created by yrc on 16/7/11.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDLogin.h"

@implementation DDLogin
{
    NSString * _username;
    NSString * _password;
}
-(id)initWithUsername:(NSString *)username
             password:(NSString *)password
{
    self = [super init];
    if (self)
    {
        _username = username;
        _password = password;
    }
    return self;
}

/// Http请求的方法
-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

// 请求的URL
- (NSString *)requestUrl
{
    return @"http://www.5199yl.com/index.php?g=Index&c=Login&a=index";
}

// 请求的参数列表
-(id)requestArgument
{
    return @ {
        @"phone" : _username,
        @"pwd" : _password,
        @"aotulogin":@"1"
    };
}

@end
