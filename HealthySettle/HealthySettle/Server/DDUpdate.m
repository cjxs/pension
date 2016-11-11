//
//  DDUpdate.m
//  HealthySettle
//
//  Created by yrc on 16/11/10.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDUpdate.h"

@implementation DDUpdate{
    NSString * _project;
     NSDictionary * _data;
}
-(id)initWithProject:(NSString *)project data:(NSDictionary *)data {
    if ([super init]) {
        _project = project;
        _data = [NSDictionary dictionaryWithDictionary:data];
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
    return @{
          @"controller":@"update",
          @"uid" : [Member DefaultUser].uid,
          @"login" :[Member DefaultUser].login,
          @"project":_project,
          @"data":_data
          };
}

@end
