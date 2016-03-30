//
//  PasswordCVController.m
//  HealthySettle
//
//  Created by yrc on 16/3/30.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "PasswordCVController.h"

@interface PasswordCVController ()

@end

@implementation PasswordCVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   RAC(self.changePass_btn,enabled) = [RACSignal combineLatest:@[self.used_passInput.rac_textSignal,self.fresh_passInput.rac_textSignal,self.refresh_passInput.rac_textSignal] reduce:^id{
        return @([self.used_passInput.text isEqualToString:@"123456"] && self.fresh_passInput.text.length > 0 && [self.refresh_passInput.text isEqualToString:self.fresh_passInput.text]);
    }];
    [self.changePass_btn addTarget:self action:@selector(changePasswordRightNow) forControlEvents:UIControlEventTouchUpInside];
}
-(void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = _titleName;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated {
    if (_type_from) {
    }else {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}
- (void)changePasswordRightNow {
    NSLog(@"我可以点击了");
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
