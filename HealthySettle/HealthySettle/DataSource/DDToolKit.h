//
//  DDToolKit.h
//  HealthySettle
//
//  Created by yrc on 16/7/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDToolKit : NSObject
+ (BOOL)checkPhoneNumberWithText:(NSString *)str;
+(BOOL)checkEmailWithText:(NSString *)text;

@end
