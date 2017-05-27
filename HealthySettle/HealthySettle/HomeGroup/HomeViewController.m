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
#import "INTULocationManager.h"
#import "TravelView.h"
#import "EntranceView.h"
#import "NewsView.h"
#import "RecommendViewCell.h"
#import "TravelTVCell.h"
#import "PensionSRTVCell.h"
#import "RegimenRTVCell.h"
#import "TravelResultVController.h"
#import "GroupDetailViewController.h"
#import "TravelDetailVController.h"


@interface HomeViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate,UIWebViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate,CityListDelegate,RecommendDelegate>
{
    NSMutableArray * imagesA;
    NSArray * urlA;
    UILabel * city_btn_label;
    UIView * bg_view;
    UIButton * back_btn;
    NSArray * seasonsA;
    NSArray * tag_A;
    NSArray * groups;
    NSMutableArray * m_groups;
    int _wave;
    SDCycleScrollView *cycleScrollView3;
    UIView * fbg_view;
}
/** 地理编码管理器 */
@property (nonatomic, strong) CLGeocoder *geoC;
/** 定位按钮 */
@property (nonatomic, weak) UIButton *cityPositionBtn;


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
    cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, screenWide , screenHeight * 0.197) delegate:self placeholderImage:[UIImage imageNamed:@"banner_p"]];
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
                          initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.5874 )];
        _tableHeadView.backgroundColor = GRAYCOLOR;
        TravelView * travel_view = [[TravelView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.197, screenWide/2-0.5, 0.2248 * screenHeight)];
        UITapGestureRecognizer * tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(skipTOTravelList)];
        [travel_view configWithtitle:@"养生度假" text:@"专业为老人服务的特色养生体验" imageName:@"travel" gesture:tapges];
        [_tableHeadView addSubview:travel_view];
        EntranceView *pensionFind_view = [[EntranceView alloc] initWithFrame:CGRectMake(screenWide/2+0.5, screenHeight * 0.197, screenWide/2-0.5, 0.1124 * screenHeight-0.5)];
        UITapGestureRecognizer * tap_pension = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(skipTOSecond:)];
        [pensionFind_view configWithtitle:@"找养老院" text:@"幸福安康的家" imageName:@"pension" gesture: tap_pension];

        [_tableHeadView addSubview:pensionFind_view];
        EntranceView *regimenFind_view = [[EntranceView alloc] initWithFrame:CGRectMake(screenWide/2+0.5, screenHeight * 0.309+0.5, screenWide/2, 0.1124 * screenHeight-0.5)];
        UITapGestureRecognizer * tap_regiment = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(skipTOSecond:)];
        [regimenFind_view configWithtitle:@"候鸟基地" text:@"延年益寿的好去处" imageName:@"regiment" gesture: tap_regiment];

        [_tableHeadView addSubview:regimenFind_view];
        
        UITapGestureRecognizer * tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clipOnBtnsWithbtn:)];
        UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clipOnBtnsWithbtn:)];
        UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clipOnBtnsWithbtn:)];
        UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clipOnBtnsWithbtn:)];

        
        NewsView * regimenstrategy_view = [[NewsView alloc] initWithFrame:CGRectMake(0, 0.4218 * screenHeight+0.5, screenWide/2-0.5, 0.0824 * screenHeight)];
        [regimenstrategy_view configWithtitle:@"养生攻略" text:@"分享健康 延年益寿" imageName:@"regimenstrategy" gesture:tap0];
        [_tableHeadView addSubview:regimenstrategy_view];
        
        NewsView * newsdynamic_view = [[NewsView alloc] initWithFrame:CGRectMake(screenWide/2+0.5, 0.4218 * screenHeight+0.5, screenWide/2-0.5, 0.0824 * screenHeight)];
        [newsdynamic_view configWithtitle:@"新闻动态" text:@"用心呵护 颐养生息" imageName:@"newsdynamic" gesture:tap1];
        [_tableHeadView addSubview:newsdynamic_view];
        
        NewsView * pensionCommon_view = [[NewsView alloc] initWithFrame:CGRectMake(0, 0.505 * screenHeight+0.5, screenWide/2-0.5, 0.0824 * screenHeight)];
        [pensionCommon_view configWithtitle:@"养老常识" text:@"养生养老 你我共享" imageName:@"pensionCommon" gesture:tap2];
        [_tableHeadView addSubview:pensionCommon_view];
        
        NewsView * healthassess_view = [[NewsView alloc] initWithFrame:CGRectMake(screenWide/2+0.5, 0.505 * screenHeight+0.5, screenWide/2-0.5, 0.0824 * screenHeight)];
        [healthassess_view configWithtitle:@"健康评估" text:@"你的健康 我来评估" imageName:@"healthassess" gesture:tap3];
        [_tableHeadView addSubview:healthassess_view];
        


        
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
    if (!cycleScrollView3) {
        [self setBanner];
    }
    [_homeTableView headerEndRefreshing];
}

