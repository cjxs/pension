//
//  ShouldKnowTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/3.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "ShouldKnowTVCell.h"

@implementation ShouldKnowTVCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel * label = [[UILabel alloc]
                           initWithFrame:CGRectMake(8, 6, 60, 30)];
        label.text = @"预定须知";
        label.font = [UIFont systemFontOfSize:14];
        [self addSubview:label];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}
-(void)configWithStr:(NSString *)text
{
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
        label.frame = CGRectMake(10, 40, screenWide - 20, height);
        label.numberOfLines = 0;
        label.textColor = RGB(158, 159, 159);
        [self addSubview:label];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
