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
    NSString * _keyword;
    NSString * _cat_id;
    NSString * _page;
    NSString * _price_range;
    NSString * _sort;
    NSString * _level;

}
-(id)initWithcat_id:(NSString *)cat_id keyword:(NSString *)keyword  area_id:(NSString *)area_id sort:(NSString *)sort priceRange:(NSString *)priceRange level:(NSString *)level page:(NSString *)page{
    self = [super init];
    if (self ) {
        _cat_id = cat_id;
        if (keyword) {
            _keyword = keyword;
        }else {
            _keyword = @"";
        }
        if (area_id) {
            _area_id = area_id;
        }else{
            _area_id = @"";
        }
        if (sort) {
            _sort = sort;
        }else{
            _sort = @"";
        }
        if (priceRange) {
            _price_range = priceRange;
        }else{
            _price_range = @"";
        }
        if (level) {
            _level = level;
        }else{
            _level = @"";
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
    return @{
        @"controller":@"new_g_list",
        @"cat_id":_cat_id,
        @"area_id":_area_id,
        @"keyword":_keyword,
        @"price_range":_price_range,
        @"sort":_sort,
        @"level":_level,
        @"page":_page
    };
}
@end
