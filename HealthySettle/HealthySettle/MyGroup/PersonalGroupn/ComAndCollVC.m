//
//  ComAndCollVC.m
//  HealthySettle
//
//  Created by yrc on 16/4/7.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "ComAndCollVC.h"
#import "ComOrCollTVCell.h"
#import "DDCollectList.h"

//收藏和点评
@interface ComAndCollVC ()<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray * collect_Arr;
    NSArray * text_arr;
    NSArray * title_arr;
}

@end

@implementation ComAndCollVC
- (UITableView *)homeTableView
{
    if (!_homeTableView)
    {
        _homeTableView = [[UITableView alloc]
                          initWithFrame:CGRectMake(0, 1, screenWide, 600)];
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
        _homeTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _homeTableView.tableFooterView = [UIView new];
    }
    return _homeTableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.type isEqualToString:@"invite"])
    {
        /*
        UIImageView * imageView = [[UIImageView alloc]
                                   initWithImage:[UIImage imageNamed:@"content"]];
        imageView.frame = CGRectMake(0, 0, screenWide, screenHeight * 0.6727);
        [self.view addSubview:imageView];
         */
        [self setInviteView];
        
    }else if ([self.type isEqualToString:@"collect"]){
        self.view.backgroundColor = [UIColor whiteColor];
        [self setCollectData];
    }
}
-(void)setInviteView{
    self.view.backgroundColor = GRAYCOLOR;
    title_arr = @[@"邀请码",@"推广链接"];
    NSString *str =  [Member DefaultUser].refer_code;
    text_arr = @[str,[NSString stringWithFormat:@"%@/index.php?g=Index&c=Login&a=reg&refer_code=%@",BASEURL,str]];
    for (int i = 0; i < 2; i++) {
        UIView * view_0 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.015 + screenHeight * 0.215 * i, screenWide, screenHeight * 0.2 + screenHeight * 0.1*i)];
        view_0.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view_0];
        
        UIButton * copy_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        copy_btn.tag = 520+i;
        [copy_btn addTarget:self action:@selector(copySomeThingWithButton:) forControlEvents:UIControlEventTouchUpInside];
        copy_btn.backgroundColor = [UIColor redColor];
        [view_0 addSubview:copy_btn];
        [copy_btn setTitle:@"复制" forState:UIControlStateNormal];
        [view_0 addSubview:copy_btn];
        [copy_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(screenWide /5,screenHeight * 0.05));
            make.bottom.equalTo(view_0).offset(-screenHeight * 0.02);
            make.centerX.equalTo(view_0);
        }];
        
        UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.03, screenWide * 0.2, screenHeight * 0.05)];
        title_label.font = [UIFont systemFontOfSize:12];
        title_label.textColor = [UIColor grayColor];
        [view_0 addSubview:title_label];
        UILabel * text_label = [[UILabel alloc] init];
        text_label.backgroundColor = GRAYCOLOR;
        text_label.layer.masksToBounds  = YES;
        text_label.numberOfLines = 0;
        text_label.layer.cornerRadius = 5;
        [view_0 addSubview:text_label];
        [text_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title_label);
            make.bottom.mas_equalTo(copy_btn.mas_top).offset(-screenHeight * 0.02);
            make.left.mas_equalTo(title_label.mas_right);
            make.right.equalTo(view_0).offset(-10);
        }];
        
        title_label.text = title_arr[i];
        text_label.text = text_arr[i];



    }
    
    
}
-(void)copySomeThingWithButton:(UIButton *)btn{
    
    int number = btn.tag - 520;
    UIPasteboard * pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = text_arr[number];
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"已成功复制 %@ 到粘贴板",title_arr[number]]];
    
}
-(void)setCollectData{
    Member * user = [Member DefaultUser];

    DDCollectList * collect_list = [[DDCollectList alloc] initWithUid:user.uid login:user.login];
    [collect_list startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary * dic = [DDLogin dictionaryWithJsonString:request.responseString];
        if ([dic[@"error_code"] intValue]== 0) {
            collect_Arr = dic[@"collect"];
            [self loadCollectData];
        }else{
            NSLog(@"出错啦%@",dic);
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
    
}
-(void)loadCollectData{
    [self.view addSubview:self.homeTableView];
    [self.homeTableView registerNib:[UINib nibWithNibName:@"ComOrCollTVCell" bundle:nil]
             forCellReuseIdentifier:@"cell123"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = _titleName;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return collect_Arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComOrCollTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell123"
                                                             forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = collect_Arr[indexPath.row];
    [cell configRefundWithtitle:dic[@"s_name"]
                          image:dic[@"pic"]
                           type: _type
                          price:dic[@"price"]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return screenHeight * 0.2544;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
