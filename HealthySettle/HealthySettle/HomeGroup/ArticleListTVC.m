//
//  ArticleListTVC.m
//  HealthySettle
//
//  Created by yrc on 16/10/26.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "ArticleListTVC.h"
#import "DDArticleList.h"
#import "ArticleListTViewCell.h"
#import "DDArticleDetail.h"
#import "WebViewController.h"

@interface ArticleListTVC (){
    NSArray * data_Arr;
}

@end

@implementation ArticleListTVC
- (UIView *)view_head {
    if (!_view_head) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, 20)];
        view.backgroundColor = RGB(242, 242, 242);
        _view_head = view;
    }
    return _view_head;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
    [self.navigationController setNavigationBarHidden:NO
                                             animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    [self.tableView registerClass:[ArticleListTViewCell class] forCellReuseIdentifier:@"article"];
    self.tableView.tableFooterView = [UIView new];
  
}

-(void)setData{
    DDArticleList * articleList = [[DDArticleList alloc] initWithtype:_type];
    [articleList startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        data_Arr = [DDLogin arrayWithJsonString:request.responseString];
        self.tableView.tableHeaderView = self.view_head;
        [self.tableView reloadData];
        
        
        
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"失败");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (data_Arr) {
        return data_Arr.count;
    }else{
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleListTViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"article" forIndexPath:indexPath];
    NSDictionary * dic = data_Arr[indexPath.row];
    [cell configWithDic:dic];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.view.alpha = 1;
    }else{
        cell.view.alpha = 0;
        
    }
    
   
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * article_id = data_Arr[indexPath.row][@"id"];//时机不成熟
    WebViewController * web_vc = [[WebViewController alloc] init];
    NSString * str= [NSString stringWithFormat:@"http://m.5199yl.com/#/article/%@?id=%@",_type,article_id];
    web_vc.urlLoad = [NSURL URLWithString:str];
    [self.navigationController pushViewController:web_vc animated:YES];
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

@end
