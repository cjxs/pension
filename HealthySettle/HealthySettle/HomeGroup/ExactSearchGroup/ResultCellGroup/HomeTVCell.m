//
//  HomeTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/1.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "HomeTVCell.h"

@implementation HomeTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.reserve_btn.clipsToBounds = YES;
    self.reserve_btn.layer.cornerRadius = 5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configWithImage:(UIImage *)image price:(NSString *)price show:(NSString *)show {
    if (image) {
        self.organ_imageView.image = image;

    }
    if (price) {
        self.price_label.text = price;
    }
    if ([show isEqualToString:@"y"]) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 143, screenWide, 72)];
        for (int i = 0; i < 3; i++) {
            UIView * viewB = [[UIView alloc] initWithFrame:CGRectMake(0, 20*i, screenWide , 19)];
            if (i == 0) {
                viewB.backgroundColor = RGB(246, 246, 246);
                NSArray * array = @[@"1-6天",@"7-14天",@"15-29天"];
                for (int i = 0; i < 3; i++) {
                    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake((screenWide /4 )*(i+1), 0, screenWide /4 , 20)];
                    label.font = [UIFont systemFontOfSize:10];
                    label.text = array[i];
                    label.textAlignment = NSTextAlignmentCenter;
                    [viewB addSubview:label];
                }
            }else {
                viewB.backgroundColor = RGB(251, 251, 251);
                NSArray *array;
                if (i== 1) {
                    array = @[@"200",@"180",@"160"];
                }else {
                    array = @[@"180",@"160",@"140"];
                }
                for (int j = 0; j < 4; j ++) {
                    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide/4 * j, 0, screenWide /4, 20)];
                    label.font = [UIFont systemFontOfSize:10];
                    if (i == 1 && j == 0) {
                        label.text = @"旺季";
                    }else if (i == 2 && j == 0) {
                        label.text = @"淡季";
                    }else {
                        label.text = array[ j - 1];
                    }
                    label.textAlignment = NSTextAlignmentCenter;
                    [viewB addSubview:label];
                    }
            }
            [view addSubview:viewB];
            }
        
        [self addSubview:view];
    }
}
@end
