//
//  GraceTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/11.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "GraceTVCell.h"


@implementation GraceTVCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGB(244, 244, 244);
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(screenHeight * 0.02, screenHeight * 0.02, screenWide - screenHeight * 0.04, screenHeight * 0.17)];
        view.backgroundColor = RGB(255, 253, 228);
        [self addSubview:view];
        UIImageView * no_use_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,screenHeight * 0.06, screenHeight * 0.06)];
        no_use_imageView.image = [UIImage imageNamed:@"weishiyong_"];
        [view addSubview:no_use_imageView];
        UILabel * rmb_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.2, screenHeight * 0.05, screenWide * 0.065, screenHeight * 0.06)];
        rmb_label.text = @"¥";
        rmb_label.textColor = RGB(252, 88, 100);
        rmb_label.font = [UIFont systemFontOfSize:40];
        [view addSubview:rmb_label];
        money_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.28, screenHeight * 0.01, screenWide * 0.3, screenHeight * 0.1)];
        money_label.font = [UIFont systemFontOfSize:75];
        money_label.textColor = RGB(252, 88, 100);
        money_label.textAlignment = NSTextAlignmentCenter;
        moneyuse_label.adjustsFontSizeToFitWidth = YES;
        money_label.text = @"50";
        [view addSubview:money_label];
        
        moneyuse_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.2, screenHeight * 0.12, screenWide * 0.4, screenHeight * 0.03)];
        moneyuse_label.text = @"[消费满300元可用]";
        moneyuse_label.font = [UIFont systemFontOfSize:14];
        moneyuse_label.adjustsFontSizeToFitWidth = YES;
        moneyuse_label.textColor = RGB(35, 183, 197);
        moneyuse_label.textAlignment = NSTextAlignmentLeft;
        [view addSubview:moneyuse_label];
        
        UIImageView * red_imageView =[[UIImageView alloc] initWithFrame:CGRectMake(screenWide * 0.66, 0, screenWide * 0.35 - screenHeight * 0.04, screenHeight * 0.17)];
        red_imageView.image = [UIImage imageNamed:@"system_08"];
        [view addSubview:red_imageView];
        
        UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.05, screenHeight * 0.03, screenWide * 0.25, screenHeight * 0.03)];
        label1.textColor = RGB(255, 253, 228);
        label1.text = @"有效期";
        label1.font = [UIFont systemFontOfSize:13];
        [red_imageView addSubview:label1];
        timeFrom_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.05, screenHeight * 0.06, screenWide * 0.25, screenHeight * 0.03)];
        timeFrom_label.textColor = RGB(255, 253, 228);
        timeFrom_label.font = [UIFont systemFontOfSize:13];
        timeFrom_label.text = @"2015.02.03";
        [red_imageView addSubview:timeFrom_label];
        UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.05, screenHeight * 0.09, screenWide * 0.25, screenHeight * 0.03)];
        label2.textColor = RGB(255, 253, 228);
        label2.text = @"至";
        label2.font = [UIFont systemFontOfSize:13];
        [red_imageView addSubview:label2];
        timeTo_label =  [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.05, screenHeight * 0.12, screenWide * 0.25, screenHeight * 0.03)];
        timeTo_label.textColor = RGB(255, 253, 228);
        timeTo_label.font = [UIFont systemFontOfSize:13];
        timeTo_label.text = @"2016.02.03";
        [red_imageView addSubview:timeTo_label];


      }
    return self;
}
- (void)configWithMoneystr:(NSString *)money use:(NSString *)use timeF:(NSString *)timeF timeT:(NSString *)timeT {
    if (money) {
        money_label.text = money;
    }
    if (use) {
        moneyuse_label.text = [NSString stringWithFormat:@"[消费满%@元可用]",use];
    }
    if (timeF) {
        timeFrom_label.text = timeF;
    }
    if (timeT) {
        timeTo_label.text = timeT;
    }
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
