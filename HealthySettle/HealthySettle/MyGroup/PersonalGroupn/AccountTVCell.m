//
//  AccountTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/12.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "AccountTVCell.h"

@implementation AccountTVCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    self.title_label.text = @"吧啦吧啦吧吧啦吧养生基地";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
