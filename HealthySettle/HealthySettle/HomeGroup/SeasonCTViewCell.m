//
//  SeasonCollectionTViewCell.m
//  HealthySettle
//
//  Created by yrc on 16/3/23.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "SeasonCTViewCell.h"
#import "SeasonMCollectViewCell.h"

static NSString * const carouselID = @"TempCarouseView";

@implementation SeasonCTViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = WHITECOLOR;
        UIView * line_view = [[UIView alloc]
                              initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.0148)];
        line_view.backgroundColor = GRAYCOLOR;
        [self addSubview:line_view];
        
        UIImageView * title_image_view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"热门"]];
        title_image_view.frame = CGRectMake(screenWide * 0.016, screenHeight * 0.03728, screenWide * 0.048, screenWide * 0.048);
        [self addSubview:title_image_view];
        UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.08, screenHeight * 0.03728, screenWide * 0.25, screenWide * 0.048)];
        title_label.text = @"四季推荐";
        title_label.backgroundColor = WHITECOLOR;
        title_label.textColor = [UIColor blackColor];
        [self addSubview:title_label];
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake(screenWide / 3.005, screenHeight * 0.1686);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView * season_collectionView = [[UICollectionView alloc]
                                                 initWithFrame:CGRectMake(0, screenHeight * 0.0794,screenWide, screenHeight * 0.1686) collectionViewLayout:layout];
        [season_collectionView registerClass:[SeasonMCollectViewCell class]
                  forCellWithReuseIdentifier:@"cellSea"];
        [self addSubview:season_collectionView];
        _season_collectionView = season_collectionView;
        _season_collectionView.backgroundColor = RGB(255, 255, 255);
        CGFloat wides = self.bounds.size.width;
        UIPageControl * carousePageControl = [[UIPageControl alloc]
                                              initWithFrame:CGRectMake(wides /4.0 , screenHeight * 0.248, wides /2.0, screenHeight * 0.04797)];
        carousePageControl.numberOfPages = 4;
        carousePageControl.pageIndicatorTintColor = RGB(246, 246, 246);
        carousePageControl.currentPageIndicatorTintColor = RGB(247, 55, 72);
        [carousePageControl addTarget:self action:@selector(pageChanged:)
                     forControlEvents:UIControlEventValueChanged];
        [self addSubview:carousePageControl];
        _carousePageControl = carousePageControl;
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _season_collectionView.bounces = NO;
    _season_collectionView.showsHorizontalScrollIndicator = NO;
    _season_collectionView.pagingEnabled = YES;
}
-(void)pageChanged:(UIPageControl *)page
{
    CGFloat x = page.currentPage * self.bounds.size.width;
    if (self.season_collectionView.contentOffset.x /screenWide >= 3)
    {
         [_season_collectionView setContentOffset:CGPointMake(x, 0) animated:NO];
    }else
    {
        [_season_collectionView setContentOffset:CGPointMake(x, 0) animated:YES];
    }
}



-(void)dealloc {
    _season_collectionView = nil;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
