//
//  ChooPersonView.m
//  HealthySettle
//
//  Created by yrc on 17/2/20.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "ChooPersonView.h"
#import "ChoosePTVCell.h"
#import "YYLUser.h"

@implementation ChooPersonView{
    UIView * bg_view;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;

        bg_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight)];
        bg_view.backgroundColor = [UIColor blackColor];
        bg_view.alpha = 0.5;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
        tap.numberOfTouchesRequired = 1;
        [bg_view addGestureRecognizer:tap];
        [self addSubview:bg_view];
        


    }
    return self;
}
-(UIView *)addheadView{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide *0.8, screenHeight * 0.05)];
    UIView *line_view = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.05-1, screenWide * 0.8,1)];
    line_view.backgroundColor = GRAYCOLOR;
    [view addSubview:line_view];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.1, screenHeight * 0.005, screenWide * 0.6, screenHeight *0.04)];
    label.textColor = [UIColor blackColor];
    label.text = @"选择常用信息";
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    return view;
}
- (void)addFirstView
{

    _select_view = [[UITableView alloc] initWithFrame:CGRectMake(screenWide * 0.1, screenHeight * 0.4, screenWide * 0.8, screenHeight * 0.4) style:UITableViewStylePlain];
    [_select_view registerClass:[ChoosePTVCell class] forCellReuseIdentifier:@"cell"];

    _select_view.delegate = self;
    _select_view.dataSource = self;

    
    _select_view.tableHeaderView = [self addheadView];
    
    _select_view.tableFooterView = [UIView new];
    
    [self addSubview:_select_view];
    _select_view.clipsToBounds = YES;
    _select_view.layer.cornerRadius = 10;


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data_arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChoosePTVCell * cell =  [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    YYLUser *user = _data_arr[indexPath.row];
    [cell configWithname:user.travel_name];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return screenHeight * 0.05;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChoosePTVCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor redColor];
    cell.img_view.image = [UIImage imageNamed:@"selected"];
    _selected ? _selected(_data_arr[indexPath.row]) : nil;
    [self remove];
        
    
}
- (void)remove {
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
