//
//  Member.h
//  HealthySettle
//
//  Created by yrc on 16/5/10.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject
@property (nonatomic,strong)NSString * uid;
@property (nonatomic,strong)NSString * nickname;
@property (nonatomic,strong)NSString * sex;
@property (nonatomic,strong)NSString * birthday;
@property (nonatomic,strong)NSString * email;
@property (nonatomic,strong)NSString * phone;
@property (nonatomic,strong)NSString * avatar;
@property (nonatomic,strong)NSString * now_money;//现金账户
@property (nonatomic,strong)NSString * vocher;//优悠券
@property (nonatomic,strong)NSMutableArray * cont_arr;
@property (nonatomic,strong)NSString * role;
@property (nonatomic,strong)NSString * pay_can;
@property (nonatomic,strong)NSString * login;
@property (nonatomic,strong)NSString * pwd;
@property (nonatomic,strong)NSString * pay_pwd;
@property (nonatomic,strong)NSString * province;
@property (nonatomic,strong)NSString * city;
@property (nonatomic,strong)NSString * refer_code;

+(Member *)DefaultUser;
@end
