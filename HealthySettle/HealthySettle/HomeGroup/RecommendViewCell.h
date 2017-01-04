//
//  RecommendViewCell.h
//  HealthySettle
//
//  Created by yrc on 17/1/3.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RecommendDelegate <NSObject>

-(void)updateDataWithWave:(int)wave;

@end

@interface RecommendViewCell : UITableViewCell
{

    int number_btn;
    UIView * bg_view;
}
@property (nonatomic,weak)id <RecommendDelegate>  delegate;

@end
