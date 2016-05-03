//
//  PensionSRTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/3/31.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "PensionSRTVCell.h"

@implementation PensionSRTVCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.organization_title.adjustsFontSizeToFitWidth = YES;
    self.price_label.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configWithimage:(UIImage *)image
                  title:(NSString *)title
                address:(NSString *)address
                 number:(NSString *)number
                  price:(NSString *)price
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
        self.organization_address.text = [NSString stringWithFormat:@"地址: %@",address];
    }
    if (number)
    {
        self.available_bunk.text = [NSString stringWithFormat:@"床位: %@",number];
    }
    if (price)
    {
        self.price_label.text = [NSString stringWithFormat:@"¥%@",price];
    }
    
}
@end
