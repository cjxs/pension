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

static NSString *setCellIdentifier = @"cellS";

@interface MineViewController ()<UITableViewDataSource, UITableViewDelegate>{
    
}

@end

@implementation MineViewController
- (UITableView *)setTableView {
    if (! _setTableView) {
        UITableView * setTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,screenHeight * 0.465 , screenWide, screenHeight * 0.064 * 5 + screenHeight * 0.015) style:UITableViewStylePlain];
        setTableView.delegate = self;
        setTableView.dataSource = self;
        setTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [setTableView registerNib:[UINib nibWithNibName:@"SetTVCell" bundle:nil] forCellReuseIdentifier:setCellIdentifier];
       
        for (int i = 0; i < 4; i++) {
            UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(0, (i+1) * screenHeight * 0.064 /* i乘以高度*/, screenWide, 1)];
            separator.backgroundColor = RGB(201, 201, 201);
            [setTableView addSubview:separator];
      
        }
        setTableView.tableFooterView = nil;
        setTableView.scrollEnabled = NO;
        _setTableView = setTableView;
 
    }
    return _setTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * returnBarButtonItem = [[UIBarButtonItem alloc] init];
    returnBarButtonItem.title = @"";
    self.navigationController.navigationBar.tintColor=[UIColor redColor];
    [returnBarButtonItem setBackgroundImage:[UIImage imageNamed:@"leftop_r"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = returnBarButtonItem;
    self.view.backgroundColor = RGB(243, 244, 245);
    [self setBottomPicWithPic:[UIImage imageNamed:@"person_back"] withPerP:[UIImage imageNamed:@"boy_head"] andTitle:@"登录/注册"];
    
    TempView *collectView = [[TempView alloc] initWithFrame:CGRectMake(screenWide /9, screenHeight * 0.255, screenWide/3, screenHeight * 0.05) withMark:[UIImage imageNamed:@"star_"] andTitle:@"我的收藏"];
    UITapGestureRecognizer * tapC = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTwoViews:)];
    tapC.numberOfTapsRequired = 1;
    [collectView addGestureRecognizer:tapC];
    TempView * dataView = [[TempView alloc] initWithFrame:CGRectMake(screenWide/9 * 5, screenHeight * 0.255, screenWide / 3, screenHeight * 0.05) withMark:[UIImage imageNamed:@"user_"] andTitle:@"个人资料"];
    UITapGestureRecognizer * tapD = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTwoViews:)];
    tapD.numberOfTapsRequired = 1;
    [dataView addGestureRecognizer:tapD];
    
    [self.view addSubview:collectView];
    [self.view addSubview:dataView];
    [self setThingsView];
    [self.view addSubview:self.setTableView];

    self.automaticallyAdjustsScrollViewInsets = NO;
   
}
- (void)setBottomPicWithPic:(UIImage *)imageP withPerP:(UIImage *)personP andTitle:(NSString *)string {
    self.view.backgroundColor = RGB(244,244, 244);
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.navigationController.navigationBarHidden = YES;
    UIImageView * topImageV =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,screenWide , screenHeight * 0.33)];
    topImageV.image = imageP;
    topImageV.alpha = 0.85;
    [self.view addSubview:topImageV];
    UITapGestureRecognizer * tapRL = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOrLoad)];
    tapRL.numberOfTapsRequired = 1;
    UIImageView * imagePerson = [[UIImageView alloc] initWithFrame:CGRectMake(screenWide/2 -30, screenHeight * 0.075, 60, 60)];
    imagePerson.image = personP;
    imagePerson.clipsToBounds = YES;
    imagePerson.layer.cornerRadius = 30;
    imagePerson.userInteractionEnabled = YES;
    [topImageV addGestureRecognizer:tapRL];
    [topImageV addSubview:imagePerson];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake((screenWide - 200)/2, CGRectGetMaxY(imagePerson.frame) + screenHeight * 0.02, 200, 40)];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont systemFontOfSize:16];
    textLabel.text = string;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.userInteractionEnabled = YES;
    [textLabel addGestureRecognizer:tapRL];
    [self.view addSubview:textLabel];
    
}
- (void)setThingsView {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.33, screenWide, screenHeight * 0.119)];
    view.backgroundColor = RGB(255, 255, 255);
    NSArray * dataArray = @[@"order_btn",@"member_btn",@"refund_btn",@"comment_btn"];
    for (int i = 0; i <dataArray.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(screenWide /4.0 * i,0, screenWide /4.0, screenHeight * 0.119);
        [btn setBackgroundImage:[UIImage imageNamed:dataArray[i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:dataArray[i]] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(clickFourViews:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 401 + i;
         [view addSubview:btn];
    }
    [self.view addSubview:view];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }else {
        return 1;
    }
   }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetTVCell * cell = [_setTableView dequeueReusableCellWithIdentifier:setCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell setThingsWithName:@"现金账户" Image:[UIImage imageNamed:@"system_1_"] number:@"¥ 0.00"];
            
        }else if (indexPath.row == 1) {
            [cell setThingsWithName:@"我的积分" Image:[UIImage imageNamed:@"system_2_"] number:@"350"];
            
        }else if (indexPath.row == 2 ) {
            [cell setThingsWithName:@"优惠券" Image:[UIImage imageNamed:@"system_3_"] number:@"1 张"];
            
            
        }else{
            [cell setThingsWithName:@"密码修改" Image:[UIImage imageNamed:@"system_4_"] number:nil];
            
        }
    }else {
        [cell setThingsWithName:@"更多" Image:[UIImage imageNamed:@"system_5_"] number:nil];

    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            [self changeToPasswordChangeVC];
            
            break;
        case 4:
            
            break;
            
        default:
            break;
    }
}
- (void)changeToPasswordChangeVC{
    PasswordCVController * passwordVC = [[PasswordCVController alloc] initWithNibName:@"PasswordCVController" bundle:nil];
    passwordVC.titleName = @"密码修改";
    [self.navigationController pushViewController:passwordVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return screenHeight * 0.064;
    }else {
        return screenHeight * 0.064;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }else {
        return screenHeight * 0.015;
    }

}
- (void)resignOrLoad {
    NSLog(@"登录");
}
- (void)clickTwoViews:(UITapGestureRecognizer *)gesture {
       if (gesture.view.frame.origin.x < screenWide / 2) {
        [self pushToComAndCollVCWithTitle:@"我的收藏" type:@"collect"];
        
    }else {
        PersonDataVController * personDataVC = [[PersonDataVController alloc] init];
        personDataVC.titleName = @"个人资料";
        [self.navigationController pushViewController:personDataVC animated:YES];
    }
}

