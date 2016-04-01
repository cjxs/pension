//
//  SearchResultTVController.m
//  HealthySettle
//
//  Created by yrc on 16/3/31.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "SearchResultTVController.h"
#import "PensionSRTVCell.h"
#import "RegimenRTVCell.h"
#import "ResultDetailTVController.h"


@interface SearchResultTVController () {
    NSArray * array;
}

@end

@implementation SearchResultTVController
-(UIView *)tableHeadView {
    if (!_tableHeadView) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.08)];
        view.backgroundColor = RGB(231, 231, 231);
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(screenWide * 0.25, screenHeight * 0.01, screenWide * 0.73, screenHeight * 0.06)];
        textField.backgroundColor = [UIColor whiteColor];
        textField.clipsToBounds = YES;
        textField.layer.cornerRadius = 5;
        textField.placeholder = @"机构名称／位置等";
        _textField = textField;
        [view addSubview:_textField];
        
        if ([self.vc_type isEqualToString:@"L"]) {
            UILabel * checkIn_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.02, screenHeight * 0.01, screenWide * 0.21, screenHeight * 0.06)];
            checkIn_label.textColor = RGB(135, 135,135);
            checkIn_label.clipsToBounds = YES;
            checkIn_label.layer.cornerRadius = 5;
            checkIn_label.backgroundColor = [UIColor whiteColor];
            _checkIn_label = checkIn_label;
            checkIn_label.text = @" 入2-15";
            checkIn_label.font = [UIFont systemFontOfSize:13];
            [view addSubview:_checkIn_label];
          
            
        }else if ([self.vc_type isEqualToString:@"S"]) {
            UIView * label_view = [[UIView alloc] initWithFrame:CGRectMake(screenWide * 0.02, screenHeight * 0.01, screenWide * 0.21, screenHeight * 0.06)];
            label_view.clipsToBounds = YES;
            label_view.layer.cornerRadius = 5;
            label_view.backgroundColor = [UIColor whiteColor];
            
            UILabel * checkIn_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWide * 0.21, screenHeight * 0.03)];
            checkIn_label.text = @" 2-15";
            checkIn_label.textColor = RGB(135, 135,135);
            _checkIn_label = checkIn_label;
            [label_view addSubview:_checkIn_label];
            UILabel * leave_label = [[UILabel alloc] initWithFrame:CGRectMake(0, screenHeight * 0.03, screenWide * 0.21, screenHeight * 0.03)];
            leave_label.text = @" 2-16";
            leave_label.textColor = RGB(135, 135,135);
            _leave_label = leave_label;
            [label_view addSubview:_leave_label];
            [view addSubview:label_view];
        }

        _tableHeadView = view;
    }
    return _tableHeadView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _searchPlace_name = @"杭州";
    if (_searchPlace_name) {
        self.navigationItem.title = _searchPlace_name;
    }
    self.tableView.tableHeaderView = self.tableHeadView;
    if ([_vc_type isEqualToString:@"S"]) {
        [self.tableView registerNib:[UINib nibWithNibName:@"RegimenRTVCell" bundle:nil] forCellReuseIdentifier:@"cellRegimen"];
        
    }else if ([_vc_type isEqualToString:@"L"]) {
        [self.tableView registerNib:[UINib nibWithNibName:@"PensionSRTVCell" bundle:nil] forCellReuseIdentifier:@"cellPension"];
    }
    array = @[@"z_02,",@"z_03",@"p_01",@"p_02"];
  
    }
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}
-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
    [self hideTabBar];

    
}
- (void)viewWillDisappear:(BOOL)animated {
    [self showTabBar];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}
- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
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
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_vc_type isEqualToString:@"L"]) {
        PensionSRTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellPension" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithimage:[UIImage imageNamed:@"pension"] title:@"杭州上城区维康老人" address:@"上城区近江南路2号"number:@"999" price:@"666"];
        return cell;
        
    }else if ([_vc_type isEqualToString:@"S"]) {
        RegimenRTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellRegimen" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithImage:[UIImage imageNamed:@"regimen"] title:@"杭州上城区维康老人上城区维康老人" address:@"上城区近江南路2号， 锦江南路哦" price:@"888" supportArray:array];
        return cell;
    }else {
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return screenHeight * 0.158;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultDetailTVController * resultDTVC = [[ResultDetailTVController alloc] initWithStyle:UITableViewStylePlain];
    resultDTVC.vc_type = self.vc_type;
    [self.navigationController pushViewController:resultDTVC animated:NO];
}
@end
