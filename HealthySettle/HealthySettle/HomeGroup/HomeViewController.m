//
//  HomeViewController.m
//  HealthySettle
//
//  Created by yrc on 16/3/17.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "HomeViewController.h"
#import "TempView.h"
#import "CitySkipViewCell.h"
#import "SearchVController.h"
#import "SeasonCTViewCell.h"
#import <MTMigration.h>
#import "ProductTipView.h"
#import "WebViewController.h"
#import "KnowledgeTVController.h"
#import "SeasonMCollectViewCell.h"
#import "MonthViewController.h"
#import "ShareView.h"
#import "DDHome_page.h"
#import "YTKNetworkConfig.h"
#import "SDCycleScrollView.h"
#import "ResultListVController.h"
#import "ArticleListTVC.h"
#import "MJRefresh.h"
#import <SVProgressHUD.h>




@interface HomeViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate,UIWebViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate,CityListDelegate>
{
    NSMutableArray * imagesA;
    NSArray * urlA;
    UILabel * city_btn_label;
    UIView * bg_view;
    UIButton * back_btn;
    NSArray * seasonsA;
    NSArray * tag_A;
    SDCycleScrollView *cycleScrollView3;
}



@end

@implementation HomeViewController
#pragma mark - LazyLoading
-(UIWebView *)webView {
    if (_webView == nil) {
        bg_view = [[UIView alloc] initWithFrame:CGRectMake(0,0, screenWide, screenHeight)];
        bg_view.backgroundColor = [UIColor whiteColor];
        
        back_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        back_btn.frame = CGRectMake(10, 20, 20, 20*1.85);
        [back_btn setBackgroundImage:[UIImage imageNamed:@"leftop_r"] forState:UIControlStateNormal];
        [back_btn addTarget:self action:@selector(cancelWeb:) forControlEvents:UIControlEventTouchUpInside];
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,64, screenWide, screenHeight-64)];
        [_webView setUserInteractionEnabled:YES];//是否支持交互
        _webView.delegate=self;
        [_webView setOpaque:NO];//opaque是不透明的意思
        [_webView setScalesPageToFit:YES];//自动缩放以适应屏幕
    }
    return _webView;
}
- (void)cancelWeb:(UIButton *)btn {
    [_webView removeFromSuperview];
    [btn removeFromSuperview];
    [bg_view removeFromSuperview];
}
- (void)setBanner {
    cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, screenWide , screenHeight * 0.222) delegate:self placeholderImage:[UIImage imageNamed:@"banner_p"]];
    cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    cycleScrollView3.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    cycleScrollView3.imageURLStringsGroup = imagesA;
    [_tableHeadView addSubview:cycleScrollView3];
}
- (UIView *)tableHeadView
{
    if (_tableHeadView == nil )
    {
        _tableHeadView = [[UIView alloc]
                          initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.477)];
        
        //轮播图下面的2+4
        UIButton * regimenFind_btn = [UIButton buttonWithType:UIButtonTypeSystem];
        regimenFind_btn.frame = CGRectMake(screenWide * 0.015, screenHeight * 0.227, screenWide * 0.48 , screenHeight * 0.12 );
        [regimenFind_btn addTarget:self
                            action:@selector(skipTOSecond:)
                  forControlEvents:UIControlEventTouchUpInside];
        [regimenFind_btn setBackgroundImage:[UIImage imageNamed:@"regimenFind_btn"]
                                   forState:UIControlStateNormal];
        regimenFind_btn.clipsToBounds = YES;
        regimenFind_btn.layer.cornerRadius = 5;
        [_tableHeadView addSubview:regimenFind_btn];
        UIButton * pensionFind_btn = [UIButton buttonWithType:UIButtonTypeSystem];
        pensionFind_btn.frame = CGRectMake(screenWide *0.505 , screenHeight * 0.227, screenWide * 0.48, screenHeight *0.12 );
        [pensionFind_btn addTarget:self
                            action:@selector(skipTOSecond:)
                  forControlEvents:UIControlEventTouchUpInside];
        [pensionFind_btn setBackgroundImage:[UIImage imageNamed:@"pensionFind_btn"]
                                   forState:UIControlStateNormal];
        pensionFind_btn.clipsToBounds = YES;
        pensionFind_btn.layer.cornerRadius = 5;
        [_tableHeadView addSubview:pensionFind_btn];
        NSArray * btn_array = @[@"regimenstrategy_btn",@"newsdynamic_btn",@"pensionCommon_btn",@"healthassess_btn"];
        for (int i = 0; i < 4; i++)
        {
            UIButton * regimenstrategy_btn = [UIButton buttonWithType:UIButtonTypeSystem];
            regimenstrategy_btn.frame = CGRectMake(i * screenWide /4, screenHeight * 0.352, screenWide /4, screenHeight * 0.125);
            [regimenstrategy_btn setBackgroundImage:[UIImage imageNamed:btn_array[i]]
                                           forState:UIControlStateNormal];
            [regimenstrategy_btn addTarget:self
                                    action:@selector(clipOnBtnsWithbtn:)
                          forControlEvents:UIControlEventTouchUpInside];
            [_tableHeadView addSubview:regimenstrategy_btn];
        }
    }
    return _tableHeadView;
}
#pragma mark - auto_view
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.barTintColor = RGB(205, 8, 20);
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.tabBarController.tabBar.translucent = NO;//不透明 0 开始的位置
}

