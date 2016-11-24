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
    self.personImageView.layer.cornerRadius = screenHeight *0.055;
    self.personImageView.layer.masksToBounds = YES;

       // Initialization code
}
-(void)configs{
    Member * user = [Member DefaultUser];
    if (user.avatar) {
        NSString * str = [NSString stringWithFormat:@"%@/%@",BASEURL,user.avatar];
        [self.personImageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"boy_head"]];
    }else{
        self.personImageView.image = [UIImage imageNamed:@"boy_head"];
    }
    __block NSString * str_s;
    __block NSString * str_bir;

    @weakify(self)
    
    [RACObserve(user, sex)
     subscribeNext:^(NSString * str) {
         @strongify(self)
         switch ([str intValue]) {
             case 1:
                 str_s = @"男";
                 break;
             case 2:
                 str_s = @"女";
                 break;
             default:
                 str_s = user.sex?user.sex:@"男／女";
                 break;
         }
         self.sex_bir_l.text = [NSString stringWithFormat:@"%@ | %@",str_s,str_bir];
     }];
    
    [RACObserve(user, birthday)
     subscribeNext:^(NSString * str) {
         @strongify(self)

         str_bir = user.birthday?user.birthday:@"未填写生日";
         self.sex_bir_l.text = [NSString stringWithFormat:@"%@ | %@",str_s,str_bir];
         
     }];
     [RACObserve(user, nickname)
        subscribeNext:^(NSString * str) {
            @strongify(self)
         self.nick_name_l.text = str?str:@"昵称还没有哦";
        }];
    
    _set_l.textColor = RGB(14, 161, 207);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
