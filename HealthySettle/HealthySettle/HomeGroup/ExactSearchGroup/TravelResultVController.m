//
//  TravelResultVController.m
//  HealthySettle
//
//  Created by yrc on 17/1/4.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "TravelResultVController.h"
#import "TravelTVCell.h"
#import "TravelDetailVController.h"
#import "DDListGet.h"
#import "MJRefresh.h"
#import "FiltView.h"


static NSInteger page = 1;

@interface TravelResultVController ()<UITableViewDelegate,UITableViewDataSource>{
    BOOL hide;
    BOOL isScroll;
    DDListGet * ddlist;//网络请求的指针
}

@end

@implementation TravelResultVController
-(UITableView *)tableView
{
    if (!_tableView)
    {
        UITableView * tableView = [[UITableView alloc]
                                   initWithFrame:CGRectMake(0, 0, screenWide, screenHeight -64)
                                   style:UITableViewStylePlain];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [UIView new];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView = tableView;
        
    }
    return _tableView;
}
-(UIView *)filter_view
{ //筛选页面
    if (!_filter_view)
    {
        NSArray * image_array = @[@"list2_1_",@"list2_2_",@"list2_4_"];
        NSArray * title_array = @[@"出发城市",@"行程周期",@"价格从高到低"];
        UIView * view = [[UIView alloc]
                         initWithFrame:CGRectMake(0, screenHeight - 49-64, screenWide, 49)];
        view.backgroundColor = RGB(249, 249, 249);
        for (int i = 0; i < 3 ;i++ )
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(screenWide /3 * i, 0, screenWide /3, 49);
            [btn addTarget:self
                    action:@selector(showfilterWithButton:)
          forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
            UIImageView * image_view;
            switch (i) {
                case 0:
                    image_view  = [[UIImageView alloc]
                                   initWithFrame:CGRectMake(screenWide/6 -screenWide * 0.02 + screenWide /3 * i, screenHeight * 0.01, screenWide * 0.04, screenWide * 0.04 /3 * 4)];
                    break;
                case 1:
                    image_view  = [[UIImageView alloc]
                                   initWithFrame:CGRectMake(screenWide/6 -screenWide * 0.02 + screenWide /3 * i, screenHeight * 0.01, screenWide * 0.05, screenWide * 0.05 )];
                    break;
                default:
                    image_view  = [[UIImageView alloc]
                                   initWithFrame:CGRectMake(screenWide/6 -screenWide * 0.02 + screenWide /3 * i, screenHeight * 0.01, screenWide * 0.04, screenWide * 0.04 /15* 16)];
                    break;
            }
            
            image_view.image = [UIImage imageNamed:image_array[i]];
            [view addSubview:image_view];
            UILabel * label = [[UILabel alloc]
                               initWithFrame:CGRectMake(screenWide/3 * i, CGRectGetMaxY(image_view.frame), screenWide /3,49 -  CGRectGetMaxY(image_view.frame))];
            label.text = title_array[i];
            label.tag = 800+i;
            label.textColor = RGB(199, 199, 199);
            label.font = [UIFont systemFontOfSize:10];
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
        }
        _filter_view = view;
    }
    return _filter_view;
}
- (void)showfilterWithButton:(UIButton *)btn
{
    int number = btn.frame.origin.x / screenWide * 3;
    if ( number ==0) {
        [self cityfileViewAppear];
    }else if (number == 1)
    {
        [self timefileViewAppear];
    }else
    {
        [self pricefileViewAppear];
    }
}
-(void)cityfileViewAppear{
    FiltView * cityfilt_view = [[FiltView alloc] init];
    cityfilt_view.data_arr1 = @[@"不限",@"华东",@"华南／华中",@"西南",@"华北／东北／西北"];
    cityfilt_view.listType = DDListTYpeMulti;
    cityfilt_view.selectType = DDSelectTYpeSingle;
    cityfilt_view.selectFir = ^(int num){
        NSLog(@"%d左",num);
        return @[@"杭州",@"南京",@"苏州",@"大连",@"重庆",@"三亚",@"深圳"];
    };
    cityfilt_view.sureBtn = ^(NSString *str){
        NSLog(@"%@结果city",str);
        for (int i = 0; i < _filter_view.subviews.count; i++) {
            if (_filter_view.subviews[i].tag ==800 &&[_filter_view.subviews[i] isKindOfClass:[UILabel class]]) {
                UILabel *label = _filter_view.subviews[i];
                label.text = str;
            }
        }
    };
    
    [cityfilt_view addFirstView];
    [UIView animateWithDuration:0.5f animations:^{
        [self.view addSubview:cityfilt_view];
        }];
}
-(void)timefileViewAppear{
    FiltView * timefilt_view = [[FiltView alloc] init];
    timefilt_view.listType = DDListTYpeSingle;
    timefilt_view.selectType = DDSelectTYpeMulti;
    timefilt_view.data_arr1 = @[@"不限",@"1-3天",@"4-7天",@"8-15天",@"15天以上"];
    timefilt_view.sureBtn = ^(NSArray *arr){
        for (NSString * str in arr) {
            NSLog(@"%@结果time",str);
        }
    };

    [timefilt_view addFirstView];

    [UIView animateWithDuration:0.5f animations:^{
        [self.view addSubview:timefilt_view];
    }];

}
-(void)pricefileViewAppear{
    FiltView * pricefilt_view = [[FiltView alloc] init];
    pricefilt_view.listType = DDListTYpeSingle;
    pricefilt_view.selectType = DDSelectTYpeSingle;
    pricefilt_view.data_arr1 = @[@"综合排序",@"价格从高到低",@"价格从低到高"];
    pricefilt_view.sureBtn = ^(NSString * str){
        for (int i = 0; i < _filter_view.subviews.count; i++) {
            if (_filter_view.subviews[i].tag ==803 &&[_filter_view.subviews[i] isKindOfClass:[UILabel class]]) {
                UILabel *label = _filter_view.subviews[i];
                label.text = str;
            }
        }

    };
    [pricefilt_view addFirstView];
    [UIView animateWithDuration:0.5f animations:^{
        [self.view addSubview:pricefilt_view];
    }];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}
