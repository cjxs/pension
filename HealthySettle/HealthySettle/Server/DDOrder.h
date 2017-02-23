//
//  DDOrder.h
//  HealthySettle
//
//  Created by yrc on 17/2/23.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDOrder : YTKBaseRequest
-(id)initWithUid:(NSString *)uid login:(NSString *)login oid:(NSString *)oid;
@end
