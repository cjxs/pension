//
//  DDTestApi.m
//  HealthySettle
//
//  Created by yrc on 16/3/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDTestApi.h"

@implementation DDTestApi {
    NSString * _username;
    NSString * _password;
}
-(id)initWithUsername:(NSString *)username password:(NSString *)password {
    self = [super init];
    if (self) {
        _username = username;
        _password = password;
    }
    return self;
}
- (NSString *)requestUrl {
    return @"/s?wd = 你好";
}
-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}
-(id)requestArgument {
    return @{
             @"username": _username,
             @"password": _password
             };
}
@end
