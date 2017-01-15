//
//  FiltView.h
//  HealthySettle
//
//  Created by yrc on 17/1/12.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, SelectType) {
    DDSelectTYpeSingle = 0,//从上到小
    DDSelectTYpeMulti = 1//从左到右
};
typedef NS_ENUM(NSUInteger, ListType) {
    DDListTYpeSingle = 0,//一级
    DDListTYpeMulti = 1//二级
};
typedef NS_ENUM(NSUInteger,ViewType){
    DDNormalView = 0,
    DDUnnormalView = 1
};
@interface FiltView : UIView<UITableViewDelegate,UITableViewDataSource>{
    UITableView * left_tab_view;
    UITableView * right_tab_view;
    NSString * result;
    NSMutableArray * result_arr;
    UIView * btns_view;
    NSIndexPath* lastIndex;
}


@property (nonatomic,strong)NSArray * data_arr1;
@property (nonatomic,strong)NSArray * data_arr2;
@property (nonatomic, copy) void(^sureBtn)(id result);
@property (nonatomic,copy) NSArray *(^selectFir)(int num);
@property (nonatomic,assign)SelectType  selectType;
@property (nonatomic,assign)ListType  listType;
@property (nonatomic,assign)ViewType  viewType;

- (void)addFirstView;
@end
