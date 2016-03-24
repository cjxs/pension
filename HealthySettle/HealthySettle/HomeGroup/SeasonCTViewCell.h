//
//  SeasonCollectionTViewCell.h
//  HealthySettle
//
//  Created by yrc on 16/3/23.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeasonCTViewCell : UITableViewCell
@property (nonatomic, strong)UICollectionView * season_collectionView;
@property(nonatomic, weak)UIPageControl * carousePageControl;
@property (nonatomic, strong)NSTimer * timer;
-(void)startTimer;
-(void)updateTimer;
@end
