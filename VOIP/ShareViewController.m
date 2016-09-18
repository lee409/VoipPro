//
//  ShareViewController.m
//  VOIP
//
//  Created by hermit on 14-11-28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ShareViewController.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
//#import "UMSocialLaiwangHandler.h"
//#import "UMSocialYiXinHandler.h"
#import "WXApi.h"
#import "WXApiObject.h"
@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addAavigationView:@"分享" aback:@"back.png"];
//    [UMSocialData setAppKey:UMENG_APPKEY];
//    [UMSocialWechatHandler setWXAppId:@"wxe98c47cff5e0051f" appSecret:@"b38b50692dd7cf0559c591e01d98438b" url:@"http://www.yidongchangliao.com"];
//    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
//    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.yidongchangliao.com"];
}


- (void)setShareUrl:(NSString *)shareUrl
{

    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UMENG_APPKEY];
    //设置微信AppId，设置分享url，默认使用友盟的网址
    //[UMSocialWechatHandler setWXAppId:@"wxd9a39c7122aa6516" url:shareUrl];
    // [UMSocialWechatHandler setWXAppId:@"wxe98c47cff5e0051f" url:shareUrl];
    //打开新浪微博的SSO开关
//    [UMSocialConfig setSupportSinaSSO:YES appRedirectUrl:shareUrl];
//    
//    //设置分享到QQ空间的应用Id，和分享url 链接
//    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:shareUrl];
//    [UMSocialQQHandler setSupportQzoneSSO:YES];
//    
//    //设置易信Appkey和分享url地址
//    [UMSocialYixinHandler setYixinAppKey:@"yx35664bdff4db42c2b7be1e29390c1a06" url:shareUrl];
//    
//    //设置来往AppId，appscret，显示来源名称和url地址41e2cfb3
    //    [UMSocialLaiwangHandler setLaiwangAppId:@"8112117817424282305" appSecret:@"9996ed5039e641658de7b83345fee6c9" appDescription:APPNAME urlStirng:shareUrl];
    [UMSocialWechatHandler setWXAppId:@"wxe98c47cff5e0051f" appSecret:@"b38b50692dd7cf0559c591e01d98438b" url:shareUrl];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    //[UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:shareUrl];
    [UMSocialQQHandler setQQWithAppId:@"1105383347" appKey:@"aAcqgxoC6sLFK7Y5" url:shareUrl];
}


//分组。
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//显示行数。
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 4;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = YES;
        cell.detailTextLabel.hidden = YES;
    }
   if (indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            
            case 0:
                [cell.textLabel setText:@"微信好友"];
                cell.detailTextLabel.text = @"wxsession";
                cell.imageView.image = [UIImage imageNamed:@"UMSocialSDKResourcesNew.bundle/SnsPlatform/UMS_wechat_icon.png"];
                break;
            case 1:
                [cell.textLabel setText:@"微信朋友圈"];
                cell.detailTextLabel.text = @"wxtimeline";
                cell.imageView.image = [UIImage imageNamed:@"UMSocialSDKResourcesNew.bundle/SnsPlatform/UMS_wechat_timeline_icon.png"];
                break;
            
            case 2:
                [cell.textLabel setText:@"QQ空间"];
                cell.detailTextLabel.text = @"qzone";
                cell.imageView.image = [UIImage imageNamed:@"UMSocialSDKResourcesNew.bundle/SnsPlatform/UMS_qzone_icon.png"];
                break;
            case 3:
                [cell.textLabel setText:@"QQ"];
                cell.detailTextLabel.text = @"qq";
                cell.imageView.image = [UIImage imageNamed:@"UMSocialSDKResourcesNew.bundle/SnsPlatform/UMS_qq_icon.png"];
                break;
                
            default:
                break;
        }
    }
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *result = [tableView cellForRowAtIndexPath:indexPath];
    NSString *snsName = result.detailTextLabel.text;
    UIImage *shareImage = [UIImage imageNamed:@"Icon.png"];
    if (indexPath.row == 0) {
        [UMSocialData defaultData].extConfig.wechatSessionData.title = @"微信分享";
            }else if (indexPath.row == 1){
      // [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"微信朋友圈分享";
            }else if (indexPath.row == 2){
       [UMSocialData defaultData].extConfig.qzoneData.title = @"QQ空间分享";
                
            }else{
       [UMSocialData defaultData].extConfig.qqData.title = @"QQ分享";
            }
    
//    if (indexPath.row == 0) {
//        [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://baidu.com";
//        [UMSocialData defaultData].extConfig.wechatSessionData.title = snsName;
//    }else if (indexPath.row == 1){
//        [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";
//        [UMSocialData defaultData].extConfig.wechatTimelineData.title = snsName;
//    }
    
    //设置分享内容，和回调对象
    
//    if (indexPath.row == 0) {
//        SendMessageToWXReq*req = [[SendMessageToWXReq alloc]init];
//        req.text = _shareText;
//        req.bText = YES;
//        req.scene = WXSceneSession;
//        [WXApi sendReq:req];
//        
//    }
//    [[UMSocialControllerService defaultControllerService] setShareText:_shareText shareImage:shareImage socialUIDelegate:self];
//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
//    snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    
//    [UMSocialData defaultData].extConfig.title = snsName;
//    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:UMENG_APPKEY
//                                      shareText:_shareText
//                                     shareImage:shareImage
//                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone]
//                                       delegate:self];
    
    
    [[UMSocialControllerService defaultControllerService] setShareText:_shareText shareImage:shareImage socialUIDelegate:self];
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
    snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"得到分享到的微博平台名是：%@",[[response.data allKeys] objectAtIndex:0]);
         [[iToast makeToast:@"分享成功"] show];
        //        if ([self.delegate respondsToSelector:@selector(shareFinish)]) {
//            [self.delegate shareFinish];
//
//        }
        
    }
}
@end
