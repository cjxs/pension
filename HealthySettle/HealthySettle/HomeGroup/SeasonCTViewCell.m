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

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGB(242, 242, 242);
        UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.012, screenWide, screenHeight * 0.001)];
        line_view.backgroundColor = RGB(229, 229, 229);
        [self addSubview:line_view];
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake(screenWide / 3.005, screenHeight * 0.253);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
     UICollectionView * season_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.013,screenWide, screenHeight * 0.253) collectionViewLayout:layout];
        
        [season_collectionView registerClass:[SeasonMCollectViewCell class] forCellWithReuseIdentifier:@"cellSea"];
        [self addSubview:season_collectionView];
        _season_collectionView = season_collectionView;
        _season_collectionView.backgroundColor = RGB(255, 255, 255);
        
        CGFloat wides = self.bounds.size.width;
        UIPageControl * carousePageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(wides /4.0 , screenHeight * 0.253 - kMargin/2, wides /2.0, kMargin)];
        carousePageControl.numberOfPages = 4;
        carousePageControl.pageIndicatorTintColor = RGB(246, 246, 246);
        carousePageControl.currentPageIndicatorTintColor = RGB(247, 55, 72);
        [carousePageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:carousePageControl];
        _carousePageControl = carousePageControl;

    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    _season_collectionView.bounces = NO;
    _season_collectionView.showsHorizontalScrollIndicator = NO;
    _season_collectionView.pagingEnabled = YES;
}

-(void)pageChanged:(UIPageControl *)page {
    CGFloat x = page.currentPage * self.bounds.size.width;
    if (self.season_collectionView.contentOffset.x /screenWide >= 3) {
         [_season_collectionView setContentOffset:CGPointMake(x, 0) animated:NO];
    }else {
        [_season_collectionView setContentOffset:CGPointMake(x, 0) animated:YES];
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int page = scrollView.contentOffset.x /scrollView.bounds.size.width + 0.5;
    self.carousePageControl.currentPage = page;
    
}
-(void)dealloc {
    _season_collectionView = nil;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
