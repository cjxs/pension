//
//  CommonTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/8.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "CommonTVCell.h"

@implementation CommonTVCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
        formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy.M.dd"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configWithTitle:(NSString *)title date:(NSDate *)date
{
    if (title)
    {
        self.title_label.text = title;
    }
    if (date)
    {
        NSMutableString *dateStr = [[formatter stringFromDate:date] mutableCopy];
        self.date_label.text =  dateStr;
    }
}

@end
