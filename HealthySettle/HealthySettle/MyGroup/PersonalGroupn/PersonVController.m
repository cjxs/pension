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
#import "OrderStatusTVController.h"
//我的订单
@interface PersonVController ()<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray * dataSource;
    NSMutableArray * current_arr;
    UILabel * label;
    
}

@end

@implementation PersonVController
-(UIView *)tableHeadView
{
    if (!_tableHeadView)
    {
        _tableHeadView = [[UIView alloc]
                          initWithFrame:CGRectMake(0, 1, screenWide, 40)];

        NSArray * array = @[@"全部", @"待付款", @"使用中", @"已关闭"];
        for (int i = 0; i < 4; i++)
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i *screenWide /4, 0, screenWide /4, 39);
            btn.tag = 500 + i;
            [btn setTitle:array[i]
                 forState:UIControlStateNormal];
            [btn addTarget:self
                    action:@selector(changeDataOfbtn:)
          forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [_tableHeadView addSubview:btn];
            UILabel * label = [[UILabel alloc]
                               initWithFrame:CGRectMake(i *screenWide /4, 39, screenWide /4, 1)];
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, screenWide, screenHeight - 64 - 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerNib:[UINib nibWithNibName:@"OrdAndRefundTVCell" bundle:nil]
         forCellReuseIdentifier:@"cellOrder"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.backgroundColor = RGB(246, 246, 246);
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
            if ([order.dd_status intValue] == 21) {
                [current_arr addObject:order];
            }
        }
    }else
    {
        for (Order_ed * order in dataSource) {
            if ([order.dd_status intValue] == 20) {
                [current_arr addObject:order];
            }
        }
    }
    [self.tableView reloadData];
    if (current_arr.count == 0 && !label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.2, screenHeight * 0.3, screenWide * 0.6, screenHeight * 0.03)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"暂无相关订单";
        label.textColor = [UIColor grayColor];
        [self.tableView addSubview:label];
    }else{
        if (label) {
            [label removeFromSuperview];
        }
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = _titleName;

    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setData];
}
-(void)setData{
    Member * user = [Member DefaultUser];
    DDOrderList * order_list = [[DDOrderList alloc] initWithUid:user.uid login:user.login];
    [order_list startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
        if ([dic[@"error_code"] intValue] == 4) {
            //其他途径获取数据
            [SVProgressHUD showErrorWithStatus:dic[@"msg"]];

        }else{
            NSArray * arr = dic[@"order"];
            dataSource = [NSMutableArray arrayWithCapacity:0];
            current_arr = [NSMutableArray arrayWithCapacity:0];
            if (arr) {
                Order_ed * order;
                for (NSDictionary * dic_l in arr) {
                    order = [Order_ed mj_objectWithKeyValues:dic_l];
                    if ([order.status intValue] == 6) {
                        order.dd_status = @"19";
                    }else if ([order.status intValue] == 4||[order.status intValue] == 5||[order.status intValue] == 11||[order.status intValue] == 12||[order.status intValue] == 13)
                    {
                        order.dd_status = @"20";
                    }else if([order.status intValue] == 1){
                    }else{
                        order.dd_status = @"21";
                        
                    }
                    [dataSource addObject:order];
                }
                [self loadData];
            }

        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
    
}
-(void)loadData{

    if ([_type isEqualToString:@"order"]) {
        current_arr = [NSMutableArray arrayWithArray:dataSource];

    }else if ([_type isEqualToString:@"un_paid"]){
        [current_arr removeAllObjects];
        for (Order_ed * order in dataSource) {
            if ([order.dd_status intValue] == 19) {
                [current_arr addObject:order];
            }
        }

        
    }else if ([_type isEqualToString:@"paid"]){
        [current_arr removeAllObjects];
        for (Order_ed * order in dataSource) {
            if ([order.status intValue] == 1) {
                [current_arr addObject:order];
            }
        }

    }
    if (current_arr.count != 0) {
        [self.view addSubview:self.tableView];
        if (label) {
            [label removeFromSuperview];
        }

    }else{
            label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.2, screenHeight * 0.3, screenWide * 0.6, screenHeight * 0.03)];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"暂无相关订单";
            label.textColor = [UIColor grayColor];
            [self.view addSubview:label];
    }
    
    
    if ([_type isEqualToString:@"order"]) {
        self.tableView.tableHeaderView = self.tableHeadView;
        
    }




}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.barTintColor = RGB(205, 8, 20);
    self.navigationController.navigationBarHidden = NO;

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if ([_type isEqualToString:@"order"] || [_type isEqualToString:@"paid"] ||[_type isEqualToString:@"un_paid"])
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Order_ed * order = [Order_ed mj_objectWithKeyValues:current_arr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configOrderWithOrder:order type:_type];
    
       
        return cell;
 }
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return screenHeight * 0.27;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [Member DefaultUser].o_from = 3;
    OrderStatusTVController * orderDetailVC = [[OrderStatusTVController alloc] init];
    Order_ed * order = [Order_ed mj_objectWithKeyValues:current_arr[indexPath.row]];
    orderDetailVC.order = order;
    orderDetailVC.vc_type = order.cat_id;
    
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
