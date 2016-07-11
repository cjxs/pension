//
//  DDTestApiS.m
//  HealthySettle
//
//  Created by yrc on 16/3/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDTestApiS.h"

@implementation DDTestApiS

- (NSString *)requestUrl
{
    return @"?id=3873";
}
-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGet;
}
@end
