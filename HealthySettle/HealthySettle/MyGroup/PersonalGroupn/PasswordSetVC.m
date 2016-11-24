//
//  PasswordSetVC.m
//  HealthySettle
//
//  Created by yrc on 16/11/10.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "PasswordSetVC.h"
#import "DDUpdate.h"

@interface PasswordSetVC ()

@end

@implementation PasswordSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置支付密码";
    self.view.backgroundColor = RGB(242, 242, 242);
    
    UIView * groud_view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, screenWide, 100)];
    groud_view.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 2; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 50*i, 120, 49)];
        label.font = [UIFont systemFontOfSize:17];
        switch (i) {
            case 0:
                label.text = @"支付密码：";
                break;
            case 1:
                label.text = @"确认支付密码：";
                break;
               
            default:
                break;
        }
        [groud_view addSubview:label];
    }
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(10, 49, screenWide, 1)];
    line.backgroundColor = RGB(242, 242, 242);
    [groud_view addSubview:self.fresh_passInput];
    [groud_view addSubview:self.refresh_passInput];

    [groud_view addSubview:line];
    [self.view addSubview:groud_view];

    
    RAC(self.changePass_btn,enabled) = [RACSignal combineLatest:@[self.fresh_passInput.rac_textSignal,self.refresh_passInput.rac_textSignal] reduce:^id
                                        {
                                            return @(self.fresh_passInput.text.length >= 6 && [self.refresh_passInput.text isEqualToString:self.fresh_passInput.text]);
                                        }];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(30, 150, screenWide- 60, 40);
    [btn setTitle:@"立刻设置" forState:UIControlStateNormal];
    btn.backgroundColor = RGB(248, 69, 69);
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn setBackgroundColor:[UIColor grayColor] forState:UIControlStateDisabled];

    self.changePass_btn = btn;
    [self.view addSubview:self.changePass_btn];

    [self.changePass_btn
     addTarget:self
     action:@selector(setPasswordRightNow)
     forControlEvents:UIControlEventTouchUpInside];
  


    
    
    
}
-(void)setPasswordRightNow{
    DDUpdate * pay_set = [[DDUpdate alloc] initWithProject:@"pay_pwd_set" data:@{@"data_new":_refresh_passInput.text}];
    [pay_set startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
        if ([dic[@"error_code"] intValue] == 0) {
            [SVProgressHUD showSuccessWithStatus:@"success！"];
            [Member DefaultUser].pay_can = @"Y";
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"failed！"];
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"failed！"];
        
    }];
}
- (UITextField *)fresh_passInput {
    if (!_fresh_passInput) {
        UITextField * textfField = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, screenWide -140, 49)];
        textfField.placeholder = @"请设置支付密码";
        textfField.textAlignment = NSTextAlignmentRight;
        _fresh_passInput = textfField;
    }
    return _fresh_passInput;
}
- (UITextField *)refresh_passInput{
    if (!_refresh_passInput) {
        UITextField * textfField = [[UITextField alloc] initWithFrame:CGRectMake(130, 50, screenWide -140, 49)];
        textfField.placeholder = @"请确认支付密码";
        textfField.textAlignment = NSTextAlignmentRight;
        _refresh_passInput = textfField;
    }
    return _refresh_passInput;
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
