//
//  LoginOrResView.m
//  HealthySettle
//
//  Created by yrc on 16/4/12.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "LoginOrResView.h"

@implementation LoginOrResView
-(UITextField *)number_field  {
    if (!_number_field) {
        UITextField * number_field = [[UITextField alloc] initWithFrame:CGRectMake(screenWide * 0.0293, screenHeight * 0.0165, screenWide * 0.7274, screenHeight * 0.0585)];
        number_field.backgroundColor = RGB(239, 239, 239);
        number_field.clipsToBounds = YES;
        number_field.layer.cornerRadius = 5;
        number_field.placeholder = @"    请输入手机号";
        _number_field =number_field;
    }
    return _number_field;
}
-(UITextField *)passWord_field {
    if (!_passWord_field) {
        UITextField * passWord_field = [[UITextField alloc] initWithFrame:CGRectMake(screenWide * 0.0293, screenHeight * 0.085, screenWide * 0.7274, screenHeight * 0.0585)];
        passWord_field.placeholder = @"    请输入密码";
        passWord_field.clipsToBounds = YES;
        passWord_field.layer.cornerRadius = 5;
        passWord_field.backgroundColor = RGB(239, 239, 239);
        _passWord_field = passWord_field;
    }
    return _passWord_field;
}
-(UIButton *)reSetpass_btn {
    if (!_reSetpass_btn) {
        UIButton * reSetpass_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reSetpass_btn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [reSetpass_btn addTarget:self action:@selector(resetyourPassword) forControlEvents:UIControlEventTouchUpInside];
        reSetpass_btn.titleLabel.font = [UIFont systemFontOfSize:13];
        reSetpass_btn.titleLabel.textAlignment = NSTextAlignmentRight;
        [reSetpass_btn setTitleColor:RGB(194, 194, 194) forState:UIControlStateNormal];
        reSetpass_btn.frame = CGRectMake(screenWide * 0.5293, screenHeight * 0.085, screenWide * 0.2274, screenHeight * 0.0585);
        _reSetpass_btn = reSetpass_btn;
    }
    return _reSetpass_btn;
}
-(UITextField *)test_field {
    if (!_test_field) {
        UITextField * test_field = [[UITextField alloc] initWithFrame:CGRectMake(screenWide * 0.0293, screenHeight * 0.085, screenWide * 0.4274, screenHeight * 0.0585)];
        test_field.placeholder = @"    动态验证码";
        test_field.clipsToBounds = YES;
        test_field.layer.cornerRadius = 5;
        test_field.backgroundColor = RGB(239, 239, 239);
        _test_field = test_field;
    }
    return _test_field;
}
-(UIButton *)getTest_btn {
    if (!_getTest_btn) {
        UIButton * getTest_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [getTest_btn setTitle:@"获取动态验证码" forState:UIControlStateNormal];
        getTest_btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [getTest_btn addTarget:self action:@selector(getTestPassword) forControlEvents:UIControlEventTouchUpInside];
        getTest_btn.titleLabel.font = [UIFont systemFontOfSize:13];
        getTest_btn.titleLabel.textAlignment = NSTextAlignmentRight;
        getTest_btn.backgroundColor = RGB(239, 239, 239);
        getTest_btn.clipsToBounds = YES;
        getTest_btn.layer.cornerRadius = 5;
        [getTest_btn setTitleColor:RGB(109, 109, 109) forState:UIControlStateNormal];
        getTest_btn.frame = CGRectMake(screenWide * 0.4754, screenHeight * 0.085, screenWide * 0.2707, screenHeight * 0.0585);
        _getTest_btn = getTest_btn;
    }
    return _getTest_btn;
}
-(UIButton *)login_btn {
    if (!_login_btn) {
        UIButton * login_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        login_btn.frame = CGRectMake(screenWide * 0.0293, screenHeight * 0.16, screenWide * 0.354, screenHeight * 0.0585);
        login_btn.clipsToBounds = YES;
        login_btn.layer.cornerRadius = 5;
        [login_btn addTarget:self action:@selector(loginOrloginView) forControlEvents:UIControlEventTouchUpInside];
        [login_btn setTitle:@"登录" forState:UIControlStateNormal];
        login_btn.backgroundColor = RGB(230, 11, 24);
        login_btn.layer.borderWidth = 1;
        login_btn.layer.borderColor = [RGB(229, 229, 229) CGColor];

        _login_btn = login_btn;
    }
    return _login_btn;
}
-(UIButton *)regis_btn {
    if (!_regis_btn) {
        UIButton * regis_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        regis_btn.frame = CGRectMake(screenWide * 0.4023, screenHeight * 0.16, screenWide * 0.354, screenHeight * 0.0585);
        [regis_btn setTitle:@"注册" forState:UIControlStateNormal];
        regis_btn.clipsToBounds = YES;
        regis_btn.layer.cornerRadius = 5;
        [regis_btn addTarget:self action:@selector(regisOrRegisVC) forControlEvents:UIControlEventTouchUpInside];
        [regis_btn setTitleColor:RGB(230, 11, 24) forState:UIControlStateNormal];
        regis_btn.layer.borderWidth = 1;
        regis_btn.layer.borderColor = [RGB(229, 229, 229) CGColor];
        _regis_btn = regis_btn;
    }
    return _regis_btn;
}
-(instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.view_type = 0;
        UIView * view =[[UIView alloc]initWithFrame:self.bounds];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tap.numberOfTapsRequired = 1;
        [view addGestureRecognizer:tap];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5;
        [self addSubview:view];
        bg_view = [[UIView alloc] initWithFrame:CGRectMake(screenWide * 0.107, -screenHeight * 0.24, 0, 0)];
        bg_view.backgroundColor = [UIColor whiteColor];
        bg_view.clipsToBounds = YES;
        bg_view.layer.cornerRadius = 5;
        [self addSubview:bg_view];
        [self addSelfSubView];
    }
    return self;
}
-(void)addSelfSubView {
    [bg_view addSubview:self.number_field];
    [bg_view addSubview:self.passWord_field];   
    [bg_view addSubview:self.reSetpass_btn];
    [bg_view addSubview:self.login_btn];
    [bg_view addSubview:self.regis_btn];
    [UIView animateWithDuration:0.3 animations:^{
        bg_view.frame = CGRectMake(screenWide * 0.107, screenHeight * 0.38, screenWide * 0.786, screenHeight * 0.24);
           }];

   
   
}

