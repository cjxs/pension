//
//  CitySkipViewCell.h
//  HealthySettle
//
//  Created by yrc on 16/3/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TempView;
@interface CitySkipViewCell : UITableViewCell {
    NSArray * data_array;
}
@property (nonatomic, strong) UICollectionView * cityCollect_view;
@property (nonatomic, strong) UIImageView      * title_icon;
@property (nonatomic, strong) UILabel          * title_label;
@property (nonatomic, assign) NSInteger        type;
@property (nonatomic,strong )NSArray * dataArr;
-(void)configWithicon:(UIImage *)icon title:(NSString *)title data:(NSArray *)dataArray;
@end
