//
//  OrderTextFieldTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/4.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "OrderTextFieldTVCell.h"

@implementation OrderTextFieldTVCell
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
        UITextField * field = [[UITextField alloc]
                               initWithFrame:CGRectMake(8+screenWide /4, 0, screenWide - 46 , screenHeight * 0.06)];
        field.font = [UIFont systemFontOfSize:12];
        _text_field = field;
        [self addSubview:_text_field];
        _next_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _next_btn.frame = CGRectMake(screenWide - 28, screenHeight * 0.01,20, screenHeight * 0.04);
        [_next_btn setBackgroundImage:[UIImage imageNamed:@"next_01"]
                             forState:UIControlStateNormal];
        [self addSubview:_next_btn];
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
    if (text)
    {
        _text_field.placeholder = text;
    }
    if (!next)
    {
        [_next_btn  removeFromSuperview];
    }
}
-(NSString *)returnfromtextField{
    return _text_field.text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
