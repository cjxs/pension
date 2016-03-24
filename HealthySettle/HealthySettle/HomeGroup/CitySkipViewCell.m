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
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(kMargin * 4, 0, screenWide - kMargin * 5 , kMargin * 3)];
        _title_label.textColor = [UIColor blackColor];
        _title_label.textAlignment = NSTextAlignmentLeft;
        _title_label.text = @"缤纷花海";
       
    }
    return _title_label;
}
- (UIImageView *)title_icon {
    if (_title_icon == nil) {
        _title_icon = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin, kMargin/2, kMargin *2, kMargin*2)];
        _title_icon.image = [UIImage imageNamed:@"z_02"];
    }
    return _title_icon;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake( screenWide/4.1 , screenWide / 4);
         UICollectionView * cityCollect_view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kMargin*3, screenWide, screenHeight/4.4) collectionViewLayout:layout];
        cityCollect_view.backgroundColor = [UIColor whiteColor];
        cityCollect_view.delegate = self;
        cityCollect_view.dataSource = self;
        self.clipsToBounds = YES;
        [self addSubview:cityCollect_view];
        _cityCollect_view = cityCollect_view;
        [self addSubview:self.title_label];
        [self addSubview:self.title_icon];

        
        [_cityCollect_view registerClass:[CityCollectionViewCell class] forCellWithReuseIdentifier:@"cellC"];
        
        


        
        
    }
    return self;
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
    [cell configWithImage:[UIImage imageNamed:@"z_02"] name:@" 三亚"];
    return cell;
}
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",self.type);
    NSLog(@"++++%ld",indexPath.row);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
