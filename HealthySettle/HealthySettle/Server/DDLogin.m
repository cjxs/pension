//
//  DDLogin.m
//  HealthySettle
//
//  Created by yrc on 16/7/11.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDLogin.h"

@implementation DDLogin
{
    NSString * _username;
    NSString * _password;
}
-(id)initWithUsername:(NSString *)username
             password:(NSString *)password
{
    self = [super init];
    if (self)
    {
        _username = username;
        _password = password;
    }
    return self;
}

/// Http请求的方法
-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}
-(NSString *)requestUrl {
    return @"/Api.html";
}

// 请求的参数列表
-(id)requestArgument
{
    return @ {
        @"controller":@"login",
        @"phone" : _username,
        @"pwd" : _password
    };
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return arr;
}

@end
