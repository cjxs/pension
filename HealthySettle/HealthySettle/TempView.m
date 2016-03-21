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
        
        self.backgroundColor = [UIColor grayColor];
        self.markImageV = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin , kMargin , frame.size.width/5.5    , frame.size.width/5.5)];
        _markImageV.image = mark;
        [self addSubview:_markImageV];
        
        self.explainTitle = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/3 , kMargin, frame.size.width/1.83   , frame.size.width/5.5)];
        _explainTitle.text = string;
        _explainTitle.font = [UIFont systemFontOfSize:14];
        _explainTitle.textAlignment = NSTextAlignmentLeft;
        _explainTitle.textColor = [UIColor whiteColor];
        _explainTitle.text = @"缤纷炸弹";
        [self addSubview:_explainTitle];
        self.layer.cornerRadius = 5;
        
    }
    return self;
}

@end
