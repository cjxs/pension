//
//  PersonMSetVC.m
//  HealthySettle
//
//  Created by yrc on 16/11/10.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "PersonMSetVC.h"
#import "DDUpdate.h"
#import "DDToolKit.h"

@interface PersonMSetVC ()

@end

@implementation PersonMSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(242, 242, 242);

    UIView * groud_view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, screenWide, 50)];
    groud_view.backgroundColor = [UIColor whiteColor];
    [groud_view addSubview:self.text_Input];
    [self.view addSubview:groud_view];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(30, 150, screenWide- 60, 40);
    [btn setTitle:@"立刻设置" forState:UIControlStateNormal];
    btn.backgroundColor = RGB(248, 69, 69);
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn setBackgroundColor:[UIColor grayColor] forState:UIControlStateDisabled];
    self.change_btn = btn;
    [self.view addSubview:self.self.change_btn];

    [self.change_btn
     addTarget:self
     action:@selector(setPasswordRightNow)
     forControlEvents:UIControlEventTouchUpInside];
    RAC(self.change_btn,enabled) = [RACSignal combineLatest:@[self.text_Input.rac_textSignal] reduce:^id
            {
                if ([self.vc_type isEqualToString:@"phone"]) {
                     return @(self.text_Input.text.length > 0 && [DDToolKit checkPhoneNumberWithText:_text_Input.text]);
                }else{
                    return @(self.text_Input.text.length > 0 && [DDToolKit checkEmailWithText:_text_Input.text]);
                }
            }];
}
-(void)setPasswordRightNow{
    DDUpdate * pay_set = [[DDUpdate alloc] initWithProject:_vc_type data:@{@"data_new":_text_Input.text}];
    [pay_set startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
        if ([dic[@"error_code"] intValue] == 0) {
            [SVProgressHUD showSuccessWithStatus:@"success！"];
            if ([_vc_type isEqualToString:@"phone"]) {
                [Member DefaultUser].phone = _text_Input.text;
            }else{
                [Member DefaultUser].email = _text_Input.text;
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"failed！"];
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"failed！"];
        
    }];
}
- (UITextField *)text_Input {
    if (!_text_Input) {
        UITextField * textfField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, screenWide-40, 49)];
        textfField.placeholder = [NSString stringWithFormat:@"请输入您要绑定的%@",self.title];
        textfField.textAlignment = NSTextAlignmentCenter;
        if ([_vc_type isEqualToString:@"phone"]) {
            textfField.keyboardType = UIKeyboardTypePhonePad;
        }else{
            textfField.keyboardType = UIKeyboardTypeASCIICapable;
        }
        _text_Input = textfField;
    }
    return _text_Input;
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