- (void)clickFourViews:(UIButton *)btn {
    
    int number = (int)btn.tag;
    switch (number) {
        case 401:
            [self pushToViewPersonWithTitle:@"我的订单" type:@"order"];
            break;
        case 402:
            [self pushToViewPersonWithTitle:@"会员特权" type:@"member"];
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
}
-(void)pushToComAndCollVCWithTitle:(NSString *)title type :(NSString *)type {
    ComAndCollVC * cVC = [[ComAndCollVC alloc] init];
    if (title) {
        cVC.titleName = title;
    }
    if (type) {
        cVC.type = type;
    }
    [self.navigationController pushViewController:cVC animated:YES];

}
-(void)pushToRefundVCWithTitle:(NSString *)title type :(NSString *)type {
     RefundViewController * refundVC = [[RefundViewController alloc] init];
    if (title) {
        refundVC.titleName = title;
    }
    if (type) {
        refundVC.type = type;
    }

    [self.navigationController pushViewController:refundVC animated:YES];
}
- (void)pushToViewPersonWithTitle:(NSString *)title type :(NSString *)type {
    PersonVController * viewC = [[PersonVController alloc] init];
    if (title) {
        viewC.titleName = title;
    }
    if (type) {
        viewC.type = type;
    }
    [self.navigationController pushViewController:viewC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
