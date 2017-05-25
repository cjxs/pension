//
//  DDLogin.m
//  HealthySettle
//
//  Created by yrc on 16/7/11.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDLogin.h"
#import "RSAEncryptor.h"
#import "YYLUser.h"




@implementation DDLogin
{
    NSString * _username;
    NSString * _password;
}
-(id)initWithUsername:(NSString *)username
             password:(NSString *)password
{
    self = [super init];
    if (self)
    {
        _username = username;
        _password = password;
    }
    return self;
}

/// Http请求的方法
-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}
-(NSString *)requestUrl {
    return @"/Api.html";
}


// 请求的参数列表
-(id)requestArgument
{
    return @{@"rsa":[DDLogin RSAsignWithdic:@{
                                              @"controller":@"login",
                                              @"phone" : _username,
                                              @"pwd" : _password
                                              }]};
}
+ (NSArray * )RSAsignWithdic:(NSDictionary *)dic {

    NSString * json_str = [self dictionaryToJson:dic];
    NSInteger  num = json_str.length/100;
    //在Document文件夹下创建私钥文件
    NSString* publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@".der"];
    
    NSString * signedString = nil;
    NSMutableArray * arr = [NSMutableArray array];
    
    if (num > 0) {
        for (int i = 0; i < num; i++) {
            NSRange  range = NSMakeRange(i*100, 100);
            NSString * no_json_str = [json_str substringWithRange:range];
            signedString = [RSAEncryptor encryptString:no_json_str publicKeyWithContentsOfFile:publicKeyPath];
            [arr addObject:signedString];
        }
        if (json_str.length%100) {
            NSRange range =NSMakeRange(num * 100,json_str.length%100);
            NSString * no_json_str = [json_str substringWithRange:range];
            signedString = [RSAEncryptor encryptString:no_json_str publicKeyWithContentsOfFile:publicKeyPath];
            [arr addObject:signedString];
        }
    }else{
        signedString = [RSAEncryptor encryptString:json_str publicKeyWithContentsOfFile:publicKeyPath];
        [arr addObject:signedString];
    }
    
    
    return [NSArray arrayWithArray:arr];
}
//词典转换为字符串
+ (NSString*)dictionaryToJson:(id)dic
{


    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    //jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        NSLog(@"%@",jsonString);
        return nil;
    }
    return dic;
}
+ (NSMutableArray *)arrayWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return [NSMutableArray array];
    }
    NSMutableArray * _arr = [NSMutableArray arrayWithArray:arr];
    return _arr;
}

+ (NSDictionary *) entityToDictionary:(id)entity
{
    
    Class clazz = [entity class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray* valueArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        objc_property_t prop=properties[i];
        const char* propertyName = property_getName(prop);
        
        [propertyArray addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
        
        //        const char* attributeName = property_getAttributes(prop);
        //        NSLog(@"%@",[NSString stringWithUTF8String:propertyName]);
        //        NSLog(@"%@",[NSString stringWithUTF8String:attributeName]);
        
        id value =  [entity performSelector:NSSelectorFromString([NSString stringWithUTF8String:propertyName])];
        if(value ==nil)
            [valueArray addObject:[NSNull null]];
        else {
            [valueArray addObject:value];
        }
        //        NSLog(@"%@",value);
    }
    
    free(properties);
    
    NSDictionary* returnDic = [NSDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
    NSLog(@"%@", returnDic);
    
    return returnDic;
}
+(NSDate *)dateWithString:(NSString *)str{
    NSTimeInterval time_str = [str integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time_str];
    return date;
    
}
+(NSString *)timeStrWithDate:(NSDate*)date{
    return [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
}
+(NSString *)timeStrWithstr:(NSString *)str{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"]; //
    NSInteger timeIn = [str integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeIn];
    return [formatter stringFromDate:date];
}
+(NSDate * )timeInFromStr:(NSString *)str{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYY-MM-dd"]; //

    NSDate * date = [formatter dateFromString:str];
    return date;
    
}
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}
+ (BOOL)checkUserName : (NSString *) userName
{
    NSString *pattern = @"^[a-zA-Z一-龥]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
}
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}
+ (BOOL)checkUserEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isMatch = [emailTest evaluateWithObject:email];
    return isMatch;
}
@end