- (void)reloadTableView {
    [_homeTableView reloadData];
    _homeTableView.tableHeaderView = self.tableHeadView;
    if (!cycleScrollView3) {
        [self setBanner];
    }
    [_homeTableView headerEndRefreshing];
}

- (void)loadNetWork {
    DDHome_page * ddHome_page = [[DDHome_page alloc] initWithUid:@"13732212641" login:@"1"];
    [ddHome_page startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
        NSArray * temp_arr = dic[@"banner"][@"img"];
        imagesA = [NSMutableArray arrayWithCapacity:0];
        for (NSString * str in temp_arr) {
            NSString *  str2 = [NSString stringWithFormat:@"%@/upload/group/%@",BASEURL,str];
            NSString * str3 = [str2 stringByReplacingOccurrencesOfString:@"," withString:@"/"];
            [imagesA addObject:str3];
        }
        urlA = dic[@"banner"][@"url"];
        seasonsA = dic[@"seasons"];
        tag_A = dic[@"tag"];
        
        [self reloadTableView];
        
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"网络错误！"];
        [_homeTableView headerEndRefreshing];
        [self performSelector:@selector(dismiss:) withObject:nil afterDelay:3];
        NSLog(@"%@++++++%ld--------",request.requestArgument,request.responseStatusCode);
    }];

}
- (void)dismiss:(id)sender {
    [SVProgressHUD dismiss];
}
- (void)setupHeaderRefresh {
    [_homeTableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    [_homeTableView headerBeginRefreshing];
    _homeTableView.headerPullToRefreshText = @"下拉可以刷新了";
    _homeTableView.headerReleaseToRefreshText = @"松开马上刷新了";
    _homeTableView.headerRefreshingText = @"小优悠正在帮你刷新中。。。";
}
-(void)headerRereshing{
    [self loadNetWork];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _homeTableView = [[UITableView alloc]
                                   initWithFrame:CGRectMake(0, 0, screenWide, screenHeight-64-screenHeight * 0.035)
                                   style:UITableViewStyleGrouped];
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    _homeTableView.showsVerticalScrollIndicator = NO;
    _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_homeTableView registerClass:[CitySkipViewCell class]
           forCellReuseIdentifier:@"cellCity"];
    [_homeTableView registerClass:[SeasonCTViewCell class]
           forCellReuseIdentifier:@"cellSeason"];
    [self.view addSubview:_homeTableView];
    [self setupHeaderRefresh];
   
       // 版本更新的时候添加提示页面，任性的设计师要求的
//    [MTMigration applicationUpdateBlock:^{
//        ProductTipView *tipView = [[ProductTipView alloc] init];
//        [self.navigationController.view addSubview:tipView];
//        [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.navigationController.view);
//        }];
//    }];
    
//    [MTMigration migrateToVersion:@"1.1.1" block:^{
//        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
//            [MemberManaged MR_truncateAllInContext:localContext];
//            [CardManaged MR_truncateAllInContext:localContext];
//            [NoticeManaged MR_truncateAllInContext:localContext];
//        } completion:^(BOOL success, NSError *error) {
//            [LoginManaged sharedInstance].isLogin = NO;
//        }];
//    }];
    UIButton * city_Btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    city_Btn.frame = CGRectMake(0, 0, 60, 30);
    city_Btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [city_Btn addTarget:self
                 action:@selector(chooseIndexCity)
       forControlEvents:UIControlEventTouchUpInside];
    UIImageView * image_view = [[UIImageView alloc]
                                initWithImage:[UIImage imageNamed:@"right_02"]];
    image_view.frame = CGRectMake(45 , 13, 12,6);
    [city_Btn addSubview:image_view];
    city_btn_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    city_btn_label.text = @"杭州";
    city_btn_label.textColor = [UIColor whiteColor];
    city_btn_label.textAlignment = NSTextAlignmentCenter;
    [city_Btn addSubview:city_btn_label];
    UIBarButtonItem * city_barBItem = [[UIBarButtonItem alloc]
                                       initWithCustomView:city_Btn];
    [self.navigationItem setLeftBarButtonItem:city_barBItem];
    UISearchBar * searchWhere = [[UISearchBar alloc]
                                 initWithFrame:CGRectMake(0, 0, screenWide - 100,0 )];
    [searchWhere setContentMode:UIViewContentModeLeft];
    searchWhere.placeholder = @"带着老伴儿去旅行";
    searchWhere.showsCancelButton=NO;
    searchWhere.delegate = self;
    searchWhere.barStyle=UIBarStyleDefault;
    searchWhere.keyboardType=UIKeyboardTypeWebSearch;
    UIBarButtonItem * searchBarWhere = [[UIBarButtonItem alloc]
                                        initWithCustomView:searchWhere];
    [self.navigationItem setRightBarButtonItem:searchBarWhere];
    _searchWhere = searchWhere;
    
    UIBarButtonItem * returnBarButtonItem = [[UIBarButtonItem alloc] init];
    returnBarButtonItem.title = @"";
    self.navigationController.navigationBar.tintColor=[UIColor redColor];
    [returnBarButtonItem setBackgroundImage:[UIImage imageNamed:@"leftop_r"]
                                   forState:UIControlStateNormal
                                 barMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = returnBarButtonItem;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return screenHeight * 0.269;
    }else
    {
        return screenHeight * 0.21;
    }
}
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    if (tag_A) {
        return tag_A.count +1;
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        SeasonCTViewCell * cell = [_homeTableView dequeueReusableCellWithIdentifier:@"cellSeason"];
        cell.season_collectionView.delegate = self;
        cell.season_collectionView.dataSource = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        CitySkipViewCell * cell = [_homeTableView dequeueReusableCellWithIdentifier:@"cellCity"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.type = indexPath.row;
        cell.delegate = self;
        [cell configWithicon:[UIImage imageNamed:@"fir_"]
                       title:tag_A[indexPath.row -1][@"tag_name"]
                            data:tag_A[indexPath.row -1][@"tag_info"]];
        return cell;
    }
}
//四季轮播
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    SeasonCTViewCell * cell = [_homeTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (scrollView == cell.season_collectionView )
    {
        int page = scrollView.contentOffset.x /scrollView.bounds.size.width + 0.5;
        cell.carousePageControl.currentPage = page;
    }
}
#pragma mark - UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    if (seasonsA.count > 12) {
        return 12;
    }else {
        return seasonsA.count;
    }
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//四季图片
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SeasonMCollectViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellSea"
                                                                        forIndexPath:indexPath];
    if (seasonsA != nil) {
        NSString * temp_str = [NSString stringWithFormat:@"%@/%@",[[YTKNetworkConfig sharedInstance] baseUrl],seasonsA[indexPath.row][@"month_file"]];
        [cell configViewWithimage:temp_str season:seasonsA[indexPath.row][@"month"] describ:seasonsA[indexPath.row][@"title"]];
    }
    
    return cell;
}
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//进入四季推荐
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MonthViewController * monVC = [[MonthViewController alloc]
                                   initWithNibName:@"MonthViewController"
                                   bundle:nil];
    monVC.hidesBottomBarWhenPushed = YES;//隐藏tabBar
    monVC.dataDic = seasonsA[indexPath.row];
    [self.navigationController pushViewController:monVC animated:NO];
}