- (void)resetyourPassword {
    NSLog(@"更改密码");
}
-(void)getTestPassword {
    //获取验证码
}
-(void)regisOrRegisVC {
    if (self.view_type == 1) {
        NSLog(@"注册");

    }else {
        //切换界面
        [UIView animateWithDuration:0.5f animations:^{
            [self.reSetpass_btn removeFromSuperview];
            [self.passWord_field removeFromSuperview];
            [bg_view addSubview:self.test_field];
            [bg_view addSubview:self.getTest_btn];
        }];
        _regis_btn.backgroundColor = RGB(230, 11, 24);
        [_regis_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_login_btn setTitleColor:RGB(230, 11, 24) forState:UIControlStateNormal];
        _login_btn.backgroundColor = [UIColor whiteColor];
        CGRect rect = _login_btn.frame;
        _login_btn.frame = _regis_btn.frame;
        _regis_btn.frame = rect;
        _number_field.placeholder = @"    手机号";
        self.view_type = 1;
    }
}
-(void)loginOrloginView {
    if (self.view_type == 0) {
        NSLog(@"登录");
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://1008611"]];

    }else {
        //切换界面
        [UIView animateWithDuration:0.5f animations:^{
            [self.test_field removeFromSuperview];
            [self.getTest_btn removeFromSuperview];
            [bg_view addSubview:self.passWord_field];
            [bg_view addSubview:self.reSetpass_btn];
        }];
        [_regis_btn setTitleColor:RGB(230, 11, 24) forState:UIControlStateNormal];
        _regis_btn.backgroundColor = [UIColor whiteColor];
        _login_btn.backgroundColor = RGB(230, 11, 24);
        [_login_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        CGRect rect = _login_btn.frame;
        _login_btn.frame = _regis_btn.frame;
        _regis_btn.frame = rect;
        _number_field.placeholder = @"    请输入手机号";
        self.view_type = 0;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)remove {
    for (UIView * view in bg_view.subviews) {
        [view removeFromSuperview];
    }
    for (UIView * view  in self.subviews) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}
-(void)dismiss {
    //自动消除
    [UIView animateWithDuration:0.3 animations:^{
        bg_view.frame = CGRectMake(screenWide * 0.107, screenHeight * 1.24, 0, 0);
    }];
    [self performSelector:@selector(remove) withObject:nil afterDelay:0.3f];

   
}
@end
