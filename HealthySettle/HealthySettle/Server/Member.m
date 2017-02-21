//
//  Member.m
//  HealthySettle
//
//  Created by yrc on 16/5/10.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "Member.h"
#import "MJExtension.h"


@implementation Member
+(Member *)DefaultUser{
    static Member * default_menber= nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        default_menber = [[self alloc] init];
        
    });
    return default_menber;
}
@end
