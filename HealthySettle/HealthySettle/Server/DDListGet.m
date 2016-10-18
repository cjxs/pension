//
//  DDListGet.m
//  HealthySettle
//
//  Created by yrc on 16/10/18.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDListGet.h"

@implementation DDListGet{
    NSString * _controller;
    NSString * _area_id;
    NSString * _page;
}
-(id)initWithController:(NSString *)controller area_id:(NSString *)area_id page:(NSString *)page{
    self = [super init];
    if (self ) {
        _controller = controller;
        if (area_id) {
            _area_id = area_id;
        }else{
            _area_id = @"3134";
        }
        if (page) {
            _page = page;
        }else{
            _page = @"1";
        }
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
        @"area_id":_area_id,
        @"page":_page
    };
}
@end
