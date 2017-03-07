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
#import "DDUpdate.h"

@interface ConPerAddVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    UITextField * current_field;
    NSDictionary * _data_dic;

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
    UIView * foot_v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.12)];
    UILabel * foot_l = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.005, screenWide * 0.9, screenHeight * 0.03)];
    foot_l.text = @"为顺利出行，请确保姓名与证件一致。";
    foot_l.font = [UIFont systemFontOfSize:12];
    foot_l.textColor = [UIColor grayColor];
    [foot_v addSubview:foot_l];
    
    if (_user_index != 99999) {
    UIButton * del_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [foot_v addSubview:del_btn];
    [del_btn setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [del_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(foot_v);
        make.bottom.equalTo(foot_v);
        make.size.mas_equalTo(CGSizeMake(screenWide * 0.08, screenWide * 0.11));
    }];
    [del_btn addTarget:self action:@selector(delContact) forControlEvents:UIControlEventTouchUpInside];
    }
    
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
    DDUpdate * update;
    update = [[DDUpdate alloc] initWithProject:@"contact" data:_conPer.mj_keyValues];
    [update startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
        if ([dic[@"error_code"] intValue] == 6) {
            NSMutableDictionary* m_dic;
            if (_user_index == 99999) {
                m_dic = [NSMutableDictionary dictionary];
                [m_dic setValue:dic[@"travel_cid"] forKey:@"travel_cid"];

            }else{
                m_dic = [Member DefaultUser].cont_arr[_user_index];
            }
            [m_dic setValue:_conPer.travel_name forKey:@"travel_name"];
            [m_dic setValue:_conPer.travel_phone forKey:@"travel_phone"];
            [m_dic setValue:_conPer.travel_id forKey:@"travel_id"];
            [m_dic setValue:_conPer.travel_sex forKey:@"travel_sex"];
            if (_user_index == 99999) {
                [[Member DefaultUser].cont_arr addObject:m_dic];
            }

            [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"failed！"];
        
    }];


}
-(void)delContact{
    
    DDUpdate * update;
    update = [[DDUpdate alloc] initWithProject:@"contact_del" data:@{@"cid":_data_dic[@"travel_cid"]}];
    [update startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
        if ([dic[@"error_code"] intValue] == 6) {
            NSMutableArray * m_dic = [Member DefaultUser].cont_arr;
            [m_dic removeObjectAtIndex:_user_index];
            [SVProgressHUD showSuccessWithStatus:@"success！"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"failed！"];
        
    }];

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
        _conPer = [[YYLUser alloc] init];
    
        [cell.name_field.rac_textSignal subscribeNext:^(id x) {
            _conPer.travel_name = cell.name_field.text;

        }];
        [cell.phone_field.rac_textSignal subscribeNext:^(id x) {
            _conPer.travel_phone = cell.phone_field.text;
        }];
        [cell.id_field.rac_textSignal subscribeNext:^(id x) {
            _conPer.travel_id = cell.id_field.text;
        }];

        cell.selectSex = ^(NSString * num){
            _conPer.travel_sex = num;
        };
    if (_user_index!= 99999) {
        _data_dic = [Member DefaultUser].cont_arr[_user_index];
        if (_data_dic) {
            _conPer.travel_name = cell.name_field.text = _data_dic[@"travel_name"];
            _conPer.travel_phone = cell.phone_field.text = _data_dic[@"travel_phone"];
            _conPer.travel_id = cell.id_field.text = _data_dic[@"travel_id"];
            [cell selectOne:[_data_dic[@"travel_sex"] intValue]];
            _conPer.travel_sex =_data_dic[@"travel_sex"];
            _conPer.travel_cid = _data_dic[@"travel_cid"];
        }

    }
    



    
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
