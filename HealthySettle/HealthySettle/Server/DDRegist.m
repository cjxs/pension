//
//  DDRegist.m
//  HealthySettle
//
//  Created by yrc on 16/7/13.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDRegist.h"

@implementation DDRegist {
    NSString * _number;
    NSString * _vfycode;
    NSString * _pwd;
}
-(id)initWithRegisNumber:(NSString *)number pwd:(NSString *)pwd vfycode: (NSString *)vfycode
{
    if ([super init]) {
        _number = number;
        _pwd = pwd;
        _vfycode = vfycode;
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
    return @{@"rsa":[DDLogin RSAsignWithdic:@{
                                              @"controller":@"reg",
                                              @"phone" : _number,
                                              @"code" : _vfycode,
                                              @"pwd":_pwd
                                              }]};
}

@end
