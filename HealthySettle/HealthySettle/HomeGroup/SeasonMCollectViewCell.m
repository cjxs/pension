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
        self.backgroundColor = WHITECOLOR;
        self.image_view = [[UIImageView alloc]
                           initWithFrame:CGRectMake(screenWide * 0.015, 0, screenWide * 0.303,screenHeight * 0.1686)];
        self.season_label = [[UILabel alloc]
                             initWithFrame:CGRectMake(kMargin/2, CGRectGetMaxY(self.image_view.frame)/2,frame.size.width - kMargin, frame.size.height/10)];
        [self addSubview:_image_view];
        [self addSubview:_season_label];
        _season_label.textAlignment = NSTextAlignmentCenter;
        _season_label.backgroundColor =  [UIColor clearColor];
        _season_label.textColor = WHITECOLOR;
//        _season_label.font = [UIFont systemFontOfSize:12];
    }
    return self;
}
-(void)configViewWithimage:(NSString *)imageurl
                    season:(NSString *)season
                   describ:(NSString *)describ
{
    [_image_view sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"season_p_1"]];
    _season_label.text = season;
}


@end
