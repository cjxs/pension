//
//  CityCollectionViewCell.h
//  HealthySettle
//
//  Created by yrc on 16/3/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView * image_view;
@property (nonatomic, strong) UILabel     * describ_label;
-(void)configWithImage:(UIImage *)image name:(NSString *)name;
@end
