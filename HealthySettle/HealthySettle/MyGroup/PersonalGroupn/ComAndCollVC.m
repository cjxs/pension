//
//  ComAndCollVC.m
//  HealthySettle
//
//  Created by yrc on 16/4/7.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "ComAndCollVC.h"
#import "ComOrCollTVCell.h"

//收藏和点评
@interface ComAndCollVC ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ComAndCollVC
- (UITableView *)homeTableView {
    if (!_homeTableView) {
        _homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, screenWide, 600)];
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
        _homeTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _homeTableView.tableFooterView = [UIView new];
    }
    return _homeTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self.type isEqualToString:@"member"]) {
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"content"]];
        imageView.frame = CGRectMake(0, 64, screenWide, screenHeight * 0.6727);
        [self.view addSubview:imageView];
    }else {
        [self.view addSubview:self.homeTableView];
        [self.homeTableView registerNib:[UINib nibWithNibName:@"ComOrCollTVCell" bundle:nil] forCellReuseIdentifier:@"cell123"];
    }
   }
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = _titleName;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

         ComOrCollTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell123" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configRefundWithtitle:@"杭州收藏所有养生基地" image:[UIImage imageNamed:@"order_image"] type: _type price:@"699.00"];
        return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
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

@end
