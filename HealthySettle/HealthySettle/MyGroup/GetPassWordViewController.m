//
//  GetPassWordViewController.m
//  HealthySettle
//
//  Created by yrc on 16/7/20.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "GetPassWordViewController.h"
#import "DDToolKit.h"
#import "DDFindTest.h"

@interface GetPassWordViewController ()<UITextFieldDelegate> {
    UIView * backView;
    int timeTick;
    NSTimer * timer;
    NSString * _code;
    NSString * _time;
    BOOL  alertV;
}

@end

@implementation GetPassWordViewController
- (UIButton * )submit_btn {
    if (!_submit_btn) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = screenHeight * 0.04;
        button.layer.masksToBounds = YES;
        [button setTitleColor:RGB(241, 204, 110) forState:UIControlStateNormal];
        [button.layer setBorderColor:RGB(241, 204, 110).CGColor];
        [button.layer setBorderWidth:1];
        button.frame = CGRectMake(screenWide * 0.1, screenHeight * 0.83, screenWide * 0.8, screenHeight * 0.08);
        [button setTitle:@"提交" forState:UIControlStateNormal];
        _submit_btn = button;
    }
    return _submit_btn;
}

- (UIButton *)back_btn {
    if (!_back_btn) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 10,40 , 40);
        button.backgroundColor = [UIColor greenColor];
        [button addTarget:self action:@selector(backToView) forControlEvents:UIControlEventTouchUpInside];
        _back_btn = button;
    }
    return _back_btn;
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
        textfield.placeholder = @"请重新设定新密码";
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
        textfield.placeholder = @"请确认新密码";
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
- (UITextField * )number_field {
    if (!_number_field) {
        UITextField * textfield = [[UITextField alloc] initWithFrame:CGRectMake(screenWide * 0.1, screenHeight * 0.45, screenWide * 0.8, screenHeight * 0.07)];
        textfield.keyboardType = UIKeyboardTypeNumberPad;
        textfield.placeholder = @"请输入您的手机号";
        if (_number_text.length != 0) {
            textfield.text = _number_text;
        }
        _number_field = textfield;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.08, screenHeight * 0.53, screenWide * 0.84, 1)];
        label.backgroundColor = RGB(224, 225, 226);
        textfield.delegate = self;
        [self.view addSubview:label];
    }
    return _number_field;
}
- (UITextField * )test_field {
    if (!_test_field) {
        UITextField * textfield = [[UITextField alloc] initWithFrame:CGRectMake(screenWide * 0.1, screenHeight * 0.55, screenWide * 0.8, screenHeight * 0.07)];
        _test_field = textfield;
        textfield.placeholder = @"请输入验证码";
        textfield.keyboardType = UIKeyboardTypeNumberPad;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.08, screenHeight * 0.63, screenWide * 0.84, 1)];
        label.backgroundColor = RGB(224, 225, 226);
        textfield.delegate = self;
        [self.view addSubview:label];
    }
    return _test_field;
}
- (UIImageView * )backPicView {
    if (!_backPicView) {
        UIImageView * backPicView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.34)];
        backPicView.image = [UIImage imageNamed:@"custom_number"];
        _backPicView = backPicView;
    }
    return _backPicView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    alertV = NO;
    self.view.backgroundColor = RGB(244, 245, 246);
    [self.view addSubview:self.backPicView];
    [self.view addSubview:self.back_btn];
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.34, screenWide, screenHeight * 0.08)];
    backView.backgroundColor = RGB(211, 219, 228);
    [self.view addSubview:backView];
    backView.layer.mask = [self creatViewlayer];
    UILabel * titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.08)];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.text = @"找回密码";
    titleL.textColor = RGB(88, 149, 224);
    [backView addSubview:titleL];
    [self.view addSubview:self.number_field];
    [self.view addSubview:self.test_field];
    [self.view addSubview:self.getTest_btn];
    [self.view addSubview:self.regispwd_field1];
    [self.view addSubview:self.regis_lab1];
    [self.view addSubview:self.line_lab];
    [self.view addSubview:self.regispwd_field2];
    [self.view addSubview:self.regis_lab2];
    [self.view addSubview:self.submit_btn];

}
- (void)submitAction {
    BOOL number = _number_field.text.length;
    BOOL test = _test_field.text.length;
    BOOL regis1 = _regispwd_field1.text.length;
    BOOL regis2 = _regispwd_field2.text.length;
    if (!number) {
       UIAlertView *   alertView = [[UIAlertView alloc] initWithTitle:@"手机号不能为空！" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alertV = YES;
        [alertView show];
    }
    if (!test) {
       UIAlertView *  alertView = [[UIAlertView alloc] initWithTitle:@"验证码不能为空！" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alertV = YES;
        [alertView show];
    }
    
    
    if (!regis1) {
       UIAlertView *  alertView = [[UIAlertView alloc] initWithTitle:@"密码不能为空！" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alertV = YES;
        [alertView show];
    }
    if (!regis2) {
       UIAlertView *  alertView = [[UIAlertView alloc] initWithTitle:@"请输入确认密码！" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alertV = YES;
        [alertView show];
    }
    NSLog(@"提交");

}
- (void)backToView {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)getTestNumber:(UIButton *)button {
    [self gettestWithPhoneNumber:_number_field.text];
    
}
- (void)gettestWithPhoneNumber:(NSString *)number {
    DDFindTest * findTest = [[DDFindTest alloc] initWithUserNumber:number];
    [findTest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
        
        if ([dic[@"error_code"] integerValue] == 0) {
            timeTick = 601;
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
            _getTest_btn.enabled = NO;
            _code = dic[@"code"];
            _time = dic[@"time"];
            NSLog(@"%@",dic);
        }else {
          UIAlertView *   alertView = [[UIAlertView alloc] initWithTitle:dic[@"msg"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alertV = YES;
            [alertView show];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%@++++++%ld",request.responseString,request.responseStatusCode);
        
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
                textField.text = @"";
                alertV = YES;
                [alertView show];
            }
        }else if (textField == _regispwd_field2) {
            if (![_regispwd_field2.text isEqualToString:_regispwd_field1.text] && _regispwd_field2.text.length != 0) {
              UIAlertView *   alertView = [[UIAlertView alloc] initWithTitle:@"您输入的密码不一致，请重新输入" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                _regispwd_field2.text = @"";
                alertV = YES;
                [alertView show];
            }
        }else if (textField == _test_field ) {
            if (![_code isEqualToString:_test_field.text]) {
              UIAlertView *   alertView = [[UIAlertView alloc] initWithTitle:@"验证码错误" message:nil delegate:self
                                             cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                textField.text = @"";
                alertV = YES;
                [alertView show];
            }else {
                NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
                NSString * nowtimer = [formatter stringFromDate:[NSDate date]];
                NSInteger time = nowtimer.integerValue - _time.integerValue;
                if (time > 600) {
                   UIAlertView *  alertView = [[UIAlertView alloc] initWithTitle:@"验证码超时" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    textField.text = @"";
                    alertV = YES;
                    [alertView show];
                    
                }
            }
        }
    }
}

-(CAShapeLayer *)creatViewlayer {
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(0, screenHeight * 0.08);
    CGPoint point3 = CGPointMake(screenWide/2 -8, screenHeight * 0.08);
    CGPoint point4 = CGPointMake(screenWide/2, screenHeight * 0.065);
    CGPoint point5 = CGPointMake(screenWide/2 + 8, screenHeight * 0.08);
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
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self viewWillMoveOfTextField:textField];
    if (alertV) {
        [textField resignFirstResponder];
        [self touchesBegan:nil withEvent:nil];
    }
}
- (void)viewWillMoveOfTextField:(UITextField *)textField {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex//点击弹窗按钮后
{
    alertV = NO;
    
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
