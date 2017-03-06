//
//  DDLogin.h
//  HealthySettle
//
//  Created by ; on 16/7/11.
//  Copyright © 2016年 yrc. All rights reserved.
//


@interface DDLogin : YTKBaseRequest     //登陆
-(id)initWithUsername:(NSString *)username password:(NSString *)password;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSMutableArray *)arrayWithJsonString:(NSString *)jsonString;
+ (NSString*)dictionaryToJson:(id)dic;
+ (NSDictionary *) entityToDictionary:(id)entity;
+ (NSArray * )RSAsignWithdic:(NSDictionary *)dic;
+(NSString *)timeStrWithDate:(NSDate*)date;
+(NSDate *)dateWithString:(NSString *)str;
+(NSString *)timeStrWithstr:(NSString *)str;
+ (BOOL)checkTelNumber:(NSString *) telNumber;
+ (BOOL)checkUserEmail:(NSString *)email;
+ (BOOL)checkUserIdCard: (NSString *) idCard;
+ (BOOL)checkUserName : (NSString *) userName;
@end
