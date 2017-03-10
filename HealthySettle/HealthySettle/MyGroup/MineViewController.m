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
#import "DDButtonView.h"
#import "DataWebViewController.h"

static NSString *setCellIdentifier = @"cellS";

@interface MineViewController ()<UITableViewDataSource, UITableViewDelegate,UserDataDelegate,ExitLoginDelegate>
{
    UIImageView * imagePerson;
    UILabel * textLabel;
    UITapGestureRecognizer * tapRL;
    UITapGestureRecognizer * tap_refer;
}

@end

@implementation MineViewController
#pragma mark - LazyLoading
-(UIImageView *)vip_imgv{
    if (!_vip_imgv) {
        UIImageView * image_v = [[UIImageView alloc] initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.14, screenWide*0.3, screenWide *0.12)];
        _vip_imgv = image_v;

        
    }
    return _vip_imgv;
}
- (UITableView *)setTableView
{
    if (! _setTableView)
    {
        UITableView * setTableView = [[UITableView alloc]
                                      initWithFrame:CGRectMake(0,screenHeight * 0.455 , screenWide, screenHeight * 0.064 * 5 + screenHeight * 0.015) style:UITableViewStylePlain];
        setTableView.delegate = self;
        setTableView.dataSource = self;
        setTableView.backgroundColor =  RGB(244,244, 244);
        setTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [setTableView registerNib:[UINib nibWithNibName:@"SetTVCell" bundle:nil]
           forCellReuseIdentifier:setCellIdentifier];
       
        for (int i = 0; i < 3; i++)
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
    [self.navigationController.tabBarController.tabBar setHidden:NO];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    if ([Member DefaultUser].login && [textLabel.text isEqualToString:@"登录/注册"]) {
        [self performSelector:@selector(updateUserData) withObject:self afterDelay:0.05];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGB(244,244, 244);
    self.navigationController.navigationBar.translucent = NO;
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
    
    
    
    
    TempView * dataView = [[TempView alloc]
                           initWithFrame:CGRectMake(screenWide/4*3-10, screenHeight * 0.15, screenWide / 4, screenHeight * 0.05)
                           withMark:[UIImage imageNamed:@"btn_16.png"]
                           andTitle:@"个人资料"];
    UITapGestureRecognizer * tapD = [[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(clickTodata)];
    tapD.numberOfTapsRequired = 1;
    [dataView addGestureRecognizer:tapD];
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
                              initWithFrame:CGRectMake(0, 0,screenWide , screenHeight * 0.25)];
    topImageV.image = [UIImage imageNamed:@"me-background.png"];
    [self.view addSubview:topImageV];
    
    tapRL = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self
                                      action:@selector(resignOrLoad)];
    tapRL.numberOfTapsRequired = 1;
    
    imagePerson = [[UIImageView alloc]
                                 initWithFrame:CGRectMake(10, screenHeight * 0.08, screenWide * 0.22, screenWide *0.22)];
    imagePerson.image = personP;
    imagePerson.clipsToBounds = YES;
    imagePerson.layer.cornerRadius = screenWide *0.11;
    imagePerson.userInteractionEnabled = YES;
    [topImageV addGestureRecognizer:tapRL];
    [topImageV addSubview:imagePerson];
    
    textLabel = [[UILabel alloc]
                           initWithFrame:CGRectMake(screenWide * 0.28, screenHeight * 0.09, 200, screenWide *0.11)];
    textLabel.textAlignment = NSTextAlignmentLeft;
    textLabel.font = [UIFont systemFontOfSize:18];
    textLabel.text = string;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.userInteractionEnabled = YES;
    [textLabel addGestureRecognizer:tapRL];
    [self.view addSubview:textLabel];
}
- (void)setThingsView
{
    UIView * view_0 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.25, screenWide, screenHeight * 0.07-1)];
    UITapGestureRecognizer * tapD = [[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(order_list)];
    tapD.numberOfTapsRequired = 1;
    [view_0 addGestureRecognizer:tapD];
    [self.view addSubview:view_0];

    
    UIImageView * order_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, screenHeight *0.02, screenHeight *0.03, screenHeight * 0.03)];
    order_imgView.image = [UIImage imageNamed:@"note.png"];
    [view_0 addSubview:order_imgView];
    UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(screenHeight *0.04+10,screenHeight *0.015 , screenWide *0.3, screenHeight * 0.04)];
    title_label.text = @"我的订单";
    [view_0 addSubview:title_label];
    
    TempView * dataView = [[TempView alloc]
                           initWithFrame:CGRectMake(screenWide/3 * 2-10, screenHeight * 0.02, screenWide / 3, screenHeight * 0.03)
                           withMark:[UIImage imageNamed:@"right_.png"]
                           andTitle:@"查看全部订单"];
    dataView.explainTitle.adjustsFontSizeToFitWidth = YES;
    dataView.explainTitle.textColor = [UIColor grayColor];
    dataView.explainTitle.textAlignment = NSTextAlignmentRight;
    [dataView.markImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(screenHeight * 0.016, screenHeight *0.02));
        make.left.mas_equalTo(dataView.explainTitle.mas_right).offset(screenHeight * 0.002);
        make.centerY.equalTo(dataView);
    }];

    [view_0 addSubview:dataView];
    UIView * view = [[UIView alloc]
                     initWithFrame:CGRectMake(0, screenHeight * 0.32, screenWide, screenHeight * 0.12)];
    view.backgroundColor = RGB(255, 255, 255);
    NSArray * img_Array = @[@"wait_pay",@"wait_use",@"invite_code",@"sale_refund"];
    NSArray * str_Array = @[@"待付款",@"待出行",@"我的邀请码",@"退款/售后"];
    for (int i = 0; i <4; i++)
    {
        DDButtonView * btn = [[DDButtonView alloc] init];
        btn.img_view_str = img_Array[i];
        btn.label_str = str_Array[i];
        btn.tag = 401 + i;
        [btn setViews];
        btn.frame = CGRectMake(screenWide /4.0 * i,0, screenWide /4.0, screenHeight * 0.119);
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFourViews:)];
        [btn addGestureRecognizer:tap];
        tap.numberOfTapsRequired = 1;
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
        return 3;
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
                [cell setThingsWithName:@"现金账户" Image:[UIImage imageNamed:@"data"] number:[NSString stringWithFormat:@"¥ %@",[Member DefaultUser].now_money]];
            }else{
                [cell setThingsWithName:@"现金账户" Image:[UIImage imageNamed:@"data"] number:@""];
            }
        }else if (indexPath.row == 1)
        {
            if ([Member DefaultUser].login.length != 0) {
                [cell setThingsWithName:@"优悠券" Image:[UIImage imageNamed:@"tag"] number:[Member DefaultUser].vocher];
            }else{
                [cell setThingsWithName:@"优悠券" Image:[UIImage imageNamed:@"tag"] number:@""];
            }
        }else if (indexPath.row == 2 )
        {
             [cell setThingsWithName:@"常用联系人" Image:[UIImage imageNamed:@"user"] number:@""];
        }else if (indexPath.row == 3 )
        {
            [cell setThingsWithName:@"我的收藏" Image:[UIImage imageNamed:@"star.png"] number:@""];
        }
    }else
    {
        [cell setThingsWithName:@"更多" Image:[UIImage imageNamed:@"settings"] number:nil];
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
                break;
            case 2:
                [self changeToGraceVC];
                break;
            case 3:
                [self pushToComAndCollVCWithTitle:@"我的收藏"
                                             type:@"collect"];
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
    loginOrRegVC.hidesBottomBarWhenPushed = YES;//隐藏tabBar
    [self.navigationController pushViewController:loginOrRegVC animated:YES];
}
-(void)exitLogin{//退出登录,代理协议方法
    if ([[Member DefaultUser].login length] == 0) {
        imagePerson.image = [UIImage imageNamed:@"boy_head"];
        [textLabel removeGestureRecognizer:tap_refer];
        [textLabel addGestureRecognizer:tapRL];
        if (self.vip_imgv) {
            [self.vip_imgv removeFromSuperview];
        }
        textLabel.text = @"登录/注册";
        NSIndexPath *indexPath1=[NSIndexPath indexPathForRow:1 inSection:0];  //你需要更新的组数中的cell
        NSIndexPath *indexPath2=[NSIndexPath indexPathForRow:0 inSection:0];  //你需要更新的组数中的cell
        [self.setTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath1,indexPath2,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}
-(void)updateUserData{//登录成功，代理协议方法
    NSString * str = [NSString stringWithFormat:@"%@/%@",BASEURL,[Member DefaultUser].avatar];
    [imagePerson sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"boy_head"]];
    [RACObserve([Member DefaultUser], nickname)
     subscribeNext:^(id x) {
         textLabel.text = x;
     }];
     [textLabel removeGestureRecognizer:tapRL];
    tap_refer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToShare)];
    tap_refer.numberOfTapsRequired = 1;
    [textLabel addGestureRecognizer:tap_refer];
    [self.view addSubview:self.vip_imgv];

    switch ([[Member DefaultUser].role intValue]) {
        case 0:
            self.vip_imgv.image = [UIImage imageNamed:@"member_regis"];
            break;
        case 1:
            self.vip_imgv.image = [UIImage imageNamed:@"member_envoy"];

            break;
        case 2:
            self.vip_imgv.image = [UIImage imageNamed:@"member_authen"];
            break;
        case 3:
            self.vip_imgv.image = [UIImage imageNamed:@"member_regis"];
            break;
        default:
            break;
    }

    NSIndexPath *indexPath1=[NSIndexPath indexPathForRow:1 inSection:0];  //你需要更新的组数中的cell
    NSIndexPath *indexPath2=[NSIndexPath indexPathForRow:0 inSection:0];  //你需要更新的组数中的cell

    
    [self.setTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath1,indexPath2,nil] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)changeToAccountWithstr:(NSString *)str //现金账户
{
    if ([Member DefaultUser].login.length !=0) {
        AccountViewController * accountVC = [[AccountViewController alloc] init];
        accountVC.titleName = str;
        accountVC.hidesBottomBarWhenPushed = YES;//隐藏tabBar
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
        graceVC.titleName = @"常用联系人";
        graceVC.hidesBottomBarWhenPushed = YES;//隐藏tabBar
        [self.navigationController pushViewController:graceVC
                                             animated:YES];
    }else{
        [self resignOrLoad];
    }

    
}
- (void)clickTodata
{
    if ([Member DefaultUser].login.length !=0) {
        PersonDataVController * personDataVC = [[PersonDataVController alloc] init];
        personDataVC.titleName = @"个人资料";
        personDataVC.delegate = self;
        personDataVC.hidesBottomBarWhenPushed = YES;//隐藏tabBar
        [self.navigationController pushViewController:personDataVC
                                             animated:YES];
    }else{
        [self resignOrLoad];
    }

}
- (void)clickFourViews:(UITapGestureRecognizer *)btn
{
    if ([Member DefaultUser].login.length !=0) {

        int number = (int)btn.view.tag;
        switch (number)
        {
            case 401:
                [self pushToViewPersonWithTitle:@"待付款" type:@"un_paid"];
                break;
            case 402:
                [self pushToViewPersonWithTitle:@"待出行" type:@"paid"];
                break;
            case 403:
                [self pushToShare];
                break;
            case 404:
                [self pushToRefundVCWithTitle:@"退款维权" type:@"refund"];

                break;
            default:
                break;
        }
    }else{
        [self resignOrLoad];
    }

}
-(void)order_list{
    if ([Member DefaultUser].login.length !=0) {
        [self pushToViewPersonWithTitle:@"我的订单" type:@"order"];
    }else{
        [self resignOrLoad];
    }

}

