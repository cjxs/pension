//
//  GroupRoom.h
//  HealthySettle
//
//  Created by yrc on 16/7/14.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupRoom : NSObject
@property (nonatomic,strong)NSString * room_id;   //房型ID
@property (nonatomic,strong)NSString * gid;  //机构id
@property (nonatomic,strong)NSString * room_type;   //房型名称
@property (nonatomic,strong)NSString * bed_type;     // 床型名称
@property (nonatomic,strong)NSString * pic_list;     //房间简图
@property (nonatomic,strong)NSString * size;        //房间面积
@property (nonatomic,strong)NSString * lived_num;  //可住人数
@property (nonatomic,strong)NSString * room_price;  //房间价格
@property (nonatomic,strong)NSString * is_catered;  //是否包餐
@property (nonatomic,strong)NSString * is_wifi;      //是否有wifi
@property (nonatomic,strong)NSString * price_spec;    //价格属性

@end
