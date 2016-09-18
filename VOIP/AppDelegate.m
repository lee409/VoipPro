//
//  AppDelegate.m
//  VOIP
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "CallPageViewController.h"
#import "AddressBookBigViewController.h"
#import "ShowViewController.h"
#import "ShowMainViewController.h"
#import "PayMoneyViewController.h"
#import <AlipaySDK/AlipaySDK.h>

CallPageViewController *m_CallPageViewController = nil;
SystemSoundID beepSound0 = -1;
SystemSoundID beepSound1 = -2;
SystemSoundID beepSound2 = -3;
SystemSoundID beepSound3 = -4;
SystemSoundID beepSound4 = -5;
SystemSoundID beepSound5 = -6;
SystemSoundID beepSound6 = -7;
SystemSoundID beepSound7 = -8;
SystemSoundID beepSound8 = -9;
SystemSoundID beepSound9 = -10;
SystemSoundID beepSound10 = -11;
SystemSoundID beepSound11 = -12;
SystemSoundID beepSound12 = -13;


@implementation AppDelegate
@synthesize getFeeview;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

      [NSThread sleepForTimeInterval:2.0];
//    [MobClick setAppVersion:XcodeAppVersion];
//    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) SEND_INTERVAL channelId:CHANNELNUMBER];
    [WXApi registerApp:@"wxe98c47cff5e0051f" withDescription:@"demo 2.0"];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [Utility shareInstance];
   //[self loadMainView0];//开机动画实现
    [self login_request];
        
    
    CTCallCenter *m_callCenter = [[CTCallCenter alloc] init];
    m_callCenter.callEventHandler = ^(CTCall* call) {
        if ([call.callState isEqualToString:CTCallStateDisconnected])
        {
            NSLog(@"Call has been disconnected挂断");//挂断
        }
        else if ([call.callState isEqualToString:CTCallStateConnected])
        {
            [Utility shareInstance].u_calledDuration = [NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]];
            NSLog(@"Call has just been connected接听");//接听
        }
        else if([call.callState isEqualToString:CTCallStateIncoming])
        {
            if (m_CallPageViewController)
            {
                [m_CallPageViewController closePage2];
            }
            NSLog(@"Call is incoming来电话。");//来电话。
        }
        else if ([call.callState isEqualToString:CTCallStateDialing])
        {
            NSLog(@"call is dialing拨号");//拨号
        }
        else
        {
            NSLog(@"Nothing is done");
        }
    };
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[mainBundle pathForResource:@"dtmf-0" ofType:@"aif"] isDirectory:NO], &beepSound0);

    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[mainBundle pathForResource:@"dtmf-1" ofType:@"aif"] isDirectory:NO], &beepSound1);

    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[mainBundle pathForResource:@"dtmf-2" ofType:@"aif"] isDirectory:NO], &beepSound2);

    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[mainBundle pathForResource:@"dtmf-3" ofType:@"aif"] isDirectory:NO], &beepSound3);

    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[mainBundle pathForResource:@"dtmf-4" ofType:@"aif"] isDirectory:NO], &beepSound4);

    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[mainBundle pathForResource:@"dtmf-5" ofType:@"aif"] isDirectory:NO], &beepSound5);

    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[mainBundle pathForResource:@"dtmf-6" ofType:@"aif"] isDirectory:NO], &beepSound6);

    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[mainBundle pathForResource:@"dtmf-7" ofType:@"aif"] isDirectory:NO], &beepSound7);

    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[mainBundle pathForResource:@"dtmf-8" ofType:@"aif"] isDirectory:NO], &beepSound8);

    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[mainBundle pathForResource:@"dtmf-9" ofType:@"aif"] isDirectory:NO], &beepSound9);

    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[mainBundle pathForResource:@"dtmf-#" ofType:@"aif"] isDirectory:NO], &beepSound10);

    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[mainBundle pathForResource:@"dtmf-s" ofType:@"aif"] isDirectory:NO], &beepSound11);
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    return YES;
}
//- (void)loadMainView0
//{
//    for(id view in self.window.subviews)
//    {
//        if(![view isKindOfClass:[UIButton class]])
//        {
//            [view removeFromSuperview];
//            view = nil;
//        }
//    }
//    JumpPageViewController *oneViewController= [[JumpPageViewController alloc] initWithNibName:@"JumpPageViewController" bundle:nil];
//     self.window.rootViewController = oneViewController;
//    [self.window makeKeyAndVisible];
//    [oneViewController release];
//}
- (void)loadMainView1
{
    for(id view in self.window.subviews)
    {
        if(![view isKindOfClass:[UIButton class]])
        {
            [view removeFromSuperview];
            view = nil;
        }
    }
    
    LogInViewController *oneViewController= [[LogInViewController alloc] initWithNibName:@"LogInViewController" bundle:nil];
    UINavigationController *oneNavigationController= [[UINavigationController alloc] initWithRootViewController:oneViewController];
    oneNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.window.rootViewController = oneNavigationController;
    [self.window makeKeyAndVisible];
    [oneViewController release];
    [oneNavigationController release];
}
- (void)loadMainView2
{
    for(id view in self.window.subviews)
    {
        if(![view isKindOfClass:[UIButton class]])
        {
            [view removeFromSuperview];
            view = nil;
        }
    }
    
    CallRecordsViewController *oneViewController= [[CallRecordsViewController alloc] initWithNibName:@"CallRecordsViewController" bundle:nil];
    UINavigationController *oneNavigationController= [[UINavigationController alloc] initWithRootViewController:oneViewController];
    oneNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    AddressBookBigViewController *twoViewController= [[AddressBookBigViewController alloc] initWithNibName:@"AddressBookBigViewController" bundle:nil];
    UINavigationController *twoNavigationController= [[UINavigationController alloc] initWithRootViewController:twoViewController];
    twoNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    
     PayMoneyViewController *threeViewController= [[PayMoneyViewController alloc] initWithNibName:@"PayMoneyViewController" bundle:nil];
    UINavigationController *threeNavigationController= [[UINavigationController alloc] initWithRootViewController:threeViewController];
    threeNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    
//    FoundViewController *fineViewController= [[FoundViewController alloc] initWithNibName:@"FoundViewController" bundle:nil];
//    UINavigationController *fineNavigationController= [[UINavigationController alloc] initWithRootViewController:fineViewController];
//    fineNavigationController.navigationBar.barStyle = UIBarStyleBlack;
//    
    
    PeopleCentreViewController *fourViewController= [[PeopleCentreViewController alloc] initWithNibName:@"PeopleCentreViewController" bundle:nil];
    UINavigationController *fourNavigationController= [[UINavigationController alloc] initWithRootViewController:fourViewController];
    fourNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    
  
    self.mainTabBarController = [[CustomTabbar alloc] init];
    self.mainTabBarController.viewControllers = [NSArray arrayWithObjects:oneNavigationController,twoNavigationController,threeNavigationController,fourNavigationController,nil];
    [[self.mainTabBarController tabBar] setSelectionIndicatorImage:[self createImageWithColor:[UIColor clearColor]]];
    [self.mainTabBarController theCustomTabbar];
    //self.mainTabBarController.selectedIndex = 2;
    
    self.window.rootViewController = self.mainTabBarController;//根视图
    [self.window makeKeyAndVisible];
    [self.mainTabBarController release];
    
    
    [oneViewController release];
    [twoViewController release];
    [threeViewController release];
    [fourViewController release];
   // [fineViewController release];
    
    [oneNavigationController release];
    [twoNavigationController release];
    [threeNavigationController release];
    [fourNavigationController release];
   // [fineNavigationController release];
    
    [Utility shareInstance].u_callShow = @"0";
    [Utility shareInstance].u_keyboardShake = @"0";
    [Utility shareInstance].u_keyboardVoice = @"0";
    [Utility shareInstance].u_beforeCallMusic = @"0";
    [Utility shareInstance].u_dialWay = @"1";//默认回拨
    NSString *str1 = [NSString stringWithFormat:@"SELECT count(*) FROM sqlite_master WHERE type='table' AND name='%@'",USERDATA];
    NSArray *icount2 = [[Utility shareInstance] sql_readData:str1 acount:1];
    if ([icount2 count]>0)
    {
        //来电显示 s_callShow  0代表显示，1不显示
        //登录成功后，存储当前用户的账号密码和ID。
        if ( [[[icount2 objectAtIndex:0] objectAtIndex:0] integerValue]==0 )
        {
            NSString *acreate = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ROW INTEGER PRIMARY KEY,s_account,s_password,s_callShow,s_keyboardShake,s_keyboardVoice,s_beforeCallMusic,s_dialWay,s_sipPhone,s_sipPwd,s_sipServer)",USERDATA];
            NSString *ainsert = [NSString stringWithFormat:@"INSERT INTO %@ (s_account,s_password,s_callShow,s_keyboardShake,s_keyboardVoice,s_beforeCallMusic,s_dialWay,s_sipPhone,s_sipPwd,s_sipServer) VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",USERDATA,[Utility shareInstance].u_account,[Utility shareInstance].u_password,[Utility shareInstance].u_callShow,[Utility shareInstance].u_keyboardShake,[Utility shareInstance].u_keyboardVoice,[Utility shareInstance].u_beforeCallMusic,[Utility shareInstance].u_dialWay,[Utility shareInstance].u_sipPhone,[Utility shareInstance].u_sipPwd,[Utility shareInstance].u_sipServer];
            ainsert = [ainsert stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            [[Utility shareInstance] sql_inser_data:acreate,ainsert,nil];
        }
        else
        {
            NSString *sql1 = [NSString stringWithFormat:@"UPDATE %@ SET s_account = '%@' ,s_password = '%@' ,s_sipPhone = '%@' ,s_sipPwd = '%@' ,s_sipServer = '%@'",USERDATA,[Utility shareInstance].u_account,[Utility shareInstance].u_password,[Utility shareInstance].u_sipPhone,[Utility shareInstance].u_sipPwd,[Utility shareInstance].u_sipServer];
            sql1 = [sql1 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            [[Utility shareInstance] sql_inser_data:sql1,nil];
            
            NSString *isql2 = [NSString stringWithFormat:@"select s_callShow,s_keyboardShake,s_keyboardVoice,s_beforeCallMusic,s_dialWay,s_sipPhone ,s_sipPwd, s_sipServer from %@",USERDATA];
            NSArray *icount = [[Utility shareInstance] sql_readData:isql2 acount:8];
            
            if ([icount count]>0)
            {
                [Utility shareInstance].u_callShow = [[icount objectAtIndex:0] objectAtIndex:0];
                [Utility shareInstance].u_keyboardShake = [[icount objectAtIndex:0] objectAtIndex:1];
                [Utility shareInstance].u_keyboardVoice = [[icount objectAtIndex:0] objectAtIndex:2];
                [Utility shareInstance].u_beforeCallMusic = [[icount objectAtIndex:0] objectAtIndex:3];
                
                [Utility shareInstance].u_dialWay = [[icount objectAtIndex:0] objectAtIndex:4];
                [Utility shareInstance].u_sipPhone = [[icount objectAtIndex:0] objectAtIndex:5];
                [Utility shareInstance].u_sipPwd = [[icount objectAtIndex:0] objectAtIndex:6];
                [Utility shareInstance].u_sipServer = [[icount objectAtIndex:0] objectAtIndex:7];
                
            }
        }
    }
    
    [self startSip];
}

- (void)startSip
{
    //初始化直拨
    if(![LinphoneManager isLcReady])
    {
        [[LinphoneManager instance]	startLibLinphone];
    }
    linphone_core_clear_proxy_config([LinphoneManager getLc]);
    linphone_core_clear_all_auth_info([LinphoneManager getLc]);
    
    NSString *username = [Utility shareInstance].u_sipPhone;
    NSString *password = [Utility shareInstance].u_sipPwd;
    NSString *domain = [Utility shareInstance].u_sipServer;
    NSString *server = [Utility shareInstance].u_sipServer;
    
    
    LinphoneProxyConfig* proxyCfg = linphone_core_create_proxy_config([LinphoneManager getLc]);
    char normalizedUserName[256];
    LinphoneAddress* linphoneAddress = linphone_address_new("sip:user@domain.com");
    linphone_proxy_config_normalize_number(proxyCfg, [username cStringUsingEncoding:[NSString defaultCStringEncoding]], normalizedUserName, sizeof(normalizedUserName));
    linphone_address_set_username(linphoneAddress, normalizedUserName);
    linphone_address_set_domain(linphoneAddress, [domain UTF8String]);
#pragma mark 直拨端口要改
    linphone_address_set_port_int(linphoneAddress, 5189);//直拨端口
    const char* identity = linphone_address_as_string_uri_only(linphoneAddress);
    LinphoneAuthInfo* info = linphone_auth_info_new([username UTF8String], NULL, [password UTF8String], NULL, NULL);
    linphone_proxy_config_set_identity(proxyCfg, identity);
    linphone_proxy_config_set_server_addr(proxyCfg, [server UTF8String]);
    linphone_proxy_config_enable_register(proxyCfg, true);
    linphone_core_add_proxy_config([LinphoneManager getLc], proxyCfg);
    linphone_core_set_default_proxy([LinphoneManager getLc], proxyCfg);
    linphone_core_add_auth_info([LinphoneManager getLc], info);
    LinphoneCore *lc=[LinphoneManager getLc];
    PayloadType *pt;
    const MSList *elem;
    for (elem=linphone_core_get_audio_codecs(lc);elem!=NULL;elem=elem->next)
    {
        pt=(PayloadType*)elem->data;
        linphone_core_enable_payload_type(lc,pt,true);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    
    //[self sign_request];
    
    if ([Utility shareInstance].u_calledDuration)
    {
        int idata1 = [[Utility shareInstance].u_calledDuration intValue];
        int idata2 = [[NSDate date] timeIntervalSince1970];
        int idata3 = idata2 - idata1;
        
        NSString * istring = nil;
        if (idata3 < 60)
        {
            istring = [NSString stringWithFormat:@"%d秒",idata3];
        }
        else if (idata3 >=60 && idata3 < 3600)
        {
            istring = [NSString stringWithFormat:@"%d分%d秒",idata3/60,idata3%60];
        }
        else if (idata3 >= 3600)
        {
            istring = [NSString stringWithFormat:@"%d时%d分%d秒",idata3/3600,(idata3%3600)/60,(idata3%3600)%60];
        }
        if (istring)
        {
           // [MobClick event:@"4" label:istring];
            
            NSString *sql1 = [NSString stringWithFormat:@"UPDATE %@ SET s_duration = '%@' where ROW =(select max(ROW) from %@)",CALLRECORDS,istring,CALLRECORDS];
            sql1 = [sql1 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            [[Utility shareInstance] sql_inser_data:sql1,nil];
            
            UINavigationController *oneNavigationController = [self.mainTabBarController.viewControllers objectAtIndex:0];
            CallRecordsViewController *oneViewController = (CallRecordsViewController *)oneNavigationController.visibleViewController;
            [oneViewController tableView_reloadData];
        }
        [Utility shareInstance].u_calledDuration = nil;
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//登录。
-(void)login_request
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *usql  = [defaults stringForKey:@"USER_1"];
    if ( !usql || [usql isEqualToString:@"out"] )
    {
        //状态为退出。
        [self performSelector:@selector(gg) withObject:nil afterDelay:0.0f];//后面设置的时间为0s就进入跳转
    }
    else
    {
        //打开用户数据库
        [[Utility shareInstance] sqlOpen:usql];
        
        //查询到数据直接登录，没有查询到数据跳转登录界面。
        NSString *isql = [NSString stringWithFormat:@"select s_account,s_password,s_sipPhone,s_sipPwd,s_sipServer from %@",USERDATA];
        NSArray *icount = [[Utility shareInstance] sql_readData:isql acount:5];
        if ([icount count]>0)
        {
            [Utility shareInstance].u_account = [[icount objectAtIndex:0] objectAtIndex:0];
            [Utility shareInstance].u_password = [[icount objectAtIndex:0] objectAtIndex:1];
            
            [Utility shareInstance].u_sipPhone = [[icount objectAtIndex:0] objectAtIndex:2];
            [Utility shareInstance].u_sipPwd = [[icount objectAtIndex:0] objectAtIndex:3];
            [Utility shareInstance].u_sipServer = [[icount objectAtIndex:0] objectAtIndex:4];
            
            [self performSelector:@selector(showMain) withObject:nil afterDelay:0.0f];
        }
       // [self sign_request];
    }
}

-(void)gg{
    ShowViewController*showViewController = [[ShowViewController alloc]init];
    self.window.rootViewController = showViewController;
    [self.window makeKeyAndVisible];
    [showViewController release];
    
}

-(void)showMain{
    ShowMainViewController*showMainViewController = [[ShowMainViewController alloc]init];
    self.window.rootViewController = showMainViewController;
    [self.window makeKeyAndVisible];
    [showMainViewController release];
}
//签到。
-(void)sign_request
{ NSMutableArray *insm = [NSMutableArray array];
    [insm addObject:@"sign_cmd"];
    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Ret", nil];
    [insm addObject:ixml];
    
    NSString *iurl = [NSString stringWithFormat:@"%@regnum=%@&regpwd=%@",[Utility submitSignPath],[Utility shareInstance].u_account,[Utility shareInstance].u_password];
    [insm addObject:iurl];
    
    if (m_request) {
        m_request.delegate = nil;
        [m_request release];
        m_request = nil;
    }
    
    m_request = [[HttpDataRequests alloc] init:insm];
    m_request.delegate = self;
}


//更新。
-(void)download_request
{ NSMutableArray *insm = [NSMutableArray array];
    [insm addObject:@"download_cmd"];
    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Ret",@"",@"url", nil];
    [insm addObject:ixml];
    
    NSString *iurl = [NSString stringWithFormat:@"%@agent_id=%@&type=iphone&code=%@",DOWNLOAD,PRODUCT,VERSIONTAG];
    [insm addObject:iurl];
    
    if (m_request) {
        m_request.delegate = nil;
        [m_request release];
        m_request = nil;
    }
    
    m_request = [[HttpDataRequests alloc] init:insm];
    m_request.delegate = self;
}
-(void)HttpCallBack:(id)adata atag:(InternetState)atag acmd:(NSString*)acmd
{
    if (![[Utility getError:atag] isEqualToString:@"OK"])
    {
       // [[iToast makeToast:[Utility getError:atag]] show];
    }
    else
    {
        if ([acmd isEqualToString:@"download_cmd"])
        {
            if ( [[adata objectForKey:@"Ret"] isEqualToString:@"0"] )
            {
                NSString *m_url = [NSString stringWithString:[adata objectForKey:@"url"]];
                m_url = [m_url stringByReplacingOccurrencesOfString:@"*" withString:@"&"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:m_url]];
                
            }
           
        }else if ([acmd isEqualToString:@"sign_cmd"]){
        
            if ( [[adata objectForKey:@"Ret"] isEqualToString:@"0"] )
            {
                
                [self performSelector:@selector(startGetfeeAnimation) withObject:nil afterDelay:2.0f];
                
                
            }
        
            [self download_request];
            return;
        }
    }
    m_request.delegate=nil;
    [m_request release];
    m_request = nil;
}

- (void)startGetfeeAnimation
{
    getFeeview = [GetFeeView defaultPopupView];
    //view.parentVC = self;
    getFeeview.getFeedelegate = self;
    getFeeview.parentVC = self.window.rootViewController;
    LewPopupViewAnimationSlide *animation = [[LewPopupViewAnimationSlide alloc]init];
    animation.type = LewPopupViewAnimationSlideTypeBottomBottomNoneDiss;
    [self.window.rootViewController lew_presentPopupView:getFeeview animation:animation dismissed:^{
        
    }];

}

- (void)getFeeCoinAnimationFinished
{
    //[getFeeview removeFromSuperview];
    //getFeeview = nil;
    [getFeeview close];
    getFeeview = nil;
  
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            NSString*memo = [resultDic objectForKey:@"memo"];
            NSLog(@"ddddd%@",memo);
            NSString*resultStatus = [resultDic objectForKey:@"resultStatus"];
            NSLog(@"ddddd%@",resultStatus);
            
            if ([resultStatus isEqualToString:@"9000"]) {
                [[iToast makeToast:@"支付宝成功"] show];
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
    }else if ([[url absoluteString] rangeOfString:@"wxe98c47cff5e0051f"].location != NSNotFound) {
        return   [WXApi handleOpenURL:url delegate:self];
    }else{
        BOOL result = [UMSocialSnsService handleOpenURL:url];
        if (result == FALSE) {
            //调用其他SDK，例如支付宝SDK等
        }
        return result;
    }
    
    
    return YES;
}






// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            NSString*memo = [resultDic objectForKey:@"memo"];
            NSLog(@"ddddd%@",memo);
            NSString*resultStatus = [resultDic objectForKey:@"resultStatus"];
            NSLog(@"ddddd%@",resultStatus);
            
            if ([resultStatus isEqualToString:@"9000"]) {
                [[iToast makeToast:@"支付宝成功"] show];
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
    }else if ([[url absoluteString] rangeOfString:@"wxe98c47cff5e0051f"].location != NSNotFound) {
        return   [WXApi handleOpenURL:url delegate:self];
    }
    
    return YES;
}

-(void) onResp:(BaseResp*)resp
{
    
    NSString *strTitle;
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"paysucess"object:nil];
                // [self user_info];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:@"支付成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
                
                break;
                
            default:
            {
                UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"支付失败" message:@"支付失败，请稍后重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertview show];
                
            }
                break;
        }
    }
    
    
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