-(void)setData{
    
    
    ddlist = [[DDListGet alloc] initWithcat_id:@"3" keyword:nil area_id:_area_id sort:nil priceRange:nil level:nil page:[NSString stringWithFormat:@"%ld",page]];
    [ddlist startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
        if ([dic[@"error_code"] intValue] == 1) {
            [SVProgressHUD showErrorWithStatus:@"暂时没有相应数据！"];
            [self.tableView headerEndRefreshing];

        }else{
            NSMutableArray * arr = dic[@"list"];
            if (arr && arr.count < 15) {
                self.tableView.footerHidden = YES;
            }
            if (page == 1) {
                _data_arr = [NSMutableArray arrayWithCapacity:0];
            }
            for (NSDictionary * dic in arr) {
                [_data_arr addObject:dic];
            }
            [self.tableView reloadData];
        }

    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%ld",request.responseStatusCode);
    }];
}
-(void)headerRereshing {
    page = 1;
    [self setData];
    if (self.tableView.footerHidden) {
        self.tableView.footerHidden = NO;
    }
    [self.tableView headerEndRefreshing];
    
}
-(void)footerRereshing {
    page++;
    [self setData];
    [self.tableView footerEndRefreshing];
    
}
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @" 小优悠正在帮你刷新中,不客气";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"正在加载更多,请稍后";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"养生度假";
    self.view.backgroundColor = WHITECOLOR;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.filter_view];
    [_tableView registerClass:[TravelTVCell class] forCellReuseIdentifier:@"travel"];
    
    [self setupRefresh];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource ,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_data_arr) {
        return _data_arr.count;
    }else{
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TravelTVCell * cell = [_tableView dequeueReusableCellWithIdentifier:@"travel"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configWithData:_data_arr[indexPath.row]];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return screenHeight * 0.17241;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TravelDetailVController * travelDVC = [[TravelDetailVController alloc] init];
    travelDVC.group_id = _data_arr[indexPath.row][@"group_id"];
    
    [self.navigationController pushViewController:travelDVC animated:YES];
    
}

#pragma mark - FilterView
- (void)showFilter_view {
    self.filter_view.frame = CGRectMake(0, screenHeight - 49-64, screenWide, 49);
}
- (void)hideFilter_view {
    self.filter_view.frame = CGRectMake(0, screenHeight-64, screenWide, 49);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static float newy = 0;
    static float oldy = 0;
    newy = scrollView.contentOffset.y ;
    if (isScroll == NO)
    {
        isScroll = YES;
        if (newy != oldy )
        {
            if (newy > oldy && hide == NO)
            {
                
                [UIView animateWithDuration:0.5 animations:^{
                    [self hideFilter_view];
                }];
                hide = YES;
            }else if(newy < oldy&& hide == YES)
            {
                [UIView animateWithDuration:0.5 animations:^{
                    [self showFilter_view];
                }];
                hide = NO;
            }
            oldy = newy;
        }
        isScroll = NO;
        
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (hide == YES) {
        [UIView animateWithDuration:0.5 animations:^{
            [self showFilter_view];
        }];
        hide = NO;
    }

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
