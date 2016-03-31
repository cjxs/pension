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
        _tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.477)];
        //轮播图
         imagesA = [NSMutableArray arrayWithObjects:@"banner",@"z_02", nil];
        GDScrollBanner * net = [[GDScrollBanner alloc] initWithFrame:CGRectMake(0, 0, screenWide , screenHeight * 0.222) WithLocalImages:imagesA];
        net.AutoScrollDelay = 2.0f;
        //占位图  net.placeImage
        [net setSmartImgdidSelectAtIndex:^(NSInteger index) {
            NSLog(@"网络图片  %ld",(long)index);
        }];
        [_tableHeadView addSubview:net];
        
        //轮播图下面的2+4
        UIButton * regimenFind_btn = [UIButton buttonWithType:UIButtonTypeSystem];
        regimenFind_btn.frame = CGRectMake(screenWide * 0.015, screenHeight * 0.227, screenWide * 0.48 , screenHeight * 0.12 );
        [regimenFind_btn addTarget:self action:@selector(skipTOSecond:) forControlEvents:UIControlEventTouchUpInside];
        [regimenFind_btn setBackgroundImage:[UIImage imageNamed:@"regimenFind_btn"] forState:UIControlStateNormal];
        regimenFind_btn.clipsToBounds = YES;
        regimenFind_btn.layer.cornerRadius = 5;
        [_tableHeadView addSubview:regimenFind_btn];
        
        UIButton * pensionFind_btn = [UIButton buttonWithType:UIButtonTypeSystem];
        pensionFind_btn.frame = CGRectMake(screenWide *0.505 , screenHeight * 0.227, screenWide * 0.48, screenHeight *0.12 );
        [pensionFind_btn addTarget:self action:@selector(skipTOSecond:) forControlEvents:UIControlEventTouchUpInside];
        [pensionFind_btn setBackgroundImage:[UIImage imageNamed:@"pensionFind_btn"] forState:UIControlStateNormal];
        pensionFind_btn.clipsToBounds = YES;
        pensionFind_btn.layer.cornerRadius = 5;
        [_tableHeadView addSubview:pensionFind_btn];
        
      
        NSArray * btn_array = @[@"regimenstrategy_btn",@"newsdynamic_btn",@"pensionCommon_btn",@"healthassess_btn"];
        for (int i = 0; i < 4; i++) {
            UIButton * regimenstrategy_btn = [UIButton buttonWithType:UIButtonTypeSystem];
            regimenstrategy_btn.frame = CGRectMake(i * screenWide /4, screenHeight * 0.352, screenWide /4, screenHeight * 0.125);
            [regimenstrategy_btn setBackgroundImage:[UIImage imageNamed:btn_array[i]] forState:UIControlStateNormal];
            [regimenstrategy_btn addTarget:self action:@selector(clipOnBtnsWithbtn:) forControlEvents:UIControlEventTouchUpInside];
            [_tableHeadView addSubview:regimenstrategy_btn];
        }
    }
    return _tableHeadView;
}
//四个跳转
- (void)clipOnBtnsWithbtn:(UIButton *)btn{
    int btn_number = btn.frame.origin.x /(screenWide/4);
    switch (btn_number) {
        case 0:
            NSLog(@"++++++++++++%d",btn_number);
            break;
        case 1:
            NSLog(@"++++++++++++%d",btn_number);
            break;
        case 2:
            NSLog(@"++++++++++++%d",btn_number);
            break;
        case 3:
            NSLog(@"++++++++++++%d",btn_number);
            break;
        default:
            break;
    }
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
- (void)skipTOSecond:(UIButton *)button{
    SearchVController * searchVC = [[SearchVController alloc] init];
    if (button.frame.origin.x < 100) {
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
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.barTintColor = RGB(205, 8, 20);
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.tabBarController.tabBar.translucent = NO;


}
- (void)viewDidLoad {
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
    [city_Btn setTitle:@"杭州 v" forState:UIControlStateNormal];
    UIBarButtonItem * city_barBItem = [[UIBarButtonItem alloc] initWithCustomView:city_Btn];
    [self.navigationItem setLeftBarButtonItem:city_barBItem];

    
    UISearchBar * searchWhere = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, screenWide - 100,0 )];
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
        return screenHeight * 0.269;
    }else {
        return screenHeight * 0.247;
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
