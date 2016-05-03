//
//  ManageTimeTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/1.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "ManageTimeTVCell.h"

@implementation ManageTimeTVCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    for (UIView *view in self.subviews)
    {
        if ([view isKindOfClass:[UILabel class]])
        {
            UILabel * label =(UILabel *) view;
            label.adjustsFontSizeToFitWidth = YES;
        }
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
