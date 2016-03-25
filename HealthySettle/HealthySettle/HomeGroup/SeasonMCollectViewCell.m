//
//  SeasonMCollectViewCell.m
//  HealthySettle
//
//  Created by yrc on 16/3/23.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "SeasonMCollectViewCell.h"

@implementation SeasonMCollectViewCell
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.image_view = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin/2, kMargin/2, frame.size.width - kMargin, frame.size.height/3*2)];
        self.season_label = [[UILabel alloc] initWithFrame:CGRectMake(kMargin/2, frame.size.height/3*2,frame.size.width - kMargin, frame.size.height/6)];
        self.describe_label = [[UILabel alloc] initWithFrame:CGRectMake(kMargin/2, frame.size.height/9 * 7, frame.size.width - kMargin, frame.size.height/6)];
        [self addSubview:_image_view];
        [self addSubview:_season_label];
        [self addSubview:_describe_label];
        _season_label.textAlignment = NSTextAlignmentCenter;
        _season_label.font = [UIFont systemFontOfSize:12];
        _describe_label.textAlignment = NSTextAlignmentCenter;
        _describe_label.font = [UIFont systemFontOfSize:10];
        
    }
    return self;
}
-(void)configViewWithimage:(UIImage *)image season:(NSString *)season describ:(NSString *)describ{
    _image_view.image = image;
    _season_label.text = season;
    _describe_label.text = describ;
}


@end
