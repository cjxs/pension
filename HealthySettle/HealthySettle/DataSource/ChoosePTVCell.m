//
//  ChoosePTVCell.m
//  HealthySettle
//
//  Created by yrc on 17/2/20.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "ChoosePTVCell.h"

@implementation ChoosePTVCell
-(UILabel *)text_label{
    if (!_text_label) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.05, screenHeight * 0.005, screenWide * 0.4, screenHeight * 0.04)];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:13];
        _text_label = label;
    }
    return _text_label;
}
-(UIImageView *)img_view {
    if (!_img_view) {
        UIImageView * img_view = [[UIImageView alloc] init];
        img_view.image = [UIImage imageNamed:@"un_select"];
        _img_view = img_view;
    }
    return _img_view;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.text_label];
        [self addSubview:self.img_view];
        [_img_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(screenWide * 0.06 , screenWide * 0.06));
            make.right.mas_equalTo(self).offset(-screenWide * 0.05);
            make.centerY.equalTo(self);
        }];
        _img_view.clipsToBounds = screenWide*0.06/2;
        _img_view.clipsToBounds = YES;
        
    }
    return self;
}
-(void)configWithname:(NSString *)name{
    if (name) {
        _text_label.text = name;
    }
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
