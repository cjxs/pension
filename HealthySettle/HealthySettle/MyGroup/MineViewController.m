//
//  MineViewController.m
//  HealthySettle
//
//  Created by yrc on 16/3/17.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "MineViewController.h"
#import "TempView.h"
#import "SetTVCell.h"
#import "PersonVController.h"
#import "PersonDataVController.h"
#import "PasswordCVController.h"
#import "RefundViewController.h"
#import "ComAndCollVC.h"
#import "GraceVC.h"
#import "AccountViewController.h"
#import "LoginOrRegisViewController.h"

static NSString *setCellIdentifier = @"cellS";

@interface MineViewController ()<UITableViewDataSource, UITableViewDelegate,UserDataDelegate,ExitLoginDelegate>
{
    UIImageView * imagePerson;
    UILabel * textLabel;
    UITapGestureRecognizer * tapRL;
}

@end

@implementation MineViewController
#pragma mark - LazyLoading

- (UITableView *)setTableView
{
    if (! _setTableView)
    {
        UITableView * setTableView = [[UITableView alloc]
                                      initWithFrame:CGRectMake(0,screenHeight * 0.465 , screenWide, screenHeight * 0.064 * 5 + screenHeight * 0.015) style:UITableViewStylePlain];
        setTableView.delegate = self;
        setTableView.dataSource = self;
        setTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [setTableView registerNib:[UINib nibWithNibName:@"SetTVCell" bundle:nil]
           forCellReuseIdentifier:setCellIdentifier];
       
        for (int i = 0; i < 4; i++)
        {
            UIView * separator = [[UIView alloc]
                                  initWithFrame:CGRectMake(0, (i+1) * screenHeight * 0.064 /* i乘以高度*/, screenWide, 1)];
            separator.backgroundColor = RGB(238, 238, 238);
            [setTableView addSubview:separator];
        }
        setTableView.tableFooterView = nil;
        setTableView.scrollEnabled = NO;
        _setTableView = setTableView;
    }
    return _setTableView;
}
#pragma mark - auto_view
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    if ([Member DefaultUser].login && [textLabel.text isEqualToString:@"登录/注册"]) {
        [self performSelector:@selector(updateUserData) withObject:self afterDelay:0.05];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.tabBarController.tabBar.translucent = YES;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGB(244,244, 244);
    self.navigationController.navigationBar.translucent = NO;
//    [UIApplication sharedApplication].statusBarHidden = YES;
    UIBarButtonItem * returnBarButtonItem = [[UIBarButtonItem alloc] init];
    returnBarButtonItem.title = @"";
    self.navigationController.navigationBar.tintColor=[UIColor redColor];
    [returnBarButtonItem setBackgroundImage:[UIImage imageNamed:@"leftop_r"]
                                   forState:UIControlStateNormal
                                 barMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = returnBarButtonItem;
    self.view.backgroundColor = RGB(243, 244, 245);//中间条的颜色
    [self setBottomPicWithPic:[UIImage imageNamed:@"person_back"]
                     withPerP:[UIImage imageNamed:@"boy_head"]
                     andTitle:@"登录/注册"];
    TempView *collectView = [[TempView alloc]
                             initWithFrame:CGRectMake(screenWide /9, screenHeight * 0.255, screenWide/3, screenHeight * 0.05) withMark:[UIImage imageNamed:@"star_"]
                             andTitle:@"我的收藏"];
    UITapGestureRecognizer * tapC = [[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(clickTwoViews:)];
    tapC.numberOfTapsRequired = 1;
    [collectView addGestureRecognizer:tapC];
    TempView * dataView = [[TempView alloc]
                           initWithFrame:CGRectMake(screenWide/9 * 5, screenHeight * 0.255, screenWide / 3, screenHeight * 0.05)
                           withMark:[UIImage imageNamed:@"user_"]
                           andTitle:@"个人资料"];
    UITapGestureRecognizer * tapD = [[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(clickTwoViews:)];
    tapD.numberOfTapsRequired = 1;
    [dataView addGestureRecognizer:tapD];
    [self.view addSubview:collectView];
    [self.view addSubview:dataView];
    [self setThingsView];
    [self.view addSubview:self.setTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)setBottomPicWithPic:(UIImage *)imageP
                   withPerP:(UIImage *)personP
                   andTitle:(NSString *)string
{
    UIImageView * topImageV =[[UIImageView alloc]
                              initWithFrame:CGRectMake(0, 0,screenWide , screenHeight * 0.33)];
    topImageV.image = imageP;
    topImageV.alpha = 0.85;
    [self.view addSubview:topImageV];
    tapRL = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self
                                      action:@selector(resignOrLoad)];
    tapRL.numberOfTapsRequired = 1;
    imagePerson = [[UIImageView alloc]
                                 initWithFrame:CGRectMake(screenWide/2 -30, screenHeight * 0.075, 60, 60)];
    imagePerson.image = personP;
    imagePerson.clipsToBounds = YES;
    imagePerson.layer.cornerRadius = 30;
    imagePerson.userInteractionEnabled = YES;
    [topImageV addGestureRecognizer:tapRL];
    [topImageV addSubview:imagePerson];
    textLabel = [[UILabel alloc]
                           initWithFrame:CGRectMake((screenWide - 200)/2, CGRectGetMaxY(imagePerson.frame), 200, 40)];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont systemFontOfSize:16];
    textLabel.text = string;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.userInteractionEnabled = YES;
    [textLabel addGestureRecognizer:tapRL];
    [self.view addSubview:textLabel];
}
- (void)setThingsView
{
    UIView * view = [[UIView alloc]
                     initWithFrame:CGRectMake(0, screenHeight * 0.33, screenWide, screenHeight * 0.119)];
    view.backgroundColor = RGB(255, 255, 255);
    NSArray * dataArray = @[@"system_1_41",@"system_1_42",@"system_1_43",@"system_1_44"];
    for (int i = 0; i <dataArray.count; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(screenWide /4.0 * i,0, screenWide /4.0, screenHeight * 0.119);
        [btn setBackgroundImage:[UIImage imageNamed:dataArray[i]]
                       forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:dataArray[i]]
                       forState:UIControlStateHighlighted];
        [btn addTarget:self
                action:@selector(clickFourViews:)
      forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 401 + i;
         [view addSubview:btn];
    }
    [self.view addSubview:view];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource, UITableViewDelegate
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
    SetTVCell * cell = [_setTableView dequeueReusableCellWithIdentifier:setCellIdentifier
                                                           forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            if ([Member DefaultUser].login.length != 0) {
                [cell setThingsWithName:@"现金账户" Image:[UIImage imageNamed:@"system_1_"] number:[NSString stringWithFormat:@"¥ %@",[Member DefaultUser].now_money]];
            }else{
                [cell setThingsWithName:@"现金账户" Image:[UIImage imageNamed:@"system_1_"] number:@""];
            }
        }else if (indexPath.row == 1)
        {
            if ([Member DefaultUser].login.length != 0) {
                [cell setThingsWithName:@"我的积分" Image:[UIImage imageNamed:@"system_2_"] number:[Member DefaultUser].score_count];
            }else{
                [cell setThingsWithName:@"我的积分" Image:[UIImage imageNamed:@"system_2_"] number:@""];
            }
        }else if (indexPath.row == 2 )
        {
            [cell setThingsWithName:@"优惠券" Image:[UIImage imageNamed:@"system_3_"] number:@""];
        }else
        {
            [cell setThingsWithName:@"密码修改" Image:[UIImage imageNamed:@"system_4_"] number:nil];
        }
    }else
    {
        [cell setThingsWithName:@"更多" Image:[UIImage imageNamed:@"system_5_"] number:nil];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row)
        {
            case 0:
                [self changeToAccountWithstr:@"现金账户"];
                break;
            case 1:
                [self changeToAccountWithstr:@"我的积分"];
                break;
            case 2:
                [self changeToGraceVC];
                break;
            case 3:
                [self changeToPasswordChangeVC];
                
                break;
            case 4:
                
                break;
                
            default:
                break;
        }

    }else{
        NSLog(@"设置");
    }
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return screenHeight * 0.064;
    }else
    {
        return screenHeight * 0.064;
    }
}

