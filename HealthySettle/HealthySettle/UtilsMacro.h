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
#define kMargin [UIScreen mainScreen].bounds.size.width / 50

#define CStringToOcString(cstr) [NSString stringWithCString:cstr encoding:GBK_ENCODE] ? [NSString stringWithCString:cstr encoding:GBK_ENCODE] : @""     //过滤为空的对象


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

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]//快捷
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.f]//快捷

#define UIColorFromHex(s) [UIColor colorWithHexString:s] //16进制

#define TITLEMAINCOLOR [UIColor colorWithHexString:@"#212121"] // 主标题
#define TITLECOMMONCOLOR [UIColor colorWithHexString:@"#616161"]// 次要标题
#define TEXTMAINCOLOR [UIColor colorWithHexString:@"#919191"]// 正文
#define TEXTCOMMONCOLOR [UIColor colorWithHexString:@"#c1c1c1"]//辅助文字
#define TEXTICONCOLOR [UIColor colorWithHexString:@"#e1e1e1"]//辅助文字
#define BACKGROUNDCOLOR [UIColor colorWithHexString:@"#f5f5f5"]//辅助文字


#define REDCOLOR [UIColor colorWithHexString:@"#cf0000"]//红色
#define PINKCOLOR [UIColor colorWithHexString:@"#f84545"]//粉色

#define BROWNCOLOR [UIColor colorWithHexString:@"#f3bc65"]//棕色
#define DARKBROWNCOLOR [UIColor colorWithHexString:@"#cf0000"]//浅棕色

#define BLUECOLOR [UIColor colorWithHexString:@"#009dcd"]//蓝色
#define DARKBLUECOLOR [UIColor colorWithHexString:@"#02baf2"]//浅蓝

#define WHITECOLOR [UIColor colorWithHexString:@"#ffffff"]//白色
#define GRAYCOLOR [UIColor colorWithHexString:@"#f6f6f6"]//灰色











#endif /* UtilsMacro_h */
