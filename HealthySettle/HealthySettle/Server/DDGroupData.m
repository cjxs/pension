//
//  DDGroupData.m
//  HealthySettle
//
//  Created by yrc on 16/10/19.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDGroupData.h"

@implementation DDGroupData{
    NSString * _controller;
    NSString * _group_id;
    NSString * _page;
}
-(id)initWithController:(NSString *)controller group_id:(NSString *)group_id{
    self = [super init];
    if (self ) {
        _controller = controller;
        _group_id = group_id;
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
    return @ {
        @"controller":_controller,
        @"group_id":_group_id,
    };
}


@end
