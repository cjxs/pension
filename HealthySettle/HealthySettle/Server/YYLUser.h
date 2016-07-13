//
//  YYLUser.h
//  HealthySettle
//
//  Created by yrc on 16/7/12.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYLUser : NSObject
@property (nonatomic,strong)NSString * uid;
@property (nonatomic,strong)NSString * phone;
@property (nonatomic,strong)NSString * pwd;
@property (nonatomic,strong)NSString * pay_pwd;
@property (nonatomic,strong)NSString * nickname;
@property (nonatomic,strong)NSString * province;
@property (nonatomic,strong)NSString * city;
@property (nonatomic,strong)NSString * now_money;
@property (nonatomic,strong)NSString * score_count;

@end
