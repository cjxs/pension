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
#import "SetTableViewCell.h"


static NSString *setCellIdentifier = @"cellS";

@interface MineViewController ()<UITableViewDataSource, UITableViewDelegate>{
    UITableView * setTableView;
}

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      // Do any additional setup after loading the view.sel
    [self setBottomPicWithPic:[UIImage imageNamed:@"z_03"] withPerP:[UIImage imageNamed:@"z_02"] andTitle:@"注册／登录"];
    TempView *collectView = [[TempView alloc] initWithFrame:CGRectMake(screenWide /9, screenHeight/12+100, screenWide/3, screenWide/9) withMark:[UIImage imageNamed:@"z_02"] andTitle:@"我的收藏"];
    TempView * dataView = [[TempView alloc] initWithFrame:CGRectMake(screenWide/9 * 5, screenHeight/12 + 100, screenWide / 3, screenWide / 9) withMark:[UIImage imageNamed:@"z_03"] andTitle:@"个人资料"];
    [self.view addSubview:collectView];
    [self.view addSubview:dataView];
    [self setThingsView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    setTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,screenHeight/9 *4 + 5, screenWide, screenHeight/9*2.4) style:UITableViewStylePlain];
    setTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:setTableView];
    setTableView.delegate = self;
    setTableView.dataSource = self;
    [setTableView registerClass:[SetTableViewCell class] forCellReuseIdentifier:setCellIdentifier];
    setTableView.tableHeaderView = nil;
    setTableView.scrollEnabled = NO;
    
    UIView * moreV = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight/9 *6.6, screenWide, screenHeight/9 * 0.6)];
    moreV.backgroundColor = [UIColor whiteColor];
    TempView * moreVT = [[TempView alloc] initWithFrame:CGRectMake(10, 5, screenWide/4, 40) withMark:[UIImage imageNamed:@"z_02"] andTitle:@"更多"];
    moreVT.explainTitle.textColor = [UIColor blackColor];
    [moreV addSubview:moreVT.markImageV];
    [moreV addSubview:moreVT.explainTitle];
    
    UIImageView * dirToRight = [[UIImageView alloc] initWithFrame:CGRectMake(screenWide-25, 10, 15, 20)];
    [moreV addSubview:dirToRight];
    dirToRight.image = [UIImage imageNamed:@"z_02"];//想有的小尖头的图片
    
    
    [self.view addSubview:moreV];

}
- (void)setBottomPicWithPic:(UIImage *)imageP withPerP:(UIImage *)personP andTitle:(NSString *)string {
    self.view.backgroundColor = [UIColor grayColor];
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.navigationController.navigationBarHidden = YES;
    UIImageView * topImageV =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,screenWide , screenHeight /3)];
    topImageV.image = imageP;
    topImageV.alpha = 0.85;
    [self.view addSubview:topImageV];
    UIImageView * imagePerson = [[UIImageView alloc] initWithFrame:CGRectMake(screenWide/2 -25, screenHeight /12, 50, 50)];
    imagePerson.backgroundColor = [UIColor greenColor];
    imagePerson.clipsToBounds = YES;
    imagePerson.layer.cornerRadius = 25;
    [self.view addSubview:imagePerson];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake((screenWide - 200)/2, screenHeight / 12 + 50, 200, 40)];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont systemFontOfSize:16];
    textLabel.text = string;
    textLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:textLabel];
    
}
- (void)setThingsView {
    ThingsView * orderTV = [[ThingsView alloc] initWithFrame:CGRectMake(0, screenHeight/3, screenWide /4, screenHeight/9) withMark:[UIImage imageNamed:@"z_02"] andTitle:@"我的订单"];
    ThingsView * memberTV = [[ThingsView alloc] initWithFrame:CGRectMake(screenWide /4, screenHeight/3, screenWide /4, screenHeight/9) withMark:[UIImage imageNamed:@"z_03"] andTitle:@"会员特权"];
    ThingsView * refundTV = [[ThingsView alloc] initWithFrame:CGRectMake(screenWide /2, screenHeight/3, screenWide /4, screenHeight/9) withMark:[UIImage imageNamed:@"z_03"] andTitle:@"退款维权"];
    ThingsView * commentTV = [[ThingsView alloc] initWithFrame:CGRectMake(screenWide /4*3, screenHeight/3, screenWide /4, screenHeight/9) withMark:[UIImage imageNamed:@"z_02"] andTitle:@"我的点评"];
    [self.view addSubview:orderTV];
    [self.view addSubview:memberTV];
    [self.view addSubview:refundTV];
    [self.view addSubview:commentTV];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
        return 4;
   }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetTableViewCell * cell = [setTableView dequeueReusableCellWithIdentifier:setCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
            if (indexPath.row == 0) {
                cell.tempThingV.explainTitle.text = @"现金账户";
                cell.informationLabel.text = @"¥ 0.00";
            }else if (indexPath.row == 1) {
                cell.tempThingV.explainTitle.text = @"我的积分";
                cell.informationLabel.text = @"350";
            }else if (indexPath.row == 2 ) {
                cell.tempThingV.explainTitle.text = @"优惠券";
                cell.informationLabel.text = @"1张";
            }else{
                cell.tempThingV.explainTitle.text = @"密码修改";
                [cell.informationLabel removeFromSuperview];

        }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"我惦记了地%@hang",indexPath);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return screenHeight/9 * 0.6;
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