- (void)loadNetWork {
    DDHome_page * ddHome_page = [[DDHome_page alloc] initWithUid:@"13732212641" login:@"1"];
    [ddHome_page startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
        if ([dic[@"error_code"] intValue]== 4) {
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
            [_homeTableView headerEndRefreshing];
            [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1.5];
        }else{
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
            groups = dic[@"group"];
            m_groups = [NSMutableArray array];
            for (NSDictionary  * dic in groups) {
                if ([dic[@"cat_id"] intValue]== 3) {
                    [m_groups addObject:dic];
                }
            }
            [self reloadTableView];
            if (fbg_view) {
                [fbg_view removeFromSuperview];
            }
        }
        
    } failure:^(__kindof YTKBaseRequest *request){
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        [_homeTableView headerEndRefreshing];
        [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1.5];
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
    _homeTableView.backgroundColor = GRAYCOLOR;
    _homeTableView.sectionHeaderHeight = 0;
    _homeTableView.sectionFooterHeight = 0;
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    _homeTableView.showsVerticalScrollIndicator = NO;
    _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_homeTableView registerClass:[CitySkipViewCell class]
           forCellReuseIdentifier:@"cellCity"];
    [_homeTableView registerClass:[SeasonCTViewCell class]
           forCellReuseIdentifier:@"cellSeason"];
    [_homeTableView registerClass:[RecommendViewCell class] forCellReuseIdentifier:@"recommend"];
    [_homeTableView registerClass:[TravelTVCell class] forCellReuseIdentifier:@"travel"];
    [_homeTableView registerClass:[RegimenRTVCell class] forCellReuseIdentifier:@"regimen"];
    [_homeTableView registerClass:[PensionSRTVCell class] forCellReuseIdentifier:@"pension"];

    
    [self.view addSubview:_homeTableView];
    [self setupHeaderRefresh];
    _homeTableView.tableHeaderView = self.tableHeadView;
   
    NSString *cityName = @"定位中";
    CGSize cityNameSize = [self sizeWithText:cityName font:[UIFont systemFontOfSize:15] maxH:44];
    UIButton *leftBaritem = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBaritem setTitle:cityName forState:UIControlStateNormal];
    leftBaritem.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBaritem setImage:[UIImage imageNamed:@"home-cityPosition"] forState:UIControlStateNormal];
    //25 ---->图片宽度
    //cityNameSize.width--------->根据要展示的城市名计算出来的宽度
    //10----> 因为设置了leftBaritem左侧内边距为   -15
    leftBaritem.frame = CGRectMake(0, 0, 25 + cityNameSize.width - 10, 44);
    leftBaritem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftBaritem.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
    [leftBaritem addTarget:self action:@selector(findLocation) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBaritem];
    self.cityPositionBtn = leftBaritem;
    [self findLocation];
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
    
    fbg_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight)];
    fbg_view.backgroundColor = WHITECOLOR;
    [self.view addSubview:fbg_view];
    [self.view bringSubviewToFront:fbg_view];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0)
        {
            return screenHeight * 0.412;
        }else if (indexPath.row == 1)
        {
            return screenHeight * 0.2961;
        }else{
            return screenHeight * 0.11544;
        }
    }else{
       
            return screenHeight * 0.17241;
    }
   }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tag_A) {
        return 2;
    }else{
        return 0;
    }
 
}
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    if (tag_A) {
        if (section == 0) {
            return 3;
        }else{
            return m_groups.count;
        }
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0)
        {
            CitySkipViewCell * cell = [_homeTableView dequeueReusableCellWithIdentifier:@"cellCity"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.type = indexPath.row;
            cell.delegate = self;
            [cell configWithdata:tag_A];
            return cell;
            
        }else if (indexPath.row == 1)
        {
            SeasonCTViewCell * cell = [_homeTableView dequeueReusableCellWithIdentifier:@"cellSeason"];
            cell.season_collectionView.delegate = self;
            cell.season_collectionView.dataSource = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else{
            RecommendViewCell * cell = [_homeTableView dequeueReusableCellWithIdentifier:@"recommend"];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
        if (!_wave || _wave == 0) {
            TravelTVCell * cell = [_homeTableView dequeueReusableCellWithIdentifier:@"travel"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell configWithData:m_groups[indexPath.row]];
            return cell;
        }else if ( _wave == 1){
            PensionSRTVCell * cell = [_homeTableView dequeueReusableCellWithIdentifier:@"pension"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell configWithData:m_groups[indexPath.row]];
            return cell;
            
        }else{
            RegimenRTVCell * cell = [_homeTableView dequeueReusableCellWithIdentifier:@"regimen"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell configWithData:m_groups[indexPath.row]];
            return cell;
            
        }
    
   }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (_wave >0) {
            GroupDetailViewController * resultDTVC = [[GroupDetailViewController alloc] init];
            resultDTVC.vc_type = [NSString stringWithFormat:@"%d",_wave];
            resultDTVC.group_id = m_groups[indexPath.row][@"group_id"];
            [self.navigationController pushViewController:resultDTVC
                                                 animated:NO];
            
        }else{
            TravelDetailVController * resultDTVC = [[TravelDetailVController alloc] init];
            resultDTVC.group_id = m_groups[indexPath.row][@"group_id"];
            resultDTVC.hidesBottomBarWhenPushed = YES;//隐藏tabBar
            [self.navigationController pushViewController:resultDTVC animated:NO];
            
        }

    }else{
    }
}

