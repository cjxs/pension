//
//  DDFindTest.m
//  HealthySettle
//
//  Created by yrc on 16/7/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDFindTest.h"

@implementation DDFindTest{
    NSString * _number;
}
-(id)initWithUserNumber:(NSString *)number
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
    return @"/index.php?g=Index&c=Login&a=Generate";
}

// 请求的参数列表
-(id)requestArgument
{
    return @{
          @"phone" : _number,
          @"vfycode" : @"",//验证的种类
          @"tmpid":@"0"
          };
}


@end
