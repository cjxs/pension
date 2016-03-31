//
//  PersonVController.m
//  HealthySettle
//
//  Created by yrc on 16/3/29.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "PersonVController.h"

@interface PersonVController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation PersonVController
-(UIView *)tableHeadView {
    if (!_tableHeadView) {
        _tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, screenWide, 30)];
        NSArray * array = @[@"全部", @"待付款", @"待使用", @"待评价"];
        for (int i = 0; i < 4; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i *screenWide /4, 0, screenWide /4, 29);
            btn.tag = 500 + i;
            [btn setTitle:array[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(changeDataOfbtn:) forControlEvents:UIControlEventTouchUpInside];
            [_tableHeadView addSubview:btn];
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(i *screenWide /4, 29, screenWide /4, 1)];
            [_tableHeadView addSubview:label];
            if (i == 0) {
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                label.backgroundColor = [UIColor redColor];
            }else {
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                label.backgroundColor = [UIColor grayColor];
            }
        }
        
    }
    return _tableHeadView;
}
- (void) changeColorForAll{
    int number = (int)_tableHeadView.subviews.count;
    for (int i = 0; i < number; i++) {
        if ([_tableHeadView.subviews[i] isKindOfClass:[UIButton class]]) {
            UIButton * btn = _tableHeadView.subviews[i];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }else {
            UILabel * lab = _tableHeadView.subviews[i];
            lab.backgroundColor = [UIColor grayColor];
        }
    }
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 31, screenWide, 500)];
        
    }
    return _tableView;
}
- (void)changeDataOfbtn:(UIButton *)btn {
    [self changeColorForAll];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    for (UIView *view in _tableHeadView.subviews) {
        if (view.frame.size.height == 1 && view.frame.origin.x == btn.frame.origin.x) {
            view.backgroundColor = [UIColor redColor];
        }
    }
    int wave = btn.frame.origin.x  / (screenWide / 4);
    [self changeDataWithWave:wave];
}
-(void)changeDataWithWave:(int)wave {
    if (wave == 0) {
        NSLog(@"数组来自数据源, 数据库数组");
    }else if (wave == 1){
        NSLog(@"新建一个数组， 按所对应筛选条件滤出数组， 作为数据源");
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.tabBarController.tabBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    if ([_type isEqualToString:@"order"]) {
        [self.view addSubview:self.tableHeadView];
    }else {
        _tableView.frame = CGRectMake(0, 1, screenWide, 500);
    }
    

}
-(void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = _titleName;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
