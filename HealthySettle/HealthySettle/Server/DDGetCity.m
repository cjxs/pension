//
//  DDGetCity.m
//  HealthySettle
//
//  Created by yrc on 16/10/24.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDGetCity.h"

@implementation DDGetCity
- (NSString *)requestUrl
{
    return @"/index.php?g=Api&c=Api&a=getplist";
}
-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGet;
}
@end
