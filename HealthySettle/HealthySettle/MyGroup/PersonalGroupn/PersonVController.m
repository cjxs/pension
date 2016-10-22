//
//  PersonVController.m
//  HealthySettle
//
//  Created by yrc on 16/3/29.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "PersonVController.h"
#import "OrdAndRefundTVCell.h"
#import "DDOrderList.h"
#import "Order_ed.h"
//我的订单
@interface PersonVController ()<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray * dataSource;
    NSMutableArray * current_arr;
}

@end

@implementation PersonVController
-(UIView *)tableHeadView
{
    if (!_tableHeadView)
    {
        _tableHeadView = [[UIView alloc]
                          initWithFrame:CGRectMake(0, 1, screenWide, 30)];
        NSArray * array = @[@"全部", @"待付款", @"待使用", @"待评价"];
        for (int i = 0; i < 4; i++)
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i *screenWide /4, 0, screenWide /4, 29);
            btn.tag = 500 + i;
            [btn setTitle:array[i]
                 forState:UIControlStateNormal];
            [btn addTarget:self
                    action:@selector(changeDataOfbtn:)
          forControlEvents:UIControlEventTouchUpInside];
            [_tableHeadView addSubview:btn];
            UILabel * label = [[UILabel alloc]
                               initWithFrame:CGRectMake(i *screenWide /4, 29, screenWide /4, 1)];
            [_tableHeadView addSubview:label];
            if (i == 0)
            {
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                label.backgroundColor = [UIColor redColor];
            }else
            {
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                label.backgroundColor = [UIColor grayColor];
            }
        }
    }
    return _tableHeadView;
}
- (void) changeColorForAll
{
    int number = (int)_tableHeadView.subviews.count;
    for (int i = 0; i < number; i++)
    {
        if ([_tableHeadView.subviews[i] isKindOfClass:[UIButton class]])
        {
            UIButton * btn = _tableHeadView.subviews[i];
            [btn setTitleColor:[UIColor grayColor]
                      forState:UIControlStateNormal];
        }else
        {
            UILabel * lab = _tableHeadView.subviews[i];
            lab.backgroundColor = [UIColor grayColor];
        }
    }
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 31, screenWide, 500) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
- (void)changeDataOfbtn:(UIButton *)btn
{
    if (btn.titleLabel.textColor == [UIColor redColor]) {
        //释放没用的事件
    }else{
        [self changeColorForAll];
        [btn setTitleColor:[UIColor redColor]
                  forState:UIControlStateNormal];
        for (UIView *view in _tableHeadView.subviews)
        {
            if (view.frame.size.height == 1 && view.frame.origin.x == btn.frame.origin.x)
            {
                view.backgroundColor = [UIColor redColor];
            }
        }
        int wave = btn.frame.origin.x  / (screenWide / 4);
        [self changeDataWithWave:wave];
    }
}
-(void)changeDataWithWave:(int)wave
{
    [current_arr removeAllObjects];
    if (wave == 0)
    {
        current_arr = [NSMutableArray arrayWithArray:dataSource];

    }else if (wave == 1)
    {
        for (Order_ed * order in dataSource) {
            if ([order.dd_status intValue] == 19) {
                [current_arr addObject:order];
            }
        }
    }else if (wave == 2)
    {
        for (Order_ed * order in dataSource) {
            if ([order.dd_status intValue] == 20) {
                NSLog(@"^%@",order.dd_status);
                [current_arr addObject:order];
            }
        }
    }else
    {
        for (Order_ed * order in dataSource) {
            if ([order.dd_status intValue] == 21) {
                [current_arr addObject:order];
            }
        }
    }
    [self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setData];
}
-(void)setData{
    Member * user = [Member DefaultUser];
    DDOrderList * order_list = [[DDOrderList alloc] initWithUid:user.uid login:user.login];
    [order_list startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
        dataSource = [NSMutableArray arrayWithCapacity:0];
        current_arr = [NSMutableArray arrayWithCapacity:0];
        if ([dic[@"error_code"] intValue] == 0) {
            Order_ed * order;
            for (NSDictionary * dic_l in dic[@"order"]) {
                order = [Order_ed mj_objectWithKeyValues:dic_l];
                if ([order.status intValue] == 10||[order.status intValue] == 11) {
                    order.dd_status = @"21";
                }
                else if ([order.status intValue] == 3||[order.status intValue] == 7||[order.status intValue] == 1) {
                    order.dd_status = @"20";
                }else if ([order.status intValue] == 6) {
                    order.dd_status = @"19";
                }
                [dataSource addObject:order];
            }
            current_arr = [NSMutableArray arrayWithArray:dataSource];
            [self loadData];
        }
        else{
             //其他途径获取数据
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
    
}
-(void)loadData{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.tableHeadView];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrdAndRefundTVCell" bundle:nil]
         forCellReuseIdentifier:@"cellOrder"];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = _titleName;
    [self.tabBarController.tabBar setHidden:YES];
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if ([_type isEqualToString:@"order"])
    {
        return current_arr.count;
    }else if ([_type isEqualToString:@"collect"])
    {
        return 1;
    }else
    {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrdAndRefundTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellOrder"
                                                                      forIndexPath:indexPath];
    Order_ed * order = [Order_ed mj_objectWithKeyValues:current_arr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configOrderWithOrder:order];
    
       
        return cell;
 }
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return screenHeight * 0.2544;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
