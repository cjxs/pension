//
//  LoginOrRegisViewController.m
//  HealthySettle
//
//  Created by yrc on 16/7/18.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "LoginOrRegisViewController.h"
#import "MJExtension.h"
#import "NSString+MJExtension.h"
#import "DDGetTest.h"
#import "GetPassWordViewController.h"
#import "DDToolKit.h"
#import "DDRegist.h"
#import "Member.h"

@interface LoginOrRegisViewController ()<UITextFieldDelegate,LoginDelegate>{
    UIView * backView;
    BOOL agree;
    int timeTick;
    NSTimer * timer;
    NSString * _code;
    NSString * _time;
    BOOL  alertV;
}
@property (nonatomic,strong)UIImageView * backPicView;
@property (nonatomic,strong)NSString * view_type;
@property (nonatomic,strong)UIButton * loginView_btn;
@property (nonatomic,strong)UIButton * regisView_btn;
@property (nonatomic,strong)UITextField * number_field;
@property (nonatomic,strong)UITextField * passWord_field;
@property (nonatomic,strong)UIButton * findpwd_btn;
@property (nonatomic,strong)UIButton * public_btn;
@property (nonatomic,strong)UIButton * getTest_btn;
@property (nonatomic,strong)UITextField * regispwd_field1;
@property (nonatomic,strong)UITextField * regispwd_field2;
@property (nonatomic,strong)UILabel * line_lab;
@property (nonatomic,strong)UILabel * regis_lab1;
@property (nonatomic,strong)UILabel * regis_lab2;
@property (nonatomic,strong)UIButton * agree_btn;
@property (nonatomic,strong)UILabel * text_label;
@property (nonatomic,strong)UIButton * agreeMent_btn;
@property (nonatomic,strong)UIButton * back_btn;

@end

