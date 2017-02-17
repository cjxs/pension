//
//  WXApiManager.m
//  SDKSample
//
//  Created by Jeason on 15/7/14.
//
//

#import "WXApi.h"
#import "WXApiRequestHandler.h"
#import "AFNetworking.h"
#import "DataMD5.h"
#import <CommonCrypto/CommonDigest.h>
#import "XMLDictionary.h"
#import "AFNetworking.h"
#import "getIPhoneIP.h"
//#import "WXApiManager.h"
//#import "SendMessageToWXReq+requestWithTextOrMediaMessage.h"
//#import "WXMediaMessage+messageConstruct.h"

@implementation WXApiRequestHandler

#pragma mark - Public Methods
//+ (BOOL)sendText:(NSString *)text
//         InScene:(enum WXScene)scene {
//    SendMessageToWXReq *req = [SendMessageToWXReq requestWithText:text
//                                                   OrMediaMessage:nil
//                                                            bText:YES
//                                                          InScene:scene];
//    return [WXApi sendReq:req];
//}

//+ (BOOL)sendImageData:(NSData *)imageData
//              TagName:(NSString *)tagName
//           MessageExt:(NSString *)messageExt
//               Action:(NSString *)action
//           ThumbImage:(UIImage *)thumbImage
//              InScene:(enum WXScene)scene {
//    WXImageObject *ext = [WXImageObject object];
//    ext.imageData = imageData;
//    
//    WXMediaMessage *message = [WXMediaMessage messageWithTitle:nil
//                                                   Description:nil
//                                                        Object:ext
//                                                    MessageExt:messageExt
//                                                 MessageAction:action
//                                                    ThumbImage:thumbImage
//                                                      MediaTag:tagName];
//    
//    SendMessageToWXReq* req = [SendMessageToWXReq requestWithText:nil
//                                                   OrMediaMessage:message
//                                                            bText:NO
//                                                          InScene:scene];
//    
//    return [WXApi sendReq:req];
//}

