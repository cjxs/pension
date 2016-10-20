//
//  DDRegist.h
//  HealthySettle
//
//  Created by yrc on 16/7/13.
//  Copyright © 2016年 yrc. All rights reserved.
//


@interface DDRegist : YTKBaseRequest  //注册
-(id)initWithRegisNumber:(NSString *)number pwd:(NSString *)pwd vfycode: (NSString *)vfycode;
@end
