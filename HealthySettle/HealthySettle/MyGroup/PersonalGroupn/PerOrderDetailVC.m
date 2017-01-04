//
//  PerOrderDetailVC.m
//  HealthySettle
//
//  Created by yrc on 16/12/8.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "PerOrderDetailVC.h"
#import "OrderStatusTVCell.h"
#import "MassageShowTVCell.h"
#import "OrderMassageTVCell.h"
#import "Order_ed.h"
@interface PerOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PerOrderDetailVC
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight - 44-20) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    NSLog(@"%@",_order);
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[OrderStatusTVCell class] forCellReuseIdentifier:@"cellstatus"];
    [self.tableView registerClass:[MassageShowTVCell class] forCellReuseIdentifier:@"cellshow"];
    [self.tableView registerClass:[OrderMassageTVCell class] forCellReuseIdentifier:@"cellorderM"];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 140;
            break;
        case 1:
            return 130;
            break;
        case 2:
            return 50 + 80 * 1;
            break;
        case 3:
            return screenWide/4 + 70 + 230;
            break;
        default:
            return 0;
            break;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderStatusTVCell * cell1;
    MassageShowTVCell * cell2;
    OrderMassageTVCell * cell3;
    switch (indexPath.row) {
        case 0:
            cell1 = [tableView dequeueReusableCellWithIdentifier:@"cellstatus" forIndexPath:indexPath];
            cell1.order_sn_label.text = [NSString stringWithFormat:@"订单号：%@",_order.order_sn];
            CGFloat balance_money = _order.price.floatValue - _order.subsidy_money_u.floatValue;
            cell1.order_balance_money_label.text = [NSString stringWithFormat:@"%.2lf",balance_money];
            
            return cell1;
            break;
        case 1:
            cell2 = [tableView dequeueReusableCellWithIdentifier:@"cellshow" forIndexPath:indexPath];
            [cell2 configWithTitle:@"预定信息" Array:@[@"王宝强",@"18666667777"]];
            return cell2;
            break;
        case  2:
            cell2 = [tableView dequeueReusableCellWithIdentifier:@"cellshow" forIndexPath:indexPath];
            [cell2 configWithTitle:@"入住信息" Array:@[@"陈冬",@"1234566778"]];
            return cell2;

        case 3:
            cell3 = [tableView dequeueReusableCellWithIdentifier:@"cellorderM" forIndexPath:indexPath];
            [cell3 configWithOrder:_order];
            return cell3;
            break;
        default:
            return nil;
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
