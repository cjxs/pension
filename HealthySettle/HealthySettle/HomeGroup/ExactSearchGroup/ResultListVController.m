//
//  ResultListVController.m
//  HealthySettle
//
//  Created by yrc on 16/4/9.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "ResultListVController.h"
#import "PensionSRTVCell.h"
#import "RegimenRTVCell.h"
#import "ResultDetailTVController.h"
#import "PriSeleView.h"
#import "DDListGet.h"
@interface ResultListVController ()<UITableViewDataSource ,UITableViewDelegate>
{
   
    BOOL hide;
    BOOL isScroll;
    UIView * begin_view;
}

@end

@implementation ResultListVController
#pragma mark - LazyLoading
-(UITableView *)tableView
{
    if (!_tableView)
    {
        UITableView * tableView = [[UITableView alloc]
                                   initWithFrame:CGRectMake(0, 0, screenWide, screenHeight -64)
                                   style:UITableViewStylePlain];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.bounces = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableView = tableView;
    }
    return _tableView;
}
-(UIView *)tableHeadView {
    if (!_tableHeadView)
    {
        UIView * view = [[UIView alloc]
                         initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.08)];
        view.backgroundColor = RGB(231, 231, 231);
        UITextField * textField = [[UITextField alloc]
                                   initWithFrame:CGRectMake(screenWide * 0.25, screenHeight * 0.01, screenWide * 0.73, screenHeight * 0.06)];
        textField.backgroundColor = [UIColor whiteColor];
        textField.clipsToBounds = YES;
        textField.layer.cornerRadius = 5;
        textField.placeholder = @"  机构名称／位置等";
        textField.font = [UIFont systemFontOfSize:14];
        _textField = textField;
        [view addSubview:_textField];
        
        if ([self.vc_type isEqualToString:@"L"])
        {
            UILabel * checkIn_label = [[UILabel alloc]
                                       initWithFrame:CGRectMake(screenWide * 0.02, screenHeight * 0.01, screenWide * 0.21, screenHeight * 0.06)];
            checkIn_label.textColor = RGB(135, 135,135);
            checkIn_label.clipsToBounds = YES;
            checkIn_label.layer.cornerRadius = 5;
            checkIn_label.backgroundColor = [UIColor whiteColor];
            _checkIn_label = checkIn_label;
            checkIn_label.text = @"   入2-15";
            checkIn_label.font = [UIFont systemFontOfSize:14];
            [view addSubview:_checkIn_label];
            
            
        }else if ([self.vc_type isEqualToString:@"S"])
        {
            UIView * label_view = [[UIView alloc]
                                   initWithFrame:CGRectMake(screenWide * 0.02, screenHeight * 0.01, screenWide * 0.21, screenHeight * 0.06)];
            label_view.clipsToBounds = YES;
            label_view.layer.cornerRadius = 5;
            label_view.backgroundColor = [UIColor whiteColor];
            
            UILabel * checkIn_label = [[UILabel alloc]
                                       initWithFrame:CGRectMake(0, 0, screenWide * 0.21, screenHeight * 0.03)];
            checkIn_label.text = @"   入 2-15";
            checkIn_label.font = [UIFont systemFontOfSize:12];
            checkIn_label.textColor = RGB(135, 135,135);
            _checkIn_label = checkIn_label;
            [label_view addSubview:_checkIn_label];
            UILabel * leave_label = [[UILabel alloc]
                                     initWithFrame:CGRectMake(0, screenHeight * 0.03, screenWide * 0.21, screenHeight * 0.03)];
            leave_label.text = @"   离 2-16";
            leave_label.font = [UIFont systemFontOfSize:12];
            leave_label.textColor = RGB(135, 135,135);
            _leave_label = leave_label;
            [label_view addSubview:_leave_label];
            [view addSubview:label_view];
        }
        
        _tableHeadView = view;
    }
    return _tableHeadView;
}
-(UIView *)filter_view
{ //筛选页面
    if (!_filter_view)
    {
        NSArray * image_array = @[@"list2_1_",@"list2_2_",@"list2_3_",@"list2_4_"];
        NSArray * title_array = @[@"所在区域",@"价格区间",@"筛选",@"排序"];
        UIView * view = [[UIView alloc]
                         initWithFrame:CGRectMake(0, screenHeight - 49-64, screenWide, 49)];
        view.backgroundColor = RGB(249, 249, 249);
        for (int i = 0; i < 4 ;i++ )
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(screenWide /4 * i, 0, screenWide /4, 49);
            [btn addTarget:self
                    action:@selector(showfilterWithButton:)
          forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
            UIImageView * image_view;
            switch (i) {
                case 0:
                    image_view  = [[UIImageView alloc]
                                   initWithFrame:CGRectMake((screenWide/4 -screenWide * 0.05)/2 + screenWide /4 * i, screenHeight * 0.01, screenWide * 0.04, screenWide * 0.04 /3 * 4)];
                    break;
                case 1:
                    image_view  = [[UIImageView alloc]
                                   initWithFrame:CGRectMake((screenWide/4 -screenWide * 0.05)/2 + screenWide /4 * i, screenHeight * 0.01, screenWide * 0.05, screenWide * 0.05 )];
                    break;
                default:
                    image_view  = [[UIImageView alloc]
                                   initWithFrame:CGRectMake((screenWide/4 -screenWide * 0.05)/2 + screenWide /4 * i, screenHeight * 0.01, screenWide * 0.04, screenWide * 0.04 /15* 16)];
                    break;
                }
         
            image_view.image = [UIImage imageNamed:image_array[i]];
            [view addSubview:image_view];
            UILabel * label = [[UILabel alloc]
                               initWithFrame:CGRectMake(screenWide/4 * i, CGRectGetMaxY(image_view.frame), screenWide /4,49 -  CGRectGetMaxY(image_view.frame))];
            label.text = title_array[i];
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
    int number = btn.frame.origin.x / screenWide * 4;
    if ( number ==0) {
        NSLog(@" 所在区域");
    }else if (number == 1)
    {
        NSLog(@" 价格区间");
        PriSeleView * pri_view = [[PriSeleView alloc] init];
        [[UIApplication sharedApplication].keyWindow addSubview:pri_view];
    }else if (number == 2)
    {
        NSLog(@"筛选");
    }else {
        NSLog(@"排序");
    }
}
#pragma mark - auto_view
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
   
    // [self hideTabBar];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    [self showTabBar];
    
}
- (void)hideTabBar
{
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
    {
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    }else
    {
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    }
    CGRect  rect = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    contentView.frame = rect;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)showTabBar{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
    {
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    }else
    {
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    }
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
}

-(void)setData{
    DDListGet * ddlist;
    if ([_vc_type isEqualToString:@"S"]) {
        ddlist = [[DDListGet alloc] initWithController:@"ys_g" area_id:nil page:nil];
    }else{
        ddlist = [[DDListGet alloc] initWithController:@"yl_g" area_id:nil page:nil];
    }
    [ddlist startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        [begin_view removeFromSuperview];
        NSArray * arr = [DDLogin arrayWithJsonString:request.responseString];
        _data_arr = arr;
        [self loadSomething];
        
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%ld",request.responseStatusCode);
    }];
}
-(void)loadSomething {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.filter_view];
    _searchPlace_name = @"杭州";
    if (_searchPlace_name)
    {
        self.navigationItem.title = _searchPlace_name;
    }
    self.tableView.tableHeaderView = self.tableHeadView;
    if ([_vc_type isEqualToString:@"S"])
    {
        [self.tableView registerNib:[UINib nibWithNibName:@"RegimenRTVCell" bundle:nil] forCellReuseIdentifier:@"cellRegimen"];
        
    }else if ([_vc_type isEqualToString:@"L"])
    {
        [self.tableView registerNib:[UINib nibWithNibName:@"PensionSRTVCell" bundle:nil] forCellReuseIdentifier:@"cellPension"];
    }
 
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    begin_view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    begin_view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:begin_view];
    [self setData];
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
    return _data_arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_vc_type isEqualToString:@"L"])
    {
        PensionSRTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellPension" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary * dic = _data_arr[indexPath.row];

        NSString *  str2 = [NSString stringWithFormat:@"%@/upload/group/%@",BASEURL,dic[@"pic"]];
        NSString * str3 = [str2 stringByReplacingOccurrencesOfString:@"," withString:@"/"];
        [cell configWithimage:str3 title:dic[@"s_name"] address:dic[@"address"] number:dic[@"bed_nums"] price:dic[@"price"]];
        
        return cell;
        
    }else if ([_vc_type isEqualToString:@"S"])
    {
        RegimenRTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellRegimen" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary * dic = _data_arr[indexPath.row];
        NSString *  str2 = [NSString stringWithFormat:@"%@/upload/group/%@",BASEURL,dic[@"pic"]];
        NSString * str3 = [str2 stringByReplacingOccurrencesOfString:@"," withString:@"/"];

        
        [cell configWithImage:str3 title:dic[@"s_name"] address:dic[@"address"] price:dic[@"price"] supportArray:dic[@"spec"]];
        return cell;
    }else
    {
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[UIScreen mainScreen] bounds].size.width == 321)
    {
        return 105;
    }
    return screenHeight * 0.158;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultDetailTVController * resultDTVC = [[ResultDetailTVController alloc] initWithStyle:UITableViewStylePlain];
    resultDTVC.hidesBottomBarWhenPushed = YES;
    resultDTVC.vc_type = self.vc_type;
    [self.navigationController pushViewController:resultDTVC
                                         animated:NO];
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
    
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
