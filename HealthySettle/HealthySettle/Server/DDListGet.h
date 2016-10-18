//
//  DDListGet.h
//  HealthySettle
//
//  Created by yrc on 16/10/18.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDListGet : YTKBaseRequest
-(id)initWithController:(NSString *)controller area_id:(NSString *)area_id page:(NSString *)page;
@end
