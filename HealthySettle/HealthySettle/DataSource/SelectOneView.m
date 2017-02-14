//
//  SelectOneView.m
//  HealthySettle
//
//  Created by yrc on 17/2/10.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "SelectOneView.h"

@implementation SelectOneView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        _lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,width/2 , height)];
        [self addSubview:_lab];
        _img_view = [[UIImageView alloc] initWithFrame:CGRectMake(width/2, height/6, width/3, height/3*2)];
        [self addSubview:_img_view];
        UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapviewges:)];
        [self addGestureRecognizer:ges];
        ges.numberOfTouchesRequired = 1;
        
        
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
-(void)tapviewges:(UITapGestureRecognizer *)ges{
    SelectOneView * view = (SelectOneView*)ges.view;
    
    if (view.lab.textColor == [UIColor redColor]) {
    }else{
        _selectBlock ? _selectBlock(ges.view.frame.origin.x) : nil;

    }

}
@end
