//
//  SearchVController.h
//  HealthySettle
//
//  Created by yrc on 16/3/22.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchVController : UIViewController
@property (nonatomic, strong) NSString    * vc_type;
@property (strong, nonatomic) UIImageView *back_imageView;
@property (nonatomic, strong) NSString    * chosedCity;
@property (nonatomic, strong) NSString    * chosed_code;
@property (nonatomic, strong) NSArray     * chosed_cityArray;
@property (nonatomic, strong) NSString    * chosed_districtStr;
@property (nonatomic,strong ) UIButton    * back_button;
@end
