//
//  RefundViewController.m
//  HealthySettle
//
//  Created by yrc on 16/3/30.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "RefundViewController.h"
#import "OrdAndRefundTVCell.h"
#import "DDOrderList.h"
#import "Order_ed.h"


//维权
@interface RefundViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray * dataSource;
    NSMutableArray * current_arr;
}


@end

@implementation RefundViewController
-(UIView *)tableHeadView
{
    if (!_tableHeadView)
    {
        _tableHeadView = [[UIView alloc]
                          initWithFrame:CGRectMake(0, 1, screenWide, 30)];
        NSArray * array = @[@"全部", @"未处理", @"已退款"];
        for (int i = 0; i < 3; i++)
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i *screenWide /3, 0, screenWide /3, 29);
            btn.tag = 500 + i;
            [btn setTitle:array[i]
                 forState:UIControlStateNormal];
            [btn addTarget:self
                    action:@selector(changeDataOfbtn:)
          forControlEvents:UIControlEventTouchUpInside];
            [_tableHeadView addSubview:btn];
            UILabel * label = [[UILabel alloc]
                               initWithFrame:CGRectMake(i *screenWide /3, 29, screenWide /3, 1)];
            [_tableHeadView addSubview:label];
            if (i == 0)
            {
                [btn setTitleColor:[UIColor redColor]
                          forState:UIControlStateNormal];
                label.backgroundColor = [UIColor redColor];
            }else
            {
                [btn setTitleColor:[UIColor grayColor]
                          forState:UIControlStateNormal];
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
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]
                      initWithFrame:CGRectMake(0, 31, screenWide, 500)];
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
        if (view.frame.size.height == 1&&
            view.frame.origin.x == btn.frame.origin.x)
        {
            view.backgroundColor = [UIColor redColor];
        }
    }
    int wave = (btn.frame.origin.x+5)  / (screenWide / 3);
    [self changeDataWithWave:wave];
    }
}
-(void)changeDataWithWave:(int)wave
{
     [current_arr removeAllObjects];
    if (wave == 0)
    {
        for (Order_ed * order in dataSource) {
            if ([order.dd_status intValue] == 31||[order.dd_status intValue] == 29) {
                [current_arr addObject:order];
            }
        }
    }else if (wave == 1)
    {
        for (Order_ed * order in dataSource) {
            if ([order.dd_status intValue] == 29) {
                [current_arr addObject:order];
            }
        }
    }else{
        for (Order_ed * order in dataSource) {
            if ([order.dd_status intValue] == 31) {
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
-(void)loadData{
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrdAndRefundTVCell" bundle:nil]
         forCellReuseIdentifier:@"cellRefund"];
    [self.view addSubview:self.tableHeadView];
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
                
                if ([order.status intValue] == 2||[order.status intValue] == 9) {
                    order.dd_status = @"29";
                    [current_arr addObject:order];
                }
                else if ([order.status intValue] == 4||[order.status intValue] == 5||[order.status intValue] == 8) {
                    order.dd_status = @"31";
                    [current_arr addObject:order];
                }
                [dataSource addObject:order];
            }
            [self loadData];
        }
        else{
            //其他途径获取数据
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = _titleName;
    [self.navigationController setNavigationBarHidden:NO animated:animated];



}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
        return current_arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrdAndRefundTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellRefund"
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
