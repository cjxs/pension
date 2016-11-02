//
//  DDLogin.h
//  HealthySettle
//
//  Created by yrc on 16/7/11.
//  Copyright © 2016年 yrc. All rights reserved.
//


@interface DDLogin : YTKBaseRequest     //登陆
-(id)initWithUsername:(NSString *)username password:(NSString *)password;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSMutableArray *)arrayWithJsonString:(NSString *)jsonString;
+ (NSString * )RSAsignWithdic:(NSDictionary *)dic;
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
@end
