//
//  YYLOrder.m
//  HealthySettle
//
//  Created by yrc on 16/7/14.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "YYLOrder.h"

@implementation YYLOrder
+(YYLOrder *)YLOrder{
    static YYLOrder * ordering = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        ordering = [[self alloc] init];
    });
    return ordering;
}
+(YYLOrder *)YSOrder{
    static YYLOrder * ordering = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        ordering = [[self alloc] init];
    });
    return ordering;
}
@end
