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
#import "ThingsView.h"
#import "CitySkipViewCell.h"
#import "GDScrollBanner.h"
#import "SearchVController.h"
#import "SeasonCTViewCell.h"
#import <MTMigration.h>
#import "ProductTipView.h"
#import "WebViewController.h"





@interface HomeViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate,UIWebViewDelegate>{
    NSMutableArray * imagesA;
}



@end

@implementation HomeViewController
- (UIView *)tableHeadView {
    
    if (_tableHeadView == nil ) {
        _tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight / 2.4)];
        //轮播图
         imagesA = [NSMutableArray arrayWithObjects:@"banner",@"z_02", nil];
        GDScrollBanner * net = [[GDScrollBanner alloc] initWithFrame:CGRectMake(0, 0, screenWide , screenHeight /4.8) WithLocalImages:imagesA];
        net.AutoScrollDelay = 1.5f;
        //占位图  net.placeImage
        [net setSmartImgdidSelectAtIndex:^(NSInteger index) {
            NSLog(@"网络图片  %ld",(long)index);
        }];
        [_tableHeadView addSubview:net];
        
        //轮播图下面的2+4
        TempView * tempViewL = [[TempView alloc] initWithFrame:CGRectMake(kMargin, screenHeight / 4.8 + kMargin/2, screenWide/2 - kMargin*1.5, screenHeight/3.2/4) withMark:[UIImage imageNamed:@"z_02"] andTitle:@"养生度假／装逼广告语"];
        
        [_tableHeadView addSubview:tempViewL];
        UITapGestureRecognizer * tapS = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(skipTOSecond:)];
        [tempViewL addGestureRecognizer:tapS];
        tapS.numberOfTapsRequired = 1;
        
        TempView * tempViewR = [[TempView alloc] initWithFrame:CGRectMake(screenWide/2 + kMargin * 0.5, screenHeight / 4.8 + kMargin/2, screenWide/2 - kMargin*1.5, screenHeight/3.2/4) withMark:[UIImage imageNamed:@"z_03"] andTitle:@"找养老院"];
        [_tableHeadView addSubview:tempViewR];
        
        UITapGestureRecognizer * tapL = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(skipTOSecond:)];
        [tempViewR addGestureRecognizer:tapL];
        tapL.numberOfTouchesRequired = 1;
        
        ThingsView * healthyArea = [[ThingsView alloc] initWithFrame:CGRectMake(0, screenHeight/3.3, screenWide /4, screenHeight/9) withMark:[UIImage imageNamed:@"z_02"] andTitle:@"养生攻略"];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clipOnBtnsWithGes:)];
        tap1.numberOfTapsRequired = 1;
        healthyArea.tag = 201;
        [healthyArea addGestureRecognizer:tap1];
        
        ThingsView * newsArea = [[ThingsView alloc] initWithFrame:CGRectMake(screenWide /4, screenHeight/3.3, screenWide /4, screenHeight/9) withMark:[UIImage imageNamed:@"z_03"] andTitle:@"新闻动态"];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clipOnBtnsWithGes:)];
        tap2.numberOfTapsRequired = 1;
        newsArea.tag = 202;
        [newsArea addGestureRecognizer:tap2];
        ThingsView * commonArea = [[ThingsView alloc] initWithFrame:CGRectMake(screenWide /2, screenHeight/3.3, screenWide /4, screenHeight/9) withMark:[UIImage imageNamed:@"z_03"] andTitle:@"养老常识"];
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clipOnBtnsWithGes:)];
        tap3.numberOfTapsRequired = 1;
        commonArea.tag = 203;
        [commonArea addGestureRecognizer:tap3];
        ThingsView * assessArea = [[ThingsView alloc] initWithFrame:CGRectMake(screenWide /4*3, screenHeight/3.3, screenWide /4, screenHeight/9) withMark:[UIImage imageNamed:@"z_02"] andTitle:@"健康评估"];
        UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clipOnBtnsWithGes:)];
        tap4.numberOfTapsRequired = 1;
        assessArea.tag = 204;
        [assessArea addGestureRecognizer:tap4];
        [_tableHeadView addSubview:healthyArea];
        [_tableHeadView addSubview:newsArea];
        [_tableHeadView addSubview:commonArea];
        [_tableHeadView addSubview:assessArea];

    }
    return _tableHeadView;
}
//四个跳转
- (void)clipOnBtnsWithGes:(UITapGestureRecognizer *)gesture{
    NSLog(@"%d++++",(int)gesture.view.tag);
    NSURL * url = [NSURL URLWithString:@"http://www.baidu.com"];
//    UIWebView * webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:webView];
//    webView.delegate = self;
//    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    WebViewController * webVC = [[WebViewController alloc] init];
    webVC.urlLoad = url;
//    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:webVC animated:NO];
    
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    NSLog(@"webViewDidStartLoad");
    
}

