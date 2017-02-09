//
//  TitleNumberView.m
//  HealthySettle
//
//  Created by yrc on 17/2/9.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "TitleNumberView.h"

@implementation TitleNumberView
-(UILabel *)title_label{
    if (!_title_label) {
        UILabel * label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        _title_label = label;
    }
    return _title_label;
}
-(UILabel *)number_label {
    if (!_number_label) {
        UILabel * label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;

        _number_label = label;
    }
    return _number_label;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat height = frame.size.height;
        CGFloat width = frame.size.width;
        [self addSubview:self.number_label];

        [self addSubview:self.title_label];
        [_number_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(width, height/2));
            make.top.equalTo(self).offset(5);
            make.centerX.equalTo(self);
        }];
        
        [_title_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(width, height/4));
            make.top.mas_equalTo(_number_label.mas_bottom);
            make.centerX.equalTo(self);
        }];
        
        
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
