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


@interface HomeViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate,UIWebViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate>
{
    NSMutableArray * imagesA;
    NSArray * urlA;
    UILabel * city_btn_label;
    UIView * bg_view;
    UIButton * back_btn;
    NSArray * seasonsA;
    NSArray * tag_A;
}



@end

@implementation HomeViewController
#pragma mark - LazyLoading
-(UIWebView *)webView {
    if (_webView == nil) {
        bg_view = [[UIView alloc] initWithFrame:CGRectMake(0,0, screenWide, screenHeight)];
        bg_view.backgroundColor = [UIColor whiteColor];
        
        back_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        back_btn.frame = CGRectMake(0, 20, 40, 23);
        back_btn.backgroundColor = [UIColor grayColor];
        [back_btn addTarget:self action:@selector(cancelWeb:) forControlEvents:UIControlEventTouchUpInside];

        
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,44, screenWide, screenHeight-44)];
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
- (UITableView *)bottomTableV
{
    if (_bottomTableV == nil)
    {
        self.bottomTableV = [[UITableView alloc]
                             initWithFrame:CGRectMake(0, 64 + screenHeight /4, screenWide, screenHeight/4*3 -64 ) style:UITableViewStylePlain];
    }
    return _bottomTableV;
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
    self.navigationController.tabBarController.tabBar.translucent = YES;//坑
}
- (void)setTableView {
    UITableView * homeTableView = [[UITableView alloc]
                                   initWithFrame:CGRectMake(0, 0, screenWide, screenHeight-64-screenHeight * 0.035)
                                   style:UITableViewStyleGrouped];
    [self.view addSubview:homeTableView];
    homeTableView.tableHeaderView = self.tableHeadView;
    homeTableView.delegate = self;
    homeTableView.dataSource = self;
    homeTableView.bounces = NO;
    homeTableView.showsVerticalScrollIndicator = NO;
    homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [homeTableView registerClass:[CitySkipViewCell class]
          forCellReuseIdentifier:@"cellCity"];
    [homeTableView registerClass:[SeasonCTViewCell class]
          forCellReuseIdentifier:@"cellSeason"];
    _homeTableView = homeTableView;
    [self setBanner];
}
- (void)setBanner {
    SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, screenWide , screenHeight * 0.222) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    cycleScrollView3.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    cycleScrollView3.imageURLStringsGroup = imagesA;
    [_tableHeadView addSubview:cycleScrollView3];
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
        
        [self setTableView];
        
        
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%@++++++%ld--------",request.requestArgument,request.responseStatusCode);
    }];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadNetWork];
   
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
        return screenHeight * 0.247;
    }
}
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    return tag_A.count +1;
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
        NSURL * url = [NSURL URLWithString:@"http://www.cjxs.github.io/"];
        WebViewController * webVC = [[WebViewController alloc] init];
        webVC.urlLoad = url;
        [self.navigationController pushViewController:webVC
                                             animated:NO];
    }else if (btn_number == 1)
    {
        NSURL * url = [NSURL URLWithString:@"http://www.baidu.com"];
        WebViewController * webVC = [[WebViewController alloc] init];
        webVC.urlLoad = url;
        [self.navigationController pushViewController:webVC
                                             animated:NO];
    }else if (btn_number == 2)
    {
        KnowledgeTVController * vc = [[KnowledgeTVController alloc] init];
        [self.navigationController pushViewController:vc
                                             animated:NO];
    }else
    {
        NSURL * url = [NSURL URLWithString:@"http://www.cjxs.github.io/"];
        WebViewController * webVC = [[WebViewController alloc] init];
        webVC.urlLoad = url;
        [self.navigationController pushViewController:webVC
                                             animated:NO];
    }
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
