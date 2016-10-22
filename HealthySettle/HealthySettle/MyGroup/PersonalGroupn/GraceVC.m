//
//  GraceVC.m
//  HealthySettle
//
//  Created by yrc on 16/4/11.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "GraceVC.h"
#import "GraceTVCell.h"

@interface GraceVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation GraceVC
-(UIView *)headView
{
    if (!_headView)
    {
        UIView * view = [[UIView alloc]
                         initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.08)];
        UILabel * label = [[UILabel alloc]
                           initWithFrame:CGRectMake(screenWide * 0.03, screenHeight * 0.015, screenWide * 0.3, screenHeight * 0.05)];
        label.text = @"请输入优惠券序列号:";
        label.textColor = RGB(138, 138, 138);
        label.font = [UIFont systemFontOfSize:14];
        label.adjustsFontSizeToFitWidth = YES;
        [view addSubview:label];
        UITextField * textfield = [[UITextField alloc]
                                   initWithFrame:CGRectMake(screenWide * 0.35, screenHeight * 0.02, screenWide * 0.42, screenHeight * 0.04)];
        textfield.borderStyle = UITextBorderStyleLine;
        textfield.font = [UIFont systemFontOfSize:10];
        textfield.layer.borderColor = [RGB(252, 252, 252) CGColor];
        textfield.layer.borderWidth = 1;
        textfield.clearButtonMode = UITextFieldViewModeAlways;
        [view addSubview:textfield];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(screenWide * 0.8, screenHeight * 0.02, screenWide * 0.17, screenHeight * 0.04);
        [btn setTitle:@"激活" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:11];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 4;
        [btn setTitleColor:[UIColor whiteColor]
                  forState:UIControlStateNormal];
        btn.backgroundColor = RGB(230, 11, 24);
        [view addSubview:btn];
        _headView = view;
    }
    return _headView;
}
-(UITableView *)tableView
{
    if (!_tableView)
    {
        UITableView *tableView = [[UITableView alloc]
                                  initWithFrame:CGRectMake(0, 0, screenWide, screenHeight -64 - 49)
                                  style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.bounces = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[GraceTVCell class]
          forCellReuseIdentifier:@"cellGrace"];
        _tableView = tableView;
    }
    return _tableView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = self.titleName;
    [self.tabBarController.tabBar setHidden:NO];
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GraceTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellGrace"
                                                         forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row)
    {
        case 0:
            [cell configWithMoneystr:@"10" use:@"100" timeF:@"2016.05.07" timeT:@"2016.11.07"];
            break;
        case 2:
            [cell configWithMoneystr:@"50" use:@"500" timeF:@"2016.03.11" timeT:@"2016.09.11"];
            break;
            
        default:
            [cell configWithMoneystr:@"30" use:@"300" timeF:@"2015.05.07" timeT:@"2016.11.07"];
            break;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return screenHeight * 0.21;
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
