//
//  DDSeaGet.m
//  HealthySettle
//
//  Created by yrc on 16/10/9.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDSeaGet.h"

@implementation DDSeaGet {
    
}
-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGet;
}

// 请求的URL
- (NSString *)requestUrl
{
    return @"/index.php?";
}

// 请求的参数列表
-(id)requestArgument
{
    return @ {
        @"g":@"Api",
        @"c":@"Api",
        @"controller":@"sea_city",
        @"sea_id":@"1"
    };
}
@end
