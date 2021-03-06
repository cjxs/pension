//
//  CDCityPicker.m
//  HealthySettle
//
//  Created by yrc on 16/3/24.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "CDCityPicker.h"

#define Key_DivisionCode    @"area_id"
#define Key_DivisionName    @"area_name"
#define Key_DivisionSub     @"city"


@interface CDCityPicker()

@property (nonatomic, strong) NSDictionary *districtDict;

@property (nonatomic, strong) NSArray *ProvinceArray; //省的数组
@property (nonatomic, strong) NSString *cityStr;      // 市名
@property (nonatomic,strong) NSString * city_code;    //市编码

@property (nonatomic, strong) NSString *districtStr;//  县区名
@property (nonatomic,strong)NSString * district_code;  //县区编码

@end
@implementation CDCityPicker
+(CDCityPicker *)currentCity{
    static CDCityPicker * default_city= nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        default_city = [[self alloc] init];
    });
    return default_city;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.alpha = 0.3;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cityPickerbtnDown)];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
        
    }
    return self;
}
- (UIPickerView *)pick_view {
    if (!_pick_view) {
        UIPickerView * pick_view = [[UIPickerView alloc] initWithFrame:[self getMainViewFrame]];
        pick_view.backgroundColor = RGB(252, 252, 252);
        pick_view.clipsToBounds = YES;
        pick_view.layer.cornerRadius = kMargin;
        pick_view.clipsToBounds = YES;
        pick_view.dataSource = self;
        pick_view.delegate = self;
        _pick_view = pick_view;
    }
    return _pick_view;
}

-(CGRect)getMainViewFrame
{
    CGFloat size_h;
    if (IS_IPHONE5) {
        size_h = 2.8;
    }else{
        size_h = 3;
    }

    CGRect rect = self.frame;
    rect.origin.x = kMargin;
    rect.origin.y = screenHeight /size_h;
    rect.size.width = screenWide - kMargin *2;
    rect.size.height = screenHeight /size_h;
    return rect;
}
-(UIView *)titleView
{
    if (_titleView!=nil) {
        return _titleView;
    }
    CGFloat size_h;
    if (IS_IPHONE5) {
        size_h = 2.8;
    }else{
        size_h = 3;
    }

    CGRect rect;
    rect.origin.x = kMargin;
    rect.origin.y = screenHeight / size_h;
    rect.size.width = screenWide - kMargin *2 ;
    rect.size.height = kMargin * 4;
    _titleView = [[UIView alloc] initWithFrame:rect];
    _titleView.backgroundColor = RGB(249, 249, 249);
    _titleView.clipsToBounds = YES;
    _titleView.layer.cornerRadius = kMargin;
    UIButton * quxiaobtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quxiaobtn.frame = CGRectMake(5, rect.size.height * 0.2, 55, rect.size.height * 0.6);
    quxiaobtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [quxiaobtn setTitle:@"取消" forState:UIControlStateNormal];
    [quxiaobtn addTarget:self action:@selector(cityPickerBtnDownCancel) forControlEvents:UIControlEventTouchUpInside];
    [quxiaobtn setTitleColor:BROWNCOLOR forState:UIControlStateNormal];
    quxiaobtn.backgroundColor = [UIColor clearColor];
    quxiaobtn.layer.cornerRadius = 5;
    
    [_titleView addSubview:quxiaobtn];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(screenWide - 2 * kMargin-60, rect.size.height * 0.2, 55, rect.size.height * 0.6);
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cityPickerbtnDown) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:BROWNCOLOR forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    btn.layer.cornerRadius = 5;
    [_titleView addSubview:btn];

    return _titleView;
}


