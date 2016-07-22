//
//  YYLGroup.h
//  HealthySettle
//
//  Created by yrc on 16/7/14.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYLGroup : NSObject
@property (nonatomic,strong)NSString * group_id;  //机构id
@property (nonatomic,strong)NSString *  mer_id;    // 商户id
@property (nonatomic,strong)NSString * cat_id;     //类别id
@property (nonatomic,strong)NSString * area_id;   //城市id
@property (nonatomic,strong)NSString * name;        //机构名称
@property (nonatomic,strong)NSString * s_name;      //短标题
@property (nonatomic,strong)NSString * intro;       //机构简介
@property (nonatomic,strong)NSString * cue;         //预定需知
@property (nonatomic,strong)NSString * content;     //详情介绍
@property (nonatomic,strong)NSString * content_file;  //设施图片
@property (nonatomic,strong)NSString * pic;         // 图片
@property (nonatomic,strong)NSString * address;    // 机构地址
@property (nonatomic,strong)NSString * telephone;  //  机构电话
@property (nonatomic,strong)NSString * spec;      //   机构属性
@property (nonatomic,strong)NSString * price;      //  单价
@property (nonatomic,strong)NSString * level;     // 机构等级
@property (nonatomic,strong)NSString * bed_nums;   //床位总数
@property (nonatomic,strong)NSString * fun_file;   //康娱设施图片
@property (nonatomic,strong)NSString * style_file; //文体图片


@end
