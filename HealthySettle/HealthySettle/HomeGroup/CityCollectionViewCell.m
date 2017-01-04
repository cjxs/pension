//
//  CityCollectionViewCell.m
//  HealthySettle
//
//  Created by yrc on 16/3/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "CityCollectionViewCell.h"


@implementation CityCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.image_view = [[UIImageView alloc]
                           initWithFrame:CGRectMake(0, 0, screenWide *0.4667, screenHeight * 0.1439)];
        [self addSubview:_image_view];
        self.describ_label = [[UILabel alloc]
                              initWithFrame:CGRectMake(screenWide *0.4667/4,screenHeight * 0.06, screenWide *0.4667/2, 40)];
        _describ_label.textAlignment = NSTextAlignmentCenter;
        _describ_label.backgroundColor = [UIColor clearColor];
        _describ_label.textColor = [UIColor whiteColor];
        [self addSubview:_describ_label];
    }
    return self;
}
-(void)configWithImage:(NSString *)imageStr name:(NSString *)name {
    if (self) {
        if (imageStr) {
            [_image_view sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"city_p"]];
        }
        if (name) {
            _describ_label.text = name;
        }
    }
}
@end
