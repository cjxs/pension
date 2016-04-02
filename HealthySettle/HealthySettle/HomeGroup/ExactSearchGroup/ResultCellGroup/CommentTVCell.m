//
//  CommentTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/2.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "CommentTVCell.h"

@implementation CommentTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.commentNow_btn.clipsToBounds = YES;
    self.commentNow_btn.layer.cornerRadius = 5;
    NSArray * array = @[@"好评",@"中评",@"差评"];
    for (int i = 0; i < 3; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide *0.47, screenHeight * (0.06 + 0.028 * i), screenWide * 0.07, screenHeight * 0.025)];
        label.font = [UIFont systemFontOfSize:9];
        label.textColor = RGB(200, 200, 200);
        label.text = array[i];
        [self addSubview:label];
    }
    for (int i = 0; i < 3; i++) {
        UIProgressView * pro = [[UIProgressView alloc] initWithFrame:CGRectMake(screenWide *0.57, screenHeight * (0.07 + 0.028 * i), screenWide * 0.38, screenHeight * 0.025)];
        pro.trackTintColor = RGB(165, 165, 165);
        pro.progress = 0.5;
        pro.tag = 200 + i;
        pro.progressTintColor = [UIColor redColor];
        [self addSubview:pro];
        
    }
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:[UIProgressView class]]) {
            if (view.tag == 200) {
                _goodPro_view = (UIProgressView *)view;
                _goodPro_view.progress = 0.88;
            }else if (view.tag == 201) {
                _midPro_view = (UIProgressView *)view;
                _midPro_view.progress = 0.1;
            }else if (view.tag == 202) {
                _badPro_view = (UIProgressView *)view;
            }
                    }
    }

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
