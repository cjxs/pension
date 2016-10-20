//
//  DDGroupData.h
//  HealthySettle
//
//  Created by yrc on 16/10/19.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDGroupData : YTKBaseRequest //详情页的数据
-(id)initWithController:(NSString *)controller group_id:(NSString *)group_id;
@end
