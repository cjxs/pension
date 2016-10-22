//
//  PersonTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/3/29.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "PersonTVCell.h"

@implementation PersonTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configClassName:(NSString *)class_name
              Andresult:(NSString *)result
                   with:(NSString *)type
{
       _className.text = class_name;
    if (result)
    {
        if ([type isEqualToString:@"Y"])
        {
            _resultLabel.text = result;
        }else
        {
            _resultLabel.text = result;
            _resultLabel.textColor = RGB(14, 161, 207);
            }
    }
}
@end
