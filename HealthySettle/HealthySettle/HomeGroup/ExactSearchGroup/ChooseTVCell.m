//
//  ChooseTVCell.m
//  HealthySettle
//
//  Created by yrc on 17/1/5.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "ChooseTVCell.h"
#import "PPNumberButton.h"

@implementation ChooseTVCell
- (PPNumberButton *)number_btn
{
    if (!_number_btn) {
        PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(screenWide * 0.718, screenHeight * 0.21664, screenWide/4, screenHeight * 0.043478)];
        numberButton.shakeAnimation = YES;
        numberButton.increaseImage = [UIImage imageNamed:@"increase_taobao"];
        numberButton.decreaseImage = [UIImage imageNamed:@"decrease_taobao"];
        numberButton.backgroundColor = [UIColor colorWithHexString:@"#ebebeb"];
        
                
        _number_btn = numberButton;
    }
    return _number_btn;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = WHITECOLOR;
        UIView * line_view0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.01499)];
        line_view0.backgroundColor = GRAYCOLOR;
        [self addSubview:line_view0];
        UIImageView * address_iView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"address_choose"]];
        address_iView.frame = CGRectMake(screenWide * 0.032, screenHeight * 0.029985, screenWide * 0.05866, screenWide * 0.05866);
        [self addSubview:address_iView];
        UILabel * address_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.12266, screenHeight * 0.03373, screenWide * 0.4, screenHeight * 0.02848)];
        address_label.text = @"杭州出发";
        [self addSubview:address_label];
        UIView * line_view1 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight*0.07946, screenWide, 1)];
        line_view1.backgroundColor = [UIColor colorWithHexString:@"#ebebeb"];
        [self addSubview:line_view1];
        
        UIImageView * date_iView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"date_choose"]];
        date_iView.frame = CGRectMake(screenWide * 0.032, screenHeight * 0.09595, screenWide * 0.05866, screenWide * 0.05866);
        [self addSubview:date_iView];
        UILabel * date_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.12266, screenHeight * 0.09595, screenWide * 0.4, screenHeight * 0.02848)];
        date_label.text = @"出发日期";
        [self addSubview:date_label];
        NSArray * array = @[@"12/15",@"12/17",@"12/26",@"12/29",@"12/30"];
        if (array) {
            UIButton * btn0;
            for (int i = 0;i < array.count; i++) {
                UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [btn1 setTitle:array[i] forState:UIControlStateNormal];
                [btn1.layer setBorderWidth:0.5f];
                [btn1 addTarget:self action:@selector(touchThisButton:)forControlEvents:UIControlEventTouchUpInside];
                btn1.layer.cornerRadius = 2;
                btn1.layer.masksToBounds = YES;
                [self addSubview:btn1];
                if (!btn0) {
                    [btn1 setTintColor:PINKCOLOR];
                    [btn1.layer setBorderColor:[PINKCOLOR CGColor]];
                    
                    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.width.mas_equalTo(@(screenWide * 0.16));
                        make.height.mas_equalTo(@(screenHeight * 0.04497));
                        make.left.equalTo(date_label);
                        make.top.mas_equalTo(date_label.mas_bottom).offset(screenHeight * 0.01499);
                    }];
                }else{
                    [btn1 setTintColor:[UIColor blackColor]];
                    [btn1.layer setBorderColor:[[UIColor grayColor] CGColor]];

                    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.width.mas_equalTo(@(screenWide * 0.15));
                        make.height.mas_equalTo(@(screenHeight * 0.04497));
                        make.left.mas_equalTo(btn0.mas_right).offset(screenWide * 0.0266);
                        make.top.mas_equalTo(date_label.mas_bottom).offset(screenHeight * 0.01499);
                    }];
                }
                btn0 = btn1;
            }
        }

        
        
        
        UIView * line_view2 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.20389, screenWide, 1)];
        line_view2.backgroundColor = [UIColor colorWithHexString:@"#ebebeb"];
        [self addSubview:line_view2];
        
        UIImageView * number_iView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"number_choose"]];
        number_iView.frame = CGRectMake(screenWide * 0.032, screenHeight * 0.22038, screenWide * 0.05866, screenWide * 0.05866);
        [self addSubview:number_iView];
        UILabel * number_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.12266, screenHeight * 0.22413, screenWide * 0.4, screenHeight * 0.02848)];
        number_label.text = @"数量";
        [self addSubview:number_label];
        
        [self addSubview:self.number_btn];
        

        

        
        
    }
    return self;
}
                                                          
-(void)touchThisButton:(UIButton *)btn{
    if (btn.tintColor == PINKCOLOR) {
    //释放掉
    }else{
        for (int i = 0; i < self.subviews.count; i++) {
            if ([self.subviews[i] isKindOfClass:[UIButton class]]) {
                if (self.subviews[i] == btn) {
                    [btn setTintColor:PINKCOLOR];
                    [btn.layer setBorderColor:[PINKCOLOR CGColor]];

                }else{
                    UIButton * btn = self.subviews[i];
                    [btn setTintColor:[UIColor blackColor]];
                    [btn.layer setBorderColor:[[UIColor grayColor] CGColor]];

                }
                
            }
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
                                               @end
