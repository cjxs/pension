//
//  ConPerAddVC.m
//  HealthySettle
//
//  Created by yrc on 17/2/20.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "ConPerAddVC.h"
#import "TravelPersonTVCell.h"
#import "YYLUser.h"

@interface ConPerAddVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    UITextField * current_field;

}

@end

@implementation ConPerAddVC
-(UIView *)headView
{
    if (!_headView)
    {
        UIView * view = [[UIView alloc]
                         initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.05)];
        view.backgroundColor = GRAYCOLOR;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10,  screenHeight *0.005,screenWide * 0.25, screenHeight * 0.04)];
        label.text = @"填写信息";
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:12];
        [view addSubview:label];
        
        _headView = view;
    }
    return _headView;
}
-(UITableView *)tableView
{
    if (!_tableView)
    {
        UITableView *tableView = [[UITableView alloc]
                                  initWithFrame:CGRectMake(0, 0, screenWide, screenHeight -64)
                                  style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.bounces = NO;
        tableView.backgroundColor = GRAYCOLOR;
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[TravelPersonTVCell class]
          forCellReuseIdentifier:@"cellCon"];
        _tableView = tableView;
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
    UIView * foot_v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.04)];
    UILabel * foot_l = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.005, screenWide * 0.5, screenHeight * 0.03)];
    foot_l.text = @"为顺利出行，请确保姓名与证件一致。";
    foot_l.font = [UIFont systemFontOfSize:12];
    foot_l.textColor = [UIColor grayColor];
    [foot_v addSubview:foot_l];
    _tableView.tableFooterView = foot_v;
    
    UIButton * save_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    save_btn.frame = CGRectMake(0, 0, 40,30);
    [save_btn addTarget:self action:@selector(saveContact) forControlEvents:UIControlEventTouchUpInside];
    [save_btn setTitle:@"保存" forState:UIControlStateNormal];
    [save_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    UIBarButtonItem * save_item = [[UIBarButtonItem alloc] initWithCustomView:save_btn];
    self.navigationItem.rightBarButtonItem = save_item;
    
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.tableView addGestureRecognizer:tapGestureRecognizer];


}
-(void)saveContact{
    NSLog(@"%@",_conPer);
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TravelPersonTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellCon"
                                                             forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (int i = 0; i< cell.subviews.count; i++) {
        if ([cell.subviews[i] isKindOfClass:[UITextField class]] ) {
            UITextField * textfield = cell.subviews[i];
            textfield.delegate = self;
        }
    }
    if (!_conPer) {
        _conPer = [[YYLUser alloc] init];
    }
    [cell configWithYYLuser:_conPer];
    
    [[cell.name_field rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(NSString * x) {
        _conPer.travel_name = cell.name_field.text;
        
    }];
    [[cell.phone_field rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(NSString * x) {
        _conPer.travel_phone = cell.phone_field.text;
    }];
    [[cell.id_field rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(NSString * x) {
        _conPer.travel_id = cell.id_field.text;
    }];
    cell.selectSex = ^(NSString * num){
        _conPer.travel_sex = num;
    };

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return screenHeight * 0.28;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    current_field = textField;
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    if (current_field) {
        [current_field resignFirstResponder];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
