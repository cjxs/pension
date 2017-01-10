//
//  TravelDetailVController.m
//  HealthySettle
//
//  Created by yrc on 17/1/5.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "TravelDetailVController.h"
#import "TitleTVCell.h"
#import "ChooseTVCell.h"
#import "PPNumberButton.h"
#import "MoveSelectTVCell.h"
#import "OrderTVController.h"
#import "LoginOrRegisViewController.h"

@interface TravelDetailVController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MoveSelDelegate>{
    UIImageView * organization_imageView;
    UITextField * current_field;
    UILabel * money_label;


    
}

@end

@implementation TravelDetailVController
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView * tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [UIView new];
        tableView.backgroundColor = GRAYCOLOR;

        _tableView = tableView;

    }
    return _tableView;
}

-(UIView *)tableHeadView {
    if (!_tableHeadView) {
        organization_imageView = [[UIImageView alloc]
                                  initWithFrame:CGRectMake(0, -20, screenWide, screenHeight * 0.2811)];
        organization_imageView.image = [UIImage imageNamed:@"banner_p"];
        _tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.2811-20)];
        _tableHeadView.backgroundColor = GRAYCOLOR;
        [_tableHeadView addSubview:organization_imageView];
        
        CGRect back_frame = CGRectMake(5, 15 , screenWide * 0.04, screenWide * 0.04/10 *18 );
        UIImageView * back_imageView = [[UIImageView alloc] initWithFrame:back_frame];
        back_imageView.image = [UIImage imageNamed:@"leftop_w"];
        
        UIButton * back_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        back_btn.frame = CGRectMake(screenWide * 0.01, screenHeight * 0.005 , screenWide * 0.2, screenHeight * 0.1 );
        [back_btn addTarget:self
                     action:@selector(cancleToRootView)
           forControlEvents:UIControlEventTouchUpInside];
        [back_btn addSubview:back_imageView];
        [_tableHeadView addSubview:back_btn];
    }
    return _tableHeadView;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WHITECOLOR;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.tableHeadView;
    [_tableView registerClass:[TitleTVCell class] forCellReuseIdentifier:@"title"];
    [_tableView registerClass:[ChooseTVCell class] forCellReuseIdentifier:@"choose"];
    [_tableView registerClass:[MoveSelectTVCell class] forCellReuseIdentifier:@"move"];
    
    [self creatBackFootView];

    
    

}
-(void)creatBackFootView{
    UIView * backFootView = [[UIView alloc]
                             initWithFrame:CGRectMake(0, screenHeight * 0.94, screenWide, screenHeight * 0.06)];
    backFootView.backgroundColor = [UIColor whiteColor];
    UIView * line_view =[[UIView alloc]
                         initWithFrame:CGRectMake(0, 0, screenWide, 1)];
    line_view.backgroundColor = RGB(246, 246, 246);
    [backFootView addSubview:line_view];
    UILabel * label = [[UILabel alloc]
                       initWithFrame:CGRectMake(screenWide * 0.1, 1, screenWide * 0.15, screenHeight * 0.06-1)];
    label.text = @"总价:";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentRight;
    [backFootView addSubview:label];
    money_label = [[UILabel alloc]
                   initWithFrame:CGRectMake(screenWide * 0.25, 1, screenWide * 0.2, screenHeight * 0.06 -1)];
    
    money_label.textAlignment = NSTextAlignmentLeft;
    money_label.font = [UIFont systemFontOfSize:14];
    money_label.text = @" ¥ 12534";
    money_label.textColor = PINKCOLOR;

    [backFootView addSubview:money_label];
    UIButton * toPay_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    toPay_btn.frame = CGRectMake(screenWide /2, 0, screenWide/2, screenHeight * 0.06);
    toPay_btn.backgroundColor = [UIColor colorWithHexString:@"#fc6120"];
    [toPay_btn setTitle:@"立即预订"
               forState:UIControlStateNormal];
    [toPay_btn addTarget:self
                  action:@selector(submitOrder)
        forControlEvents:UIControlEventTouchUpInside];
    [toPay_btn setTitleColor:[UIColor whiteColor]
                    forState:UIControlStateNormal];
    [backFootView addSubview:toPay_btn];
    [self.view addSubview:backFootView];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
#pragma mark - UITableViewDataSource ,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            TitleTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"title"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row == 1){
            ChooseTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"choose"];
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
            //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
            tapGestureRecognizer.cancelsTouchesInView = NO;
            //将触摸事件添加到当前view
            [cell addGestureRecognizer:tapGestureRecognizer];
            cell.number_btn.textField.delegate = self;
            cell.number_btn.numberBlock = ^(NSString *num){
                NSLog(@"%@--",num);
            };


            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }else{
            MoveSelectTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"move"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;

            return cell;
        }
    }else{
        return nil;
    }
    
   }

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return screenHeight * 0.1574;
        }else if (indexPath.row == 1){
            return screenHeight * 0.27136;
        }else{
            return screenHeight * 0.08095;
        }
    }
    return screenHeight * 0.1574;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
}
- (void)resignOrLoad
{
    LoginOrRegisViewController *loginOrRegVC = [[LoginOrRegisViewController alloc] init];
    loginOrRegVC.delegate = self;
    [self.navigationController pushViewController:loginOrRegVC animated:YES];
}
-(void)submitOrder{
    NSLog(@"提交");
    if (![Member DefaultUser].login) {
        [self resignOrLoad];
    }else{
        OrderTVController * orderVC = [[OrderTVController alloc]
                                       initWithStyle:UITableViewStylePlain];
//        orderVC.vc_type = _vc_type;
//        orderVC.gid = self.group_id;
//        orderVC.group_dic = _data_dic;
//        orderVC.chargeArray = _spec_Arr;
//      if (price_Now) {
//        orderVC.charge_price = price_Now;
//        }else{
//            orderVC.charge_price = [NSString stringWithFormat:@"%ld",[_data_dic[@"price"] integerValue]];
//        }
        [self.navigationController pushViewController:orderVC animated:YES];
    }

}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    current_field = textField;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"%@++",textField.text);

}
-(void)updateDataWithWave:(int)wave{
    NSLog(@"%d",wave);
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    if (current_field) {
        [current_field resignFirstResponder];
//        ChooseTVCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
//        cell.number_btn.numberBlock ? cell.number_btn.numberBlock(current_field.text) : nil;

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)cancleToRootView
{
    [self.navigationController popViewControllerAnimated:YES];
    for (UIView * view in self.view.subviews) {
        //        if (!(view.bounds.size.height ==self.view.bounds.size.height)) {
        [view removeFromSuperview];
        //        }
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
