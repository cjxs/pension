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
@property (nonatomic,strong)NSString * province;
@property (nonatomic,strong)NSString * city;
@property (nonatomic,strong)NSString * avatar;
@property (nonatomic,strong)NSString * now_money;
@property (nonatomic,strong)NSString * birthday;
@property (nonatomic,strong)NSString * vip_type;
@property (nonatomic,strong)NSString * email;
@property (nonatomic,strong)NSString * tel;

@end
