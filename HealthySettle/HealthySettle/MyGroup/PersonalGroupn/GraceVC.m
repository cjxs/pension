//
//  GraceVC.m
//  HealthySettle
//
//  Created by yrc on 16/4/11.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "GraceVC.h"
#import "ConPersonTVCell.h"
#import "ConPerAddVC.h"
#import "YYLUser.h"

@interface GraceVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation GraceVC
-(void)addContact{
    ConPerAddVC * addVC = [[ConPerAddVC alloc] init];
    addVC.title = @"新增联系人";
    [self.navigationController pushViewController:addVC animated:YES];
}
-(UIView *)headView
{
    if (!_headView)
    {
        UIView * view = [[UIView alloc]
                         initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.08)];
        view.backgroundColor = RGB(246, 246, 246);

        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(screenWide * 0.15, screenHeight * 0.02, screenWide * 0.7, screenHeight * 0.04);
        [btn setTitle:@"新增常用联系人" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(addContact) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5;
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
                                  initWithFrame:CGRectMake(0, 0, screenWide, screenHeight -64)
                                  style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.bounces = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[ConPersonTVCell class]
          forCellReuseIdentifier:@"cellCon"];
        _tableView = tableView;
    }
    return _tableView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
    
    if ([Member DefaultUser].cont_arr.count == 0) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.2, screenHeight * 0.3, screenWide * 0.6, screenHeight * 0.03)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"暂无常用联系人";
        label.textColor = [UIColor grayColor];
        [_tableView addSubview:label];
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = self.titleName;
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
    return [Member DefaultUser].cont_arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConPersonTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellCon"
                                                         forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary * dic = [Member DefaultUser].cont_arr[indexPath.row];
    [cell configWithName:dic[@"travel_name"] card:dic[@"travel_id"]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConPerAddVC * addVC = [[ConPerAddVC alloc] init];
    addVC.title = @"编辑联系人";
    addVC.data_dic =  [Member DefaultUser].cont_arr[indexPath.row];
    [self.navigationController pushViewController:addVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return screenHeight * 0.08;
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
