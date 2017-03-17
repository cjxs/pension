//
//  UsecanTVCell.m
//  HealthySettle
//
//  Created by yrc on 17/2/13.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "UsecanTVCell.h"

@implementation UsecanTVCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle: style
                reuseIdentifier:reuseIdentifier];
    if (self)
    {
        NSArray * arr = @[@"现金账户",@"优惠券"];
        for (int i = 0; i < 2; i++) {
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.03 + screenHeight * 0.07*i, screenWide * 0.25, screenHeight * 0.04)];
            lab.text = arr[i];
            if (IS_IPHONE6EARLY) {
                lab.font = [UIFont systemFontOfSize:13];
            }
            
            [self addSubview:lab];
            
            UILabel * title_lab_0 = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.35, screenHeight * 0.03 + screenHeight * 0.07*i, screenWide * 0.45, screenHeight * 0.04)];
            title_lab_0.textColor = [UIColor redColor];
            
            if (IS_IPHONE6EARLY) {
                title_lab_0.font = [UIFont systemFontOfSize:13];
            }
            if (i==0) {
                _cash_use_label = title_lab_0;
                [self addSubview:_cash_use_label];
            }else{
                _dis_count_label = title_lab_0;
                [self addSubview:_dis_count_label];
            }
            
            UISwitch *switchButton = [[UISwitch alloc]
                                      initWithFrame:CGRectMake(screenWide * 0.81,screenHeight * 0.028 + screenHeight * 0.07 *i , screenWide * 0.15,screenHeight * 0.03)];
            switchButton.onTintColor = RGB(241, 69, 62);
            switchButton.clipsToBounds = YES;
            switchButton.layer.cornerRadius = screenHeight * 0.015;
            if (i==0) {
                _cash_switch_btn = switchButton;
                [self addSubview:_cash_switch_btn];
            }else{
                _dis_count_switch_btn = switchButton;
                [self addSubview:_dis_count_switch_btn];
            }
           
            
        }
        UIView * line_view_0 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.155, screenWide, screenHeight * 0.015)];
        line_view_0.backgroundColor = GRAYCOLOR;
        [self addSubview:line_view_0];
        UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.015 + screenHeight * 0.07, screenWide, 1)];
        line_view.backgroundColor = GRAYCOLOR;
        [self addSubview:line_view];
    }
    return self;
}
-(void)configWithCash:(NSString *)cash dis_count:(NSString *)dis_count cashUse:(BOOL )cashuse dis_countUse:(BOOL)dis_countUse {
    if (cash) {
        _cash_use_label.text = [NSString stringWithFormat:@"可用余额：¥ %@",cash];
    }
    if (dis_count) {
        _dis_count_label.text = [NSString stringWithFormat:@"可用优悠券：¥ %@",dis_count];

    }else{
        _dis_count_label.text = [NSString stringWithFormat:@"可用优悠券：¥ 0.00"];
    }
    _cash_switch_btn.on = cashuse;
    _dis_count_switch_btn.on = dis_countUse;
    
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
