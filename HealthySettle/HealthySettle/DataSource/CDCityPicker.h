//
//  CDCityPicker.h
//  HealthySettle
//
//  Created by yrc on 16/3/24.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CDCityPickerDelegate <NSObject>
//-(void)cityPickerBtnDownCancel;
-(void)cityPickerbtnDown;
- (void)currentSelectedName:(NSString *)name Array:(NSArray *)array;
@end
@interface CDCityPicker : UIView
@property (strong ,nonatomic)NSString * type;
@property (nonatomic, strong)UIView * titleView;
@property (strong,nonatomic)UIPickerView * pick_view;
@property (nonatomic, strong) NSArray *CityArray;   //市的数组
@property (nonatomic, strong) NSArray *districtArray;  //县区数组
@property (weak, nonatomic)id<CDCityPickerDelegate>delegate;
-(void)showPickerView;
@end
