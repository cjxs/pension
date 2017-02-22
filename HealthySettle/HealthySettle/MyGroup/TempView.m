//
//  TempView.m
//  HealthySettle
//
//  Created by yrc on 16/3/18.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "TempView.h"

@implementation TempView

-(instancetype)initWithFrame:(CGRect)frame
                    withMark:(UIImage *)mark
                   andTitle :(NSString *)string
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIView * view = [[UIView alloc]
                         initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        view.backgroundColor = [UIColor clearColor];
        view.clipsToBounds = YES;
        view.layer.cornerRadius = 5;
        [self addSubview:view];
        
        self.explainTitle = [[UILabel alloc]
                             initWithFrame:CGRectMake(0 , frame.size.height/2 - frame.size.width/11, frame.size.width*0.8 , frame.size.width/5.5)];
        _explainTitle.text = string;
        _explainTitle.font = [UIFont systemFontOfSize:15];
        _explainTitle.textAlignment = NSTextAlignmentLeft;
        _explainTitle.textColor = [UIColor whiteColor];
        [self addSubview:_explainTitle];

        
        self.markImageV = [[UIImageView alloc]
                           initWithFrame:CGRectMake(frame.size.width-frame.size.width/10*2 , frame.size.height/2- frame.size.width/14, frame.size.width/7, frame.size.width/7)];
        _markImageV.image = mark;
        [self addSubview:_markImageV];
        

    }
    return self;
}

@end
