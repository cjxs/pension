//
//  DDListGet.h
//  HealthySettle
//
//  Created by yrc on 16/10/18.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDListGet : YTKBaseRequest //列表数据
-(id)initWithcat_id:(NSString *)cat_id keyword:(NSString *)keyword  area_id:(NSString *)area_id sort:(NSString *)sort priceRange:(NSArray *)priceRange level:(NSString *)level page:(NSString *)page;
@end