- (void)pushToViewPersonWithTitle:(NSString *)title
                            type :(NSString *)type //订单
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
    viewC.hidesBottomBarWhenPushed = YES;//隐藏tabBar
    [self.navigationController pushViewController:viewC
                                         animated:YES];
}
-(void)pushToShare{
    if ([Member DefaultUser].login.length !=0) {
        [self pushToComAndCollVCWithTitle:@"我的邀请码" type:@"invite"];
    }else{
        [self resignOrLoad];
    }


}


-(void)pushToComAndCollVCWithTitle:(NSString *)title
                             type :(NSString *)type// 收藏 邀请码
{
    if ([type isEqualToString:@"invite"] &&([[Member DefaultUser].role intValue] == 0 || [[Member DefaultUser].role intValue] == 3)) {
        DataWebViewController * web_vc = [[DataWebViewController alloc] init];
        web_vc.hidesBottomBarWhenPushed = YES;//隐藏tabBar

        [self.navigationController pushViewController:web_vc animated:NO];

    }else{
        ComAndCollVC * cVC = [[ComAndCollVC alloc] init];
        if (title)
        {
            cVC.titleName = title;
        }
        if (type)
        {
            cVC.type = type;
        }
        cVC.hidesBottomBarWhenPushed = YES;//隐藏tabBar
        [self.navigationController pushViewController:cVC
                                             animated:YES];

    }

    

}
-(void)pushToRefundVCWithTitle:(NSString *)title
                         type :(NSString *)type// 退款等
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
    refundVC.hidesBottomBarWhenPushed = YES;//隐藏tabBar
    [self.navigationController pushViewController:refundVC
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
