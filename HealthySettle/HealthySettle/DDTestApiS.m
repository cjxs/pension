//
//  DDTestApiS.m
//  HealthySettle
//
//  Created by yrc on 16/3/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDTestApiS.h"

@implementation DDTestApiS {
    NSString * _thingsN;
}


-(id)initWithThingsT:(NSString *)thingsT {
    self = [super init];
    if (self) {
        _thingsN = thingsT;
    }
    return self;
}
- (NSString *)requestUrl {
    return @"";
}
-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}
-(id)requestArgument {
    return @{@"s?wd=":_thingsN};
}
@end
