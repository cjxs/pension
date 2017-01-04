//
//  ArrayLabelView.m
//  HealthySettle
//
//  Created by yrc on 16/12/9.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "ArrayLabelView.h"

@implementation ArrayLabelView
-(instancetype)initWithFrame:(CGRect)frame Array:(NSArray *)array color:(UIColor *)color{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel * title_label, * status_label;
        
        for (int i = 0; i < [array count]/2;i++ ) {
            title_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5 + 40*i, screenWide/3, 40)];
            title_label.text = array[0+i*2];
            title_label.textAlignment = NSTextAlignmentLeft;
            [self addSubview:title_label];
            
            status_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide/5*4, 5+40*i, screenWide/5 - 10 , 40)];
            status_label.textColor = color;
            status_label.text = array[1+i*2];
            status_label.textAlignment = NSTextAlignmentRight;
            [self addSubview:status_label];
        }

    }
    return self;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
