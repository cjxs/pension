//
//  DDArticleDetail.m
//  HealthySettle
//
//  Created by yrc on 16/10/26.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDArticleDetail.h"

@implementation DDArticleDetail{
    NSString * _title_id;
}
-(id)initWithtitle_id:(NSString *)title_id{
    self = [super init];
    if (self ) {
        _title_id = title_id;
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
    return @"/index.php?g=Wap&c=Phone_wap&a=newsDetail";
}

// 请求的参数列表
-(id)requestArgument
{
    return @ {
        @"news_id":_title_id
    };
}

@end