-(void)showPickerView
{
//    self.districtDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city_" ofType:@"plist"]];
//    self.ProvinceArray = self.districtDict[Key_Division];
   self.ProvinceArray =  [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city_" ofType:@"plist"]];
//    NSMutableArray * m_arr = [NSMutableArray arrayWithCapacity:0];
//    for (NSDictionary * dic in self.ProvinceArray) {
//        for (NSDictionary * city_d in dic[@"city"]) {
//            [m_arr addObject:city_d];
//        }
//    }
//    NSArray * array = [m_arr sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
//        NSComparisonResult result = [obj1[@"aera_name"]compare:obj2[@"area_name"]];
//            return result;
//    }];
//    //1. 创建一个plist文件
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString *path=[paths  objectAtIndex:0];
//    NSLog(@"path = %@",path);
//    NSString *filename=[path stringByAppendingPathComponent:@"city_2.plist"];
//    NSFileManager* fm = [NSFileManager defaultManager];
//    [fm createFileAtPath:filename contents:nil attributes:nil];
//    [array writeToFile:filename atomically:YES];
   
    UIWindow * window = [UIApplication  sharedApplication].keyWindow;
    [window addSubview:self];
    [window addSubview:self.pick_view];
    [window addSubview:self.titleView];
    
}

#pragma mark - UIPickerViewDataSource,UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if ([_type isEqualToString:@"2"]) {
        return 2;
    }else {
        return 1;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ([_type isEqualToString:@"2"]) {
        if (component == 0) {
            return self.ProvinceArray.count; //省的个数
        }else {
            if ([pickerView selectedRowInComponent:0]==-1)
            {
                return 0;
            }
            else
            {
                NSDictionary *ProvinceDict = self.ProvinceArray[[_pick_view selectedRowInComponent:0]];
                self.CityArray = [ProvinceDict objectForKey:Key_DivisionSub];
                
                return [self.CityArray count];
            }

        }
    } else {
                return self.districtArray.count;

    }
    
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = nil;
    if ([_type isEqualToString:@"2"]) {
        if (component==0)
        {
            NSDictionary *ProvinceDict = self.ProvinceArray[row];
            title = [ProvinceDict objectForKey:@"province_name"];
            
        }
        else if(component ==1)
        {
            NSDictionary *CityDict = self.CityArray[row];
            title = [CityDict objectForKey:Key_DivisionName];
        }

    }else {
        NSDictionary *DistrictDict = self.districtArray[row];
        title = [DistrictDict objectForKey:Key_DivisionName];
    }
    return title ?title : @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if ([_type isEqualToString:@"2"]) {
        if (component==0)
        {
            [pickerView reloadComponent:1];
            [self getSelectDistrictName];
        }
        else if(component==1)
        {
            [self getSelectDistrictName];
        }

    }else {
         [self getSelectDistrictName];
    }
   
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return [UIScreen mainScreen].bounds.size.width*0.5;
    
}
- (void)getSelectDistrictName
{
    if ([_type isEqualToString:@"2"]) {
        NSDictionary *ProvinceDict = self.ProvinceArray[[_pick_view selectedRowInComponent:0]];
        
            //*****
        
            NSArray *array = [ProvinceDict objectForKey:Key_DivisionSub];        
            if ([_pick_view selectedRowInComponent:1] > array.count - 1) {
                return;
            }
    NSDictionary *CityDict = [[ProvinceDict objectForKey:Key_DivisionSub] objectAtIndex:[_pick_view selectedRowInComponent:1]];
        self.cityStr = [CityDict objectForKey:Key_DivisionName];
        self.city_code = [CityDict objectForKey:Key_DivisionCode];
        
        self.districtArray = [CityDict objectForKey:Key_DivisionSub];

        if (self.delegate && [self.delegate respondsToSelector:@selector(currentSelectedName:code:Array:)]) {
            
            [self.delegate currentSelectedName:self.cityStr code:self.city_code Array:self.districtArray];
        }
       
    }else {

    self.districtStr = [self.districtArray[[_pick_view selectedRowInComponent:0]] objectForKey:Key_DivisionName];//****
        self.district_code = [self.districtArray[[_pick_view selectedRowInComponent:0]] objectForKey:Key_DivisionCode];//****
        

        if (self.delegate && [self.delegate respondsToSelector:@selector(currentSelectedName:code: Array:)]) {
            [self.delegate currentSelectedName:self.cityStr code:self.city_code Array:nil];
        }
    }
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return screenHeight * 0.08;
}




-(void)cityPickerBtnDownCancel {
    [self dismiss];
    if(self.delegate && [self.delegate respondsToSelector:@selector(cityPickerBtnDownCancel)]){
        [self.delegate cityPickerBtnDownCancel];
    }
    
}
-(void)cityPickerbtnDown {
    [self dismiss];
    if(self.delegate && [self.delegate respondsToSelector:@selector(cityPickerbtnDown)]){
        [self.delegate cityPickerbtnDown];
    }
}
- (void)dismiss {
    [self removeFromSuperview];
    [_titleView removeFromSuperview];
    _titleView = nil;
    [_pick_view removeFromSuperview];
    _pick_view = nil;
    
}



























@end
