//
//  SeasonMCollectViewCell.m
//  HealthySettle
//
//  Created by yrc on 16/3/23.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "SeasonMCollectViewCell.h"

@implementation SeasonMCollectViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.image_view = [[UIImageView alloc]
                           initWithFrame:CGRectMake(screenWide * 0.015, screenHeight * 0.017, screenWide * 0.303, screenHeight * 0.175)];
        self.season_label = [[UILabel alloc]
                             initWithFrame:CGRectMake(kMargin/2, CGRectGetMaxY(self.image_view.frame),frame.size.width - kMargin, frame.size.height/12)];
        self.describe_label = [[UILabel alloc]
                               initWithFrame:CGRectMake(kMargin/2, CGRectGetMaxY(self.season_label.frame), frame.size.width - kMargin, frame.size.height/12)];
        [self addSubview:_image_view];
        [self addSubview:_season_label];
        [self addSubview:_describe_label];
        _describe_label.textColor = RGB(173, 173, 173);
        _season_label.textAlignment = NSTextAlignmentCenter;
        _season_label.font = [UIFont systemFontOfSize:12];
        _describe_label.textAlignment = NSTextAlignmentCenter;
        _describe_label.font = [UIFont systemFontOfSize:10];
    }
    return self;
}
-(void)configViewWithimage:(NSString *)imageurl
                    season:(NSString *)season
                   describ:(NSString *)describ
{
    [_image_view sd_setImageWithURL:[NSURL URLWithString:imageurl]];
    _season_label.text = season;
    _describe_label.text = describ;
}


@end
