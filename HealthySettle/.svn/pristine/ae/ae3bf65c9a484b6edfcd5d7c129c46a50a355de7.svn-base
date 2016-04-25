//
//  ServeTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/3.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "ServeTVCell.h"

@implementation ServeTVCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(screenWide /2, 3, 1, 25)];
        view.backgroundColor = RGB(250, 251, 252);
        [self addSubview:view];
        NSArray * array =@[@"通用服务",@"收费服务"];
        UIView * line_view =[[UIView alloc] initWithFrame:CGRectMake(0, 29, screenWide, 1)];
        line_view.backgroundColor = RGB(250, 251, 252);
        [self addSubview:line_view];
        for (int i = 0; i < 2; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(screenWide /2 *i, 0, screenWide/2, 29);
            [btn setTitle:array[i] forState:UIControlStateNormal];
            if (i == 0) {
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }else {
                [btn setTitleColor:RGB(196, 196, 196) forState:UIControlStateNormal];
            }
            [btn addTarget:self action:@selector(showSelectViewWithbtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [self addSubview:btn];
        }
        [self showCommonServe];
    
    }
    return self;
}
-(void)showSelectViewWithbtn:(UIButton *)btn {
    for (UIButton * button in self.subviews) {
        if ([button isKindOfClass:[UIButton class]] && button.frame.origin.x != btn.frame.origin.x ) {
            button.enabled = YES;
            [button setTitleColor:RGB(196, 196, 196) forState:UIControlStateNormal];
        }
    }
    btn.enabled = NO;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (btn.frame.origin.x == 0) {
        [self showCommonServe];
    }else {
        [self showTollServe];
    }
}
-(void)showCommonServe{
    if (_tollServe_view) {
        [_tollServe_view removeFromSuperview];
        _tollServe_view = nil;
    }
    _commonServe_view = [[UIView alloc] initWithFrame:CGRectMake(0, 30, screenWide, 80)];
    UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 32, 20)];
    title_label.text = @"自理：";
    title_label.font = [UIFont systemFontOfSize:10];
    [_commonServe_view addSubview:title_label];
    UILabel * text_label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, screenWide - 50, 70)];
    text_label.numberOfLines = 0;
    text_label.font = [UIFont systemFontOfSize:10];
    text_label.textColor = RGB(205, 206, 207);

    text_label.text = @"打发时间开会开到家风格哈卡官方电话发个大富豪们纷纷对萨哈的设计开发噶就回复客人趋于规范企鹅家企鹅    啊饿我好积分卡上打个飞机啊 啊饿空间发噶电话睡觉啊 啊瞬间复活噶多少多少风格很舒服，和高科技示范户公司，每当个合适的肌肤很干，即使对方很干，对方就会告诉大家，汾河谷地房价高哈健康噶独立国家的国家啊对方就会个入口  阿迪看见噶话， 季后赛，哈空间 ";
    [_commonServe_view addSubview:text_label];
    [self addSubview:_commonServe_view];
}
- (void)showTollServe{
    if (_commonServe_view) {
        [_commonServe_view removeFromSuperview];
        _commonServe_view = nil;
    }
    _tollServe_view = [[UIView alloc] initWithFrame:CGRectMake(0, 30, screenWide, 80)];
    UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 32, 20)];
    title_label.text = @"收费：";
    title_label.font = [UIFont systemFontOfSize:10];
    [_tollServe_view addSubview:title_label];
    UILabel * text_label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, screenWide - 50, 70)];
    text_label.numberOfLines = 0;
    text_label.text = @"打发时间开会开到家风格哈卡官方电话发个大富豪们纷纷对萨哈的设计开发噶就回复客人趋于规范企鹅家企鹅    啊饿我好积分卡上打个飞机啊 啊饿空间发噶电话睡觉啊 啊瞬间复活噶多少 ";
    text_label.font = [UIFont systemFontOfSize:10];
    text_label.textColor = RGB(205, 206, 207);
    [_tollServe_view addSubview:text_label];
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
