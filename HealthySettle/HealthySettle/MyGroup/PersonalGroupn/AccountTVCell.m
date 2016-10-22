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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configWithTitle:(NSString *)title type:(NSString *)type money:(NSString *)money {
    if (title) {
        self.title_label.text = title;
    }
    if (money) {
        if ([type intValue]==1) {
            self.number_label.text = [NSString stringWithFormat:@"+¥ %@",money];
            self.number_label.textColor = [UIColor redColor];
        }else{
            self.number_label.text = [NSString stringWithFormat:@"-¥ %@",[money substringFromIndex:1]];
            self.number_label.textColor = [UIColor greenColor];
            
        }
    }
    
}
-(void)configWithTitle:(NSString *)title type:(NSString *)type score:(NSString *)score {
    if (title) {
        self.title_label.text = title;
    }
    if (score) {
        if ([type intValue]==1) {
            self.number_label.text = [NSString stringWithFormat:@"+ %@",score];
            self.number_label.textColor = [UIColor redColor];
        }else{
            self.number_label.text = [NSString stringWithFormat:@"- %@",[score substringFromIndex:1]];
            self.number_label.textColor = [UIColor greenColor];
            
        }
    }

}

@end