- (void)webViewDidFinishLoad:(UIWebView *)web{
    
    NSLog(@"webViewDidFinishLoad");
    
}

-(void)webView:(UIWebView*)webView  DidFailLoadWithError:(NSError*)error{
    
    NSLog(@"DidFailLoadWithError");
    
}
//两个跳转
- (void)skipTOSecond:(UITapGestureRecognizer *)gesture{
    SearchVController * searchVC = [[SearchVController alloc] init];
    if (gesture.view.frame.origin.x < 100) {
          searchVC.vc_type = @"S";
    }else {
        searchVC.vc_type = @"L";
    }
    [self.navigationController pushViewController:searchVC animated:YES];
}
- (UITableView *)bottomTableV {
    if (_bottomTableV == nil) {
        self.bottomTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + screenHeight /4, screenWide, screenHeight/4*3 -64 ) style:UITableViewStylePlain];
        
    }
    return _bottomTableV;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.tabBarController.tabBar.translucent = NO;
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
    city_Btn.frame = CGRectMake(0, 0, 50, 30);
    [city_Btn setTitle:@"杭州" forState:UIControlStateNormal];
    UIBarButtonItem * city_barBItem = [[UIBarButtonItem alloc] initWithCustomView:city_Btn];
    [self.navigationItem setLeftBarButtonItem:city_barBItem];

    
    UISearchBar * searchWhere = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, screenWide - 100,40 )];
    [searchWhere setContentMode:UIViewContentModeLeft];
    searchWhere.placeholder = @"带着老伴儿去旅行";
    searchWhere.showsCancelButton=NO;
    searchWhere.delegate = self;
    searchWhere.barStyle=UIBarStyleDefault;
    searchWhere.keyboardType=UIKeyboardTypeWebSearch;
    UIBarButtonItem * searchBarWhere = [[UIBarButtonItem alloc] initWithCustomView:searchWhere];
    [self.navigationItem setRightBarButtonItem:searchBarWhere];
    
    _searchWhere = searchWhere;
    
     UITableView * homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight-64) style:UITableViewStyleGrouped];
    [self.view addSubview:homeTableView];
    homeTableView.tableHeaderView = self.tableHeadView;
    homeTableView.delegate = self;
    homeTableView.dataSource = self;
    homeTableView.bounces = NO;
    
    [homeTableView registerClass:[CitySkipViewCell class] forCellReuseIdentifier:@"cellCity"];
    [homeTableView registerClass:[SeasonCTViewCell class] forCellReuseIdentifier:@"cellSeason"];
    _homeTableView = homeTableView;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return screenHeight/5;
    }else {
        return screenHeight/5.8;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SeasonCTViewCell * cell = [_homeTableView dequeueReusableCellWithIdentifier:@"cellSeason"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        CitySkipViewCell * cell = [_homeTableView dequeueReusableCellWithIdentifier:@"cellCity"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.type = indexPath.row;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d",(int)indexPath.row);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"%@",_searchWhere.text);
    _searchWhere.showsCancelButton = NO;
    
    [self searchBarClear];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    
    // 修改UISearchBar右侧的取消按钮文字颜色及背景图片
    for (UIView *searchbuttons in [searchBar subviews]){
        if ([searchbuttons isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton*)searchbuttons;
            // 修改文字颜色
            [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            
            // 修改按钮背景
            [cancelButton setBackgroundImage:[UIImage imageNamed:@"z_02"] forState:UIControlStateNormal];
            [cancelButton setBackgroundImage:nil forState:UIControlStateHighlighted];
            [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        }
}
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self searchBarClear];

}
- (void)searchBarClear {
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
