//
//  FiltView.m
//  HealthySettle
//
//  Created by yrc on 17/1/12.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "FiltView.h"
#import "FiltViewCell.h"

@implementation FiltView


-(instancetype)init{
    self = [super init];
    if (self) {
        self.selectType = DDSelectTYpeSingle;
        self.listType = DDListTYpeSingle;
        _viewType = DDUnnormalView;
        self.frame = [UIScreen mainScreen].bounds;
        
        UIView * alpha_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight  * 57496)];
        alpha_view.alpha = 0.5;
        alpha_view.backgroundColor = [UIColor blackColor];
        alpha_view.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tap.numberOfTouchesRequired = 1;
        [alpha_view addGestureRecognizer:tap];
        
        [self addSubview:alpha_view];

    }
    return self;
}
- (void)addFirstView
{

    if (self.listType == 0) {
        UITableView * tabview_0 = [[UITableView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.57496 , screenWide, screenHeight * 0.5 - screenHeight * 0.07496-64) style:UITableViewStylePlain];
        UITableView * tabview_1 = [[UITableView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.57496 , screenWide, screenHeight * 0.5 - screenHeight * 0.07496) style:UITableViewStylePlain];
        left_tab_view = self.viewType ==1?tabview_0:tabview_1;

    }else{
        UITableView * tabview_2 = [[UITableView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.57496 , screenWide * 0.353, screenHeight * 0.5 - screenHeight * 0.07496-64) style:UITableViewStylePlain];
        UITableView * tabview_3 = [[UITableView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.57496 , screenWide * 0.353, screenHeight * 0.5 - screenHeight * 0.07496) style:UITableViewStylePlain];
        left_tab_view = self.viewType ==1?tabview_2:tabview_3;
        UIView * white_view = [[UIView alloc] init];
        white_view.backgroundColor = WHITECOLOR;
        [self addSubview:white_view];
        [white_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self);
            make.top.equalTo(self).offset(screenHeight  * 0.57496);
            make.left.equalTo (self);
            make.bottom.equalTo(self);
        }];


    }
    left_tab_view.delegate = self;
    left_tab_view.dataSource = self;
    left_tab_view.tableFooterView = [UIView new];
    left_tab_view.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
    [left_tab_view registerClass:[FiltViewCell class] forCellReuseIdentifier:@"cell"];
    [self addSubview:left_tab_view];
    
    if (_selectType == DDSelectTYpeSingle &&_listType == 1) {
        
    }else{
        btns_view = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.5, screenWide, screenHeight * 0.07496)];
        btns_view.backgroundColor = [UIColor colorWithHexString:@"#f2774b"];
        
        [self addSubview:btns_view];
        
        UIButton * clear_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [clear_btn addTarget:self action:@selector(clearSelected) forControlEvents:UIControlEventTouchUpInside];
        [clear_btn setTitle:@"清空筛选" forState:UIControlStateNormal];
        clear_btn.clipsToBounds = YES;
        clear_btn.layer.cornerRadius = 4;
        [btns_view addSubview:clear_btn];
        [clear_btn setBackgroundColor:[UIColor colorWithHexString:@"#de693e"] forState:UIControlStateNormal];
        [clear_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@(screenWide *0.266));
            make.height.mas_equalTo(@(screenHeight * 0.04497));
            make.center.equalTo(btns_view);
        }];
        
        UIButton * cancle_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancle_btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [cancle_btn setTitle:@"取消" forState:UIControlStateNormal];
        [btns_view addSubview:cancle_btn];
        [cancle_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(clear_btn);
            make.size.mas_equalTo(CGSizeMake(screenWide * 0.16, screenHeight * 0.04497));
        }];
        
        UIButton * sure_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sure_btn addTarget:self action:@selector(confirmSure) forControlEvents:UIControlEventTouchUpInside];
        [sure_btn setTitle:@"确定" forState:UIControlStateNormal];
        [btns_view addSubview:sure_btn];
        [sure_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.top.equalTo(clear_btn);
            make.size.equalTo(cancle_btn);
        }];
        if (IS_IPHONE5||IS_IPHONE5EARLY) {
            cancle_btn.titleLabel.font = [UIFont systemFontOfSize:14];
            sure_btn.titleLabel.font = [UIFont systemFontOfSize:14];
            clear_btn.titleLabel.font = [UIFont systemFontOfSize:12];
        }
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == left_tab_view) {
        return _data_arr1.count;
    }else{
        return _data_arr2.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return screenHeight * 0.0659;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FiltViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (tableView == left_tab_view) {
        cell.text_label.text = _data_arr1[indexPath.row];
        cell.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
        
    }else{
        cell.text_label.text = _data_arr2[indexPath.row];
    }
    
    if (self.selectType == DDSelectTYpeMulti && [result_arr containsObject:_data_arr2[indexPath.row]]) {
        cell.text_label.textColor = [UIColor colorWithHexString:@"f2774b"];
    }else{
        cell.text_label.textColor = [UIColor blackColor];
    }
    if (IS_IPHONE5EARLY || IS_IPHONE5) {
        cell.text_label.font = [UIFont systemFontOfSize:11];
    }else{
        cell.text_label.font = [UIFont systemFontOfSize:14];
    }

    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FiltViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];

    if (tableView == left_tab_view) {
        if (_listType == 1) {
            if (_selectFir != nil) {
                _data_arr2 = _selectFir(indexPath.row);
                cell.backgroundColor = WHITECOLOR;
                
                if (lastIndex) {
                    [tableView reloadRowsAtIndexPaths:@[lastIndex] withRowAnimation:UITableViewRowAnimationNone];
                }
                lastIndex = indexPath;
            }
            if (_selectType == 0 && indexPath.row == 0) {
                [self clearSelected];
            }else{
                right_tab_view = [[UITableView alloc] initWithFrame:CGRectMake(screenWide * 0.394, screenHeight * 0.57496 , screenWide * 0.606, screenHeight * 0.5 - screenHeight * 0.07496-64) style:UITableViewStylePlain];
                right_tab_view.delegate = self;
                right_tab_view.dataSource = self;
                right_tab_view.tableFooterView = [UIView new];
                [right_tab_view registerClass:[FiltViewCell class] forCellReuseIdentifier:@"cell"];
                
                [self addSubview:right_tab_view];
            }

        }else{
            switch (self.selectType) {
                case DDSelectTYpeSingle:
                    result = _data_arr1[indexPath.row];
                    cell.text_label.textColor = [UIColor colorWithHexString:@"f2774b"];
                    [self confirmSure];
                    break;
                case DDSelectTYpeMulti:
                    if (result_arr) {
                        if ([result_arr containsObject:_data_arr1[indexPath.row]]) {
                            [result_arr removeObject:_data_arr1[indexPath.row]];
                            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                            
                        }else{
                            [result_arr addObject:_data_arr1[indexPath.row]];
                            cell.text_label.textColor = [UIColor colorWithHexString:@"f2774b"];
                        }
                    }else{
                        result_arr = [NSMutableArray arrayWithObject:_data_arr1[indexPath.row]];
                        cell.text_label.textColor = [UIColor colorWithHexString:@"f2774b"];
                        
                    }
                    break;
                    
                default:
                    break;
            }
            
        }

    }else{
        switch (self.selectType) {
            case DDSelectTYpeSingle:
                result = _data_arr2[indexPath.row];
                cell.text_label.textColor = [UIColor colorWithHexString:@"f2774b"];
                [self confirmSure];
                break;
            case DDSelectTYpeMulti:
                if (result_arr) {
                    if ([result_arr containsObject:_data_arr2[indexPath.row]]) {
                        [result_arr removeObject:_data_arr2[indexPath.row]];
                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

                    }else{
                        [result_arr addObject:_data_arr2[indexPath.row]];
                        cell.text_label.textColor = [UIColor colorWithHexString:@"f2774b"];
                    }
                }else{
                    result_arr = [NSMutableArray arrayWithObject:_data_arr2[indexPath.row]];
                    cell.text_label.textColor = [UIColor colorWithHexString:@"f2774b"];

                }
                break;
                
            default:
                break;
        }
    }
    
}
-(void)clearSelected{
    if (_sureBtn) {
        switch (self.selectType) {
            case 0:
                _sureBtn(@"");
                break;
            case 1:
                
                _sureBtn(@[]);
                break;
                
            default:
                break;
        }
    }
    [self performSelector:@selector(dismiss) withObject:self afterDelay:0.2f];

}
-(void)confirmSure{
    if (_sureBtn) {
        switch (self.selectType) {
            case 0:
                _sureBtn(result);
                break;
            case 1:
                
                _sureBtn(result_arr);
                break;
                
                default:
                break;
        }
    }
    [self performSelector:@selector(dismiss) withObject:self afterDelay:0.2f];
}
-(void)dismiss{
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
