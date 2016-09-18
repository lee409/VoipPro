//
//  PayMoney1ViewController.m
//  VOIP
//
//  Created by apple on 16/6/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PayMoney1ViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
@interface PayMoney1ViewController ()
@property(nonatomic,retain)NSString*result;
@property(nonatomic,retain)NSString*typeofpayment;

@end

@implementation PayMoney1ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self addAavigationView:@"充值确认" aback:@"back.png"];
    self.numberPhoneLabel.text = [Utility shareInstance].u_account;
   
    self.numPayLabel.text = self.labelNumstr;
  
   
    
}

-(void)requseDate:(NSString*)typeofpayment{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
     mbp.labelText = @"   请稍等...   ";
    //    NSMutableArray *insm = [NSMutableArray array];
    //    [insm addObject:@"alipay"];
    //    NSArray*alipayArrayc = [NSArray array];
    //    [insm addObject:alipayArrayc];
    
    
    // [insm addObject:iurl];
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    if (!netStatus)
    {
        mbp.labelText = @"   网络异常，请检测网络   ";
    }
    else
    {
        NSString *iurl = nil;
        if ([typeofpayment isEqualToString:@"alipayapi"]) {
            iurl = [NSString stringWithFormat:@"http://120.76.78.99/api/alipay/alipayapi.php?topup_type=%@&mobile=%@&subject=%@&body=%@&total_fee=%@&topup_from=%@",self.topup_type,[Utility shareInstance].u_account,self.subject,self.labelNumstr,self.moneyStr,@"2"];
        }else if ([typeofpayment isEqualToString:@"wxpayapi"]){
            iurl = [NSString stringWithFormat:@"http://120.76.78.99/api/wxpay/wxpayapi.php?topup_type=%@&mobile=%@&body=%@&price=%@&topup_from=%@",self.topup_type,[Utility shareInstance].u_account,self.labelNumstr,self.moneyStr,@"2"];
        }
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[iurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        request.tag = 10;
        request.timeOutSeconds = 30L;
        [request setDelegate:self];
        [request startAsynchronous];
    }
    
    //[MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
}
//请求开始
- (void)requestStarted:(ASIHTTPRequest *)request
{
    //NSLog(@"请求开始");
    
}

//请求完成
- (void)requestFinished:(ASIHTTPRequest *)request
{
    // NSLog(@"请求完成");
    //    NSDictionary *dic = request.responseHeaders;
    //    NSLog(@"aa%@",dic);
    //
    //    NSLog(@"hh%@",request.responseString);
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
     NSString*state = [dic objectForKey:@"state"];
    
    if (request.tag == 10) {
       
        if ([self.typeofpayment isEqualToString:@"alipayapi"]) {
            NSString*result = [dic objectForKey:@"result"];
            if ([state isEqualToString:@"1"]) {
                self.result = result;
                
                NSArray*resustOut = [result componentsSeparatedByString:@"&"];
                
                for (NSString*str in resustOut) {
                    if ([str rangeOfString:@"out_trade_no"].location != NSNotFound) {
                        [Utility shareInstance].orderPay = [str componentsSeparatedByString:@"="][1];
                        NSLog(@"sssss%@",[Utility shareInstance].orderPay);
                        break;
                    }
                }
                
                [[iToast makeToast:@"正在跳转支付宝页面。。。。。"] show];
                NSString *appScheme = @"yidongchangliao";
                [[AlipaySDK defaultService] payOrder:self.result fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    NSLog(@"reslut = %@",resultDic);
                    
                    NSString*memo = [resultDic objectForKey:@"memo"];
                    NSLog(@"ddddd%@",memo);
                    NSString*resultStatus = [resultDic objectForKey:@"resultStatus"];
                    NSLog(@"ddddd%@",resultStatus);
                    
                    if ([resultStatus isEqualToString:@"9000"]) {
                        NSString *iurl = [NSString stringWithFormat:@"http://120.76.78.99/api/get_result_api.php?out_trade_no=%@",[Utility shareInstance].orderPay];
                        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[iurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                        request.tag = 100;
                        request.timeOutSeconds = 30L;
                        [request setDelegate:self];
                        [request startAsynchronous];
                        
                        
                        
                    }else if ([resultStatus isEqualToString:@"8000"]){
                        [[iToast makeToast:@"支付结果处理中"] show];
                        
                    }else if ([resultStatus isEqualToString:@"6001"]){
                        [[iToast makeToast:@"支付取消"] show];
                        
                    }else if ([resultStatus isEqualToString:@"4000"]){
                        [[iToast makeToast:@"订单支付失败"] show];
                        
                    }else {
                        [[iToast makeToast:@"支付失败"] show];
                        
                    }
                    
                }];
            }else if ([state isEqualToString:@"-1"]){
                [[iToast makeToast:@"很抱歉，访问支付宝失败"] show];
            }else if ([state isEqualToString:@"-2"]){
                [[iToast makeToast:@"手机号码未注册"] show];
            }else if ([state isEqualToString:@"-3"]){
                [[iToast makeToast:@"订单创建失败"] show];
            }else if ([state isEqualToString:@"-4"]){
                [[iToast makeToast:@"对不起，该号码已经使用过优惠活动"] show];
            }
            NSLog(@"aaaa%@,dddd%@",state,result);
            
        }else if ([self.typeofpayment isEqualToString:@"wxpayapi"]){
            
            if ([state isEqualToString:@"1"]) {
            
            NSDictionary*result = [dic objectForKey:@"result"];
            NSLog(@"aaaa%@,dddd%@",state,result);
            PayReq* req             = [[[PayReq alloc] init]autorelease];
            NSMutableString *stamp  = [result objectForKey:@"timestamp"];
            req.partnerId           = [result objectForKey:@"partnerid"];
            req.prepayId            = [result objectForKey:@"prepayid"];
            req.nonceStr            = [result objectForKey:@"noncestr"];
            req.timeStamp           = stamp.intValue;
            req.package             = [result objectForKey:@"package"];
            req.sign                = [result objectForKey:@"sign"];
                [WXApi sendReq:req];
            }else if ([state isEqualToString:@"-1"]){
                [[iToast makeToast:@"很抱歉，访问微信失败"] show];
            }else if ([state isEqualToString:@"-2"]){
                [[iToast makeToast:@"手机号码未注册"] show];
            }else if ([state isEqualToString:@"-3"]){
                [[iToast makeToast:@"预付单无效"] show];
            }else if ([state isEqualToString:@"-4"]){
                [[iToast makeToast:@"订单创建失败"] show];
            }else if ([state isEqualToString:@"-5"]){
                [[iToast makeToast:@"对不起，该号码已经使用过优惠活动"] show];
            }
        }
        
        

    }else if (request.tag == 100){
        if ([state isEqualToString:@"1"]) {
            [[iToast makeToast:@"支付宝支付成功"] show];
        }else{
            [[iToast makeToast:@"支付宝支付失败"] show];
        }
    }
    
    
   
    //NSLog(@"%@",[request responseString]);
    
}

//请求失败
- (void)requestFailed:(ASIHTTPRequest *)request
{
    
     [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    [[iToast makeToast:@"请求失败,请检查网络"] show];
    NSLog(@"请求失败");
}


- (void)dealloc {
     [super dealloc];
   
    [_labelNumstr release];
    [_moneyStr release];
    [_result release];
    [_subject release];
    [_typeofpayment release];
  
    [_topup_type release];
    [_labelNumstr release];
   
}
- (void)viewDidUnload {
    
    [self setNumPayLabel:nil];
    [self setNumberPhoneLabel:nil];
    [super viewDidUnload];
}
- (IBAction)zhiFuBaoPayAction:(UIButton *)sender {
    
    self.typeofpayment = @"alipayapi";
    [self requseDate:self.typeofpayment];
    //    NSString *partner = @"2088221874328562";
//    NSString *seller = @"3433409460@qq.com";
//    NSString *privateKey = @"";
//    
//    Order *order = [[Order alloc] init];
//    order.partner = partner;
//    order.sellerID = seller;
//    order.outTradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
//    order.subject = self.labelNumstr; //商品标题
//    order.body = self.labelNumstr; //商品描述
//    order.totalFee = [NSString stringWithFormat:@"%.2f",[self.moneyStr floatValue]]; //商品价格
//    order.notifyURL =  @"http://www.yidongchangliao.com"; //回调URL
//    
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    order.showURL = @"m.alipay.com";
//    
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    
//    
//    //将商品信息拼接成字符串
//    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
//    
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderSpec];
//    
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
//    NSString *orderString = nil;
//    if (signedString != nil) {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];
    
    
    
    
  //  }
    
    
}

//- (NSString *)generateTradeNO
//{
//    static int kNumber = 15;
//    
//    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//    NSMutableString *resultStr = [[NSMutableString alloc] init];
//    srand((unsigned)time(0));
//    for (int i = 0; i < kNumber; i++)
//    {
//        unsigned index = rand() % [sourceStr length];
//        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
//        [resultStr appendString:oneStr];
//    }Wap\U6536\U94f6\U53f0\U52a0\U8f7d\U5931\U8d25
//    return resultStr;
//}

- (IBAction)weiXiPayAction:(UIButton *)sender {
    self.typeofpayment = @"wxpayapi";
    [self requseDate:self.typeofpayment];
}
@end
