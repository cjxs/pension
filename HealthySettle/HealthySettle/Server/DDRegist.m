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
}
-(id)initWithRegisNumber:(NSString *)number
{
    if ([super init]) {
        _number = number;
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
    return @"http://cswl.5199yl.com/index.php?g=Index&c=Login&a=reg";
}

// 请求的参数列表
-(id)requestArgument
{
    return @ {
        @"phone" : _number,
        @"vfycode" : @"",
        @"tmpid":@"0"
    };
}

@end
