//
//  ThingsView.m
//  HealthySettle
//
//  Created by yrc on 16/3/18.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "ThingsView.h"

@implementation ThingsView

-(instancetype)initWithFrame:(CGRect)frame withMark:(UIImage *)mark andTitle :(NSString *)string {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        UIImageView * markImageV = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/3, frame.size.height/5, frame.size.width/3, frame.size.height/5 * 2)];
        markImageV.image = mark;
        [self addSubview:markImageV];
        UILabel * explainTitle = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/4, frame.size.height/5*3, frame.size.width/2, frame.size.height/5*2)];
        explainTitle.text = string;
        explainTitle.font = [UIFont systemFontOfSize:10];
        explainTitle.textAlignment = NSTextAlignmentCenter;
        explainTitle.textColor = [UIColor blackColor];
        [self addSubview:explainTitle];
        
    }
    return self;
}


@end
