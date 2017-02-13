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
@property (nonatomic,strong)NSString * now_money;
@property (nonatomic,strong)NSString * vocher;
@property (nonatomic,strong)NSString * score_count;
@property (nonatomic,strong)NSString * pay_can;
@property (nonatomic,strong)NSString * login;

+(Member *)DefaultUser;
@end
