//
//  CashStatusTVC.m
//  HealthySettle
//
//  Created by yrc on 16/12/6.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "CashStatusTVC.h"

@implementation CashStatusTVC
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle: style
                reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(16, 5, 70, 35)];
        title_label.text = @"现金账户";
        [self addSubview:title_label];
        UILabel * balance_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide/2 - 20, 5, 40, 30)];
        balance_label.text = @"余额";
        [self addSubview:balance_label];
        _cash_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide/2+20, 5, 60, 30)];
        Member * user = [Member DefaultUser];
        [RACObserve(user, now_money) subscribeNext:^(NSString * text) {
            _cash_label.text = text;
        }];
        _cash_label.textColor = [UIColor redColor];
        [self addSubview:_cash_label];
        UISwitch *switchButton = [[UISwitch alloc]
                                  initWithFrame:CGRectMake(screenWide -66,5 , 50,30)];
        switchButton.onTintColor = RGB(241, 69, 62);
        switchButton.clipsToBounds = YES;
        _cash_switch_btn = switchButton;
        [self addSubview:_cash_switch_btn];
        UILabel * switch_btn_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide -120, 5, 45, 30)];
        switch_btn_label.text = @"去使用";
        switch_btn_label.adjustsFontSizeToFitWidth = YES;
        switch_btn_label.textColor = RGB(190, 190, 190);
        [self addSubview:switch_btn_label];
        
 
    }
    return self;
}
-(void)creatCashView{
    if (_cash_switch_btn.on) {
        UIView * back_view = [[UIView alloc] initWithFrame:CGRectMake(20, 50, screenWide-40, 50)];
        back_view.backgroundColor = RGB(245, 249, 252);
        [self addSubview:back_view];
        UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(5,10, 150, 30)];
        title_label.text = @"自定义使用金额";
        [back_view addSubview:title_label];
        
        _cash_use_field = [[UITextField alloc] initWithFrame:CGRectMake(160, 10, 150, 30)];
        _cash_use_field.borderStyle = UITextBorderStyleRoundedRect;
        _cash_use_field.backgroundColor = [UIColor clearColor];
        _cash_use_field.placeholder = @"请输入使用金额";
        _cash_use_field.keyboardType = UIKeyboardTypeDecimalPad;
        [back_view addSubview:_cash_use_field];
    }
}
-(void)configWithUse:(BOOL )use{
    _cash_switch_btn.on = use;
    if (use) {
        [self creatCashView];
    }
}

@end
