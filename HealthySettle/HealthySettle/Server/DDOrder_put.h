//
//  DDOrder_put.h
//  HealthySettle
//
//  Created by yrc on 17/2/16.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDOrder_put : YTKBaseRequest
-(id)initWithUid:(NSString *)uid login:(NSString *)login data:(YYLOrder *)data;
@end
