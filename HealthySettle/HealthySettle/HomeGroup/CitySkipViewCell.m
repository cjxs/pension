//
//  CitySkipViewCell.m
//  HealthySettle
//
//  Created by yrc on 16/3/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "CitySkipViewCell.h"
#import "CityCollectionViewCell.h"
#import "TempView.h"

@implementation CitySkipViewCell
- (UILabel *)title_label {
    if (_title_label== nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(kMargin * 4, kMargin /2, screenWide - kMargin * 5 , screenHeight * 0.06)];
        _title_label.textColor = RGB(25, 25, 25);
        _title_label.textAlignment = NSTextAlignmentLeft;
        _title_label.text = @"缤纷花海";
    }
    return _title_label;
}
- (UIImageView *)title_icon {
    if (_title_icon == nil) {
        _title_icon = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin, kMargin * 2, kMargin *2, kMargin*2)];
        _title_icon.image = [UIImage imageNamed:@"z_02"];
    }
    return _title_icon;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGB(242, 242, 242);
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake( screenWide * 0.25 , screenHeight * 0.187);
         UICollectionView * cityCollect_view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.073, screenWide, screenHeight * 0.187) collectionViewLayout:layout];
        cityCollect_view.backgroundColor = [UIColor whiteColor];
        cityCollect_view.delegate = self;
        cityCollect_view.dataSource = self;
        self.clipsToBounds = YES;
        [self addSubview:cityCollect_view];
        _cityCollect_view = cityCollect_view;
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.013, screenWide, screenHeight * 0.06)];
        [view addSubview:self.title_label];
        [view addSubview:self.title_icon];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];

        
        [_cityCollect_view registerClass:[CityCollectionViewCell class] forCellWithReuseIdentifier:@"cellC"];
        data_array = @[@"city_01",@"city_02",@"city_03",@"city_04"];

    }
    return self;
}
-(void)configWithicon:(UIImage *)icon title:(NSString *)title data:(NSArray *)data_array {
    if (icon) {
        self.title_icon.image = icon;
    }
    if (title) {
        self.title_label.text = title;
    }
    if (data_array) {
        
    }
}
#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CityCollectionViewCell * cell = [_cityCollect_view dequeueReusableCellWithReuseIdentifier:@"cellC" forIndexPath:indexPath];
    [cell configWithImage:[UIImage imageNamed:data_array[indexPath.row]] name:nil];
    return cell;
}
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%d",(int)self.type);
    NSLog(@"++++%d",(int)indexPath.row);
}

-(void)dealloc {
    _cityCollect_view = nil;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
