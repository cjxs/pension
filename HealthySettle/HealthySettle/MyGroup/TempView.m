//
//  TempView.m
//  HealthySettle
//
//  Created by yrc on 16/3/18.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "TempView.h"

@implementation TempView

-(instancetype)initWithFrame:(CGRect)frame withMark:(UIImage *)mark andTitle :(NSString *)string {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.4;
        [self addSubview:view];

        self.markImageV = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin , kMargin , frame.size.width/5.5    , frame.size.width/5.5)];
        _markImageV.image = mark;
        [self addSubview:_markImageV];
        
        self.explainTitle = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/3 , kMargin, frame.size.width/1.83   , frame.size.width/5.5)];
        _explainTitle.text = string;
        _explainTitle.font = [UIFont systemFontOfSize:14];
        _explainTitle.textAlignment = NSTextAlignmentLeft;
        _explainTitle.textColor = [UIColor whiteColor];
        [self addSubview:_explainTitle];
        

        
    }
    return self;
}

@end
