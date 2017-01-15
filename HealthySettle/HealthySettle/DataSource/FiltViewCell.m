//
//  FiltViewCell.m
//  HealthySettle
//
//  Created by yrc on 17/1/12.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "FiltViewCell.h"

@implementation FiltViewCell
-(UILabel *)text_label{
    if (!_text_label) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.05, 0, self.frame.size.width*0.8, self.frame.size.height)];
        label.textAlignment = NSTextAlignmentLeft;
        _text_label = label;


    }
    return _text_label;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.text_label];
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
