//
//  DDToolKit.m
//  HealthySettle
//
//  Created by yrc on 16/7/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDToolKit.h"

@implementation DDToolKit
+ (BOOL)checkPhoneNumberWithText:(NSString *)str {
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
        if (!isMatch) {
            return NO;
        }
    return YES;
}

@end
