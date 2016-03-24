//
//  UtilsMacro.h
//  HealthySettle
//
//  Created by yrc on 16/3/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h

#define screenWide [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define kMargin [UIScreen mainScreen].bounds.size.width / 40

#define IS_Pad ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? !((NSInteger)[[UIScreen mainScreen] currentMode].size.width % 768) || !((NSInteger)[[UIScreen mainScreen] currentMode].size.width % 1024) : NO)

#define IS_IOS8  ([[[UIDevice currentDevice] systemVersion] compare:@"8" options:NSNumericSearch] != NSOrderedAscending)

#define IS_IOS7_1_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.1)
#define IS_IOS7_1_OR_EARLIER ([[[UIDevice currentDevice] systemVersion] floatValue] <= 7.1)

#define IS_IPHONE5EARLY  ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON ) //iPhone 5之前的，不包括iPhone 5

#define IS_IPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE6EARLY ( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568  < DBL_EPSILON ) //iPhone 6之前的，不包括iPhone 6

#define IS_IPHONE6PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


#define REDCOLOR [UIColor colorWithRed:221.0f/255.0f green:34.0f/255.0f blue:56.0f/255.0f alpha:1.0f] // 红色主色
#define PINKCOLOR [UIColor colorWithRed:245.0f/255.0f green:188.0f/255.0f blue:195.0f/255.0f alpha:1.0f]// 粉红色
#define LIGHTREDCOLOR [UIColor colorWithRed:255.0f/255.0f green:229.0f/255.0f blue:232.0f/255.0f alpha:1.0f]// 淡红色

#define REDLINECOLOR [UIColor colorWithRed:245.0f/255.0f green:192.0f/255.0f blue:199.0f/255.0f alpha:1.0f]

#define BLUECOLOR [UIColor colorWithRed:9.0f/255.0f green:118.0f/255.0f blue:170.0f/255.0f alpha:1.0f]// 蓝色
#define LIGHTBLUECOLOR [UIColor colorWithRed:34.0f/255.0f green:167.0f/255.0f blue:240.0f/255.0f alpha:1.0f]// 淡蓝色

#define GREENCOLOR [UIColor colorWithRed:0.0f/255.0f green:144.0f/255.0f blue:31.0f/255.0f alpha:1.0f]// 绿色
#define LIGHTGREENCOLOR [UIColor colorWithRed:34.0f/255.0f green:221.0f/255.0f blue:74.0f/255.0f alpha:1.0f]// 淡绿色

#define LINECOLOR [UIColor colorWithRed:214.0f/255.0f green:214.0f/255.0f blue:214.0f/255.0f alpha:1.0f]
#define GRAYCOLOR [UIColor colorWithRed:176.0f/255.0f green:176.0f/255.0f blue:176.0f/255.0f alpha:1.0f]// 灰色

#define BLACKTEXTCOLOR [UIColor colorWithRed:45.0f/255.0f green:45.0f/255.0f blue:45.0f/255.0f alpha:1.0f]// 黑色文本
#define LIGHTTEXTCOLOR [UIColor colorWithRed:116.0f/255.0f green:116.0f/255.0f blue:116.0f/255.0f alpha:1.0f]// 淡色文本

#define BACKGROUNDCOLOR [UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:231.0f/255.0f alpha:1.0f]// 背景色
#define RGB(r, g, b)    [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define ALLBLUECOLOR    [UIColor colorWithRed:(0)/255.f green:(171)/255.f blue:(235)/255.f alpha:1.f]
#define ALLBLACKCOLOR    [UIColor colorWithRed:(50)/255.f green:(45)/255.f blue:(45)/255.f alpha:1.f]
#define ALLGRAYCOLOR    [UIColor colorWithRed:(165)/255.f green:(164)/255.f blue:(160)/255.f alpha:1.f]
#define ALLBeiJingCOLOR    [UIColor colorWithRed:(244)/255.f green:(243)/255.f blue:(238)/255.f alpha:1.f]
#define ALLGreenCOLOR    [UIColor colorWithRed:(193)/255.f green:(217)/255.f blue:(105)/255.f alpha:1.f]
#define ALLOrangeCOLOR    [UIColor colorWithRed:(240)/255.f green:(131)/255.f blue:(0)/255.f alpha:1.f]
#define ALLFenSeCOLOR    [UIColor colorWithRed:(215)/255.f green:(0)/255.f blue:(52)/255.f alpha:1.f]
#define ALLLittleYellowCOLOR    [UIColor colorWithRed:(254)/255.f green:(242)/255.f blue:(210)/255.f alpha:1.f]
#endif /* UtilsMacro_h */