//+ (BOOL)sendLinkURL:(NSString *)urlString
//            TagName:(NSString *)tagName
//              Title:(NSString *)title
//        Description:(NSString *)description
//         ThumbImage:(UIImage *)thumbImage
//            InScene:(enum WXScene)scene {
//    WXWebpageObject *ext = [WXWebpageObject object];
//    ext.webpageUrl = urlString;
//
//    WXMediaMessage *message = [WXMediaMessage messageWithTitle:title
//                                                   Description:description
//                                                        Object:ext
//                                                    MessageExt:nil
//                                                 MessageAction:nil
//                                                    ThumbImage:thumbImage
//                                                      MediaTag:tagName];
//    
//    SendMessageToWXReq* req = [SendMessageToWXReq requestWithText:nil
//                                                   OrMediaMessage:message
//                                                            bText:NO
//                                                          InScene:scene];
//    return [WXApi sendReq:req];
//}
//
//+ (BOOL)sendMusicURL:(NSString *)musicURL
//             dataURL:(NSString *)dataURL
//               Title:(NSString *)title
//         Description:(NSString *)description
//          ThumbImage:(UIImage *)thumbImage
//             InScene:(enum WXScene)scene {
//    WXMusicObject *ext = [WXMusicObject object];
//    ext.musicUrl = musicURL;
//    ext.musicDataUrl = dataURL;
//
//    WXMediaMessage *message = [WXMediaMessage messageWithTitle:title
//                                                   Description:description
//                                                        Object:ext
//                                                    MessageExt:nil
//                                                 MessageAction:nil
//                                                    ThumbImage:thumbImage
//                                                      MediaTag:nil];
//    
//    SendMessageToWXReq* req = [SendMessageToWXReq requestWithText:nil
//                                                   OrMediaMessage:message
//                                                            bText:NO
//                                                          InScene:scene];
//    
//    return [WXApi sendReq:req];
//}
//
//+ (BOOL)sendVideoURL:(NSString *)videoURL
//               Title:(NSString *)title
//         Description:(NSString *)description
//          ThumbImage:(UIImage *)thumbImage
//             InScene:(enum WXScene)scene {
//    WXMediaMessage *message = [WXMediaMessage message];
//    message.title = title;
//    message.description = description;
//    [message setThumbImage:thumbImage];
//    
//    WXVideoObject *ext = [WXVideoObject object];
//    ext.videoUrl = videoURL;
//    
//    message.mediaObject = ext;
//    
//    SendMessageToWXReq* req = [SendMessageToWXReq requestWithText:nil
//                                                   OrMediaMessage:message
//                                                            bText:NO
//                                                          InScene:scene];
//    return [WXApi sendReq:req];
//}
//
//+ (BOOL)sendEmotionData:(NSData *)emotionData
//             ThumbImage:(UIImage *)thumbImage
//                InScene:(enum WXScene)scene {
//    WXMediaMessage *message = [WXMediaMessage message];
//    [message setThumbImage:thumbImage];
//    
//    WXEmoticonObject *ext = [WXEmoticonObject object];
//    ext.emoticonData = emotionData;
//    
//    message.mediaObject = ext;
//    
//    SendMessageToWXReq* req = [SendMessageToWXReq requestWithText:nil
//                                                   OrMediaMessage:message
//                                                            bText:NO
//                                                          InScene:scene];
//    return [WXApi sendReq:req];
//}
//
//+ (BOOL)sendFileData:(NSData *)fileData
//       fileExtension:(NSString *)extension
//               Title:(NSString *)title
//         Description:(NSString *)description
//          ThumbImage:(UIImage *)thumbImage
//             InScene:(enum WXScene)scene {
//    WXMediaMessage *message = [WXMediaMessage message];
//    message.title = title;
//    message.description = description;
//    [message setThumbImage:thumbImage];
//    
//    WXFileObject *ext = [WXFileObject object];
//    ext.fileExtension = @"pdf";
//    ext.fileData = fileData;
//    
//    message.mediaObject = ext;
//    
//    SendMessageToWXReq* req = [SendMessageToWXReq requestWithText:nil
//                                                   OrMediaMessage:message
//                                                            bText:NO
//                                                          InScene:scene];
//    return [WXApi sendReq:req];
//}
//
//+ (BOOL)sendAppContentData:(NSData *)data
//                   ExtInfo:(NSString *)info
//                    ExtURL:(NSString *)url
//                     Title:(NSString *)title
//               Description:(NSString *)description
//                MessageExt:(NSString *)messageExt
//             MessageAction:(NSString *)action
//                ThumbImage:(UIImage *)thumbImage
//                   InScene:(enum WXScene)scene {
//    WXAppExtendObject *ext = [WXAppExtendObject object];
//    ext.extInfo = info;
//    ext.url = url;
//    ext.fileData = data;
//
//    WXMediaMessage *message = [WXMediaMessage messageWithTitle:title
//                                                   Description:description
//                                                        Object:ext
//                                                    MessageExt:messageExt
//                                                 MessageAction:action
//                                                    ThumbImage:thumbImage
//                                                      MediaTag:nil];
//    
//    SendMessageToWXReq* req = [SendMessageToWXReq requestWithText:nil
//                                                   OrMediaMessage:message
//                                                            bText:NO
//                                                          InScene:scene];
//    return [WXApi sendReq:req];
//
//}
//
//+ (BOOL)addCardsToCardPackage:(NSArray *)cardItems {
//    AddCardToWXCardPackageReq *req = [[[AddCardToWXCardPackageReq alloc] init] autorelease];
//    req.cardAry = cardItems;
//    return [WXApi sendReq:req];
//}
//
//+ (BOOL)sendAuthRequestScope:(NSString *)scope
//                       State:(NSString *)state
//                      OpenID:(NSString *)openID
//            InViewController:(UIViewController *)viewController {
//    SendAuthReq* req = [[[SendAuthReq alloc] init] autorelease];
//    req.scope = scope; // @"post_timeline,sns"
//    req.state = state;
//    req.openID = openID;
//    
//    return [WXApi sendAuthReq:req
//               viewController:viewController
//                     delegate:[WXApiManager sharedManager]];
//}
//
//+ (BOOL)jumpToBizWebviewWithAppID:(NSString *)appID
//                      Description:(NSString *)description
//                        tousrname:(NSString *)tousrname
//                           ExtMsg:(NSString *)extMsg {
//    [WXApi registerApp:appID withDescription:description];
//    JumpToBizWebviewReq *req = [[[JumpToBizWebviewReq alloc]init]autorelease];
//    req.tousrname = tousrname;
//    req.extMsg = extMsg;
//    req.webType = WXMPWebviewType_Ad;
//    return [WXApi sendReq:req];
//}


