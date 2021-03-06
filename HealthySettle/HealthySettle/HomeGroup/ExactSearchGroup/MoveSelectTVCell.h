//
//  MoveSelectTVCell.h
//  HealthySettle
//
//  Created by yrc on 17/1/6.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MoveSelDelegate <NSObject>

-(void)updateDataWithWave:(int)wave;

@end
@interface MoveSelectTVCell : UITableViewCell<UIWebViewDelegate>{
    int number_btn;

}
@property (nonatomic,weak)id<MoveSelDelegate>delegate;
@property (nonatomic,strong)UIWebView * webView;
-(void)configWithStr:(NSString *)str;
@end