-(CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }else
    {
        return screenHeight * 0.015;
    }
    
}

#pragma mark - VTOF
- (void)resignOrLoad
{
    LoginOrRegisViewController *loginOrRegVC = [[LoginOrRegisViewController alloc] init];
    loginOrRegVC.delegate = self;
    loginOrRegVC.vc_type = @"login";
    [self.navigationController pushViewController:loginOrRegVC animated:YES];
}
-(void)exitLogin{//退出登录,代理协议方法
    if ([[Member DefaultUser].login length] == 0) {
        imagePerson.image = [UIImage imageNamed:@"boy_head"];
        [textLabel addGestureRecognizer:tapRL];
        textLabel.text = @"登录/注册";
        NSIndexPath *indexPath1=[NSIndexPath indexPathForRow:1 inSection:0];  //你需要更新的组数中的cell
        NSIndexPath *indexPath2=[NSIndexPath indexPathForRow:0 inSection:0];  //你需要更新的组数中的cell
        [self.setTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath1,indexPath2,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}
-(void)updateUserData{//登录成功，代理协议方法
    NSString * str = [NSString stringWithFormat:@"%@/%@",BASEURL,[Member DefaultUser].avatar];
    [imagePerson sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"boy_head"]];
    textLabel.text = [Member DefaultUser].nickname;
     [textLabel removeGestureRecognizer:tapRL];
    NSIndexPath *indexPath1=[NSIndexPath indexPathForRow:1 inSection:0];  //你需要更新的组数中的cell
    NSIndexPath *indexPath2=[NSIndexPath indexPathForRow:0 inSection:0];  //你需要更新的组数中的cell

    
    [self.setTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath1,indexPath2,nil] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)changeToAccountWithstr:(NSString *)str
{
    if ([Member DefaultUser].login.length !=0) {
        AccountViewController * accountVC = [[AccountViewController alloc] init];
        accountVC.titleName = str;
        [self.navigationController pushViewController:accountVC
                                             animated:YES];
    }else{
        [self resignOrLoad];
    }
    
}
- (void)changeToGraceVC
{
    if ([Member DefaultUser].login.length !=0) {
        GraceVC * graceVC = [[GraceVC alloc] init];
        graceVC.titleName = @"我的优惠券";
        [self.navigationController pushViewController:graceVC
                                             animated:YES];
    }else{
        [self resignOrLoad];
    }

    
}
- (void)changeToPasswordChangeVC{
    
    if ([Member DefaultUser].login.length !=0) {
        PasswordCVController * passwordVC = [[PasswordCVController alloc]
                                             initWithNibName:@"PasswordCVController"
                                             bundle:nil];
        passwordVC.titleName = @"密码修改";
        [self.navigationController pushViewController:passwordVC
                                             animated:YES];
    }else{
        [self resignOrLoad];
    }

}

- (void)clickTwoViews:(UITapGestureRecognizer *)gesture
{
    if ([Member DefaultUser].login.length !=0) {
        if (gesture.view.frame.origin.x < screenWide / 2)
        {
            [self pushToComAndCollVCWithTitle:@"我的收藏"
                                     type:@"collect"];
        }else
        {
            PersonDataVController * personDataVC = [[PersonDataVController alloc] init];
            personDataVC.titleName = @"个人资料";
            personDataVC.delegate = self;
            [self.navigationController pushViewController:personDataVC
                                                 animated:YES];
        }
    }else{
        [self resignOrLoad];
    }

}
- (void)clickFourViews:(UIButton *)btn
{
    if ([Member DefaultUser].login.length !=0) {

        int number = (int)btn.tag;
        switch (number)
        {
            case 401:
                [self pushToViewPersonWithTitle:@"我的订单" type:@"order"];
                break;
            case 402:
                [self pushToComAndCollVCWithTitle:@"会员特权" type:@"member"];
                break;
            case 403:
                [self pushToRefundVCWithTitle:@"退款维权" type:@"refund"];
                break;
            case 404:
                [self pushToComAndCollVCWithTitle:@"我的点评" type:@"comment"];
                break;
            default:
                break;
        }
    }else{
        [self resignOrLoad];
    }

}
-(void)pushToComAndCollVCWithTitle:(NSString *)title
                             type :(NSString *)type
{
    ComAndCollVC * cVC = [[ComAndCollVC alloc] init];
    if (title)
    {
        cVC.titleName = title;
    }
    if (type)
    {
        cVC.type = type;
    }
    [self.navigationController pushViewController:cVC
                                         animated:YES];

}
-(void)pushToRefundVCWithTitle:(NSString *)title
                         type :(NSString *)type
{
     RefundViewController * refundVC = [[RefundViewController alloc] init];
    if (title)
    {
        refundVC.titleName = title;
    }
    if (type)
    {
        refundVC.type = type;
    }
    [self.navigationController pushViewController:refundVC
                                         animated:YES];
}
- (void)pushToViewPersonWithTitle:(NSString *)title
                            type :(NSString *)type
{
    PersonVController * viewC = [[PersonVController alloc] init];
    if (title)
    {
        viewC.titleName = title;
    }
    if (type)
    {
        viewC.type = type;
    }
    [self.navigationController pushViewController:viewC
                                         animated:YES];
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
