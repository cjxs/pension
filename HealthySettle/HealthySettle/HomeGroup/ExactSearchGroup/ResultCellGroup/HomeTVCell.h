//
//  HomeTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/4/1.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *organ_imageView;
@property (weak, nonatomic) IBOutlet UIButton    *priceDetail_btn;
@property (weak, nonatomic) IBOutlet UILabel     *price_label;
@property (weak, nonatomic) IBOutlet UIButton    *reserve_btn;
-(void)configWithImage:(UIImage *)image price:(NSString *)price show:(NSString *)show;
@end
