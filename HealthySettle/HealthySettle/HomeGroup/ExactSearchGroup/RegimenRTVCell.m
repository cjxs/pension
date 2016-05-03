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
    self.organization_title.adjustsFontSizeToFitWidth = YES;
    self.price_label.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configWithImage:(UIImage *)image
                  title:(NSString *)title
                address:(NSString *)address
                  price:(NSString *)price
           supportArray:(NSArray *)array
{
    if (image)
    {
        self.organization_image.image = image;
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
            UIImageView * imageView = [[UIImageView alloc]
                                       initWithImage:[UIImage imageNamed:array [i]]];
            imageView.frame = CGRectMake(100 + i * kMargin * 2.5, 45, kMargin * 2, kMargin * 2);
            imageView.backgroundColor = [UIColor blackColor];
            [self addSubview:imageView];
        }
    }
}
@end
