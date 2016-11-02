//
//  DDCollectList.m
//  HealthySettle
//
//  Created by yrc on 16/10/22.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDCollectList.h"

@implementation DDCollectList{
    NSString * _uid;
    NSString * _login;
}
-(id)initWithUid:(NSString *)uid login:(NSString *)login {
    self = [super init];
    if (self) {
        _uid = uid;
        if (!login) {
            _login = @"";
        }else{
            _login = login;
        }
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
    return @{@"rsa": [DDLogin RSAsignWithdic:@{
                                               @"controller":@"collect",
                                               @"uid" : _uid,
                                               @"login" : _login
                                               }]};
}


@end