#pragma mark - VTOF
- (void)chooseIndexCity
{   //选择城市
    if ([city_btn_label.text isEqualToString:@"杭州"])
    {
        city_btn_label.text = @"上海";
         [ShareView showShareViewInViewController:self];
    }else
    {
        city_btn_label.text = @"杭州";
    }
}

//四个跳转
- (void)clipOnBtnsWithbtn:(UIButton *)btn
{
    int btn_number = btn.frame.origin.x /(screenWide/4);
    
    
    if (btn_number == 0)
    {
        [self pushToArticleWithTitle:@"养生攻略"type:@"health"];
    }else if (btn_number == 1)
    {
        [self pushToArticleWithTitle:@"新闻动态"type:@"news"];
    }else if (btn_number == 2)
    {
        [self pushToArticleWithTitle:@"养老常识"type:@"pension"];
    }else
    {
        NSURL * url = [NSURL URLWithString:@"http://n.5199yl.com/#/assess"];
        WebViewController * webVC = [[WebViewController alloc] init];
        webVC.urlLoad = url;
        [self.navigationController pushViewController:webVC
                                             animated:NO];
    }
}
- (void)pushToArticleWithTitle:(NSString *)title type:(NSString *)type{
    ArticleListTVC * arti_listVC= [[ArticleListTVC alloc] init];
    arti_listVC.type = type;
    arti_listVC.title = title;
    [self.navigationController pushViewController:arti_listVC animated:YES];
}
//两个跳转
- (void)skipTOSecond:(UIButton *)button
{
    SearchVController * searchVC = [[SearchVController alloc] init];
    searchVC.hidesBottomBarWhenPushed = YES;//隐藏tabBar
    if (button.frame.origin.x < 100)
    {
        searchVC.vc_type = @"S";
    }else
    {
        searchVC.vc_type = @"L";
    }
    [self.navigationController pushViewController:searchVC
                                         animated:YES];
}
-(void)pushToReginWithArea_id:(NSString *)area_id area:(NSString *)area{//代理方法
    ResultListVController * ResultLVC = [[ResultListVController alloc] init];
    ResultLVC.vc_type = @"S";
    ResultLVC.area_id = area_id;
    ResultLVC.title_l = area;
    ResultLVC.hidesBottomBarWhenPushed = YES;//隐藏tabBar
    [self.navigationController pushViewController:ResultLVC
                                             animated:YES];
}
#pragma mark - SDCycleScrollViewDelegate //轮播
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if ([urlA[index] length] !=0) {
        NSURL *url = [NSURL URLWithString:urlA[index]];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
        [[[UIApplication sharedApplication].delegate window]addSubview:bg_view];
        [bg_view addSubview:_webView];
        [bg_view addSubview:back_btn];
    }
}

- (void)searchBarClear
{
    [_searchWhere resignFirstResponder];
    _searchWhere.text = nil;
    _searchWhere.showsCancelButton = NO;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%@",_searchWhere.text);
    _searchWhere.showsCancelButton = NO;
    [self searchBarClear];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES
                           animated:YES];
    // 修改UISearchBar右侧的取消按钮文字颜色及背景图片
    for (UIView *searchbuttons in [searchBar subviews])
    {
        if ([searchbuttons isKindOfClass:[UIButton class]])
        {
            UIButton *cancelButton = (UIButton*)searchbuttons;
            // 修改文字颜色
            [cancelButton setTitleColor:[UIColor whiteColor]
                               forState:UIControlStateNormal];
            [cancelButton setTitleColor:[UIColor whiteColor]
                               forState:UIControlStateHighlighted];
            // 修改按钮背景
            [cancelButton setBackgroundImage:[UIImage imageNamed:@"z_02"]
                                    forState:UIControlStateNormal];
            [cancelButton setBackgroundImage:nil
                                    forState:UIControlStateHighlighted];
            [cancelButton setTitle:@"取消"
                          forState:UIControlStateNormal];
        }
    }
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self searchBarClear];
}

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
