//
//  PersonDataVController.m
//  HealthySettle
//
//  Created by yrc on 16/3/30.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "PersonDataVController.h"
#import "PersonTVCell.h"
#import "PasswordCVController.h"
@interface PersonDataVController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

@end

@implementation PersonDataVController
-(UITableView *)tableView {
    if (!_tableView) {
        CGRect rect = CGRectMake(0,0, screenWide, screenHeight);
        UITableView * tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerNib:[UINib nibWithNibName:@"PersonTVCell" bundle:nil] forCellReuseIdentifier:@"personCell"];
        tableView.scrollEnabled = NO;
        tableView.tableFooterView = [UIView new];
        _tableView = tableView;
    }
    return _tableView;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = _titleName;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.view addSubview:self.tableView];
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = RGB(242, 242, 242);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }else {
    return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"personCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.resultField.delegate = self;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
               
                [cell.NextImage removeFromSuperview];
                [cell.resultLabel removeFromSuperview];
                [cell configClassName:@"昵称" Andresult:@"输入昵称" with:@"T"];
                break;
            case 1:
                [cell.resultField removeFromSuperview];
                [cell configClassName:@"性别" Andresult:@"--" with:@"L"];
                
                break;
            case 2:
                [cell.resultField removeFromSuperview];
                [cell configClassName:@"生日" Andresult:@"请选择生日" with:@"L"];
                break;
            case 3:
                [cell.resultLabel removeFromSuperview];
                [cell.NextImage removeFromSuperview];
                [cell configClassName:@"邮箱" Andresult:@"请输入邮箱" with:@"T"];
                break;
            case 4:
                [cell.resultField removeFromSuperview];
                [cell configClassName:@"手机号" Andresult:@"13752212643" with:@"L"];
                break;
            default:
                break;
        }

    }else {
        [cell.resultField removeFromSuperview];
        [cell.resultLabel removeFromSuperview];
        [cell configClassName:@"修改密码" Andresult:nil with:nil];

    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return screenHeight * 0.064;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return screenHeight * 0.015 ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        PasswordCVController * passwordVC = [[PasswordCVController alloc] initWithNibName:@"PasswordCVController" bundle:nil];
        passwordVC.titleName = @"密码修改";
        passwordVC.type_from = @"fdhjgsfad";
        [self.navigationController pushViewController:passwordVC animated:YES];
    }else{
        
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}
@end
