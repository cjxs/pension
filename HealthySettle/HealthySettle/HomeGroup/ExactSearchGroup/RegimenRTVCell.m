//
//  RegimenRTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/3/31.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "RegimenRTVCell.h"


@implementation RegimenRTVCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    self.price_label.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configWithImage:(NSString *)image_u
                  title:(NSString *)title
                address:(NSString *)address
                  price:(NSString *)price
           supportArray:(NSArray *)array
{
    if (image_u)
    {
        [self.organization_image sd_setImageWithURL:[NSURL URLWithString:image_u]];
    }
    if (title)
    {
        self.organization_title.text = title;
    }
    if (address)
    {
        self.address_label.text = address;
    }
    if (price)
    {
        self.price_label.text = [NSString stringWithFormat:@"¥ %@",price];
    }
    if (array)
    {
        for (int i = 0; i < array.count; i++)
        {
            
            NSString *  str2 = [NSString stringWithFormat:@"%@/upload/group/%@",BASEURL,array[i][@"spec_img"]];
            NSString * str3 = [str2 stringByReplacingOccurrencesOfString:@"," withString:@"/"];
            

            UIImageView * imageView = [[UIImageView alloc]init];
            imageView.frame = CGRectMake(screenHeight * 0.158 + i * kMargin * 2.5, 45, kMargin * 2, kMargin * 2);
            imageView.backgroundColor = [UIColor clearColor];
            [imageView sd_setImageWithURL:[NSURL URLWithString:str3]];

            [self addSubview:imageView];
        }
    }
}
@end
