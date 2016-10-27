//
//  CommentTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/2.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "CommentTVCell.h"

@implementation CommentTVCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    UIView * margin_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, 13)];
    margin_view.backgroundColor =  RGB(242, 242, 242);
    [self addSubview:margin_view];
    // Initialization code
    self.commentNow_btn.clipsToBounds = YES;
    self.commentNow_btn.layer.cornerRadius = 5;
    NSArray * array = @[@"好评",@"中评",@"差评"];
    for (int i = 0; i < 3; i++)
    {
        UILabel * label = [[UILabel alloc]
                           initWithFrame:CGRectMake(screenWide *0.47, screenHeight * (0.08 + 0.028 * i), screenWide * 0.07, screenHeight * 0.025)];
        label.font = [UIFont systemFontOfSize:9];
        label.textColor = RGB(200, 200, 200);
        label.text = array[i];
        [self addSubview:label];
    }
    for (int i = 0; i < 3; i++)
    {
        UIProgressView * pro = [[UIProgressView alloc]
                                initWithFrame:CGRectMake(screenWide *0.57, screenHeight * (0.09 + 0.028 * i), screenWide * 0.38, screenHeight * 0.025)];
        pro.trackTintColor = RGB(241, 241, 241);
        pro.progress = 0.5;
        pro.tag = 200 + i;
        pro.progressTintColor = [UIColor redColor];
        [self addSubview:pro];
        
    }
    for (UIView * view in self.subviews)
    {
        if ([view isKindOfClass:[UIProgressView class]])
        {
            if (view.tag == 200)
            {
                _goodPro_view = (UIProgressView *)view;
                _goodPro_view.progress = 0.92;
            }else if (view.tag == 201)
            {
                _midPro_view = (UIProgressView *)view;
                _midPro_view.progress = 0.05;
            }else if (view.tag == 202)
            {
                _badPro_view = (UIProgressView *)view;
                _badPro_view.progress = 0;
            }
        }
    }

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
