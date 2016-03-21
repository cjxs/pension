//
//  SeasonPageView.m
//  HealthySettle
//
//  Created by yrc on 16/3/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "SeasonPageView.h"
#import "SeasonView.h"
@implementation SeasonPageView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.left_View = [[SeasonView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/3, frame.size.height)];
        self.mid_View = [[SeasonView alloc] initWithFrame:CGRectMake(frame.size.width/3, 0, frame.size.width/3, frame.size.height)];
        self.right_View = [[SeasonView alloc] initWithFrame:CGRectMake(frame.size.width/3*2, 0, frame.size.width/3, frame.size.height)];
        [self addSubview:_left_View];
        [self addSubview:_mid_View];
        [self addSubview:_right_View];
    }
    return self;
}

@end
