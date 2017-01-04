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
#import "ShareView.h"

@implementation CitySkipViewCell
#pragma mark - LazyLoading
- (UILabel *)title_label {
    if (_title_label== nil) {
        _title_label = [[UILabel alloc]
                        initWithFrame:CGRectMake(screenWide * 0.08, screenHeight * 0.03728, screenWide * 0.25, screenWide * 0.048)];
        _title_label.textColor = RGB(25, 25, 25);
        _title_label.text = @"热门城市";
        _title_label.textAlignment = NSTextAlignmentLeft;
    }
    return _title_label;
}
- (UIImageView *)title_icon {
    if (_title_icon == nil) {
        _title_icon = [[UIImageView alloc]
                       initWithFrame:CGRectMake(screenWide * 0.016, screenHeight * 0.03728, screenWide * 0.048, screenWide * 0.048)];
        _title_icon.image = [UIImage imageNamed:@"热门"];
    }
    return _title_icon;
}
#pragma mark - auto_view
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.title_label];
        [self addSubview:self.title_icon];
        
        self.backgroundColor = WHITECOLOR;
        UIView * line_view = [[UIView alloc]
                              initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.0148)];
        line_view.backgroundColor = GRAYCOLOR;
        
        [self addSubview:line_view];

        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake( screenWide * 0.4667 , screenHeight * 0.1439);
         UICollectionView * cityCollect_view = [[UICollectionView alloc]
                                        initWithFrame:CGRectMake(screenWide * 0.015, screenHeight * 0.073, screenWide * 0.97, screenHeight * 0.3328) collectionViewLayout:layout];
        cityCollect_view.backgroundColor = [UIColor whiteColor];
        cityCollect_view.delegate = self;
        cityCollect_view.dataSource = self;
        self.clipsToBounds = YES;
        [self addSubview:cityCollect_view];
        _cityCollect_view = cityCollect_view;
        
        [_cityCollect_view registerClass:[CityCollectionViewCell class]
                            forCellWithReuseIdentifier:@"cellC"];

    }
    return self;
}
-(void)dealloc {
    _cityCollect_view = nil;
}
-(void)configWithdata:(NSArray *)dataArray {
    if (dataArray) {
        data_array = dataArray;
    }
}
#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (data_array.count > 4) {
        return 4;
    }else {
        return data_array.count;
    }
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CityCollectionViewCell * cell = [_cityCollect_view dequeueReusableCellWithReuseIdentifier:@"cellC"
                                                                                 forIndexPath:indexPath];
    [cell configWithImage:data_array[indexPath.row][@"img"] name:data_array[indexPath.row][@"area_name"]];
    return cell;
}
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
        NSString * area_id = data_array[indexPath.row][@"area_id"];
        NSString * area = data_array[indexPath.row][@"area_name"];
        [self.delegate pushToReginWithArea_id:area_id area:area];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
