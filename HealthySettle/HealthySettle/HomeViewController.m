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
#import "SeasonMovingViewCell.h"
#import "CitySkipViewCell.h"
#import "GDScrollBanner.h"
#import "SearchVController.h"

static NSString * seaIdentifier = @"cellSea";


@interface HomeViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>{
    UITableView * homeTableView;
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
        net.AutoScrollDelay = 2;
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
        ThingsView * newsArea = [[ThingsView alloc] initWithFrame:CGRectMake(screenWide /4, screenHeight/3.3, screenWide /4, screenHeight/9) withMark:[UIImage imageNamed:@"z_03"] andTitle:@"新闻动态"];
        ThingsView * commonArea = [[ThingsView alloc] initWithFrame:CGRectMake(screenWide /2, screenHeight/3.3, screenWide /4, screenHeight/9) withMark:[UIImage imageNamed:@"z_03"] andTitle:@"养老常识"];
        ThingsView * assessArea = [[ThingsView alloc] initWithFrame:CGRectMake(screenWide /4*3, screenHeight/3.3, screenWide /4, screenHeight/9) withMark:[UIImage imageNamed:@"z_02"] andTitle:@"健康评估"];
        [_tableHeadView addSubview:healthyArea];
        [_tableHeadView addSubview:newsArea];
        [_tableHeadView addSubview:commonArea];
        [_tableHeadView addSubview:assessArea];

    }
    return _tableHeadView;
}
- (void)skipTOSecond:(UITapGestureRecognizer *)gesture{
    SearchVController * searchVC = [[SearchVController alloc] init];
    if (gesture.view.frame.origin.x < 100) {
          searchVC.vc_type = @"S";
    }else {
        searchVC.vc_type = @"L";

    }
  
    [self.navigationController pushViewController:searchVC animated:YES];
}
//SensibleViewController *senVC = self.sensiNaVC.viewControllers[0];
//senVC.type = @"SCAN";
//self.delegate = senVC;
//if ([self.delegate respondsToSelector:@selector(doSomethings)]) {
//    [self.delegate doSomethings];
//}
//self.sensiNaVC.viewControllers = @[senVC];
//
//self.navigationController.tabBarController.selectedViewController = self.sensiNaVC;
- (UITableView *)bottomTableV {
    if (_bottomTableV == nil) {
        self.bottomTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + screenHeight /4, screenWide, screenHeight/4*3 -64 ) style:UITableViewStylePlain];
        
    }
    return _bottomTableV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.tabBarController.tabBar.translucent = NO;
    self.navigationController.tabBarController.tabBar.translucent = NO;

    UIButton * city_Btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    city_Btn.frame = CGRectMake(0, 0, 50, 30);
    [city_Btn setTitle:@"杭州" forState:UIControlStateNormal];
    UIBarButtonItem * city_barBItem = [[UIBarButtonItem alloc] initWithCustomView:city_Btn];
    [self.navigationItem setLeftBarButtonItem:city_barBItem];

    
    UISearchBar * searchWhere = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, screenWide - 100,40 )];
    [searchWhere setContentMode:UIViewContentModeLeft];
    searchWhere.placeholder = @"带着老伴儿去旅行";
    UIBarButtonItem * searchBarWhere = [[UIBarButtonItem alloc] initWithCustomView:searchWhere];
    [self.navigationItem setRightBarButtonItem:searchBarWhere];
    
    homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight-64) style:UITableViewStyleGrouped];
    [self.view addSubview:homeTableView];
    homeTableView.tableHeaderView = self.tableHeadView;
    homeTableView.delegate = self;
    homeTableView.dataSource = self;
    [homeTableView registerClass:[SeasonMovingViewCell class] forCellReuseIdentifier:seaIdentifier];
    [homeTableView registerClass:[CitySkipViewCell class] forCellReuseIdentifier:@"cellCity"];
    
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
        SeasonMovingViewCell * cell = [homeTableView dequeueReusableCellWithIdentifier:seaIdentifier];
        [cell delegateFromController:self];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        return cell;
    }else {
        CitySkipViewCell * cell = [homeTableView dequeueReusableCellWithIdentifier:@"cellCity"];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;

        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource, UITableViewDelegate
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
