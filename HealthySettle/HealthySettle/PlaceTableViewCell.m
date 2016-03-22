//
//  PlaceTableViewCell.m
//  HealthySettle
//
//  Created by yrc on 16/3/22.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "PlaceTableViewCell.h"

@implementation PlaceTableViewCell

- (void)awakeFromNib {
    _mark_image.image = [UIImage imageNamed:@"z_02"];
    _input_text.placeholder = @"杭州市";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
