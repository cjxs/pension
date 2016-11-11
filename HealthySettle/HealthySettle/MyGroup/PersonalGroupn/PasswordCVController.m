//
//  PasswordCVController.m
//  HealthySettle
//
//  Created by yrc on 16/3/30.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "PasswordCVController.h"
#import "DDUpdate.h"

//修改密码，两个入口＋- 
@implementation PasswordCVController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.changePass_btn setBackgroundColor:[UIColor grayColor] forState:UIControlStateDisabled];
    // Do any additional setup after loading the view from its nib.
    self.changePass_btn.clipsToBounds = YES;
    self.changePass_btn.layer.cornerRadius = 5;
    RAC(self.changePass_btn,enabled) = [RACSignal combineLatest:@[self.used_passInput.rac_textSignal,self.fresh_passInput.rac_textSignal,self.refresh_passInput.rac_textSignal] reduce:^id
    {
        return @(self.used_passInput.text.length >= 6  && self.fresh_passInput.text.length >= 6 && [self.refresh_passInput.text isEqualToString:self.fresh_passInput.text]);
    }];
    [self.changePass_btn
     addTarget:self
     action:@selector(changePasswordRightNow)
     forControlEvents:UIControlEventTouchUpInside];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = _titleName;

    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)changePasswordRightNow
{
    if ([self.type_from isEqualToString:@"D"]) {
        DDUpdate * pwd_update = [[DDUpdate alloc] initWithProject:@"pwd" data:@{@"data_old":_used_passInput.text,@"data_new":_refresh_passInput.text}];
        [pwd_update startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
            if ([dic[@"error_code"] intValue] == 0) {
                [SVProgressHUD showSuccessWithStatus:@"success！"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:@"failed！"];

            }
            
        } failure:^(__kindof YTKBaseRequest *request) {
            [SVProgressHUD showErrorWithStatus:@"failed！"];

                    }];
    }else {
        DDUpdate * pay_update = [[DDUpdate alloc] initWithProject:@"pay_pwd" data:@{@"data_old":_used_passInput.text,@"data_new":_refresh_passInput.text}];
        [pay_update startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
            if ([dic[@"error_code"] intValue] == 0) {
                [SVProgressHUD showSuccessWithStatus:@"密码修改成功！"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:@"密码修改失败！"];
                
            }
            
        } failure:^(__kindof YTKBaseRequest *request) {
            [SVProgressHUD showErrorWithStatus:@"密码修改失败！"];
        }];
    }
    
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
