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
#import "UIImage+DDImage.h"
@interface SearchTVController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray * data_array;
    NSDictionary * dic;
    UIScrollView * scr_view;
    int _num;
    UIView * fbg_view;
}

@end

@implementation SearchTVController
-(UIView *)tableHeadView{
    if (!_tableHeadView) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide , screenHeight * 0.05997)];
        view.backgroundColor = WHITECOLOR;
        _tableHeadView = view;
//        UIView * img_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.07496)];
//        UIImage *bg_img = [UIImage gradientColorImageFromColors:@[[UIColor colorWithHexString:@"#898ede"],[UIColor colorWithHexString:@"#be7daf"]] gradientType:GradientTypeLeftToRight imgSize:CGSizeMake(screenWide, screenHeight * 0.07496)];
//        img_view.backgroundColor = [UIColor colorWithPatternImage:bg_img];
//        
//        [_tableHeadView addSubview:img_view];
        if (dic &&[dic[@"tag"] count] > 3) {
            int number = [dic[@"tag"] count];
            scr_view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.05997)];
            scr_view.contentSize = CGSizeMake(screenWide*5/16*number-screenWide/16, screenHeight * 0.05997);
            scr_view.showsHorizontalScrollIndicator = NO;
            scr_view.delegate = self;
            for (int i = 0; i < number; i++) {
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(screenWide*5/16 * i, 0, screenWide/4, screenHeight*0.05997-1);
                [btn addTarget:self action:@selector(scrolToGroupWithButton:) forControlEvents:UIControlEventTouchUpInside];
                btn.titleLabel.font = [UIFont systemFontOfSize:15];
                [btn setTitle:dic[@"tag"][i][@"tag_name"] forState:UIControlStateNormal];
                [scr_view addSubview:btn];
                UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(screenWide*5/16 * i, screenHeight* 0.05997-1, screenWide/4, 1)];
                [scr_view addSubview:line_view];
                if (i == 0) {
                    line_view.backgroundColor = PINKCOLOR;
                    [btn setTitleColor:PINKCOLOR forState:UIControlStateNormal];
                }else{
                    line_view.backgroundColor = WHITECOLOR;
                    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
                
            }
            [_tableHeadView addSubview:scr_view];
            
        }else{
            NSLog(@"+++");
        }
        
        
        
        
    }
    return _tableHeadView;
}
-(void)scrolToGroupWithButton:(UIButton *)btn{
    int num = btn.frame.origin.x/screenWide/5 * 16;

    if (_num == num) {
    }else{
        _num = num;
        [self changeColorsWithnumber:num];
        self.tableView.contentOffset = CGPointMake(0,screenHeight * 0.008+ screenHeight * 0.32*4 * num);
        
    }
}
-(void)changeColorsWithnumber:(int)number{
    for (int i = 0;i < scr_view.subviews.count;i++) {
        if ([scr_view.subviews[i] isKindOfClass:[UIButton class]]) {
            UIButton * btn = scr_view.subviews[i];
            if (btn.frame.origin.x/screenWide/5 * 16 == number) {
                [btn setTitleColor:[UIColor redColor]
                          forState:UIControlStateNormal];
            }else{
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }else{
            
            UIView * view = scr_view.subviews[i];
            if (view.frame.origin.x/screenWide/5 * 16 == number) {
                view.backgroundColor = [UIColor redColor];
            }else{
                view.backgroundColor = WHITECOLOR;
            }
        }
    }
    [UIView animateWithDuration:0.3f animations:^{
        switch (number) {
            case 0:
                scr_view.contentOffset = CGPointMake(0, 0);
                break;
            case 1:
                scr_view.contentOffset = CGPointMake(0, 0);
                break;
            case 2:
                scr_view.contentOffset = CGPointMake(87, 0);
                break;
            case 3:
                scr_view.contentOffset = CGPointMake(207, 0);
                break;
            case 4:
                scr_view.contentOffset = CGPointMake(207, 0);
                break;
                
            default:
                break;
        }

    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"发现 • 热门机构";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.05997, screenWide, screenHeight*(1-0.05997) -64 -44) style:UITableViewStylePlain];
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
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.01799)];
    _tableView.tableHeaderView.backgroundColor = WHITECOLOR;
    fbg_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight)];
    fbg_view.backgroundColor = WHITECOLOR;
    [self.view addSubview:fbg_view];
    [self.view bringSubviewToFront:fbg_view];



}
- (void)loadNetWork{
    DDFindGet * find = [[DDFindGet alloc] init];
    [find startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        dic = [DDLogin dictionaryWithJsonString:request.responseString];
        if ([dic[@"error_code"] intValue] == 4) {
            [SVProgressHUD showErrorWithStatus:@"暂时没有相应数据！"];
        }else{
            [self.tableView reloadData];
            [self.view addSubview:self.tableHeadView];
            [self.tableView headerEndRefreshing];
            if (fbg_view) {
                [fbg_view removeFromSuperview];
            }

        }
        
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
    return [dic[@"tag"] count];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSArray * arr = dic[@"tag"][section][@"tag_info"];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchOrganTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellSearch"
                                                               forIndexPath:indexPath];
    cell.clipsToBounds = YES;
    NSDictionary * dic_cell = dic[@"tag"][indexPath.section][@"tag_info"][indexPath.row];
    [cell configWithImage:dic_cell[@"img"] title:dic_cell[@"area_name"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return screenHeight * 0.32;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    GroupDetailViewController * resultDTVC = [[GroupDetailViewController alloc] init];
//    resultDTVC.hidesBottomBarWhenPushed = YES;
//    resultDTVC.group_id = data_array[indexPath.row][@"group_id"];
//    [self.navigationController pushViewController:resultDTVC
//                                         animated:NO];

    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_tableView == scrollView) {
        NSArray * visibleCells = [self.tableView visibleCells];
        for (SearchOrganTVCell * cell in visibleCells) {
            [cell cellOnTableView:self.tableView didScrollOnView:self.view];
        }
        CGFloat fla = (scrollView.contentOffset.y-screenHeight * 0.008)/(screenHeight*4*0.32);
        int num = roundf(fla);
        if (num != _num) {
            [self changeColorsWithnumber:num];
            _num = num;
        }
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
