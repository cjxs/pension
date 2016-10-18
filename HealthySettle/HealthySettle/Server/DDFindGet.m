//
//  DDFindGet.m
//  HealthySettle
//
//  Created by yrc on 16/10/14.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDFindGet.h"

@implementation DDFindGet

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
        @"controller":@"find"
    };
}

@end
