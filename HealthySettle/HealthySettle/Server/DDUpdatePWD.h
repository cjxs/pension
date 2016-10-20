//
//  DDUpdatePWD.h
//  HealthySettle
//
//  Created by yrc on 16/10/20.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDUpdatePWD : YTKBaseRequest
-(id)initWithUserNumber:(NSString *)number pwd:(NSString *)newpwd vfycode:(NSString *)vfycode;
@end
