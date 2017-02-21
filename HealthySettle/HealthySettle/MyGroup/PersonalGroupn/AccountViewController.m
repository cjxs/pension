//
//  AccountViewController.m
//  HealthySettle
//
//  Created by yrc on 16/4/11.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountTVCell.h"
#import "DDMoneyList.h"
#import "DDScoreList.h"
@interface AccountViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray * data_Arr;
}

@end

@implementation AccountViewController
-(UILabel *)nomoney_label
{
    if (!_nomoney_label)
    {
        UILabel * label = [[UILabel alloc]
                           initWithFrame:CGRectMake(screenWide * 0.4, screenHeight * 0.08, screenWide * 0.2, screenHeight * 0.04)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        _nomoney_label = label;
    }
    return _nomoney_label;
}
-(UILabel *)money_label
{
    if (!_money_label)
    {
        UILabel * label = [[UILabel alloc]
                           initWithFrame:CGRectMake(screenWide * 0.3, screenHeight * 0.08, screenWide * 0.4, screenHeight * 0.04)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.adjustsFontSizeToFitWidth = YES;
        _money_label = label;
    }
    return _money_label;
}
-(UIView *)above_view
{
    if (!_above_view)
    {
        UIView * view = [[UIView alloc] init];
        view.backgroundColor = RGB(255, 255, 255);
        if ([self.titleName isEqualToString:@"我的积分"])
        {
            view.frame = CGRectMake(0, screenHeight * 0.01, screenWide, screenHeight * 0.18);
            //加限制条件判断有无积分
            if ([[Member DefaultUser].vocher integerValue] != 0 ) {
                self.money_label.text = [NSString stringWithFormat:@"我的积分:%@",[Member DefaultUser].vocher];
                [view addSubview:self.money_label];
            }else{
                self.nomoney_label.text = @"暂无积分";
                [view addSubview:self.nomoney_label];
            }
        }else
        {
            view.frame = CGRectMake(0, screenHeight * 0.01, screenWide, screenHeight * 0.29);
            UIButton * button = [[UIButton alloc]
                                 initWithFrame:CGRectMake(screenWide * 0.3, screenHeight * 0.17, screenWide * 0.4, screenHeight * 0.05)];
            [button setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];
            [button setTitle:@"提现"
                    forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            button.clipsToBounds = YES;
            button.layer.cornerRadius = 5;
            _toCash_btn = button;
            [view addSubview:button];
            //加限制条件判断有无现金
            button.backgroundColor = RGB(190, 190, 190);

            if ([[Member DefaultUser].now_money integerValue] != 0 ) {
                self.money_label.text = [NSString stringWithFormat:@"¥%@",[Member DefaultUser].now_money];
                [view addSubview:self.money_label];
            }else{
                self.nomoney_label.text = @"暂无现金";
                [view addSubview:self.nomoney_label];

            }
        }
        UIView * line = [[UIView alloc]
                         initWithFrame:CGRectMake(0, CGRectGetHeight(view.frame) - 1, screenWide, 1)];
        line.backgroundColor = RGB(234, 234, 234);
        [view addSubview:line];
        _above_view = view;
    }
    return _above_view;
}
-(UITableView *)table_view
{
    if (!_table_view)
    {
        _table_view = [[UITableView alloc]
                       initWithFrame:CGRectMake(0, CGRectGetMaxY(self.above_view.frame), screenWide, screenHeight - CGRectGetMaxY(self.above_view.frame))
                       style:UITableViewStylePlain];
        _table_view.backgroundColor = RGB(244, 244, 244);
        [_table_view registerNib:[UINib nibWithNibName:@"AccountTVCell" bundle:nil]
          forCellReuseIdentifier:@"cellAccount"];
        _table_view.bounces = NO;
        _table_view.delegate = self;
        _table_view.dataSource = self;
        _table_view.tableFooterView = [UIView new];
        _table_view.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _table_view;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGB(244, 244, 244);
    if ([self.titleName isEqualToString:@"我的积分"])
    {
        [self setScoreData];
    }else{
        [self setMoneyData];
    }
}
-(void)loadData {
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0, 0, screenWide * 0.175, 35);
//    button.titleLabel.font = [UIFont systemFontOfSize:14];
//    [button setTitle:@"全部明细" forState:UIControlStateNormal];
//    [button addTarget:self
//               action:@selector(showAllData)
//     forControlEvents:UIControlEventTouchUpInside];
//    [button setTitleColor:RGB(229, 0, 0)
//                 forState:UIControlStateNormal];
//    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]
//                                         initWithCustomView:button];
//    self.navigationItem.rightBarButtonItem = rightButtonItem;
    [self.view addSubview:self.above_view];
    [self showAllData];

}
-(void)setMoneyData {
    Member * user = [Member DefaultUser];
    DDMoneyList * money_list = [[DDMoneyList alloc] initWithUid:user.uid login:user.login];
    [money_list startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
        if ([dic[@"error_code"] intValue] == 0) {
            data_Arr = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *dic_l  in dic[@"money_list"]) {
                [data_Arr addObject:dic_l];
                }
            [self loadData];
            }
           } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%@",request.requestOperation);
    }];
}
-(void)setScoreData{
    Member * user = [Member DefaultUser];
    DDScoreList * score_list = [[DDScoreList alloc] initWithUid:user.uid login:user.login];
    [score_list startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
        if ([dic[@"error_code"] intValue] == 0) {
            data_Arr = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *dic_l  in dic[@"score_list"]) {
                [data_Arr addObject:dic_l];
            }
            [self loadData];
        }

    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
    
}

-(void)showAllData
{
    if ([self.titleName isEqualToString:@"我的积分"])
    {
        //加限制条件
        UILabel * label = [[UILabel alloc]
                           initWithFrame:CGRectMake(screenWide * 0.3, screenHeight * 0.22, screenWide * 0.4, screenHeight * 0.05)];
        label.text = @"暂无使用进度";
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = RGB(188, 188, 188);
        [self.view addSubview:label];
        [self.view addSubview:self.table_view];
    }else
    {
//        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.3, screenHeight * 0.36, screenWide * 0.4, screenHeight * 0.05)];
//        label.text = @"暂无提现进度";
//        label.font = [UIFont systemFontOfSize:14];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.textColor = RGB(188, 188, 188);
//        [self.view addSubview:label];
        [self.view addSubview:self.table_view];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = _titleName;
    [self.navigationController setNavigationBarHidden:NO animated:animated];}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return data_Arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccountTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellAccount"
                                                           forIndexPath:indexPath];
    NSDictionary * dic = data_Arr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([self.titleName isEqualToString:@"我的积分"])
    {
        [cell configWithTitle:dic[@"desc"] type:dic[@"type"] score:dic[@"score"]];
    }else{
        [cell configWithTitle:dic[@"desc"] type:dic[@"type"] money:dic[@"money"]];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return screenHeight * 0.06;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