@implementation LoginOrRegisViewController
- (UIButton *)back_btn {
    if (!_back_btn) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 15,screenWide*0.05 , screenWide* 0.05*1.85);
        [button setBackgroundImage:[UIImage imageNamed:@"leftop_r"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backToView) forControlEvents:UIControlEventTouchUpInside];
        _back_btn = button;
    }
    return _back_btn;
}
- (UIButton *)agreeMent_btn {
    if (!_agreeMent_btn) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(CGRectGetMaxX(self.text_label.frame), screenHeight * 0.795, screenWide * 0.35, screenWide * 0.05);
        [button setTitle:@"《用户使用协议》" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:RGB(241, 204, 110) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(userAgreeMent) forControlEvents:UIControlEventTouchUpInside];
        _agreeMent_btn = button;
    }
    return _agreeMent_btn;
}
- (UILabel *)text_label {
    if (!_text_label) {
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.23, screenHeight * 0.795, screenWide * 0.3, screenWide * 0.05)];
        lab.text = @"我已阅读并同意";
        lab.font = [UIFont systemFontOfSize:13];
        _text_label = lab;
    }
    return _text_label;
}
- (UIButton *)agree_btn {
    if (!_agree_btn) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(screenWide * 0.15, screenHeight * 0.795, screenWide * 0.06, screenWide * 0.06);
        button.backgroundColor = [UIColor redColor];
        agree = YES;
        [button addTarget:self action:@selector(agreeToAgreeMent:) forControlEvents:UIControlEventTouchUpInside];
        _agree_btn = button;
    }
    return _agree_btn;
}
- (UILabel *)regis_lab1 {
    if (!_regis_lab1) {
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.08, screenHeight * 0.7, screenWide * 0.84, 1)];
        lab.backgroundColor = RGB(224, 225, 226);
        _regis_lab1 = lab;
    }
    return _regis_lab1;
}
- (UITextField *)regispwd_field1 {
    if (!_regispwd_field1) {
        UITextField * textfield = [[UITextField alloc] initWithFrame:CGRectMake(screenWide * 0.1, screenHeight * 0.65, screenWide * 0.8, screenHeight * 0.04)];
        textfield.placeholder = @"请输入密码";
        textfield.delegate = self;
        textfield.secureTextEntry = YES;
        _regispwd_field1 = textfield;
    }
    return _regispwd_field1;
}
- (UILabel *)regis_lab2 {
    if (!_regis_lab2) {
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.08, screenHeight * 0.77, screenWide * 0.84, 1)];
        lab.backgroundColor = RGB(224, 225, 226);
        _regis_lab2 = lab;
    }
    return _regis_lab2;
}
- (UITextField *)regispwd_field2 {
    if (!_regispwd_field2) {
        UITextField * textfield =[[UITextField alloc] initWithFrame:CGRectMake(screenWide * 0.1, screenHeight * 0.72, screenWide * 0.8, screenHeight * 0.04)];
        textfield.placeholder = @"请确认密码";
        textfield.delegate = self;
        textfield.secureTextEntry = YES;
        _regispwd_field2 = textfield;
    }
    return _regispwd_field2;
}
- (UILabel *)line_lab {
    if (!_line_lab) {
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.59, screenHeight * 0.55, 1, screenHeight * 0.07)];
        lab.backgroundColor = RGB(224, 225, 226);
        _line_lab = lab;
    }
    return _line_lab;
}
- (UIButton * )getTest_btn {
    if (!_getTest_btn) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(screenWide * 0.6, screenHeight * 0.55, screenWide * 0.3, screenHeight * 0.07);
        [button setTitle:@"获取验证码" forState: UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button addTarget:self action:@selector(getTestNumber:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:RGB(192, 193, 194) forState:UIControlStateNormal];
        _getTest_btn = button;
    }
    return _getTest_btn;
}
- (UIButton * )public_btn {
    if (!_public_btn) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(publicAction) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = screenHeight * 0.04;
        button.layer.masksToBounds = YES;
        [button setTitleColor:RGB(241, 204, 110) forState:UIControlStateNormal];
        [button.layer setBorderColor:RGB(241, 204, 110).CGColor];
        [button.layer setBorderWidth:1];
        _public_btn = button;
    }
    return _public_btn;
}
- (UIButton *)findpwd_btn {
    if (!_findpwd_btn) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(screenWide * 0.7, screenHeight * 0.64, screenWide * 0.22, screenHeight * 0.06);
        [button setTitle:@"忘记密码" forState:UIControlStateNormal];
        [button setTitleColor:RGB(192, 193, 194) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(findPassWordViewAppeaar) forControlEvents:UIControlEventTouchUpInside];
        _findpwd_btn = button;
    }
    return _findpwd_btn;
}
- (UITextField * )number_field {
    if (!_number_field) {
        UITextField * textfield = [[UITextField alloc] initWithFrame:CGRectMake(screenWide * 0.1, screenHeight * 0.45, screenWide * 0.8, screenHeight * 0.07)];
        textfield.keyboardType = 4;
        _number_field = textfield;
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"username"] length]!= 0) {
            _number_field.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        }
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.08, screenHeight * 0.53, screenWide * 0.84, 1)];
        label.backgroundColor = RGB(224, 225, 226);
        textfield.delegate = self;
        [self.view addSubview:label];
    }
    return _number_field;
}
- (UITextField * )passWord_field {
    if (!_passWord_field) {
        UITextField * textfield = [[UITextField alloc] initWithFrame:CGRectMake(screenWide * 0.1, screenHeight * 0.55, screenWide * 0.8, screenHeight * 0.07)];
        _passWord_field = textfield;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.08, screenHeight * 0.63, screenWide * 0.84, 1)];
        label.backgroundColor = RGB(224, 225, 226);
        textfield.delegate = self;
        [self.view addSubview:label];
    }
    return _passWord_field;
}
- (UIImageView * )backPicView {
    if (!_backPicView) {
        UIImageView * backPicView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.34)];
        backPicView.image = [UIImage imageNamed:@"custom_number"];
        _backPicView = backPicView;
    }
    return _backPicView;
}
-(UIButton *)loginView_btn {
    if (!_loginView_btn) {
        UIButton * loginView_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        loginView_btn.frame = CGRectMake(0, 0, screenWide/2, screenHeight * 0.08);
        [loginView_btn setTitle:@"登录" forState:UIControlStateNormal];
        [loginView_btn addTarget:self action:@selector(loginViewAppear) forControlEvents:UIControlEventTouchUpInside];
        _loginView_btn = loginView_btn;
    }
    return _loginView_btn;
}
-(UIButton *)regisView_btn {
    if (!_regisView_btn) {
        UIButton * regisView_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        regisView_btn.frame = CGRectMake(screenWide / 2, 0, screenWide / 2, screenHeight * 0.08);
        [regisView_btn setTitle:@"注册" forState:UIControlStateNormal];
        [regisView_btn addTarget:self action:@selector(regisViewAppear) forControlEvents:UIControlEventTouchUpInside];
        _regisView_btn = regisView_btn;
    }
    return _regisView_btn;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(244, 245, 246);
    [self.view addSubview:self.backPicView];
    [self.view addSubview:self.back_btn];
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.34, screenWide, screenHeight * 0.08)];
    backView.backgroundColor = RGB(211, 219, 228);
    [backView addSubview:self.loginView_btn];
    [backView addSubview:self.regisView_btn];
    [self.view addSubview:backView];
    [self.view addSubview:self.number_field];
    [self.view addSubview:self.passWord_field];
    [self.view  addSubview:self.public_btn];
    [self loginViewAppear];
}
//用户协议页
- (void)userAgreeMent {
    NSLog(@"用户使用协议");
}
//是否同意用户协议
- (void)agreeToAgreeMent:(UIButton *)button {
    agree = !agree;
    if (agree) {
        button.backgroundColor = [UIColor redColor];
        NSLog(@"正确，同意");
    }else {
        button.backgroundColor = [UIColor blackColor];
        NSLog(@"不同意");
    }
}
//验证手机号是否合法，并获取注册验证码
- (void)getTestNumber:(UIButton *)button {
    if (_number_field.text.length == 0) {
        UIAlertView * alertView =[[UIAlertView alloc] initWithTitle:@"请输入手机号码" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alertV = YES;
        [alertView show];
        [_number_field becomeFirstResponder];
        return;
    }
    [self gettestWithPhoneNumber:_number_field.text];
}
//验证码发送后有效时间倒计时
- (void)timeFireMethod {
    timeTick--;
    if (timeTick == 0) {
        [timer invalidate];
        _getTest_btn.enabled = YES;
        [_getTest_btn setTitle:@"获取验证码" forState: UIControlStateNormal];
    }else {
        [_getTest_btn setTitle:[NSString stringWithFormat:@"%d秒",timeTick] forState: UIControlStateNormal];
    }
}
//公共提交方法，并验证是否必填的已经填写
- (void)publicAction {
    if ([_view_type isEqualToString:@"L"]) {
        [self loginWithUserName:_number_field.text password:_passWord_field.text];

    }else {
        BOOL number = _number_field.text.length;
        BOOL test = _passWord_field.text.length;
        BOOL regis1 = _regispwd_field1.text.length;
        BOOL regis2 = _regispwd_field2.text.length;
        if (!number) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"手机号不能为空！" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alertV = YES;
            [alertView show];
            return;
        }
        if (!test) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"验证码不能为空！" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alertV = YES;
            [alertView show];
            return;
        }
        if (!regis1) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"注册密码不能为空！" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alertV = YES;
            [alertView show];
            return;
        }
        if (!regis2) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"请输入确认密码！" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alertV = YES;
            [alertView show];
            return;
        }

        if (!agree) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"请阅读并同意用户使用手册！" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alertV = YES;
            [alertView show];
            return;
        }
        [self regisWithNumber:_number_field.text pwd:_regispwd_field1.text  vfycode:_passWord_field.text];
    }
    
}
-(void)loginCurrentuser:(NSString *)phone{
    _number_field.text = phone;
}
-(void)findPassWordViewAppeaar {
    GetPassWordViewController * getPwdVC = [[GetPassWordViewController alloc] init];
    getPwdVC.delegate = self;
    if (_number_field.text.length != 0) {
        getPwdVC.number_text = _number_field.text;
    }
    [self.navigationController pushViewController:getPwdVC  animated:YES];
}
-(void)regisViewAppear {
    if ([_view_type isEqualToString:@"R"]) {
        return;
    }
    _view_type = @"R";
    [self touchesBegan:nil withEvent:nil];
    backView.layer.mask = [self creatViewlayerWithtype:@"R"];
    [_regisView_btn setTitleColor:RGB(88, 149, 224) forState:UIControlStateNormal];
    [_loginView_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_public_btn setTitle:@"注册" forState:UIControlStateNormal];
    _number_field.placeholder = @"请输入手机号码";
    _passWord_field.placeholder = @"请输入验证码";
    _passWord_field.text = @"";
    _passWord_field.secureTextEntry = NO;
    _passWord_field.keyboardType = 4;
    _regispwd_field2.text = @"";
    _regispwd_field1.text = @"";
    [self.view addSubview:self.getTest_btn];
    [self.view addSubview:self.line_lab];
    [self.findpwd_btn removeFromSuperview];
    [self.view addSubview:self.regispwd_field1];
    [self.view addSubview:self.regis_lab1];
    [self.view addSubview:self.regispwd_field2];
    [self.view addSubview:self.regis_lab2];
    [self.view addSubview:self.agree_btn];
    [self.view addSubview:self.text_label];
    [self.view addSubview:self.agreeMent_btn];
    self.public_btn.frame = CGRectMake(screenWide * 0.1, screenHeight * 0.88, screenWide * 0.8, screenHeight * 0.08);
}
-(void)loginViewAppear {
    if ([_view_type isEqualToString:@"L"]) {
        return;
    }
    [self touchesBegan:nil withEvent:nil];
    _view_type = @"L";
    backView.layer.mask = [self creatViewlayerWithtype:@"L"];
    [_loginView_btn setTitleColor:RGB(88, 149, 224) forState:UIControlStateNormal];
    [_regisView_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_public_btn setTitle:@"登录" forState:UIControlStateNormal];
    self.number_field.placeholder = @"请输入帐号";
    _passWord_field.text = @"";
    _passWord_field.placeholder = @"请输入密码";
    _passWord_field.secureTextEntry = YES;
    _passWord_field.keyboardType = UIKeyboardTypeDefault;
    [self.getTest_btn removeFromSuperview];
    [self.line_lab removeFromSuperview];
    [self.regispwd_field1 removeFromSuperview];
    [self.regis_lab1 removeFromSuperview];
    [self.regispwd_field2 removeFromSuperview];
    [self.regis_lab2 removeFromSuperview];
    [self.agreeMent_btn removeFromSuperview];
    [self.agree_btn removeFromSuperview];
    [self.text_label removeFromSuperview];
    [self.view addSubview:self.findpwd_btn];
    self.public_btn.frame = CGRectMake(screenWide * 0.1, screenHeight * 0.8, screenWide * 0.8, screenHeight * 0.08);
}
- (void)backToView {
    [self.navigationController popViewControllerAnimated:YES];
}
-(CAShapeLayer *)creatViewlayerWithtype:(NSString *)type {
    NSInteger number = 0;
    
    if ([type isEqualToString:@"R"]) {
        number = 3;
    }else{
        number = 1;
    }

    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(0, screenHeight * 0.08);
    CGPoint point3 = CGPointMake(screenWide/4 * number -8, screenHeight * 0.08);
    CGPoint point4 = CGPointMake(screenWide/4 * number, screenHeight * 0.065);
    CGPoint point5 = CGPointMake(screenWide/4 * number + 8, screenHeight * 0.08);
    CGPoint point6 = CGPointMake(screenWide, screenHeight * 0.08);
    CGPoint point7 = CGPointMake(screenWide, 0);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    [path addLineToPoint:point7];
    [path closePath];
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    return layer;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    
    CGFloat heights = self.view.frame.size.height;
    
    // 当前点击textfield的坐标的Y值 + 当前点击textFiled的高度 - （屏幕高度- 键盘高度 - 键盘上tabbar高度）
    
    // 在这一部 就是了一个 当前textfile的的最大Y值 和 键盘的最全高度的差值，用来计算整个view的偏移量
    
    int offset = frame.origin.y + 42- ( heights - 216.0-35.0) +40;//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    float width = self.view.frame.size.width;
    
    float height = self.view.frame.size.height;
    
    if(offset > 0)
        
    {
        
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        
        self.view.frame = rect;
        
    }
    
    [UIView commitAnimations];
    
    if (alertV) {
        [textField resignFirstResponder];
        [self touchesBegan:nil withEvent:nil];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
}
-(NSString *)loginWithUserName:(NSString *)username password:(NSString *)pwd {
    
    DDLogin * loginApi = [[DDLogin alloc] initWithUsername:username password:pwd];
    __block NSDictionary * dic;
    
    
    [loginApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSString *str = [request.responseString stringByReplacingOccurrencesOfString:@":null" withString:@":\"\""];
        dic = [DDLogin dictionaryWithJsonString: str];
        if ([dic[@"msg"]length] == 0) {
            [Member DefaultUser].uid = dic[@"uid"];
            [Member DefaultUser].nickname = dic[@"nickname"];
            [Member DefaultUser].sex = dic[@"gender"];
            [Member DefaultUser].birthday = dic[@"birthday"];
            [Member DefaultUser].email = dic[@"email"];
            [Member DefaultUser].phone = dic[@"phone"];
            [Member DefaultUser].avatar = dic[@"avatar"];
            [Member DefaultUser].now_money = dic[@"now_money"];
            [Member DefaultUser].score_count = dic[@"score_count"];
            [Member DefaultUser].login = @"online";
            [Member DefaultUser].pay_can = dic[@"pay_can"];
            [self.navigationController popViewControllerAnimated:YES];
            if ([_vc_type isEqualToString:@"login"]) {
                [self.delegate updateUserData];
            }
            [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
        }else {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:dic[@"msg"] message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [self touchesBegan:nil withEvent:nil];
            [alertView show];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
    }];
    
    return nil;
}
- (void)regisWithNumber:(NSString *)number pwd:(NSString *)pwd vfycode:(NSString *)vfycode {
    DDRegist * regisApi = [[DDRegist alloc] initWithRegisNumber:number pwd:pwd vfycode:vfycode];
    __block NSDictionary * dic;

    [regisApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        dic = [DDLogin dictionaryWithJsonString:request.responseString];
        if (![dic[@"msg"] isEqualToString:@"OK"]) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"注册成功！" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             [self touchesBegan:nil withEvent:nil];
            [alertView show];
        }else {
            [self loginViewAppear];
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%@",request.responseString);

    }];
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length != 0) {
        if (_number_field == textField) {
            if (![DDToolKit checkPhoneNumberWithText:textField.text]) {
                textField.text = @"";
                [SVProgressHUD showErrorWithStatus:@"手机号码错误"];
            };
        }
        
        if (textField == _regispwd_field1) {
            if (textField.text.length < 6) {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"您输入的密码过于简单，请重新输入！" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                alertV = YES;
                [alertView show];
            }
        }else if (textField == _regispwd_field2) {
            if (![_regispwd_field2.text isEqualToString:_regispwd_field1.text] && _regispwd_field2.text.length != 0) {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"您输入的密码不一致，请重新输入" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                alertV = YES;
                _regispwd_field2.text = @"";
                [alertView show];
            }
        }else if (textField == _passWord_field && [_view_type isEqualToString:@"R"]) {
            if (![_code isEqualToString:_passWord_field.text]) {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"验证码错误" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                alertV = YES;
                textField.text = @"";
                [alertView show];

            }else {
                NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
                NSString * nowtimer = [formatter stringFromDate:[NSDate date]];
                NSInteger time = nowtimer.integerValue - _time.integerValue;
                if (time > 600) {
                    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"验证码超时" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    alertV = YES;
                    textField.text = @"";
                    [alertView show];

                }
            }
        }

        
    }
}
- (void)gettestWithPhoneNumber:(NSString *)number {
    DDGetTest * getTest = [[DDGetTest alloc] initWithRegisNumber:number];
    [getTest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
        if ([dic[@"error_code"] integerValue] == 0) {
            timeTick = 600;
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
            _getTest_btn.enabled = NO;
            _code = dic[@"code"];
            _time = dic[@"time"];
            [_passWord_field becomeFirstResponder];
        }else {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:dic[@"msg"] message:nil delegate:self cancelButtonTitle:@"去登陆" otherButtonTitles:@"找回密码", nil];
             [self touchesBegan:nil withEvent:nil];
            alertView.tag = 300;
            [alertView show];
            
        }
        
        
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%@++++++%ld",request.responseString,request.responseStatusCode);
        
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex//点击弹窗按钮后
{
    if (alertView.tag == 300) {
        if (buttonIndex == 0) {//
            [self loginViewAppear];
        }else if (buttonIndex == 1){//
            [self findPassWordViewAppeaar];
        }
        return;
    }
    alertV = NO;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
