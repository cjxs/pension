//
//  RecommendViewCell.m
//  HealthySettle
//
//  Created by yrc on 17/1/3.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "RecommendViewCell.h"

@implementation RecommendViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.05547)];
        line_view.backgroundColor = GRAYCOLOR;
        [self addSubview:line_view];
        UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide/4, screenHeight * 0.02488, screenWide/2, screenHeight * 0.01799)];
        title_label.text = @"——— 精品推荐 ———";
        title_label.textAlignment = NSTextAlignmentCenter;
        [line_view addSubview:title_label];
        bg_view = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.05547, screenWide, screenHeight * 0.05997)];
        [self addSubview:bg_view];
        bg_view.backgroundColor = WHITECOLOR;
        
        NSArray * array = @[@"养生度假", @"找养老院", @"养生基地"];
        for (int i = 0; i < 3; i++)
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i *screenWide /4 + screenWide /8, 0.005, screenWide /4, screenHeight * 0.05);
            btn.tag = 500 + i;
            [btn setTitle:array[i]
                 forState:UIControlStateNormal];
            [btn addTarget:self
                    action:@selector(changeDataOfbtn:)
          forControlEvents:UIControlEventTouchUpInside];
            [bg_view addSubview:btn];
            UIView * label = [[UIView alloc]
                               initWithFrame:CGRectMake(i *screenWide /4+ screenWide /8, screenHeight * 0.055, screenWide /4, screenHeight * 0.00497)];
            label.clipsToBounds = YES;
            label.layer.cornerRadius = 3;
            [bg_view addSubview:label];
            if (i == 0)
            {
                [btn setTitleColor:[UIColor redColor]
                          forState:UIControlStateNormal];
                label.backgroundColor = [UIColor redColor];
            }else
            {
                [btn setTitleColor:[UIColor blackColor]
                          forState:UIControlStateNormal];
                label.backgroundColor = [UIColor whiteColor];
            }

        }
        
    }
    return self;
}
- (void)changeDataOfbtn:(UIButton *)btn {
    
    if (number_btn != btn.tag - 500) {
        number_btn = btn.tag-500;
        
            [self changeColorForAll];
            [btn setTitleColor:[UIColor redColor]
                      forState:UIControlStateNormal];
            for (UIView *view in bg_view.subviews)
            {
                if (view.frame.size.height == screenHeight * 0.00497&&
                    view.frame.origin.x == btn.frame.origin.x)
                {
                    view.backgroundColor = [UIColor redColor];
                }
            }
        if (self.delegate && [self.delegate respondsToSelector:@selector(updateDataWithWave:)]) {
            [self.delegate updateDataWithWave:number_btn];
        }

      
        
    }
}
-(void)changeColorForAll{
    for (int i = 0;i < bg_view.subviews.count;i++) {
        if ([bg_view.subviews[i] isKindOfClass:[UIButton class]]) {
            UIButton * btn = bg_view.subviews[i];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else{
            UIView * view = bg_view.subviews[i];
            view.backgroundColor = WHITECOLOR;
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
