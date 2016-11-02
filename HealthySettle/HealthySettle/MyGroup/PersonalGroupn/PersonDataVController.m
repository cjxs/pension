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
#import "PersonNTVCell.h"

//个人资料
@interface PersonDataVController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>{
    UIButton * regis_btn;
}

@end

@implementation PersonDataVController
-(UITableView *)tableView
{
    if (!_tableView)
    {
        CGRect rect = CGRectMake(0,0, screenWide, screenHeight * 0.6);
        UITableView * tableView = [[UITableView alloc]
                                   initWithFrame:rect
                                   style:UITableViewStylePlain];
        [tableView registerNib:[UINib nibWithNibName:@"PersonTVCell" bundle:nil]
        forCellReuseIdentifier:@"personCell"];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.scrollEnabled = NO;
        tableView.tableFooterView = [UIView new];
        _tableView = tableView;
    }
    return _tableView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = _titleName;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.view addSubview:self.tableView];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = RGB(242, 242, 242);
    self.view.backgroundColor = RGB(242, 242, 242);

    UIBarButtonItem * returnBarButtonItem = [[UIBarButtonItem alloc] init];
    returnBarButtonItem.title = @"";
    self.navigationController.navigationBar.tintColor=[UIColor redColor];
    [returnBarButtonItem setBackgroundImage:[UIImage imageNamed:@"leftop_r"]
                                   forState:UIControlStateNormal
                                 barMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = returnBarButtonItem;
    regis_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    regis_btn.backgroundColor = RGB(248, 69, 69);
    regis_btn.frame = CGRectMake(screenWide * 0.05, CGRectGetMaxY(self.tableView.frame), screenWide * 0.9, screenWide * 0.15);
    [regis_btn addTarget:self action:@selector(exitLogin) forControlEvents:UIControlEventTouchUpInside];
    [regis_btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [regis_btn setTintColor:[UIColor whiteColor]];
    regis_btn.layer.cornerRadius = 10;
    [self.view addSubview:regis_btn];
    
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 4;
    }else
    {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Member * user = [Member DefaultUser];

    if (indexPath.section == 0 && indexPath.row == 0) {
        [tableView registerNib:[UINib nibWithNibName:@"PersonNTVCell" bundle:nil] forCellReuseIdentifier:@"pNewcell"];
        PersonNTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"pNewcell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else {
        PersonTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"personCell"
                                                              forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0 && indexPath.row != 0)
        {
            switch (indexPath.row)
            {
                    
                case 1:
                    if (!user.phone) {
                        [cell configClassName:@"手机号" Andresult:@"未绑定" with:@"N"];
                        
                    }else{
                        [cell configClassName:@"手机号" Andresult:user.phone with:@"Y"];
                    }
                    break;
                case 2:
                    if (!user.email) {
                        [cell configClassName:@"邮箱" Andresult:@"未绑定" with:@"N"];
                        
                    }
                    [cell configClassName:@"邮箱" Andresult:user.email with:@"Y"];
                    break;
                case 3:
                    [cell configClassName:@"会员等级" Andresult:@"普通会员" with:@"Y"];
                    break;
                default:
                    break;
            }
            
        }else
        {
            if (!user.pay_can) {
                [cell configClassName:@"支付密码" Andresult:@"未设置" with:@"N"];
            }else{
                [cell configClassName:@"支付密码" Andresult:@"修改" with:@"Y"];
            }
        }
        return cell;

    }
}
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return screenHeight * 0.16;

    }else{
        return screenHeight * 0.08;
 
    }
}
-(CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    return screenHeight * 0.015 ;
}
-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        PasswordCVController * passwordVC = [[PasswordCVController alloc]
                                             initWithNibName:@"PasswordCVController"
                                             bundle:nil];
        passwordVC.titleName = @"密码修改";
        passwordVC.type_from = @"fdhjgsfad";
        [self.navigationController pushViewController:passwordVC
                                             animated:YES];
    }else
    {
        
    }
}
-(void)exitLogin{
    Member * user = [Member DefaultUser];
    user.login = nil;
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"password"];
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate exitLogin];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
