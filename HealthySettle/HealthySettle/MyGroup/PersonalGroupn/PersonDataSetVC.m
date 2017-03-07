//
//  PersonDataSetVC.m
//  HealthySettle
//
//  Created by yrc on 16/11/11.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "PersonDataSetVC.h"
#import "HMDatePickView.h"
#import "DDUpdate.h"

@interface PersonDataSetVC (){
    NSString * birth_day;
    NSInteger gender;
    NSString * nick_name;
}

@end

@implementation PersonDataSetVC
-(UITextField *)name_textfield {
    if (!_name_textfield) {
        UITextField * textfField = [[UITextField alloc] initWithFrame:CGRectMake(130,0, screenWide -150, 49)];
        textfField.placeholder = @"请输入姓名";
        textfField.textAlignment = NSTextAlignmentLeft;
        [[textfField.rac_textSignal filter:^BOOL(id value) {
            NSString * text = value;
            return text.length > 0;
        }] subscribeNext:^(id x) {
            nick_name = x;
        }];
        _name_textfield = textfField;
    }
    return _name_textfield;
}
-(UIView *)color_view {
    if (!_color_view) {
        _color_view = [[UIView alloc] initWithFrame:CGRectMake(120, 97,80, 3)];
        _color_view.backgroundColor = RGB(2, 186, 242);
        
        
    }
    return _color_view;
}
- (void)loadModel {
    Member * user = [Member DefaultUser];
    if (user.nickname) {
        
        nick_name = user.nickname;
    }
    gender = [user.sex integerValue];
    if (user.birthday) {
        birth_day = user.birthday;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadModel];
    [self.group_view addSubview:self.name_textfield];
    
    self.submit_btn.layer.cornerRadius = 5;
    
    [self.group_view addSubview:self.color_view];
    [self.man_btn addTarget:self action:@selector(tap_sexButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.woman_btn addTarget:self action:@selector(tap_sexButton:) forControlEvents:UIControlEventTouchUpInside];
    self.name_textfield.placeholder = nick_name;
    if (gender== 1) {
        [self tap_sexButton:self.man_btn];
    }else if(gender== 2){
        [self tap_sexButton:self.woman_btn];
    }
    if ([birth_day intValue] == 0) {
        [self.birthday_btn setTitle:@"未选择" forState:UIControlStateNormal];
        [self.birthday_btn setTitleColor: RGB(14, 161, 207) forState:UIControlStateNormal];
    }else{
        [self.birthday_btn setTitle:birth_day forState:UIControlStateNormal];
    }
    [self.birthday_btn addTarget:self action:@selector(dateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.submit_btn addTarget:self action:@selector(submitChanges) forControlEvents:UIControlEventTouchUpInside];
    [self.birthday_btn setBackgroundColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [RACSignal combineLatest:@[self.name_textfield.rac_textSignal] reduce:^id
                                        {
                                            return @(self.name_textfield.text.length > 0);
                                        }];

    
    
}

- (void)dateBtnClick:(UIButton *)sender {
    HMDatePickView *datePickVC;
    if (datePickVC == nil) {
        /** 自定义日期选择器 */
        datePickVC = [[HMDatePickView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.5, screenWide, screenHeight * 0.5)];
        //距离当前日期的年份差（设置最大可选日期）
        datePickVC.maxYear = 1;
        //设置最小可选日期(年分差)
        //    _datePickVC.minYear = 10;
        datePickVC.date = [NSDate date];
        //设置字体颜色
        datePickVC.fontColor = [UIColor redColor];
        //日期回调
        datePickVC.completeBlock = ^(NSString *selectDate) {
            [self.birthday_btn setTitle:selectDate forState:UIControlStateNormal];
            birth_day = selectDate;
        };
        //配置属性
        [datePickVC configuration];
        
        [self.view addSubview:datePickVC];
    }else{
       
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.name_textfield resignFirstResponder];
}

- (void)tap_sexButton:(UIButton *)btn {
    
    if (btn.tintColor == RGB(2, 168, 242)) {
        
    }else{
        if ([btn.titleLabel.text isEqualToString:@"男"]) {
            [_woman_btn setTitleColor:RGB(0, 0, 0) forState:UIControlStateNormal];
        }else{
            [_man_btn setTitleColor:RGB(0, 0, 0) forState:UIControlStateNormal];
        }
        [UIView animateWithDuration:0.2f animations:^{
            [btn setTitleColor:RGB(2, 168, 242) forState:UIControlStateNormal];
            if ([btn.titleLabel.text isEqualToString:@"男"]) {
                _color_view.frame = CGRectMake(120, 97,80, 3);
                gender = 1;
            }else{
                _color_view.frame = CGRectMake(204, 97,80, 3);
                gender = 2;
            }
        }];
 
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)submitChanges{
    DDUpdate * update;
        update = [[DDUpdate alloc] initWithProject:@"user_data" data:@{@"sex":@(gender),@"nickname":nick_name,@"birthday":birth_day}];
      [update startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
        if ([dic[@"error_code"] intValue] == 6) {
            [SVProgressHUD showSuccessWithStatus:@"success！"];
            [Member DefaultUser].nickname = nick_name;
            [Member DefaultUser].sex = [NSString stringWithFormat:@"%ld",gender];
            [Member DefaultUser].birthday = birth_day;
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"failed！"];
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"failed！"];
        
    }];
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
