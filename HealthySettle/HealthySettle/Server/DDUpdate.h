//
//  DDUpdate.h
//  HealthySettle
//
//  Created by yrc on 16/11/10.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDUpdate : YTKBaseRequest  //注册
-(id)initWithProject:(NSString *)project data:(NSDictionary *)data;

@end
