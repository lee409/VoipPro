//
//  ShareModel.m
//  Move
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShareModel.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
//#import "UMSocialLaiwangHandler.h"
//#import "UMSocialYiXinHandler.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "UMSocial.h"
#import "UMSocialControllerService.h"

@implementation ShareModel

-(void)dealloc{
    [super dealloc];
    [_shareUrl release];
    
}
+(instancetype)shareModel{
    static ShareModel *shareModel;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareModel = [[ShareModel alloc] init];
    });
    
    return  shareModel;
}


- (void)setShareUrl:(NSString *)shareUrl{
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UMENG_APPKEY];
    [UMSocialWechatHandler setWXAppId:@"wxe98c47cff5e0051f" appSecret:@"b38b50692dd7cf0559c591e01d98438b" url:shareUrl];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    //[UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:shareUrl];
    [UMSocialQQHandler setQQWithAppId:@"1105383347" appKey:@"aAcqgxoC6sLFK7Y5" url:shareUrl];
    
    
}
+(void)shareModel:(UIViewController*)controller snsName:(NSString *)snsName  shareImage:(UIImage *)shareImage shareText:(NSString *)shareText{
    [[UMSocialControllerService defaultControllerService] setShareText:shareText shareImage:shareImage socialUIDelegate:(id<UMSocialUIDelegate>)controller];
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
    snsPlatform.snsClickHandler(controller,[UMSocialControllerService defaultControllerService],YES);
    
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
    
    
}


@end
