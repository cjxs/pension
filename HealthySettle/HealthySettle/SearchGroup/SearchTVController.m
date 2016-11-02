//
//  SearchTVController.m
//  HealthySettle
//
//  Created by yrc on 16/3/24.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "SearchTVController.h"
#import "SearchOrganTVCell.h"
#import "ShareView.h"
#import "DDFindGet.h"
#import "GroupDetailViewController.h"
#import "MJRefresh.h"
#import <SVProgressHUD.h>
@interface SearchTVController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray * data_array;
}

@end

@implementation SearchTVController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"发现 • 热门机构";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight -64 ) style:UITableViewStylePlain];
    [self.tableView registerClass:[SearchOrganTVCell class] forCellReuseIdentifier:@"cellSearch"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    [self.tableView addHeaderWithTarget:self action:@selector(loadNetWork) dateKey:@"table"];
    [self.tableView headerBeginRefreshing];
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @"小优悠正在帮你刷新中。。。";




}
- (void)loadNetWork{
    DDFindGet * find = [[DDFindGet alloc] init];
    [find startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSArray * arr = [DDLogin arrayWithJsonString:request.responseString];
        data_array = arr;
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [self.tableView headerEndRefreshing];
        [SVProgressHUD showErrorWithStatus:@"网络错误！"];
        [self performSelector:@selector(dismiss:) withObject:nil afterDelay:3];
    }];


}
- (void)dismiss:(id)sender {
    [SVProgressHUD dismiss];
}
-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.translucent = NO;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (data_array) {
        return data_array.count;
    }else{
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchOrganTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellSearch"
                                                               forIndexPath:indexPath];
    cell.clipsToBounds = YES;
    NSString *  str2 = [NSString stringWithFormat:@"%@/upload/group/%@",BASEURL,data_array[indexPath.row][@"pic"]];
    NSString * str3 = [str2 stringByReplacingOccurrencesOfString:@"," withString:@"/"];
    [cell configWithImage:str3 title:data_array[indexPath.row][@"s_name"]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return screenHeight * 0.33;
}
-(CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    return 0.5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GroupDetailViewController * resultDTVC = [[GroupDetailViewController alloc] init];
    resultDTVC.hidesBottomBarWhenPushed = YES;
    resultDTVC.group_id = data_array[indexPath.row][@"group_id"];
    [self.navigationController pushViewController:resultDTVC
                                         animated:NO];

    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSArray * visibleCells = [self.tableView visibleCells];
    for (SearchOrganTVCell * cell in visibleCells) {
        [cell cellOnTableView:self.tableView didScrollOnView:self.view];
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
