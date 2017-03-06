//
//  DDUpdatePay.h
//  HealthySettle
//
//  Created by yrc on 17/3/4.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDUpdatePay : YTKBaseRequest
-(id)initWithUid:(NSString *)uid login:(NSString *)login type:(NSString *)type;
@end
