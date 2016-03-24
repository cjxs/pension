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
        self.backgroundColor = [UIColor grayColor];
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake(screenWide/3, screenHeight/5-kMargin);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
     UICollectionView * season_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kMargin/2,screenWide, screenHeight/5 - kMargin) collectionViewLayout:layout];
        
        season_collectionView.dataSource = self;
        season_collectionView.delegate =self;
        [self addSubview:season_collectionView];
        _season_collectionView = season_collectionView;
        [season_collectionView registerClass:[SeasonMCollectViewCell class] forCellWithReuseIdentifier:@"cellSea"];
        [self addSubview:self.carousePageControl];
        
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
            [cell configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"1 月" describ:@"新的开始"];
            break;
        case 1:
            [cell configViewWithimage:[UIImage imageNamed:@"z_03"] season:@"2 月" describ:@"春季旅行"];
            break;
        case 2:
            [cell configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"3 月" describ:@"春节没玩够"];            
            break;
        case 3:
            [cell configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"4 月" describ:@"新的开始"];
            break;
        case 4:
            [cell configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"5 月" describ:@"新的开始"];
            break;
        case 5:
            [cell configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"6 月" describ:@"新的开始"];
            break;
        case 6:
            [cell configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"7 月" describ:@"新的开始"];
            break;
        case 7:
            [cell configViewWithimage:[UIImage imageNamed:@"z_03"] season:@"8月" describ:@"新的开始"];
            break;
        case 8:
            [cell configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"9 月" describ:@"新的开始"];
            break;
        case 9:
            [cell configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"10 月" describ:@"新的开始"];
            break;
        case 10:
            [cell configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"11月" describ:@"新的开始"];
            break;
            
        default:
            [cell configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"12月" describ:@"新的开始"];
            break;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选择了第%ld个",indexPath.row);
}

-(void)pageChanged:(UIPageControl *)page {
    [self.timer invalidate];
    CGFloat x = page.currentPage * self.bounds.size.width;
    if (self.season_collectionView.contentOffset.x /screenWide >= 3) {
         [_season_collectionView setContentOffset:CGPointMake(x, 0) animated:NO];
    }else {
        [_season_collectionView setContentOffset:CGPointMake(x, 0) animated:YES];
    }
    [self startTimer];
}

-(void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
-(void)updateTimer{
    
    NSUInteger count = 4;
    if (count == 0) {
        NSLog(@"图片个数是0");
        return;
    }
    int page = (self.carousePageControl.currentPage + 1 ) % (int)count;
    self.carousePageControl.currentPage = page;
    [self pageChanged:self.carousePageControl];
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];//停止时钟
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int page = scrollView.contentOffset.x /scrollView.bounds.size.width + 0.5;
    self.carousePageControl.currentPage = page;
    
}
- (UIPageControl *)carousePageControl {
    if (!_carousePageControl) {
        UIPageControl * carousePageControl = [[UIPageControl alloc] init];
        carousePageControl.numberOfPages = 4;
        CGFloat wide = self.bounds.size.width;
        carousePageControl.frame = CGRectMake(0, screenHeight/5 - 1.5 * kMargin, wide, kMargin);
        
        carousePageControl.pageIndicatorTintColor = [UIColor redColor];
        carousePageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        
        [carousePageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
        _carousePageControl = carousePageControl;
        [self startTimer];

    }
    return _carousePageControl;
}
-(void)dealloc {
    [_timer invalidate];
    _timer = nil;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
