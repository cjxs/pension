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
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake(screenWide / 3.005, screenHeight * 0.253);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
     UICollectionView * season_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.013,screenWide, screenHeight * 0.253) collectionViewLayout:layout];
        
        
        season_collectionView.dataSource = self;
        season_collectionView.delegate =self;
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SeasonMCollectViewCell * cell = [_season_collectionView dequeueReusableCellWithReuseIdentifier:@"cellSea" forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            [cell configViewWithimage:[UIImage imageNamed:@"p_01"] season:@"1 月" describ:@"新的开始"];
            break;
        case 1:
            [cell configViewWithimage:[UIImage imageNamed:@"p_02"] season:@"2 月" describ:@"春季旅行"];
            break;
        case 2:
            [cell configViewWithimage:[UIImage imageNamed:@"p_03"] season:@"3 月" describ:@"春节没玩够"];
            break;
        case 3:
            [cell configViewWithimage:[UIImage imageNamed:@"p_01"] season:@"4 月" describ:@"新的开始"];
            break;
        case 4:
            [cell configViewWithimage:[UIImage imageNamed:@"p_02"] season:@"5 月" describ:@"新的开始"];
            break;
        case 5:
            [cell configViewWithimage:[UIImage imageNamed:@"p_03"] season:@"6 月" describ:@"新的开始"];
            break;
        case 6:
            [cell configViewWithimage:[UIImage imageNamed:@"p_01"] season:@"7 月" describ:@"新的开始"];
            break;
        case 7:
            [cell configViewWithimage:[UIImage imageNamed:@"p_02"] season:@"8月" describ:@"新的开始"];
            break;
        case 8:
            [cell configViewWithimage:[UIImage imageNamed:@"p_03"] season:@"9 月" describ:@"新的开始"];
            break;
        case 9:
            [cell configViewWithimage:[UIImage imageNamed:@"p_01"] season:@"10 月" describ:@"新的开始"];
            break;
        case 10:
            [cell configViewWithimage:[UIImage imageNamed:@"p_02"] season:@"11月" describ:@"新的开始"];
            break;
            
        default:
            [cell configViewWithimage:[UIImage imageNamed:@"p_03"] season:@"12月" describ:@"新的开始"];
            break;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选择了第%d个",(int)indexPath.row);
}


-(void)pageChanged:(UIPageControl *)page {
    CGFloat x = page.currentPage * self.bounds.size.width;
    if (self.season_collectionView.contentOffset.x /screenWide >= 3) {
         [_season_collectionView setContentOffset:CGPointMake(x, 0) animated:NO];
    }else {
        [_season_collectionView setContentOffset:CGPointMake(x, 0) animated:YES];
    }
}

- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

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
