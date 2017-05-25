//
//  TestModel.m
//  HealthySettle
//
//  Created by yrc on 16/4/2.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel
-(instancetype)init
{
  self =  [super init];
    if (self)
    {
        self.show = [NSMutableString stringWithFormat:@"n"];
    }
    return self;
}
@end
