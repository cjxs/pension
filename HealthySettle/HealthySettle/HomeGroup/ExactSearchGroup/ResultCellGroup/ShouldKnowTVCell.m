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
        UIView * margin_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, 13)];
        margin_view.backgroundColor =  RGB(242, 242, 242);
        [self addSubview:margin_view];

        UILabel * label = [[UILabel alloc]
                           initWithFrame:CGRectMake(8, 19, 60, 30)];
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
-(CGFloat)configWithStr:(NSString *)text
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
        UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 50, screenWide-20, height)];
        [webView loadHTMLString:text baseURL:[NSURL URLWithString:BASEURL]];
        webView.scrollView.bounces = NO;
        [self addSubview:webView];
        return height;
    }
    return 0;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