-(void)updateDataWithWave:(int)wave{
    _wave = wave;
    [m_groups removeAllObjects];
    if (wave == 0) {
        wave = 3;
    }
    for (NSDictionary  * dic in groups) {
        if ([dic[@"cat_id"] intValue]== wave) {
            [m_groups addObject:dic];
        }
    }
    NSIndexSet  * indexSet = [[NSIndexSet alloc] initWithIndex:1];
    [_homeTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationRight];
}
//四季轮播
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    SeasonCTViewCell * cell = [_homeTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
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
//进入四季推荐详情
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
- (void)skipTOTravelList{
    //旅游路线
    TravelResultVController * resultVC = [[TravelResultVController alloc] init];
    resultVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:resultVC animated:YES];
    
}
//两个跳转
- (void)skipTOSecond:(UITapGestureRecognizer *)gesture
{
    SearchVController * searchVC = [[SearchVController alloc] init];
    searchVC.hidesBottomBarWhenPushed = YES;//隐藏tabBar
    if (gesture.view.frame.origin.y-screenHeight * 0.197==0)
    {
        searchVC.vc_type = @"1";
    }else
    {
        searchVC.vc_type = @"2";
    }
    [self.navigationController pushViewController:searchVC
                                         animated:YES];
}

//四个跳转链接
- (void)clipOnBtnsWithbtn:(UITapGestureRecognizer *)gesture
{
    int number_x = gesture.view.frame.origin.x;
    int number_y = gesture.view.frame.origin.y- 0.4218 * screenHeight;
    if (number_x == 0 && number_y == 0)
    {
        [self pushToArticleWithTitle:@"养生攻略"type:@"health"];
    }else if ( number_x != 0&&number_y == 0)
    {
        [self pushToArticleWithTitle:@"新闻动态"type:@"news"];
    }else if (number_x == 0&& number_y != 0)
    {
        [self pushToArticleWithTitle:@"养老常识"type:@"pension"];
    }else
    {
        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/phone#/assess",BASEURL]];
        WebViewController * webVC = [[WebViewController alloc] init];
        webVC.urlLoad = url;
        webVC.hidesBottomBarWhenPushed = YES;
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

-(void)pushToReginWithArea_id:(NSString *)area_id area:(NSString *)area{//代理方法
    TravelResultVController * ResultLVC = [[TravelResultVController alloc] init];
    ResultLVC.area_id = area_id;
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
    TravelResultVController * resultVC = [[TravelResultVController alloc] init];
    resultVC.hidesBottomBarWhenPushed = YES;
    resultVC.keyword = searchBar.text;
    [self.navigationController pushViewController:resultVC animated:YES];
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
#pragma mark -------------------------------定位-------------------
-(void)findLocation{
    if ([self.cityPositionBtn.titleLabel.text isEqualToString:@"定位中"]) {
        INTULocationManager *locMgr = [INTULocationManager sharedInstance];
        [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyCity
                                           timeout:10.0
                              delayUntilAuthorized:YES  // This parameter is optional, defaults to NO if omitted
                                             block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                                 if (status == INTULocationStatusSuccess) {
                                                     [self reverseGeoCode:currentLocation];
                                                 }else {
                                                     NSString *cityName = @"杭州";
                                                     CGSize cityNameSize = [self sizeWithText:cityName font:[UIFont systemFontOfSize:15] maxH:44];
                                                     //25 ---->图片宽度
                                                     //cityNameSize.width--------->根据要展示的城市名计算出来的宽度
                                                     //15----> 因为设置了leftBaritem左侧内边距为   -15
                                                     self.cityPositionBtn.frame = CGRectMake(100, 0, 25+cityNameSize.width - 10, 44);
                                                     [self.cityPositionBtn setTitle:cityName forState:UIControlStateNormal];

                                                 }
                                             }];
    }else {
        NSLog(@"出列表");
    }
    
}
-(void)reverseGeoCode:(CLLocation *)currentLocation{
    [self.geoC reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *pl = [placemarks firstObject];
        if (error == nil) {
            NSString *cityName;
            NSString *shiStr = [pl.locality substringFromIndex:pl.locality.length-1];
            if ([shiStr isEqualToString:@"市"]) {
                cityName =  [pl.locality substringToIndex:pl.locality.length -1];
            } else {
                cityName = pl.locality;
            }
            if (cityName.length > 4) {
                cityName = [cityName substringToIndex:4];
            }
            
            CGSize cityNameSize = [self sizeWithText:cityName font:[UIFont systemFontOfSize:15] maxH:44];
            //25 ---->图片宽度
            //cityNameSize.width--------->根据要展示的城市名计算出来的宽度
            //15----> 因为设置了leftBaritem左侧内边距为   -15
            self.cityPositionBtn.frame = CGRectMake(100, 0, 25+cityNameSize.width - 10, 44);
            [self.cityPositionBtn setTitle:cityName forState:UIControlStateNormal];
        }
    }];
}
-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxH:(CGFloat)maxH{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(MAXFLOAT, maxH);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CLGeocoder *)geoC {
    if (!_geoC){
        _geoC = [[CLGeocoder alloc] init];
    }
    return _geoC;
}

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
