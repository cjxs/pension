//
//  ComOrCollTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/7.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "ComOrCollTVCell.h"

@implementation ComOrCollTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.organAddress_label.numberOfLines = 0;
        [self.last_btn.layer setBorderColor:RGB(237, 237, 237).CGColor];
        [self.last_btn.layer setBorderWidth:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configRefundWithtitle:(NSString *)title
                       image:(UIImage *)image
                        type:(NSString *)type
                       price:(NSString *)price
{
    if (self)
    {
        if (title)
        {
            self.title_label.text = title;
        }
        if (image)
        {
            self.organimage_view.image = image;
        }
        if ([type isEqualToString:@"collect"])
        {
            [self.last_btn setTitle:@"取消收藏"
                           forState:UIControlStateNormal];
            [self.price_label mas_makeConstraints:^(MASConstraintMaker *make)
            {
                make.bottom.equalTo(self.organAddress_label);
            }];
            [self.organAddress_label mas_makeConstraints:^(MASConstraintMaker *make)
            {
                make.width.mas_equalTo(self.serve_label);
            }];
            self.serve_label.text = @"自理｜单人间朝南｜包餐";
            self.organAddress_label.text = @"地址：杭州市滨江区江晖路隆和国际603fsgsdkyarhkgadgdshgfjzdhgfzdhj";
        }else if ([type isEqualToString:@"comment"])
        {
            [self.price_label mas_makeConstraints:^(MASConstraintMaker *make)
            {
                make.bottom.equalTo(self.serve_label);
            }];
            [self.organAddress_label mas_makeConstraints:^(MASConstraintMaker *make)
            {
                make.width.mas_equalTo(self.serve_label).offset(60);
            }];
            [self.last_btn setTitle:@"取消点评"
                           forState:UIControlStateNormal];
            self.serve_label.text = @"自理｜单人间朝南｜包餐";
            self.organAddress_label.text = @"地址：杭州市滨江区江晖路隆和国际603fsgsdkyarhkgadgdshgfjzdhg圣诞节匡扶汉室的风景还是等高科技的身高马大分身乏术的空间更加简单快乐时光     fzdhj";
        }
        if (price)
        {
            self.price_label.text = price;
        }
    }
}
@end
