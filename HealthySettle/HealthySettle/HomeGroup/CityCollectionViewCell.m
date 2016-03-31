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
        self.backgroundColor = [UIColor whiteColor];
        self.image_view = [[UIImageView alloc] initWithFrame:CGRectMake(screenWide * 0.01, 0, screenWide * 0.235, screenHeight * 0.165)];
        _image_view.image = [UIImage imageNamed:@"z_03"];
        [self addSubview:_image_view];
        self.describ_label = [[UILabel alloc] initWithFrame:CGRectMake(0, screenWide/8 - kMargin, screenWide/4 - kMargin, 30)];
        _describ_label.textAlignment = NSTextAlignmentCenter;
        _describ_label.font = [UIFont systemFontOfSize:18];
        _describ_label.textColor = [UIColor whiteColor];
        [self addSubview:_describ_label];
    }
    return self;
}
-(void)configWithImage:(UIImage *)image name:(NSString *)name {
    if (self) {
        _image_view.image = image;
        _describ_label.text = name;
    }
}
@end
