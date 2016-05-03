//
//  ShowTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/3.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "ShowTVCell.h"

@implementation ShowTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configWithTitle:(NSString *)title
            imageArray:(NSArray *)array
                  text:(NSString *)text
{
    if (title)
    {
        self.title_label.text = title;
    }
    if (array)
    {
        self.left_imageView.image = array[0];
        self.mid_imageView.image = array[1];
        self.right_imageView.image = array[2];
    }
    if (text)
    {
        UILabel * label = [[UILabel alloc] init];
        label.text = text;
        UIFont * fnt = [UIFont fontWithName:text size:8];
        label.font = fnt;
        label.font = [UIFont systemFontOfSize:10];
        CGFloat  height =[label.text boundingRectWithSize:
                               CGSizeMake(screenWide - 20, CGFLOAT_MAX)
                                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                    attributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName, nil] context:nil].size.height;
        label.frame = CGRectMake(10, 125, screenWide - 20, height);
        label.numberOfLines = 0;
        label.textColor = RGB(158, 159, 159);
        [self addSubview:label];
    }
}

@end
