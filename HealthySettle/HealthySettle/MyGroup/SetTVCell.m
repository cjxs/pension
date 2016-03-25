//
//  SetTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/3/25.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "SetTVCell.h"

@implementation SetTVCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setThingsWithName:(NSString *)stringQ Image:(UIImage *)imageB number:(NSString *)stringH
{
    self.mark_View.image = imageB;
    self.mark_label.text = stringQ;
    if (stringH) {
        self.explain_label.text = stringH;
    }else {
        [self.explain_label removeFromSuperview];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
