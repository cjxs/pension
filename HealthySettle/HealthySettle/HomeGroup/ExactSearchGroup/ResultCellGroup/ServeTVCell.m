//
//  ServeTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/3.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "ServeTVCell.h"

@implementation ServeTVCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIView * margin_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, 13)];
        margin_view.backgroundColor =  RGB(242, 242, 242);
        [self addSubview:margin_view];
        UIView * view = [[UIView alloc]
                         initWithFrame:CGRectMake(screenWide /2, 16, 1, 25)];
        view.backgroundColor = RGB(250, 251, 252);
        [self addSubview:view];
        NSArray * array =@[@"通用服务",@"收费服务"];
        UIView * line_view =[[UIView alloc]
                             initWithFrame:CGRectMake(0, 42, screenWide, 1)];
        line_view.backgroundColor = RGB(250, 251, 252);
        [self addSubview:line_view];
        for (int i = 0; i < 2; i++)
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(screenWide /2 *i, 13, screenWide/2, 29);
            [btn setTitle:array[i]
                 forState:UIControlStateNormal];
            if (i == 0)
            {
                [btn setTitleColor:[UIColor blackColor]
                          forState:UIControlStateNormal];
            }else
            {
                [btn setTitleColor:RGB(196, 196, 196)
                          forState:UIControlStateNormal];
            }
            [btn addTarget:self
                    action:@selector(showSelectViewWithbtn:)
          forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [self addSubview:btn];
        }
           }
    return self;
}
-(void)configwithCommon:(NSString *)common charge:(NSString *)charge{
    if (common) {
        self.common_t = common;
    }
    if (charge) {
        self.charge_t = charge;
    }
    [self showCommonServe];
}
-(void)showSelectViewWithbtn:(UIButton *)btn
{
    for (UIButton * button in self.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]
            && button.frame.origin.x != btn.frame.origin.x )
        {
            button.enabled = YES;
            [button setTitleColor:RGB(196, 196, 196)
                         forState:UIControlStateNormal];
        }
    }
    btn.enabled = NO;
    [btn setTitleColor:[UIColor blackColor]
              forState:UIControlStateNormal];
    if (btn.frame.origin.x == 0)
    {
        [self showCommonServe];
    }else
    {
        [self showTollServe];
    }
}
-(void)showCommonServe
{
    if (_tollServe_view)
    {
        [charge_label removeFromSuperview];
        charge_label = nil;
        [_tollServe_view removeFromSuperview];
        _tollServe_view = nil;
    }
    if (!_commonServe_view) {
        _commonServe_view = [[UIView alloc]
                             initWithFrame:CGRectMake(0, 43, screenWide, 80)];
    }
        if (!common_label) {
        UILabel * text_label = [[UILabel alloc]
                                initWithFrame:CGRectMake(15, 0, screenWide - 20, 70)];
        text_label.numberOfLines = 0;
        text_label.font = [UIFont systemFontOfSize:10];
        text_label.textColor = RGB(205, 206, 207);
        text_label.text = self.common_t;
        common_label = text_label;
    }
    [_commonServe_view addSubview:common_label];
    [self addSubview:_commonServe_view];
}
- (void)showTollServe
{
    if (_commonServe_view)
    {
        [common_label removeFromSuperview];
        common_label = nil;
        [_commonServe_view removeFromSuperview];
        _commonServe_view = nil;
       
    }
    if (!_tollServe_view) {
        _tollServe_view = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 43, screenWide, 80)];
    }
    if (!charge_label) {
        UILabel * text_label = [[UILabel alloc]
                                initWithFrame:CGRectMake(15, 0, screenWide - 20, 70)];
        text_label.numberOfLines = 0;
        text_label.text = self.charge_t;
        text_label.font = [UIFont systemFontOfSize:10];
        text_label.textColor = RGB(205, 206, 207);
        charge_label = text_label;
    }
        [_tollServe_view addSubview:charge_label];
    [self addSubview:_tollServe_view];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
