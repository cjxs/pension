//
//  SearchVController.m
//  HealthySettle
//
//  Created by yrc on 16/3/22.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "SearchVController.h"

@interface SearchVController ()
@property (weak, nonatomic) IBOutlet UIImageView * topImageV;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet UIView *fourthView;
@property (weak, nonatomic) IBOutlet UIView *fivthView;
@property (weak, nonatomic) IBOutlet UIButton *serch_messagebtn;
@property (weak, nonatomic) IBOutlet UIImageView *first_markPic;
@property (weak, nonatomic) IBOutlet UIImageView *second_markPic;
@property (weak, nonatomic) IBOutlet UIImageView *third_markPic;
@property (weak, nonatomic) IBOutlet UIImageView *four_markPic;
@property (weak, nonatomic) IBOutlet UIImageView *fivth_markPic;
@property (weak, nonatomic) IBOutlet UILabel *city_label;
@property (weak, nonatomic) IBOutlet UILabel *sellectOn_label;
@property (weak, nonatomic) IBOutlet UILabel *seletOff_label;
@property (weak, nonatomic) IBOutlet UILabel *nurseChoose_label;
@property (weak, nonatomic) IBOutlet UILabel *nurseTrue_label;
@property (weak, nonatomic) IBOutlet UILabel *position_label;
@property (weak, nonatomic) IBOutlet UILabel *priceAndCity_label;

@end

@implementation SearchVController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor grayColor];
//    _vc_type = @"L";
    if ([_vc_type isEqualToString:@"L"]) {
        [self setBottomPicWithPic:[UIImage imageNamed:@"z_03"] andTitle:@"找。养老院"];
        _third_markPic.image = [UIImage imageNamed:@"z_02"];
        _four_markPic.image = [UIImage imageNamed:@"z_02"];
        _fivth_markPic.image = [UIImage imageNamed:@"z_02"];
        _city_label.text = @"杭州市";
        
        [_sellectOn_label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(45);
        }];
        [_seletOff_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
        }];
        _sellectOn_label.font = [UIFont systemFontOfSize:16];
        _sellectOn_label.text = @"区／县";
        _seletOff_label.alpha = 0;
        _nurseChoose_label.text = @"护理等级";
        _nurseTrue_label.text = @"全护";
        _position_label.text = @"机构名称／位置";
        _priceAndCity_label.alpha = 1.0;
        _priceAndCity_label.text = @"价格";
        
    }else {
         [self setBottomPicWithPic:[UIImage imageNamed:@"z_02"] andTitle:@"养生。度假"];
        
        _third_markPic.image = [UIImage imageNamed:@"z_03"];
        _four_markPic.image = [UIImage imageNamed:@"z_03"];
        _fivth_markPic.image = [UIImage imageNamed:@"z_03"];
        
        _city_label.text = @"杭州市";
        _seletOff_label.alpha = 1.0;
        [_sellectOn_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(23);
        }];
        [_seletOff_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(23);
        }];
        _sellectOn_label.text = @"2 月 14 日   今天入住";
        _seletOff_label.text = @"2 月 15 日   明天离店";
        [_nurseChoose_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(150);
        }];
        _nurseChoose_label.text = @"机构／位置／景点名";
        _nurseTrue_label.text = @"";
        _position_label.text = @"价格";
        _priceAndCity_label.alpha = 0;

    }
    

}
//配置上方图片和标题信息
- (void)setBottomPicWithPic:(UIImage *)imageP andTitle:(NSString *)string {
    _topImageV.image = imageP;
    _textLabel.text = string;
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
