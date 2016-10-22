//
//  ComAndCollVC.m
//  HealthySettle
//
//  Created by yrc on 16/4/7.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "ComAndCollVC.h"
#import "ComOrCollTVCell.h"
#import "DDCollectList.h"

//收藏和点评
@interface ComAndCollVC ()<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray * collect_Arr;
}

@end

@implementation ComAndCollVC
- (UITableView *)homeTableView
{
    if (!_homeTableView)
    {
        _homeTableView = [[UITableView alloc]
                          initWithFrame:CGRectMake(0, 1, screenWide, 600)];
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
        _homeTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _homeTableView.tableFooterView = [UIView new];
    }
    return _homeTableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self.type isEqualToString:@"member"])
    {
        UIImageView * imageView = [[UIImageView alloc]
                                   initWithImage:[UIImage imageNamed:@"content"]];
        imageView.frame = CGRectMake(0, 0, screenWide, screenHeight * 0.6727);
        [self.view addSubview:imageView];
    }else if ([self.type isEqualToString:@"collect"]){
        [self setCollectData];
    }
}
-(void)setCollectData{
    Member * user = [Member DefaultUser];

    DDCollectList * collect_list = [[DDCollectList alloc] initWithUid:user.uid login:user.login];
    [collect_list startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
        if ([dic[@"error_code"] intValue]== 0) {
            collect_Arr = dic[@"collect"];
            [self loadCollectData];
        }else{
            NSLog(@"出错啦%@",dic);
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
    
}
-(void)loadCollectData{
    [self.view addSubview:self.homeTableView];
    [self.homeTableView registerNib:[UINib nibWithNibName:@"ComOrCollTVCell" bundle:nil]
             forCellReuseIdentifier:@"cell123"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = _titleName;
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return collect_Arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComOrCollTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell123"
                                                             forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = collect_Arr[indexPath.row];
    [cell configRefundWithtitle:dic[@"s_name"]
                          image:dic[@"pic"]
                           type: _type
                          price:dic[@"price"]];
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
