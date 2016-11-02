//
//  DDSeaGet.m
//  HealthySettle
//
//  Created by yrc on 16/10/9.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDSeaGet.h"

@implementation DDSeaGet {
    NSString * _sea_id;
}
-(id)initWithSea_id:(NSString *)sea_id {
    if ([super init]) {
        _sea_id = sea_id;
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
    return @"/Api.html";
}

// 请求的参数列表
-(id)requestArgument
{
    return @{
        @"controller":@"sea_city",
        @"sea_id":_sea_id
    };
}
@end
