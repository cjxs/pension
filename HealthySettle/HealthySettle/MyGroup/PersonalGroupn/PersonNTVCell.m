//
//  PersonNTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/10/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "PersonNTVCell.h"

@implementation PersonNTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    Member * user = [Member DefaultUser];
    self.personImageView.layer.cornerRadius = screenHeight *0.055;
    self.personImageView.layer.masksToBounds = YES;
    if (user.avatar) {
        NSString * str = [NSString stringWithFormat:@"%@/%@",BASEURL,user.avatar];
        [self.personImageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"boy_head"]];
    }else{
        self.personImageView.image = [UIImage imageNamed:@"boy_head"];
    }
    NSString * str_s = user.sex?user.sex:@"男／女";
    NSString * str_bir = user.birthday?user.birthday:@"未填写生日";
    self.nick_name_l.text = user.nickname?user.nickname:@"昵称还没有哦";
    self.sex_bir_l.text = [NSString stringWithFormat:@"%@|%@",str_s,str_bir];
    _set_l.textColor = RGB(14, 161, 207);

    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
