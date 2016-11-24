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
#import "PasswordSetVC.h"
#import "PersonMSetVC.h"
#import "PersonDataSetVC.h"

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
    [self.navigationController setNavigationBarHidden:NO animated:animated];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = _titleName;
    [self.view addSubview:self.tableView];

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
    regis_btn.frame = CGRectMake(screenWide * 0.05, CGRectGetMaxY(self.tableView.frame) + 50, screenWide * 0.9, screenWide * 0.15);
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
        return 2;
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
        [cell configs];
        
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
                {
                    [cell configClassName:@"手机号"];
                    [RACObserve(user, phone)
                     subscribeNext:^(NSString * str) {
                         if (str.length > 0) {
                             cell.resultLabel.text = str;
                             cell.resultLabel.textColor = RGB(14, 161, 207);
                         }else{
                             cell.resultLabel.text = @"未绑定";
                             cell.resultLabel.textColor = [UIColor blackColor];
                         }
                     }];
                }
                    break;
                case 2:
                {
                    [cell configClassName:@"邮箱"];
                    [RACObserve(user, email)
                     subscribeNext:^(NSString * str) {
                         if (str.length > 0) {
                             cell.resultLabel.text = str;
                             cell.resultLabel.textColor = RGB(14, 161, 207);
                         }else{
                             cell.resultLabel.text = @"未绑定";
                             cell.resultLabel.textColor = [UIColor blackColor];
                         }
                     }];
                }
                    break;
                case 3:
                {
                    [cell configClassName:@"会员等级"];
                    cell.resultLabel.text = @"普通会员";
                }
                    break;
                default:
                    break;
            }

        }else
            {
            switch (indexPath.row)
            {
                case 1:
                {
                    [cell configClassName:@"支付密码"];
                    [RACObserve(user, pay_can)
                     subscribeNext:^(NSString * str) {
                         if ([str isEqualToString:@"Y"]) {
                             cell.resultLabel.text = @"修改";
                             cell.resultLabel.textColor = [UIColor blackColor];
                         }else{
                             cell.resultLabel.text = @"未设置";
                             cell.resultLabel.textColor = RGB(14, 161, 207);
                         }
                     }];
                }
                    break;
                case 0:
                {
                [cell configClassName:@"登录密码"];
                cell.resultLabel.text = @"修改";
                cell.resultLabel.textColor = [UIColor blackColor];
                }
                    break;
                default:
                    break;
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
    if (indexPath.section == 0&& indexPath.row == 0)
    {
        PersonDataSetVC * perDataVC = [[PersonDataSetVC alloc] init];
        perDataVC.title = @"编辑个人资料";
        [self.navigationController pushViewController:perDataVC animated:YES];
        
       
    }else if (indexPath.section == 0&& indexPath.row >=1 && indexPath.row < 3)
    {
        PersonMSetVC * personVC = [[PersonMSetVC alloc] init];
        if (indexPath.row == 1) {
            personVC.title = @"手机号";
            personVC.vc_type = @"phone";
        }else{
            personVC.title = @"邮箱";
            personVC.vc_type = @"email";
        }
        [self.navigationController pushViewController:personVC animated:YES];
    }else if (indexPath.section == 0&& indexPath.row == 3){
        
        
    }else if (indexPath.section == 1&& indexPath.row == 0){
        PasswordCVController * passwordVC = [[PasswordCVController alloc]
                                             initWithNibName:@"PasswordCVController"
                                             bundle:nil];
        passwordVC.titleName = @"登录密码修改";
        passwordVC.type_from = @"D";
        [self.navigationController pushViewController:passwordVC
                                             animated:YES];
        
    }else if (indexPath.section == 1&& indexPath.row == 1){
        
        if ([[Member DefaultUser].pay_can isEqualToString:@"N"]) {
            PasswordSetVC * passwordSet = [[PasswordSetVC alloc] init];
            [self.navigationController pushViewController:passwordSet animated:YES];
        }else{
            PasswordCVController * passwordVC = [[PasswordCVController alloc]
                                                 initWithNibName:@"PasswordCVController"
                                                 bundle:nil];
            passwordVC.titleName = @"支付密码修改";
            passwordVC.type_from = @"L";
            [self.navigationController pushViewController:passwordVC
                                                 animated:YES];

        }
        
    }else{
        
    }


}
-(void)exitLogin{
    Member * user = [Member DefaultUser];
    user.login = nil;
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"password"];
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate exitLogin];
}
-(void)updateView{
//    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
