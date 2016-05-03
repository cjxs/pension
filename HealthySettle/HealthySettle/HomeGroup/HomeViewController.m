//
//  HomeViewController.m
//  HealthySettle
//
//  Created by yrc on 16/3/17.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "HomeViewController.h"
#import "DDTestApi.h"
#import "DDTestApiS.h"
#import "TempView.h"
#import "CitySkipViewCell.h"
#import "GDScrollBanner.h"
#import "SearchVController.h"
#import "SeasonCTViewCell.h"
#import <MTMigration.h>
#import "ProductTipView.h"
#import "WebViewController.h"
#import "KnowledgeTVController.h"
#import "SeasonMCollectViewCell.h"
#import "MonthViewController.h"


@interface HomeViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate,UIWebViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray * imagesA;
}



@end

@implementation HomeViewController
- (UIView *)tableHeadView
{
    if (_tableHeadView == nil )
    {
        _tableHeadView = [[UIView alloc]
                          initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.477)];
        //轮播图
         imagesA = [NSMutableArray arrayWithObjects:@"z_03",@"z_02", nil];
        GDScrollBanner * net = [[GDScrollBanner alloc]
                                initWithFrame:CGRectMake(0, 0, screenWide , screenHeight * 0.222) WithLocalImages:imagesA];
        net.AutoScrollDelay = 2.0f;
        //占位图  net.placeImage
        [net setSmartImgdidSelectAtIndex:^(NSInteger index)
        {
            NSLog(@"网络图片  %ld",(long)index);
        }];
        [_tableHeadView addSubview:net];
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
- (UITableView *)bottomTableV
{
    if (_bottomTableV == nil)
    {
        self.bottomTableV = [[UITableView alloc]
                             initWithFrame:CGRectMake(0, 64 + screenHeight /4, screenWide, screenHeight/4*3 -64 ) style:UITableViewStylePlain];
    }
    return _bottomTableV;
}
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
- (void)viewDidLoad
{
    [super viewDidLoad];
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
    UIImageView * image_view = [[UIImageView alloc]
                                initWithImage:[UIImage imageNamed:@"right_02"]];
    image_view.frame = CGRectMake(48 , 12, 12, 6);
    [city_Btn addSubview:image_view];
    city_Btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [city_Btn setTitle:@"杭州"
              forState:UIControlStateNormal];
    [city_Btn addTarget:self
                 action:@selector(chooseIndexCity)
       forControlEvents:UIControlEventTouchUpInside];
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
    UIBarButtonItem * returnBarButtonItem = [[UIBarButtonItem alloc] init];
    returnBarButtonItem.title = @"";
    self.navigationController.navigationBar.tintColor=[UIColor redColor];
    [returnBarButtonItem setBackgroundImage:[UIImage imageNamed:@"leftop_r"]
                                   forState:UIControlStateNormal
                                 barMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = returnBarButtonItem;
}
- (void)chooseIndexCity
{   //选择城市
    NSLog(@"+++----");
}
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
    return 3;
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
        if (indexPath.row == 1)
        {
            [cell configWithicon:[UIImage imageNamed:@"fir_"]
                           title:@"浪漫海滨"
                            data:nil];
        }else {
            [cell configWithicon:[UIImage imageNamed:@"fir_"]
                           title:@"缤纷花海"
                            data:nil];
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
    return 12;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SeasonMCollectViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellSea"
                                                                              forIndexPath:indexPath];
    switch (indexPath.row)
    {
        case 0:
            [cell configViewWithimage:[UIImage imageNamed:@"p_01"] season:@"1 月" describ:@"新的开始"];
            break;
        case 1:
            [cell configViewWithimage:[UIImage imageNamed:@"p_02"] season:@"2 月" describ:@"春季旅行"];
            break;
        case 2:
            [cell configViewWithimage:[UIImage imageNamed:@"p_03"] season:@"3 月" describ:@"春节没玩够"];
            break;
        case 3:
            [cell configViewWithimage:[UIImage imageNamed:@"p_01"] season:@"4 月" describ:@"新的开始"];
            break;
        case 4:
            [cell configViewWithimage:[UIImage imageNamed:@"p_02"] season:@"5 月" describ:@"新的开始"];
            break;
        case 5:
            [cell configViewWithimage:[UIImage imageNamed:@"p_03"] season:@"6 月" describ:@"新的开始"];
            break;
        case 6:
            [cell configViewWithimage:[UIImage imageNamed:@"p_01"] season:@"7 月" describ:@"新的开始"];
            break;
        case 7:
            [cell configViewWithimage:[UIImage imageNamed:@"p_02"] season:@"8月" describ:@"新的开始"];
            break;
        case 8:
            [cell configViewWithimage:[UIImage imageNamed:@"p_03"] season:@"9 月" describ:@"新的开始"];
            break;
        case 9:
            [cell configViewWithimage:[UIImage imageNamed:@"p_01"] season:@"10 月" describ:@"新的开始"];
            break;
        case 10:
            [cell configViewWithimage:[UIImage imageNamed:@"p_02"] season:@"11月" describ:@"新的开始"];
            break;
            
        default:
            [cell configViewWithimage:[UIImage imageNamed:@"p_03"] season:@"12月" describ:@"新的开始"];
            break;
    }
    return cell;
}
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MonthViewController * monVC = [[MonthViewController alloc]
                                   initWithNibName:@"MonthViewController"
                                   bundle:nil];
       [self.navigationController pushViewController:monVC animated:NO];
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
- (void)searchBarClear
{
    [_searchWhere resignFirstResponder];
    _searchWhere.text = nil;
    _searchWhere.showsCancelButton = NO;
}

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
