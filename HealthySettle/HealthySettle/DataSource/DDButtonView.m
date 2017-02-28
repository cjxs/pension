//
//  DDButtonView.m
//  HealthySettle
//
//  Created by yrc on 17/2/27.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "DDButtonView.h"

@implementation DDButtonView

-(void)setViews{
    UIImageView * img_view = [[UIImageView alloc] init];
    [self addSubview:img_view];
    img_view.image = [UIImage imageNamed:_img_view_str];
    [img_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(screenHeight * 0.07, screenHeight * 0.07));
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(screenHeight * 0.012);
    }];
    UILabel*label = [[UILabel alloc] init];
    [self addSubview:label];
    label.text = _label_str;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.height.mas_equalTo(screenHeight * 0.035);
        make.centerX.equalTo(self);
        make.top.mas_equalTo(img_view.mas_bottom).offset(screenHeight * 0.005);
    }];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:12];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
