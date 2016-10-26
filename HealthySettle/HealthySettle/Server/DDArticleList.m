//
//  DDArticleList.m
//  HealthySettle
//
//  Created by yrc on 16/10/26.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDArticleList.h"

@implementation DDArticleList
{
    NSString * _type;
}
-(id)initWithtype:(NSString *)type  {
    self = [super init];
    if (self ) {
        _type = type;
    }
    return self;
}
-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGet;
}

// 请求的URL
- (NSString *)requestUrl
{
    return @"/index.php?g=Wap&c=Phone_wap&a=newsList";
}

// 请求的参数列表
-(id)requestArgument
{
    return @ {
        @"type":_type
    };
}

@end