+ (NSString *)jumpToBizPay:(NSDictionary *)dic{
    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
        //解析服务端返回json数据
        NSError *error;
        //加载一个NSURL对象
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        //将请求的url数据放到NSData对象中
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        if ( response != nil) {
            NSMutableDictionary *dict = NULL;
            //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
            dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
            
            NSLog(@"url:%@",urlString);
            if(dict != nil){
                NSMutableString *retcode = [dict objectForKey:@"retcode"];
                if (retcode.intValue == 0){
                    NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                    
                    //调起微信支付
                    PayReq* req             = [[PayReq alloc] init];
                    req.partnerId = WXMID;
                    req.prepayId            = [dict objectForKey:@"prepayid"];
                    req.nonceStr            = [dict objectForKey:@"noncestr"];
                    req.timeStamp           = stamp.intValue;
                    req.package             = @"Sign=WXPay";
                    req.sign                = [dict objectForKey:@"sign"];
                    DataMD5 *md5 = [[DataMD5 alloc] init];
                    
                    req.sign=[md5 createMD5SingForPay:WXAPPID partnerid:req.partnerId prepayid:req.prepayId package:req.package noncestr:req.nonceStr timestamp:req.timeStamp];
                    [WXApi sendReq:req];
                    //日志输出
                    //NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                    return @"";
                }else{
                    return [dict objectForKey:@"retmsg"];
                }
            }else{
                return @"服务器返回错误，未获取到json对象";
            }
        }else{
            return @"服务器返回错误";
        }
}




- (void)http:(NSString *)xml onoce:(NSString *)str sign:(NSString *)sign xmlString:(NSData *)xmlstring{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //这里传入的xml字符串只是形似xml，但是不是正确是xml格式，需要使用af方法进行转义
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"https://api.mch.weixin.qq.com/pay/unifiedorder" forHTTPHeaderField:@"SOAPAction"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return xml;
    }];
//    发起请求
    [manager POST:@"https://api.mch.weixin.qq.com/pay/unifiedorder" parameters:xml success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        {
            
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] ;
            NSLog(@"responseString is %@－－－",responseString);
            //将返回的xml解析成字典
            NSDictionary *dic = [NSDictionary dictionaryWithXMLString:responseString];
            
            //判断返回的许可
            if ([[dic objectForKey:@"result_code"] isEqualToString:@"SUCCESS"] &&[[dic objectForKey:@"return_code"] isEqualToString:@"SUCCESS"] ) {
                
                
                //发起微信支付，设置参数
                
                PayReq *request = [[PayReq alloc] init];
                request.nonceStr= [dic objectForKey:@"nonce_str"];
                request.partnerId = WXMID;
                request.prepayId= [dic objectForKey:@"prepay_id"];
                request.package = @"Sign=WXPay";
                request.openID = WXAPPID;
                
                //将当前事件转化成时间戳
                NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
                UInt32 timeStamp =[timeSp intValue];
                
                request.timeStamp= timeStamp;
                
                DataMD5 *md5 = [[DataMD5 alloc] init];
                
                request.sign=[md5 createMD5SingForPay:WXAPPID partnerid:request.partnerId prepayid:request.prepayId package:request.package noncestr:request.nonceStr timestamp:request.timeStamp];
                
                // 调用微信
                BOOL flag=  [WXApi sendReq:request];
                NSLog(@"%d",flag);
                
                NSLog(@"\nappid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@\n",request.openID,request.partnerId,request.prepayId,request.nonceStr,(long)request.timeStamp,request.package,request.sign );
               
            }else{
                NSLog(@"参数不正确，请检查参数");
            }
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
          NSLog(@"error is %@",error);
    }];
 }
