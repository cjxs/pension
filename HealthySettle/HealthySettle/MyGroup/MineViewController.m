//
//  MineViewController.m
//  HealthySettle
//
//  Created by yrc on 16/3/17.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "MineViewController.h"
#import "TempView.h"
#import "ThingsView.h"
#import "SetTVCell.h"
#import "PersonVController.h"
#import "PersonDataVController.h"
#import "PasswordCVController.h"
#import "RefundViewController.h"

static NSString *setCellIdentifier = @"cellS";

@interface MineViewController ()<UITableViewDataSource, UITableViewDelegate>{
    
}

@end

@implementation MineViewController
- (UITableView *)setTableView {
    if (! _setTableView) {
        UITableView * setTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,screenHeight/9 *4 + 5, screenWide, 250) style:UITableViewStylePlain];
        setTableView.delegate = self;
        setTableView.dataSource = self;
        [setTableView registerNib:[UINib nibWithNibName:@"SetTVCell" bundle:nil] forCellReuseIdentifier:setCellIdentifier];
       
        for (int i = 0; i < 8; i++) {
            UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(0, (i+1) * 50 /* i乘以高度*/, screenWide, 1)];
            
            separator.backgroundColor = [UIColor colorWithRed:0.03 * i green:0.05*i blue:0.1*i alpha:0.3];
            [setTableView addSubview:separator];
      
        }
        setTableView.tableHeaderView = nil;
        setTableView.scrollEnabled = NO;
        _setTableView = setTableView;
 
    }
    return _setTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBottomPicWithPic:[UIImage imageNamed:@"p_01"] withPerP:[UIImage imageNamed:@"z_02"] andTitle:@"注册／登录"];
    
    TempView *collectView = [[TempView alloc] initWithFrame:CGRectMake(screenWide /9, screenHeight/12+100, screenWide/3, screenWide/9) withMark:[UIImage imageNamed:@"z_02"] andTitle:@"我的收藏"];
    UITapGestureRecognizer * tapC = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTwoViews:)];
    tapC.numberOfTapsRequired = 1;
    [collectView addGestureRecognizer:tapC];
    TempView * dataView = [[TempView alloc] initWithFrame:CGRectMake(screenWide/9 * 5, screenHeight/12 + 100, screenWide / 3, screenWide / 9) withMark:[UIImage imageNamed:@"z_03"] andTitle:@"个人资料"];
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
    UIImageView * topImageV =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,screenWide , screenHeight /3)];
    topImageV.image = imageP;
    topImageV.alpha = 0.85;
    [self.view addSubview:topImageV];
    UITapGestureRecognizer * tapRL = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOrLoad)];
    tapRL.numberOfTapsRequired = 1;
    UIImageView * imagePerson = [[UIImageView alloc] initWithFrame:CGRectMake(screenWide/2 -25, screenHeight /12, 50, 50)];
    imagePerson.backgroundColor = [UIColor greenColor];
    imagePerson.clipsToBounds = YES;
    imagePerson.layer.cornerRadius = 25;
    imagePerson.userInteractionEnabled = YES;
    [topImageV addGestureRecognizer:tapRL];
    [topImageV addSubview:imagePerson];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake((screenWide - 200)/2, screenHeight / 12 + 50, 200, 40)];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont systemFontOfSize:16];
    textLabel.text = string;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.userInteractionEnabled = YES;
    [textLabel addGestureRecognizer:tapRL];
    [self.view addSubview:textLabel];
    
}
- (void)setThingsView {
    ThingsView * orderTV = [[ThingsView alloc] initWithFrame:CGRectMake(0, screenHeight/3, screenWide /4, screenHeight/9) withMark:[UIImage imageNamed:@"z_02"] andTitle:@"我的订单"];
    orderTV.tag = 401;
    UITapGestureRecognizer * tapO = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFourViews:)];
    tapO.numberOfTapsRequired = 1;
    [orderTV addGestureRecognizer:tapO];
    ThingsView * memberTV = [[ThingsView alloc] initWithFrame:CGRectMake(screenWide /4, screenHeight/3, screenWide /4, screenHeight/9) withMark:[UIImage imageNamed:@"z_03"] andTitle:@"会员特权"];
    memberTV.tag = 402;
     UITapGestureRecognizer * tapM = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFourViews:)];
    tapM.numberOfTapsRequired = 1;
    [memberTV addGestureRecognizer:tapM];
    ThingsView * refundTV = [[ThingsView alloc] initWithFrame:CGRectMake(screenWide /2, screenHeight/3, screenWide /4, screenHeight/9) withMark:[UIImage imageNamed:@"z_03"] andTitle:@"退款维权"];
    refundTV.tag = 403;
     UITapGestureRecognizer * tapR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFourViews:)];
    tapR.numberOfTapsRequired = 1;
    [refundTV addGestureRecognizer:tapR];
    ThingsView * commentTV = [[ThingsView alloc] initWithFrame:CGRectMake(screenWide /4*3, screenHeight/3, screenWide /4, screenHeight/9) withMark:[UIImage imageNamed:@"z_02"] andTitle:@"我的点评"];
    commentTV.tag = 404;
     UITapGestureRecognizer * tapC = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFourViews:)];
    tapC.numberOfTapsRequired = 1;
    [commentTV addGestureRecognizer:tapC];
    [self.view addSubview:orderTV];
    [self.view addSubview:memberTV];
    [self.view addSubview:refundTV];
    [self.view addSubview:commentTV];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
        return 5;
   }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetTVCell * cell = [_setTableView dequeueReusableCellWithIdentifier:setCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
            if (indexPath.row == 0) {
                [cell setThingsWithName:@"现金账户" Image:[UIImage imageNamed:@"z_02"] number:@"¥ 0.00"];
                
            }else if (indexPath.row == 1) {
                [cell setThingsWithName:@"我的积分" Image:[UIImage imageNamed:@"z_03"] number:@"350"];
            
            }else if (indexPath.row == 2 ) {
                [cell setThingsWithName:@"优惠券" Image:[UIImage imageNamed:@"z_02"] number:@"1 张"];

               
            }else  if (indexPath.row == 3 ){
                [cell setThingsWithName:@"密码修改" Image:[UIImage imageNamed:@"z_03"] number:nil];

            }else {
                [cell setThingsWithName:@"更多" Image:[UIImage imageNamed:@"z_03"] number:nil];
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
    return 50;
}
- (void)resignOrLoad {
    NSLog(@"登录");
}
- (void)clickTwoViews:(UITapGestureRecognizer *)gesture {
   
    if (gesture.view.frame.origin.x < screenWide / 2) {
        [self pushToViewPersonWithTitle:@"我的收藏" type:@"collect"];
        
    }else {
        PersonDataVController * personDataVC = [[PersonDataVController alloc] init];
        personDataVC.titleName = @"个人资料";
        [self.navigationController pushViewController:personDataVC animated:YES];
    }
}

- (void)clickFourViews:(UITapGestureRecognizer *)gesture {
    
    int number = (int)gesture.view.tag;
    switch (number) {
        case 401:
            [self pushToViewPersonWithTitle:@"我的订单" type:@"order"];
            break;
        case 402:
            [self pushToRefundVC];
            break;
        case 403:
            [self pushToViewPersonWithTitle:@"退款维权" type:@"refund"];
            break;
        case 404:
            [self pushToViewPersonWithTitle:@"我的点评" type:@"comment"];
            break;
        default:
            break;
    }
}
-(void)pushToRefundVC {
     RefundViewController * refundVC = [[RefundViewController alloc] init];
    refundVC.titleName = @"退款维权";
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
