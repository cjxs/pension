//
//  OrderBtnTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/4.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "OrderBtnTVCell.h"

@implementation OrderBtnTVCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel * label = [[UILabel alloc]
                           initWithFrame:CGRectMake(8, 0, screenWide/4, screenHeight * 0.06)];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = RGB(106, 106, 106);
        _title_label = label;
        [self addSubview:_title_label];
        UISwitch *switchButton = [[UISwitch alloc]
                                  initWithFrame:CGRectMake(screenWide -58,5 , 20,10)];
        [switchButton setOn:YES];
        switchButton.onTintColor = RGB(241, 69, 62);
        switchButton.clipsToBounds = YES;
        _switch_btn = switchButton;
        [self addSubview:switchButton];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}
-(void)configWithtitle:(NSString *)title
                  text:(NSString *)text
                  next:(BOOL)next {
    if (title)
    {
        _title_label.text = title;
    }
        [_switch_btn setOn:next];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
