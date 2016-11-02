//
//  DDLogin.m
//  HealthySettle
//
//  Created by yrc on 16/7/11.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "DDLogin.h"
#import "RSAEncryptor.h"




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
+ (NSString * )RSAsignWithdic:(NSDictionary *)dic {
    NSString * json_str = [DDLogin dictionaryToJson:dic];
    //在Document文件夹下创建私钥文件
    NSString* publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@".der"];

 NSString * signedString = nil;
    signedString = [RSAEncryptor encryptString:json_str publicKeyWithContentsOfFile:publicKeyPath];
    /*   NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingPathComponent:@"NET-RSAPrivateKey"];
    
    //
    // 把密钥写入文件
    //
    NSString *formatKey = [DDLogin formatPrivateKey:NETPRIKEY];
    [formatKey writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    const char *message = [@"1" cStringUsingEncoding:NSUTF8StringEncoding];
    int messageLength = (int)strlen(message);
    unsigned char *sig = (unsigned char *)malloc(256);
    unsigned int sig_len;
    int ret = rsa_sign_with_private_key_pem((char *)message, messageLength, sig, &sig_len, (char *)[path UTF8String]);
    //签名成功,需要给签名字符串base64编码和UrlEncode,该两个方法也可以根据情况替换为自己函数
    if (ret == 1) {
        //signedString = [[NSString alloc] initWithData:[NSData dataWithBytes:sig length:sig_len] encoding:NSUTF8StringEncoding];
        NSString * base64String = base64StringFromData([NSData dataWithBytes:sig length:sig_len]);
        //NSData * UTF8Data = [base64String dataUsingEncoding:NSUTF8StringEncoding];
       // signedString = [[NSString alloc] initWithData:UTF8Data encoding:NSUTF8StringEncoding];
        signedString =  base64String;
    }
   free(sig);
*/
    if (!signedString) {
        signedString = json_str;
    }
    
    return signedString;
}
//词典转换为字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
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
        return nil;
    }
    NSMutableArray * _arr = [NSMutableArray arrayWithArray:arr];
    return _arr;
}



@end
