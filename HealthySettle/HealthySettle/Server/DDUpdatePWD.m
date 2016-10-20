//
//  DDUpdatePWD.m
//  HealthySettle
//
//  Created by yrc on 16/10/20.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDUpdatePWD.h"

@implementation DDUpdatePWD{
    NSString * _number;
    NSString * _newpwd;
    NSString * _vfycode;
}
-(id)initWithUserNumber:(NSString *)number pwd:(NSString *)newpwd vfycode:(NSString *)vfycode
{
    if ([super init]) {
        _number = number;
        _newpwd = newpwd;
        _vfycode = vfycode;
        
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
    return @"/index.php?g=Index&c=Login&a=pwdModifying";
}

// 请求的参数列表
-(id)requestArgument
{
    return @ {
        @"phone" : _number,
        @"vfycode" : _vfycode,//验证的种类
        @"newpwd": _newpwd
    };
}


@end
