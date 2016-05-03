//
//  ResultDetailTVController.m
//  HealthySettle
//
//  Created by yrc on 16/4/1.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "ResultDetailTVController.h"
#import "LivingTimeTVCell.h"
#import "ManageTimeTVCell.h"
#import "HomeTVCell.h"
#import "TestModel.h"
#import "CommentTVCell.h"
#import "SelectTVCell.h"
#import "OrgIntroTVCell.h"
#import "ServeTVCell.h"
#import "ChargeTVCell.h"
#import "ShowTVCell.h"
#import "ShouldKnowTVCell.h"
#import "OrderTVController.h"
#import "CommentViewController.h"
#import "ShareView.h"
#import "UMSocial.h"


@interface ResultDetailTVController () <UMSocialUIDelegate>
{
    UIImageView * organization_imageView;
    UILabel *     organization_titleLabel;
    UILabel *     priceNow_label;
    UILabel *     pricePast_label;
    UILabel *     address_label;
    UILabel *     organDetail_label;
    UILabel *     commentNumber_label;
    UILabel *     commentRatio_label;
    NSArray * showArray;
    UIView * backFootView;
}

@end

@implementation ResultDetailTVController
-(UIView *)tableHeadView
{
    if (!_tableHeadView)
    {
        organization_imageView = [[UIImageView alloc]
                                  initWithFrame:CGRectMake(0, -20, screenWide, screenHeight * 0.319)];
        organization_titleLabel = [[UILabel alloc]
                                   initWithFrame:CGRectMake(screenHeight * 0.035, CGRectGetMaxY(organization_imageView.frame) - screenHeight * 0.045,screenWide , screenHeight * 0.045)];
        organization_titleLabel.backgroundColor = [UIColor clearColor];
        organization_titleLabel.textColor = [UIColor whiteColor];
        organization_titleLabel.text = [NSString stringWithFormat:@"   杭州上城区维康老人文化公寓%@",_vc_type];
        organization_titleLabel.font = [UIFont systemFontOfSize:12];
        UIView * view = [[UIView alloc]
                         initWithFrame:CGRectMake(0, CGRectGetMaxY(organization_imageView.frame) - screenHeight * 0.045,screenWide , screenHeight * 0.045)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5;
        UIButton * back_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [back_btn setBackgroundImage:[UIImage imageNamed:@"leftop_w"]
                            forState:UIControlStateNormal];
        back_btn.frame = CGRectMake(screenWide * 0.04, screenHeight * 0.02 , screenWide * 0.035, screenWide * 0.035/10 *18 );
        [back_btn addTarget:self
                     action:@selector(cancleToRootView)
           forControlEvents:UIControlEventTouchUpInside];
        if ([_vc_type isEqualToString:@"S"])
        {
            _tableHeadView = [[UIView alloc]
                              initWithFrame:CGRectMake(0,0 , screenWide, screenHeight * 0.469)];
            organization_imageView.image = [UIImage imageNamed:@"regimen_organ"];
            _tableHeadView.backgroundColor = RGB(249, 249, 249);
            [_tableHeadView addSubview:organization_imageView];
            [_tableHeadView addSubview:view];
            
         
            
            [_tableHeadView addSubview:organization_titleLabel];
            [_tableHeadView addSubview:back_btn];
            for (int i = 1; i < 4; i++)
            {
                UIView * lineView = [[UIView alloc]
                                     initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableHeadView.frame)-1- screenHeight * 0.059 * i, screenWide, 1)];
                lineView.backgroundColor = RGB(241, 241, 241);
                [_tableHeadView addSubview:lineView];
            }
            NSArray * icon_array = @[@"list1_show_1_",@"list1_show_2_",@"list1_show_3_"];
            for (int i = 0; i < 3; i++)
            {
                UIImageView * imageView = [[UIImageView alloc]
                                           initWithFrame:CGRectMake(screenWide * 0.03,CGRectGetMaxY(organization_imageView.frame)+screenHeight * 0.023 + screenHeight * 0.059 * i, screenHeight * 0.02, screenHeight * 0.02)];
                imageView.image = [UIImage imageNamed:icon_array[i]];
                [_tableHeadView addSubview:imageView];
                UIImageView * imageView2 = [[UIImageView alloc]
                                            initWithFrame:CGRectMake(screenWide * 0.965,CGRectGetMaxY(organization_imageView.frame)+screenHeight * 0.027 + screenHeight * 0.059 * i, screenWide * 0.022, screenHeight * 0.017)];
                imageView2.image = [UIImage imageNamed:@"right_"];
                [_tableHeadView addSubview:imageView2];
            }
            
            address_label = [[UILabel alloc]
                             initWithFrame:CGRectMake(screenWide * 0.08, CGRectGetMaxY(organization_imageView.frame)+screenHeight * 0.018 , screenWide * 0.72, screenHeight * 0.035)];
            address_label.text = @"浙江省杭州市上城区近江南路20号（富春江路近江小区）";
            address_label.adjustsFontSizeToFitWidth = YES;
            
            organDetail_label = [[UILabel alloc]
                                 initWithFrame:CGRectMake(screenWide * 0.08, CGRectGetMaxY(organization_imageView.frame)+screenHeight * 0.077 , screenWide * 0.72, screenHeight * 0.035)];
            organDetail_label.text = @"祥阳老年公寓是无锡市南长区民政局下属的福利企业受到环境";
           
            NSArray * label_array = @[address_label,organDetail_label];
            for (UILabel * label in label_array)
            {
                label.font = [UIFont systemFontOfSize:10];
                label.textColor = RGB(152, 152, 152);
                [_tableHeadView addSubview:label];
            }
            UILabel * label1 = [[UILabel alloc]
                                initWithFrame:CGRectMake(screenWide * 0.8, CGRectGetMaxY(organization_imageView.frame)+screenHeight * 0.018  , screenWide * 0.15, screenHeight * 0.035)];
            label1.text = @"查看地图";
            label1.font = [UIFont systemFontOfSize:10];
            label1.textAlignment = NSTextAlignmentRight;
            label1.textColor = [UIColor redColor];
            [_tableHeadView addSubview:label1];
            UILabel * label2 = [[UILabel alloc]
                                initWithFrame:CGRectMake(screenWide * 0.8, CGRectGetMaxY(organization_imageView.frame)+screenHeight * 0.077  , screenWide * 0.15, screenHeight * 0.035)];
            label2.text = @"机构详情";
            label2.font = [UIFont systemFontOfSize:10];
            label2.textColor = [UIColor redColor];
            label2.textAlignment = NSTextAlignmentRight;
            [_tableHeadView addSubview:label2];
            UIView * lineView = [[UIView alloc]
                                 initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableHeadView.frame)-1, screenWide, 1)];
            lineView.backgroundColor = RGB(241, 241, 241);
            [_tableHeadView addSubview:lineView];
        }else if ([_vc_type isEqualToString:@"L"] )
        {
            _tableHeadView = [[UIView alloc]
                              initWithFrame:CGRectMake(0,0 , screenWide, screenHeight * 0.496)];
            organization_imageView.image = [UIImage imageNamed:@"pension_organ"];
            _tableHeadView.backgroundColor = RGB(254, 255, 255);
            [_tableHeadView addSubview:organization_imageView];
            [_tableHeadView addSubview:view];
            [_tableHeadView addSubview:organization_titleLabel];
            [_tableHeadView addSubview:back_btn];
            for (int i = 0; i < 3; i ++)
            {
                UIView * lineView = [[UIView alloc]
                                     initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableHeadView.frame)-1- screenHeight * 0.059 * i, screenWide, 1)];
                lineView.backgroundColor = RGB(241, 241, 241);
                [_tableHeadView addSubview:lineView];
            }
                            UILabel * label_y = [[UILabel alloc]
                                                 initWithFrame:CGRectMake(screenWide * 0.03, CGRectGetMaxY(organization_imageView.frame) + screenHeight * 0.019, screenWide * 0.03, screenHeight *0.0285 )];
                            label_y.text = @"¥";
                            label_y.font = [UIFont systemFontOfSize:12];
                            label_y.textColor = RGB(230, 11, 24);
                            [_tableHeadView addSubview:label_y];

            priceNow_label = [[UILabel alloc]
                              initWithFrame:CGRectMake(screenWide * 0.06, CGRectGetMaxY(organization_imageView.frame) + screenHeight * 0.015, screenWide * 0.12, screenHeight *0.0285 )];
            priceNow_label.font = [UIFont systemFontOfSize:20];
            priceNow_label.textColor = [UIColor redColor];
            [_tableHeadView addSubview:priceNow_label];
            priceNow_label.text = @"999";
            UILabel * label_q = [[UILabel alloc]
                                 initWithFrame:CGRectMake(CGRectGetMaxX(priceNow_label.frame),CGRectGetMaxY(organization_imageView.frame) + screenHeight * 0.017, screenWide * 0.05, screenHeight *0.0285 )];
            label_q.text = @"起";
            label_q.font = [UIFont systemFontOfSize:12];
            label_q.textColor = RGB(196, 196, 196);
            [_tableHeadView addSubview:label_q];
            UILabel * label_gg = [[UILabel alloc]
                                  initWithFrame:CGRectMake(CGRectGetMaxX(label_q.frame),CGRectGetMaxY(organization_imageView.frame) + screenHeight * 0.0175, screenWide * 0.3, screenHeight *0.022 )];
            label_gg.textColor = [UIColor whiteColor];
            label_gg.backgroundColor = RGB(230, 11, 24);
            label_gg.adjustsFontSizeToFitWidth = YES;
            label_gg.text = @"去哪养老网 保证全网最低价";
            label_gg.font = [UIFont systemFontOfSize:9];
            [_tableHeadView addSubview:label_gg];
            [self dealLinesWithString:@"门市价 ¥10888"];
            NSArray * icon_array = @[@"list1_show_1_",@"list1_show_3_"];
                for (int i = 0; i < 2; i++)
                {
                    UIImageView * imageView = [[UIImageView alloc]
                                               initWithFrame:CGRectMake(screenWide * 0.03,CGRectGetMaxY(organization_imageView.frame)+screenHeight * 0.108 + screenHeight * 0.059 * i, screenHeight * 0.02, screenHeight * 0.02)];
                        imageView.image = [UIImage imageNamed:icon_array[i]];
                    [_tableHeadView addSubview:imageView];
                    UIImageView * imageView2 = [[UIImageView alloc]
                                                initWithFrame:CGRectMake(screenWide * 0.965,CGRectGetMaxY(organization_imageView.frame)+screenHeight * 0.11 + screenHeight * 0.059 * i, screenWide * 0.022, screenHeight * 0.017)];
                    imageView2.image = [UIImage imageNamed:@"right_"];
                    [_tableHeadView addSubview:imageView2];
                }
                            
            address_label = [[UILabel alloc]
                             initWithFrame:CGRectMake(screenWide * 0.08, CGRectGetMaxY(organization_imageView.frame)+screenHeight * 0.102, screenWide * 0.72, screenHeight * 0.03)];
            address_label.text = @"浙江省杭州市上城区近江南路2号（富春江路近江小区）";
            address_label.font = [UIFont systemFontOfSize:12];
            address_label.adjustsFontSizeToFitWidth = YES;
            address_label.textColor = RGB(152, 152, 152);
            [_tableHeadView addSubview:address_label];
            UILabel * map_label = [[UILabel alloc]
                                   initWithFrame:CGRectMake(screenWide * 0.8, CGRectGetMaxY(_tableHeadView.frame)- screenHeight * 0.104  , screenWide * 0.15, screenHeight * 0.03)];
            map_label.textColor = [UIColor redColor];
            map_label.text = @"查看地图";
            map_label.textAlignment = NSTextAlignmentRight;
            map_label.font = [UIFont systemFontOfSize:10];
            [_tableHeadView addSubview:map_label];
        }
        commentNumber_label = [[UILabel alloc]
                                initWithFrame:CGRectMake(screenWide * 0.08, CGRectGetMaxY(_tableHeadView.frame)-screenHeight * 0.045 , screenWide * 0.72, screenHeight * 0.03)];
        commentNumber_label.text = @"点评：2458条";
        commentNumber_label.font = [UIFont systemFontOfSize:10];
        commentNumber_label.textColor = RGB(152, 152, 152);
        [_tableHeadView addSubview:commentNumber_label];
        commentRatio_label = [[UILabel alloc]
                              initWithFrame:CGRectMake(screenWide * 0.8, CGRectGetMaxY(_tableHeadView.frame)- screenHeight * 0.045  , screenWide * 0.15, screenHeight * 0.03)];
        commentRatio_label.textColor = [UIColor redColor];
        commentRatio_label.text = @"200%好评";
        commentRatio_label.textAlignment = NSTextAlignmentRight;
        commentRatio_label.font = [UIFont systemFontOfSize:10];
        [_tableHeadView addSubview:commentRatio_label];
        UIImageView * honourView = [[UIImageView alloc]
                                    initWithFrame:CGRectMake(screenHeight * 0.025, CGRectGetMaxY(organization_imageView.frame) - screenHeight * 0.033,screenHeight * 0.02/32*21 , screenHeight * 0.02)];
        honourView.image = [UIImage imageNamed:@"list1_show_0_"];
        [_tableHeadView addSubview:honourView];
    }
    return _tableHeadView;
    
}
-(void)shareToEveryone
{
    [ShareView showShareViewInViewController:self];
}
//计算划掉的数字长度
- (void)dealLinesWithString:(NSString *)string
{
    pricePast_label = [[UILabel alloc] init];
    pricePast_label.text = string;
    UIFont * fnt = [UIFont fontWithName:string size:10];
    pricePast_label.font = fnt;
    CGSize size =[pricePast_label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]];
     CGFloat nameW = size.width;
    CGFloat nameH = size.height;
    pricePast_label.frame = CGRectMake(screenWide * 0.03, CGRectGetMaxY(organization_imageView.frame) + screenHeight * 0.0485, nameW, nameH);
    UIView * view = [[UIView alloc]
                     initWithFrame:CGRectMake(0, screenHeight * 0.012, nameW,1 )];
    view.backgroundColor = RGB(199, 200, 201);
    [pricePast_label addSubview:view];
    pricePast_label.textColor = RGB(199, 200, 201);
    pricePast_label.font = [UIFont systemFontOfSize:11];
    [_tableHeadView addSubview:pricePast_label];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.bounces = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    UIBarButtonItem * returnBarButtonItem = [[UIBarButtonItem alloc] init];
    returnBarButtonItem.title = @"";
    [returnBarButtonItem setBackgroundImage:[UIImage imageNamed:@"leftop_r"]
                                   forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = returnBarButtonItem;
    self.tableView.tableHeaderView = self.tableHeadView;
    if ([self.vc_type isEqualToString:@"S"])
    {
        self.tableView.backgroundColor = RGB(250, 250, 250);
        [self.tableView registerNib:[UINib nibWithNibName:@"LivingTimeTVCell" bundle:nil]
             forCellReuseIdentifier:@"cellLiving"];
        [self.tableView registerNib:[UINib nibWithNibName:@"ManageTimeTVCell" bundle:nil]
             forCellReuseIdentifier:@"cellManager"];
        [self.tableView registerNib:[UINib nibWithNibName:@"HomeTVCell" bundle:nil]
             forCellReuseIdentifier:@"cellHome"];
        [self.tableView registerNib:[UINib nibWithNibName:@"CommentTVCell" bundle:nil]
             forCellReuseIdentifier:@"cellComment"];
        TestModel * model1 = [[TestModel alloc] init];
        TestModel * model2 = [[TestModel alloc] init];
        TestModel * model3 = [[TestModel alloc] init];
        showArray = @[model1,model2,model3,model1];
    }else {
        [self.tableView registerClass:[SelectTVCell class]
               forCellReuseIdentifier:@"cellSelect"];
        [self.tableView registerNib:[UINib nibWithNibName:@"OrgIntroTVCell" bundle:nil]
             forCellReuseIdentifier:@"cellIntro"];
        [self.tableView registerClass:[ServeTVCell class]
               forCellReuseIdentifier:@"cellServe"];
        [self.tableView registerClass:[ChargeTVCell class]
               forCellReuseIdentifier:@"cellCharge"];
        [self.tableView registerNib:[UINib nibWithNibName:@"ShowTVCell" bundle:nil]
             forCellReuseIdentifier:@"cellShow"];
        [self.tableView registerClass:[ShouldKnowTVCell class]
               forCellReuseIdentifier:@"cellKnow"];
        [self.tableView registerNib:[UINib nibWithNibName:@"CommentTVCell" bundle:nil]
             forCellReuseIdentifier:@"cellComment"];
        
        backFootView = [[UIView alloc]
                         initWithFrame:CGRectMake(0, 0, screenWide, 44 + 60)];
        UIButton * predeter_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        predeter_btn.frame = CGRectMake(0, 0, screenWide/2, 44);
        [predeter_btn setTitle:@"立即预定"
                      forState:UIControlStateNormal];
        [predeter_btn addTarget:self
                         action:@selector(fillInOrderController)
               forControlEvents:UIControlEventTouchUpInside];
        predeter_btn.backgroundColor = RGB(229, 12, 24);
        [backFootView addSubview:predeter_btn];
        UIButton * try_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        try_btn.frame = CGRectMake(screenWide /2, 0, screenWide/2, 44);
        [try_btn setTitle:@"一元试住" forState:UIControlStateNormal];
        try_btn.backgroundColor = [UIColor whiteColor];
        [try_btn setTitleColor:RGB(60, 61, 63)
                      forState:UIControlStateNormal];
        [backFootView addSubview:try_btn];
        self.tableView.tableFooterView = backFootView;
    }
    
}
- (void)fillInOrderController
{
    OrderTVController * orderVC = [[OrderTVController alloc]
                                   initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:orderVC animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES
                                             animated: YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO
                                             animated:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)cancleToRootView
{
    [self.navigationController popViewControllerAnimated:YES];
    for (UIView * view in self.view.subviews)
    {
        [view removeFromSuperview];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.vc_type isEqualToString:@"S"])
    {
        return 5;
    }else if ([self.vc_type isEqualToString:@"L"])
    {
        return 8;
    }else
    {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
      return 1;
}

- (void)cellShowPriceDetail:(UIButton *)btn
{
    NSInteger number = btn.tag - 500;
    TestModel * model = showArray[number];
    NSIndexSet *indexSet=[[NSIndexSet alloc]
                          initWithIndex:number];
    if ([model.show isEqualToString:@"y"])
    {
        model.show = @"n";
        [self.tableView reloadSections:indexSet
                      withRowAnimation:UITableViewRowAnimationAutomatic];
    }else
    {
        model.show = @"y";
        [self.tableView reloadSections:indexSet
                      withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.vc_type isEqualToString:@"S"])
    {
        if (indexPath.section == 0) {
          LivingTimeTVCell *  cell  =  [tableView dequeueReusableCellWithIdentifier:@"cellLiving"
                                                                       forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

        }else if (indexPath.section == 1)
        {
           ManageTimeTVCell * cell =  [tableView dequeueReusableCellWithIdentifier:@"cellManager"
                                                                      forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

        }else if (indexPath.section == 2 || indexPath.section == 3)
        {
         HomeTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellHome"
                                                             forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.priceDetail_btn.tag = 500 + indexPath.section;
            [cell.priceDetail_btn addTarget:self
                                     action:@selector(cellShowPriceDetail:)
                           forControlEvents:UIControlEventTouchUpInside];
            [cell.reserve_btn addTarget:self
                                 action:@selector(fillInOrderController)
                       forControlEvents:UIControlEventTouchUpInside];
            TestModel * model = showArray[indexPath.section];
            [cell configWithImage:nil
                            price:nil
                             show:model.show];
            return cell;
        }else
        {
           CommentTVCell *  cell  = [tableView dequeueReusableCellWithIdentifier:@"cellComment"
                                                                    forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.commentNow_btn addTarget:self
                                    action:@selector(submitCommentNow)
                          forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        
    }else
    {
        if (indexPath.section == 0)
        {
            SelectTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellSelect"
                                                                  forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else  if (indexPath.section == 1)
        {
            OrgIntroTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellIntro"
                                                                    forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.section == 2)
        {
            ServeTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellServe"
                                                                 forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
 
        }else if (indexPath.section == 3)
        {
            ChargeTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellCharge"
                                                                  forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else  if (indexPath.section == 4 || indexPath.section == 5)
        {
            ShowTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellShow"
                                                                forIndexPath:indexPath];
            NSString * string;
            if (indexPath.section == 4)
            {
                string = @"    黄精声讨时代感和解放军三大发感慨合适的高富帅对方感受到结婚高峰   电视剧发噶时间会发生的阿萨德和规范哈健身房大世界一个五言绝句 ";
            }else
            {
                string = @"    阿萨德和规范哈公司的发送到官方的那首风格哈枫叶如图俄企业听日 u 全额退；也咖啡公司的人哈 u 俄国也让其他育儿课堂人跟同事打好几个发生开发高的水果变成美女不为所动简单啊  啊社区家风格的活动放大个人过五个人啊 test发的话题任何事 ";
            }
            NSArray * image_array = @[[UIImage imageNamed:@"p_01"],[UIImage imageNamed:@"p_02"],[UIImage imageNamed:@"p_03"]];
            [cell configWithTitle:@"文化活动"
                       imageArray:image_array text:string];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.section == 6)
        {
            ShouldKnowTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellKnow"
                                                                      forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell configWithStr:@"吧啦吧啦吧啦吧啦吧啦吧啦吧啦吧啦吧啦吧吧啦吧啦吧吧啦吧啦吧啦吧啦吧吧啦吧啦吧啦吧啦吧吧啦吧啦吧啦吧啊啦吧啦"];
            return cell;
        }else
        {
            CommentTVCell *  cell  = [tableView dequeueReusableCellWithIdentifier:@"cellComment"
                                                                     forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.commentNow_btn addTarget:self
                                    action:@selector(submitCommentNow)
                          forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
    }
}
- (void)submitCommentNow
{
    CommentViewController * commentVC = [[CommentViewController alloc] init];
    [self.navigationController pushViewController:commentVC
                                         animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.vc_type isEqualToString:@"S"])
    {
        if (indexPath.section < 2)
        {
            return 0.0449 * screenHeight;
        }else if (indexPath.section == 2 || indexPath.section == 3)
        {
            TestModel * model = showArray[indexPath.section];
            if ([model.show isEqualToString:@"y"])
            {
                return 215;
            }else
            {
            return 143;
            }
        }else
        {
            return 288;
        }

    }else if ([self.vc_type isEqualToString:@"L"])
    {
        if (indexPath.section == 0)
        {
            return screenHeight * 0.3688;
        }else if (indexPath.section == 1)
        {
            return 173;
        }else if (indexPath.section == 2)
        {
            return 110;
        }else if (indexPath.section == 3)
        {
            return 176;
        }else if (indexPath.section == 4 || indexPath.section ==5)
        {
            NSString * string;
            if (indexPath.section == 4)
            {
                string = @"    黄精声讨时代感和解放军三合适的高富帅对方感受到结婚高峰   电视剧发噶时间会发生的阿萨德和规范哈健身房大世界一个五言绝句 ";
            }else
            {
               string = @"    阿萨德和规范哈公司的发送到官方的那首风格哈枫叶如图俄企业听日 u 全额退；也咖啡公司的人哈 u 俄国也让其他育儿课堂人跟同事打好几个发生开发高的水果变成美女不为所动简单啊  啊社区家风格的活动放大个人过五个人啊 test发的话题任何事 ";
            }
            return  [self backheightWith:string];
        }else if (indexPath.section == 6)
        {
            return [self backheightWith:@"吧啦吧啦吧啦吧啦吧啦吧啦吧啦吧啦吧啦吧吧啦吧啦吧啦吧吧啦吧啦吧啦吧啦吧啦吧吧啦吧啦吧啦吧啦吧吧啦吧啦吧啦吧啊啦吧啦"] - 80;
        }else
        {
            return 288;
        }

    }else
    {
        return 0;
    }

}
- (CGFloat)backheightWith:(NSString *)str
{
    if (str)
    {
        UILabel * label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:10];
        label.text = str;
        CGFloat  height =[str boundingRectWithSize:
                          CGSizeMake(screenWide - 20, CGFLOAT_MAX)
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                        attributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName, nil] context:nil].size.height;
        return height + 130;
        
    }else
    {
        return 120;
    }
}

//设置table
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat sectionHeaderHeight = screenHeight * 0.02;
//    if (scrollView.contentOffset.y<=sectionHeaderHeight)
//    {
//        if (scrollView.contentOffset.y > 0)
//        {
//            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        }else if(scrollView.contentOffset.y == 0)
//        {   //下降的位置
//            scrollView.contentInset = UIEdgeInsetsMake(sectionHeaderHeight , 0, 0, 0);
////            if (backFootView.frame.size.height == sectionHeaderHeight + 44) {
////                backFootView.frame = CGRectMake(0, 0, screenWide, 44);
////            }
//        }
//    }
//    else if (scrollView.contentOffset.y>=sectionHeaderHeight)
//    {   //让headSectionView  上移到刚好盖住的位置
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight , 0, 0, 0);
//    }
//}
-(CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    if ([self.vc_type isEqualToString:@"S"])
    {
               return screenHeight * 0.02;
    }else if ([self.vc_type isEqualToString:@"L"])
    {
        return screenHeight * 0.02;
    }else
    {
        return 0;
    }

}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self shareToEveryone];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