-(void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        switch(response.errCode){
            caseWXSuccess:{
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");}
                break;
            default:
            printf("支付失败，retcode=%d",resp.errCode);
                break;
        }
    }
}
#pragma mark 微信支付
///产生随机字符串
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRST";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

//将订单号使用md5加密self.dic[@"goods_name"];
//product.subject = self.dic[@"goods_name"];
//product.orderId = self.dic[@"orderno"];
//product.type = self.dic[@"order_type"]
-(NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16]= "0123456789abcdef";
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
//产生随机数
- (NSString *)getOrderNumber{
    int random = arc4random()%10000;
    return [self md5:[NSString stringWithFormat:@"%d",random]];
}


- (void)httpService:(NSDictionary *)dictionary{
    YYLOrder * pre_order = [YYLOrder PreOrder];

    NSString *appid,*mch_id,*nonce_str,*sign,*body,*out_trade_no,*total_fee,*spbill_create_ip,*notify_url,*trade_type,*partner;
    //应用APPID
    appid = WXAPPID;
    //微信支付商户号
    mch_id = WXMID;
    ///产生随机字符串，这里最好使用和安卓端一致的生成逻辑
    nonce_str =[self generateTradeNO];
    body = [NSString stringWithFormat:@"优悠乐－－%@",pre_order.order_name];
    //随机产生订单号用于测试，正式使用请换成你从自己服务器获取的订单号
    out_trade_no = [self getOrderNumber];// dictionary[@"orderno"];
    //交易价格1表示0.01元，10表示0.1元
    
    total_fee = [NSString stringWithFormat:@"%d",[pre_order.payment_money intValue] * 100];//dictionary[@"total_price"];
    //获取本机IP地址，请再wifi环境下测试，否则获取的ip地址为error，正确格式应该是8.8.8.8
    spbill_create_ip = @"192.168.1.25";
//    spbill_create_ip = @"192.168.0.111";
    //交易结果通知网站此处用于测试，随意填写，正式使用时填写正确网站
    notify_url =@"http://cswl.5199yl.com/";
    trade_type =@"APP";
    //商户密钥
    partner = WXMPRIKEY;
    //获取sign签名
    DataMD5 *data = [[DataMD5 alloc] initWithAppid:appid mch_id:mch_id nonce_str:nonce_str partner_id:partner body:body out_trade_no:out_trade_no total_fee:total_fee spbill_create_ip:spbill_create_ip notify_url:notify_url trade_type:trade_type];
    sign = [data getSignForMD5];
  
    //设置参数并转化成xml格式
//    NSLog(@"-----========%@",sign);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:appid forKey:@"appid"];//公众账号ID
    [dic setValue:mch_id forKey:@"mch_id"];//商户号
    [dic setValue:nonce_str forKey:@"nonce_str"];//随机字符串
    [dic setValue:sign forKey:@"sign"];//签名
    [dic setValue:body forKey:@"body"];//商品描述
    [dic setValue:out_trade_no forKey:@"out_trade_no"];//订单号
    [dic setValue:total_fee forKey:@"total_fee"];//金额
    [dic setValue:spbill_create_ip forKey:@"spbill_create_ip"];//终端IP
    [dic setValue:notify_url forKey:@"notify_url"];//通知地址
    [dic setValue:trade_type forKey:@"trade_type"];//交易类型
    
    NSString *string = [dic XMLString];
    NSLog(@"%@----%@",dic,string);
    [self http:string onoce:nonce_str sign:sign xmlString:nil];
}

@end
