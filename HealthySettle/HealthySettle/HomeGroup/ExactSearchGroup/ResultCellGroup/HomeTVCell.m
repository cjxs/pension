//
//  HomeTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/1.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "HomeTVCell.h"

@implementation HomeTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.priceDetail_btn addTarget:self action:@selector(showpriceDetail) forControlEvents:UIControlEventTouchUpInside];
       
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)showpriceDetail {
}
@end
