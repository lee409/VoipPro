//
//  CallRecordsViewController.m
//  VOIP
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CallRecordsViewController.h"
#import "LewPopupViewAnimationSlide.h"

#import "AppDelegate.h"

@interface CallRecordsViewController()
{
    
}
@end

@implementation CallRecordsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       // [self.navigationController setNavigationBarHidden:YES];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self tableView_reloadData];
   
  
//    if (m_adView != nil) {
//        [m_adView startTimer];
//    }
    //获取网络
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    if (netStatus) {
        
       
        [self query_ad];//获取广告图片信息
      
        [self query_call_ad];//获取拨打界面的图片信息
        [self getMsg];//滚动游字
        [self more_info_request];
        
    }
 
    if (m_dialView != nil) {
        m_dialView.msgData = nil;
    }

}

- (void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
//    if (m_adView != nil) {
//        [m_adView stopTimer];
//    }
}
//获取文字信息
-(void)getMsg
{
    NSURL *url = [NSURL URLWithString:[[Utility commonTextPushPath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableString *xmlString = [NSMutableString stringWithString:@"<?xml version='1.0' encoding='UTF-8'?>"];
    [xmlString appendString:@"<data>"];
    [xmlString appendString:@"<type>advertising_word</type>"];
    [xmlString appendFormat:@"<uid>%@</uid>",USERID];
    [xmlString appendFormat:@"<phone>%@</phone>",[Utility shareInstance].u_account];
    [xmlString appendString:@"</data>"];
    // 2. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    // 3. Connection异步
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *reponse, NSData *data, NSError *error) {
        
        
        if (data != nil) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
         
            if (dict != nil && dict.count > 0) {
                if ([dict[@"status"] isEqualToString:@"1"]) {
                    NSDictionary *data = dict[@"data"][0];
                    NSString *aw_content = data[@"content"];
                    if (m_dialView != nil) {
                        m_dialView.msgData = aw_content;
                    }
                  
                }
            }
        }else{
          NSLog(@"data = null");
        }
        
    }];
}

//获取广告图片信息
- (void)query_ad
{
   
    NSURL *url = [NSURL URLWithString:[[Utility commonPicPushPath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableString *xmlString = [NSMutableString stringWithString:@"<?xml version='1.0' encoding='UTF-8'?>"];
    [xmlString appendString:@"<data>"];
    [xmlString appendString:@"<type>dial_pic</type>"];
    [xmlString appendFormat:@"<uid>%@</uid>",USERID];
    [xmlString appendFormat:@"<phone>%@</phone>",[Utility shareInstance].u_account];
    [xmlString appendString:@"</data>"];
    // 2. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    // 3. Connection异步
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *reponse, NSData *data, NSError *error) {
        
        
        if (data != nil) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
            //NSLog(@"dtata = %@",dict);
            
            if (dict != nil && dict.count > 1) {
                if ([dict[@"status"] isEqualToString:@"1"]) {
                    NSArray *array = dict[@"data"];
                    
                    
                    
                    if (array != nil && array.count > 0) {
                        NSMutableArray *arrayM = [[NSMutableArray alloc]init];
                        for (NSDictionary *d in array) {
                            NSMutableDictionary *item = [[NSMutableDictionary alloc]init];
                            [item setValue:d[@"img"] forKey:@"p_img_full"];
                            [item setValue:d[@"url"] forKey:@"p_url"];
                            [arrayM addObject:item];
                        }
                        
                        
                        [self performSelectorOnMainThread:@selector(threadLoadImage:) withObject:arrayM waitUntilDone:YES];
                    }
                }
            }
        }
    }];
}


/*
 唐工给的拨打界面的图片的代码
 */
//获取拨打界面的图片信息
- (void)query_call_ad
{
   
    NSURL *url=[NSURL URLWithString:[[Utility commonPicPushPath]  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];//转换成utf8格式的编码
    
    NSMutableString*xmlString=[NSMutableString stringWithString:@"<?xml version='1.0' encoding='UTF-8'?>"];
    [xmlString appendString:@"<data>"];
    [xmlString appendString:@"<type>dial_waiting_pic</type>"];
    [xmlString appendFormat:@"<uid>%@</uid>",USERID ];
    [xmlString appendFormat:@"<phone>%@</phone>",[Utility shareInstance].u_account];
    [xmlString appendString:@"</data>"];
  //2 Request
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"post"];
    [request setHTTPBody:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];
//3 异步(主线程里面)
    [NSURLConnection  sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(data !=nil)
        {
            NSDictionary*dict=[NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
            if((NSNull *)dict[@"status"] != [NSNull null] && [dict[@"status"] isEqualToString:@"1"])
            {
                NSArray* array=dict[@"data"];
              
                if(array !=nil)
                {
                    NSMutableArray *arrayM = [[NSMutableArray alloc]init];
                    for (NSDictionary *d in array) {
                        NSMutableDictionary *item = [[NSMutableDictionary alloc]init];
                        [item setValue:d[@"img"] forKey:@"p_img_full"];
                        [item setValue:@"" forKey:@"p_url"];
                        [arrayM addObject:item];
                    }
                    [self performSelectorOnMainThread:@selector(threadLoadImage2:) withObject:arrayM waitUntilDone:YES];
                }
            }
        }
        
    }];
}


-(void)more_info_request
{
    
    NSMutableArray *insm = [NSMutableArray array];
    [insm addObject:@"more_info_cmd"];
    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Ret",@"",@"service_call", @"",@"website",nil];
    [insm addObject:ixml];
   
    
    NSString *iurl = [Utility queryMoreInfoPath];
    NSMutableString *xmlString = [NSMutableString stringWithString:@"<?xml version='1.0' encoding='UTF-8'?>"];
    [xmlString appendString:@"<data>"];
    [xmlString appendString:@"<type>more_info</type>"];
    [xmlString appendFormat:@"<uid>%@</uid>",USERID];
    [xmlString appendFormat:@"<phone>%@</phone>",[Utility shareInstance].u_account];
    [xmlString appendString:@"</data>"];
    [insm addObject:iurl];
    [insm addObject:xmlString];
    
    if (m_request) {
        m_request.delegate = nil;
        [m_request release];
        m_request = nil;
    }
    
    m_request = [[HttpDataRequests alloc] initWithData:insm];
    m_request.delegate = self;
}


- (void)HttpCallBack:(id)adata atag:(InternetState)atag acmd:(NSString *)acmd
{
    if ([[Utility getError:atag] isEqualToString:@"OK"] )
    {
        
        NSString *service_call = adata[@"service_call"];
        NSString *website = adata[@"website"];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:service_call forKey:SERVICE_CALL];
        [userDefaults setObject:website forKey:WEBSITE_URL];
        
    }
    m_request.delegate=nil;
    [m_request release];
    m_request = nil;
    
}


- (void)threadLoadImage:(NSArray *)imageInfo
{
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(loadImage:) object:imageInfo];
    // 启动线程
    [thread start];
}
//唐工的给的拨打图片的代码
- (void)threadLoadImage2:(NSArray *)imageInfo
{
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(loadImage2:) object:imageInfo];
    // 启动线程
    [thread start];
    
}

// 下载图片，这里要注意一下，本来是 if (b || !b)的，但是后面(self.s)
- (void)loadImage:(NSArray *)imageInfo
{
    
    FileOperationHelp *fileOperation = [[FileOperationHelp alloc]init];
    
    BOOL b = [fileOperation loadImageWithImageInfo:imageInfo withSaveFileDir:DIAL_AD withSavePlistFileName:DIAL_AD_PLIST];
    [fileOperation release];
    
  
    //有新图片，刷新
    if (b)
    {
        [self refreshADView];
    }
}

//SaveFileDir保存的文件夹    //PlistFileName保存的plist文件名字
-(void)loadImage2:(NSArray *)imageInfo
{
    FileOperationHelp *fileOperation = [[FileOperationHelp alloc]init];

      [fileOperation loadImageWithImageInfo:imageInfo withSaveFileDir:CALL_AD  withSavePlistFileName:CALL_AD_PLIST];
    [fileOperation release];
}

//刷新广告
- (void)refreshADView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"DialView"owner:self options:nil];
    DialView *iDialView =   [[nibView objectAtIndex:0] retain];
    CGRect frame_1;
   
    
    frame_1 = CGRectMake(0, 0, self.view.bounds.size.width,[UIScreen mainScreen].bounds.size.height - iDialView.bounds.size.height - 49 - self.navigationController.navigationBar.bounds.size.height - 20);

    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documents[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",DIAL_AD,DIAL_AD_PLIST]];
    //图片信息
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    //图片名称
    NSMutableArray *arrayM = [[NSMutableArray alloc]init];
    //图片链接地址
    NSMutableDictionary *imageUrlDict = [[NSMutableDictionary alloc]init];
    if (array != nil && array.count > 0) {
        for (NSInteger i = 0; i < array.count; i++) {
            NSDictionary *dict = array[i];
            NSString * imageName = dict[@"p_img_full"];
            NSString * imageUrl = dict[@"p_url"];
            if (imageName != nil && imageName.length > 0) {
                [arrayM addObject:imageName];
                [imageUrlDict setValue:imageUrl forKey:imageName];
            }
        }
      
        if (m_adView == nil) {
            //这里是做广告层的位置放在callRecordsViewController.m中上面
            ADView *adView = [[ADView alloc]initWithFrame:frame_1];
            adView.fileDir = DIAL_AD;
            
            adView.imageNameList = arrayM;
            adView.imageUrlDict = imageUrlDict;
            [adView setDelegate:self];
            m_adView = adView;
            [self.view addSubview:m_adView];
        }
        else
        {
            
            m_adView.imageUrlDict = imageUrlDict;
            m_adView.imageNameList = arrayM;
            
        }
    }

   
    //[adView release];
}
//打开广告链接
- (void)ADopenUrl:(NSString *)url withName:(NSString *)name
{
    ItemHelpViewController *ctl = [[ItemHelpViewController alloc] initWithNibName:@"ItemHelpViewController" bundle:nil];
    ctl.m_data = 2;
    ctl.m_url = url;
    ctl.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:ctl animated:YES];
    [ctl release];
}

-(void)tableView_reloadData
{
    //读取扩展信息。
    NSString *isql = [NSString stringWithFormat:@"select *,count(*) s_count from %@ group by s_phone order by row desc",CALLRECORDS];
    if (m_callRecords) {
        
        [m_callRecords release];
    }
    m_callRecords = [[NSMutableArray alloc] initWithArray:[[Utility shareInstance] sql_readData:isql acount:10]];
    for(UIView *view in self.view.subviews)
    {
        if([view isKindOfClass:[UITableView class]])
        {
            UITableView *tableView = (UITableView *)view;
            if (view.tag==0)
            {
                tableView.rowHeight = 50;
                [tableView reloadData];
            }
            else if (view.tag==1)
            {
                tableView.rowHeight = 50;
            }
            //解决IOS7上的显示问题。
            if ( IOS_VERSION_7_OR_ABOVE )
            {
                CGRect iframe;
                iframe.origin.x = self.view.frame.origin.x;
                iframe.origin.y = 0;
                iframe.size.width = self.view.frame.size.width;
                iframe.size.height = self.view.frame.size.height;
                tableView.frame = iframe;
                self.edgesForExtendedLayout=NO;
            }
        }
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = self.view.frame;
    frame.origin.y=0;
    self.tableViewCallLog.frame = frame;
    
    self.navigationController.navigationBar.hidden =NO;
    [self addAavigationView:@"最近通话" aback:nil];
    
    m_phoneDic=[[NSMutableDictionary alloc] init];
    m_filteredArray=[[NSMutableArray alloc] init];
    m_DialAphla = [[NSMutableDictionary alloc] init];
    m_sectionDic = [[NSMutableDictionary alloc]init];
    [self performSelector:@selector(loadContacts) withObject:nil afterDelay:0.1f];
    
    //拨号键盘。
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"DialView"owner:self options:nil];
    DialView *iDialView =   [[nibView objectAtIndex:0] retain];
    CGRect irect;
    irect.origin.x = 0;
    irect.origin.y = self.view.frame.size.height;
    irect.size.width = [UIScreen mainScreen].bounds.size.width;
    irect.size.height = iDialView.frame.size.height;
    iDialView.frame = irect;
    [iDialView initWithFrame];
    m_dialView = iDialView;
    
    [m_DialAphla setObject:@"ABC" forKey:@"2"];
    [m_DialAphla setObject:@"DEF" forKey:@"3"];
    [m_DialAphla setObject:@"GHI" forKey:@"4"];
    [m_DialAphla setObject:@"JKL" forKey:@"5"];
    [m_DialAphla setObject:@"MNO" forKey:@"6"];
    [m_DialAphla setObject:@"PQRS" forKey:@"7"];
    [m_DialAphla setObject:@"TUV" forKey:@"8"];
    [m_DialAphla setObject:@"WXYZ" forKey:@"9"];
    

    [self refreshADView];//点击这里面进去，就是设置通话记录上面的图片变小
    [self createDialCallBar];

    [self.view addSubview:iDialView];
   // [iDialView release];
}

-(void)createDialCallBar
{
    CGFloat screenH = [UIScreen mainScreen].bounds.size.width;
    UIView *dialView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenH, 49)];
    [dialView setBackgroundColor:[UIColor whiteColor]];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:CGRectMake(20, 10 ,25, 25)];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"tabbar_00_nor.png"] forState:UIControlStateNormal];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"tabbar_00_nor.png"] forState:UIControlStateHighlighted];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"tabbar_00_down.png"] forState:UIControlStateNormal];
    btn1.tag = 1;
    [btn1 addTarget:self action:@selector(button_clicked_tag:) forControlEvents:UIControlEventTouchUpInside];
    [dialView addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setFrame:CGRectMake(screenH / 2 - 180 / 2, 4, 180, 40)];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"tabbar_call_nor.png"] forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"tabbar_call_nor.png"] forState:UIControlStateHighlighted];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"tabbar_call_down.png"] forState:UIControlStateNormal];
    btn2.tag = 2;
    [btn2 addTarget:self action:@selector(button_clicked_tag:) forControlEvents:UIControlEventTouchUpInside];
    [dialView addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    
     [btn3 setFrame:CGRectMake(screenH - 48, 10, 25, 25)];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"tabbar_contact_nor.png"] forState:UIControlStateNormal];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"tabbar_contact_nor.png"] forState:UIControlStateHighlighted];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"tabbar_contact_down.png"] forState:UIControlStateNormal];
    btn3.tag = 3;
    [btn3 addTarget:self action:@selector(button_clicked_tag:) forControlEvents:UIControlEventTouchUpInside];
    [dialView addSubview:btn3];
    m_dialCallBar = dialView;
    m_dialCallBar.tag = 0;
    
}

- (void)go_callsetting
{
    CallerIDPrivacyViewController *ctl = [[CallerIDPrivacyViewController alloc] initWithNibName:@"CallerIDPrivacyViewController" bundle:nil];
    ctl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctl animated:YES];
    [ctl release];
}

- (void)showDialCallBar:(BOOL) b
{
    //b = true 要求显示 b = false 要求隐藏 tag == 0 表示未显示 tag == 1表示已显示
    if (b) {
        if (m_dialCallBar.tag == 0) {
            [self.tabBarController.tabBar addSubview:m_dialCallBar];
            m_dialCallBar.tag = 1;
        }
        
        if(m_adView != nil){
            m_adView.hidden = YES;
        }
    }
    else
    {
        if (m_dialCallBar.tag == 1) {
            [m_dialCallBar removeFromSuperview];
            m_dialCallBar.tag = 0;
        }
        if(m_adView != nil){
            m_adView.hidden = NO;
        }
        
    }
}

- (void)button_clicked_tag:(UIButton *)btn
{
    
    
    if (btn.tag == 1) {
        [m_dialCallBar removeFromSuperview];
        m_dialCallBar.tag = 0;
    }else if (btn.tag == 2){
        
        for (UIView *view in self.view.subviews) {
            
            if ([view isKindOfClass:[DialView class]]) {
                [((DialView *)view) bohao];
                [m_dialCallBar removeFromSuperview];
                m_dialCallBar.tag = 0;
                
                NSString *itype = [Utility shareInstance].u_dialWay;
                if ( [itype isEqualToString:@"0"] )//智能拨打
                {
                    if ( [[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable )
                    {
                        [Utility shareInstance].u_calledHuiboOrZhibo = @"0";
                        [[Utility shareInstance] callPhonaPage:self];
                    }
                    else
                    {
                        [Utility shareInstance].u_calledHuiboOrZhibo = @"1";
                        [[Utility shareInstance] callPhonaPage:self];
                    }
                }//回拨
                else if ( [itype isEqualToString:@"1"] )
                {
                    [Utility shareInstance].u_calledHuiboOrZhibo = @"1";
                    [[Utility shareInstance] callPhonaPage:self];
                }//直拨
                else if ( [itype isEqualToString:@"2"] )
                {
                    [Utility shareInstance].u_calledHuiboOrZhibo = @"0";
                    [[Utility shareInstance] callPhonaPage:self];
                    
                }//手动选择
                else if ( [itype isEqualToString:@"3"] )
                {
                    CallSelectView *view = [CallSelectView defaultPopupView];
                    view.parentVC = self;
                    view.delegate = self;
                    LewPopupViewAnimationSlide *animation = [[LewPopupViewAnimationSlide alloc]init];
                    animation.type = LewPopupViewAnimationSlideTypeBottomBottomEdge;
                    [self lew_presentPopupView:view animation:animation dismissed:^{
                        
                    }];
                }
                
            }
        }
        
        if(m_adView != nil){
            m_adView.hidden = NO;
        }
        
        
    }
    else if (btn.tag == 3)
    {
        [((AppDelegate*)[UIApplication sharedApplication].delegate).mainTabBarController when_tabbar_is_selected:1];
        [self.navigationController popViewControllerAnimated:YES];
        [m_dialCallBar removeFromSuperview];
        m_dialCallBar.tag = 0;
    }
}



//滑动隐藏。
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    CustomTabbar *mainTabBarController = ((AppDelegate *)[UIApplication sharedApplication].delegate).mainTabBarController;
    ExButton *ibtn = [mainTabBarController.m_tableArray objectAtIndex:0];
    if ( ibtn.m_bool == NO )
    {
        [mainTabBarController when_tabbar_is_selected:0];
    }
}
-(NSString*)Back_filteredArray
{
    if ([m_filteredArray count]>0)
    {
        NSDictionary *person=[m_filteredArray objectAtIndex:0];
        return [[person objectForKey:@"name"] stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return @"匿名";
}

-(NSString*)Back_filteredArray_phone
{
    if ([m_filteredArray count]>0)
    {
        NSDictionary *person=[m_filteredArray objectAtIndex:0];
        return [[person objectForKey:@"phone"] stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return @"";
}

//出现那种情况是在xib中本来设置的tableview开始位置0.0 ，但是下移，这是就加上下面的代码，3句，frame
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView.tag==0)
    {
       CGRect frame=tableView.frame;
       frame.origin.y=0;
       tableView.frame=frame;
        return nil;
    }
    else if (tableView.tag==1)
    {
        return [NSString stringWithFormat:@"共搜索到%d条",[m_filteredArray count]];
    }
    return nil;
}
//设置每个区有多少行共有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    if (tableView.tag==0)
    {
        return [m_callRecords count];
    }
    else if (tableView.tag==1)
    {
        return [m_filteredArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0)
    {
        CGRect frame=tableView.frame;
        frame.origin.y=0;
        tableView.frame=frame;
        static NSString *CellIdentifier = @"Cell";
        publicTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[[publicTableViewCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            UIImageView*imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dial_Callhistory_bg"]];
            
            cell.backgroundView =  imageView;
            
            cell.m_img1.frame = CGRectMake(172, 35, 11, 11);
            
            cell.m_string6.frame = CGRectMake(15, 5, 200, 20);
            cell.m_string6.font = [UIFont boldSystemFontOfSize:15.0f];
            cell.m_string6.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
            
            cell.m_string2.frame = CGRectMake(15, 30, 80, 20);
            cell.m_string2.font = [UIFont systemFontOfSize:11.0f];
            cell.m_string2.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
            
            cell.m_string3.frame = CGRectMake(102, 30, 75, 20);
            cell.m_string3.font = [UIFont systemFontOfSize:11.0f];
            cell.m_string3.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];

            cell.m_string4.frame = CGRectMake(230, 5, 75, 20);
            cell.m_string4.font = [UIFont systemFontOfSize:11.0f];
            cell.m_string4.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
            cell.m_string4.textAlignment = NSTextAlignmentRight;

            cell.m_string5.frame = CGRectMake(220, 30, 85, 20);
            cell.m_string5.font = [UIFont systemFontOfSize:11.0f];
            cell.m_string5.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
            cell.m_string5.textAlignment = NSTextAlignmentRight;
        }
        
        cell.m_string6.text = [NSString stringWithFormat:@"%@ (%@次)",[[m_callRecords objectAtIndex:indexPath.row] objectAtIndex:1],[[m_callRecords objectAtIndex:indexPath.row] objectAtIndex:9]];
        cell.m_string1.hidden = YES;
        cell.m_string1.text = [[m_callRecords objectAtIndex:indexPath.row] objectAtIndex:1];
        cell.m_string2.text = [[m_callRecords objectAtIndex:indexPath.row] objectAtIndex:2];
        cell.m_string3.text = [[m_callRecords objectAtIndex:indexPath.row] objectAtIndex:3];
        //cell.m_string4.text = [[m_callRecords objectAtIndex:indexPath.row] objectAtIndex:5];
        cell.m_string5.text = [[m_callRecords objectAtIndex:indexPath.row] objectAtIndex:8];
        cell.m_img1.image = [UIImage imageNamed:@"dialOut.png"];
        return cell;
    }
    else if (tableView.tag==1)
    {
        static NSString *CellIdentifier = @"Cell";
        publicTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[[publicTableViewCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            UIImageView*imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dial_Callhistory_bg"]];
            
            cell.backgroundView =  imageView;
            cell.m_string1.frame = CGRectMake(15, 5, 200, 20);
            cell.m_string1.font = [UIFont boldSystemFontOfSize:15.0f];
            cell.m_string1.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
            
            cell.m_string2.frame = CGRectMake(15, 30, 200, 20);
            cell.m_string2.font = [UIFont systemFontOfSize:11.0f];
            cell.m_string2.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
            
            cell.m_string3.frame = CGRectMake(202, 30, 100, 20);
            cell.m_string3.font = [UIFont systemFontOfSize:11.0f];
            cell.m_string3.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
            cell.m_string3.textAlignment = NSTextAlignmentRight;
        }
        NSDictionary *person=[m_filteredArray objectAtIndex:indexPath.row];
        NSString *sname = [[person objectForKey:@"name"] stringByReplacingOccurrencesOfString:@" " withString:@""];
        cell.m_string1.text= sname;
        NSString * iPhone = [person objectForKey:@"phone"];
        iPhone = [iPhone stringByReplacingOccurrencesOfString:@"+86" withString:@""];
        iPhone = [iPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
        iPhone = [iPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
        cell.m_string2.text = iPhone;
        cell.m_string3.text = [[Utility shareInstance] selectInfoByPhone:iPhone];
        return cell;
    }
    return nil;
}
//行高。
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0)
    {
        return 50;
    }
    else if (tableView.tag==1)
    {
        return 50;
    }
    return 0;
}
//点击进入好友详细资料。
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    publicTableViewCell1 *cell = (publicTableViewCell1 *)[tableView cellForRowAtIndexPath:indexPath];
    [Utility shareInstance].u_calledName = cell.m_string1.text;
    [Utility shareInstance].u_calledNumber = cell.m_string2.text;

  
    NSString *itype = [Utility shareInstance].u_dialWay;
    if ( [itype isEqualToString:@"0"] )//智能拨打
    {
        if ( [[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable )
        {
            [Utility shareInstance].u_calledHuiboOrZhibo = @"0";
            [[Utility shareInstance] callPhonaPage:self];
        }
        else
        {
            [Utility shareInstance].u_calledHuiboOrZhibo = @"1";
            [[Utility shareInstance] callPhonaPage:self];
        }
    }//回拨
    else if ( [itype isEqualToString:@"1"] )
    {
        [Utility shareInstance].u_calledHuiboOrZhibo = @"1";
        [[Utility shareInstance] callPhonaPage:self];
    }//直拨
    else if ( [itype isEqualToString:@"2"] )
    {
        [Utility shareInstance].u_calledHuiboOrZhibo = @"0";
        [[Utility shareInstance] callPhonaPage:self];
        
    }//手动选择
    else if ( [itype isEqualToString:@"3"] )
    {
        CallSelectView *view = [CallSelectView defaultPopupView];
        view.parentVC = self;
        view.delegate = self;
        LewPopupViewAnimationSlide *animation = [[LewPopupViewAnimationSlide alloc]init];
        animation.type = LewPopupViewAnimationSlideTypeBottomBottomEdge;
        [self lew_presentPopupView:view animation:animation dismissed:^{
        
        }];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)callSelect:(NSInteger)tag
{
    if (tag == 0) {
        //免费电话
        [Utility shareInstance].u_calledHuiboOrZhibo = @"0";
        [[Utility shareInstance] callPhonaPage:self];
    }else{
        //普通电话
        [Utility shareInstance].u_calledHuiboOrZhibo = @"1";
        [[Utility shareInstance] callPhonaPage:self];    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0)
    {
        return UITableViewCellEditingStyleDelete;
    }
    else if (tableView.tag==1)
    {
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleNone;
}
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        publicTableViewCell1 *cell = (publicTableViewCell1 *)[tableView cellForRowAtIndexPath:indexPath];
        NSString *sql1 = [NSString stringWithFormat:@"DELETE FROM %@ WHERE s_phone = '%@'",CALLRECORDS,cell.m_string2.text];
        sql1 = [sql1 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
        [[Utility shareInstance] sql_inser_data:sql1,nil];
        [m_callRecords removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}




-(void)searchingAddressList:(NSString*)istring
{
    istring = [istring stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if (istring.length<=0)
    {
        UITableView *tableView = (UITableView *)[self.view viewWithTag:1];
        [tableView setHidden:YES];
    }
    else
    {
        UITableView *tableView = (UITableView *)[self.view viewWithTag:1];
        [tableView setHidden:NO];
       [self performSelectorOnMainThread:@selector(znSearchWithString:) withObject:istring waitUntilDone:YES];
    }
}


- (void)znSearchWithString:(NSString *)searchString
{
    [m_filteredArray removeAllObjects];
    
    if ([searchString rangeOfRegex:@"1"].location == 0 || [searchString rangeOfRegex:@"0"].location == 0) {
        [self searchWithString:searchString];
        NSLog(@"searchString = %@",searchString);
    }else{
        //保存数字对应的拼音
        NSMutableArray *searchPinyin = [[NSMutableArray alloc]init];
        //取出每个拼音保存到数组
        for (int i = 0; i < searchString.length; i++) {
            NSRange rang = NSMakeRange(i, 1);
            NSString *num = [searchString substringWithRange:rang];
            if (![num isEqualToString:@"0"] && ![num isEqualToString:@"1"]) {
                NSString *a = [m_DialAphla objectForKey:num];
                 NSLog(@"输入字母 = %@",a);
                [searchPinyin addObject:a];
               
            }
            
        }
        //组合拼音
        NSString *str1 = @"";
        NSString *str2 = @"";
        NSString *str3 = @"";
        NSString *str_group = @"";
        
        for (int i = 0; i < [searchPinyin count] && i < 3; i++) {
            if (i == 0) {
                str1 = searchPinyin[0];
            }else if (i == 1){
                str2 = searchPinyin[1];
            }else if(i == 2){
                str3 = searchPinyin[2];
            }
        }
        
        for (int i = 0; i < str1.length; i++) {
            
            
            NSRange range1 = NSMakeRange(i, 1);
            NSString *a1 = [str1 substringWithRange:range1];
            str_group = a1;
            
            if ([searchPinyin count] == 1) {
                [self searchWithString:str_group];
            }
            for (int k = 0; k < str2.length; k++) {
                
                NSRange range2 = NSMakeRange(k, 1);
                NSString *a2 = [str2 substringWithRange:range2];
                str_group = [NSString stringWithFormat:@"%@%@",a1,a2];
                if ([searchPinyin count] == 2) {
                    [self searchWithString:str_group];
                }
                for (int j = 0; j < str3.length; j++) {
                    
                    NSRange range3 = NSMakeRange(j, 1);
                    NSString *a3 = [str3 substringWithRange:range3];
                    str_group = [NSString stringWithFormat:@"%@%@%@",a1,a2,a3];
                    if ([searchPinyin count] == 2) {
                        [self searchWithString:str_group];
                    }
                }
                
            }
            
        }
        
    }
    
}

#pragma mark -
#pragma mark - 处理号码
-(void)loadContacts
{
//    if ([Utility shareInstance].u_bool)
//    {
//        [m_phoneDic removeAllObjects];
//        ABAddressBookRef myAddressBook = [Utility shareInstance].u_addressBook;
//        CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(myAddressBook);
//        CFMutableArrayRef mresults=CFArrayCreateMutableCopy(kCFAllocatorDefault,CFArrayGetCount(results),results);
//        //遍历所有联系人
//        for (int k=0;k<CFArrayGetCount(mresults);k++)
//        {
//            ABRecordRef record=CFArrayGetValueAtIndex(mresults,k);
//            ABMultiValueRef phone = ABRecordCopyValue(record, kABPersonPhoneProperty);
//            ABRecordID recordID=ABRecordGetRecordID(record);
//            //得到手机号码
//            for (int k = 0; k<ABMultiValueGetCount(phone); k++)
//            {
//                NSString * iPhone = (NSString*)ABMultiValueCopyValueAtIndex(phone, k);
//                iPhone = [iPhone stringByReplacingOccurrencesOfString:@"+86" withString:@""];
//                iPhone = [iPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
//                iPhone = [iPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
//                if ([iPhone isMatchedByRegex:@"^(13|15|18|17|14)\\d{9}$"])
//                {
//                    [m_phoneDic setObject:record forKey:[NSString stringWithFormat:@"%@%d",iPhone,recordID]];
//                }
//            }
//        }
//    }
    
    [m_sectionDic removeAllObjects];
    [m_phoneDic removeAllObjects];
    
    if ([Utility shareInstance].u_bool)
    {
        for (int i = 0; i < ALPHA.length-1; i++)
        {
            [m_sectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'A'+i]];
        }
        [m_sectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'#']];
        
        ABAddressBookRef myAddressBook = [Utility shareInstance].u_addressBook;
        CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(myAddressBook);
        CFMutableArrayRef mresults=CFArrayCreateMutableCopy(kCFAllocatorDefault,CFArrayGetCount(results),results);
        CFArraySortValues(mresults,CFRangeMake(0, CFArrayGetCount(results)),(CFComparatorFunction) ABPersonComparePeopleByName,(void*) ABPersonGetSortOrdering());
        
        //遍历所有联系人
        for (int k=0;k<CFArrayGetCount(mresults);k++)
        {
            ABRecordRef record=CFArrayGetValueAtIndex(mresults,k);
            NSString *personname = (NSString *)ABRecordCopyCompositeName(record);
            ABMultiValueRef phone = ABRecordCopyValue(record, kABPersonPhoneProperty);
            ABRecordID recordID=ABRecordGetRecordID(record);
            //得到手机号码
            for (int k = 0; k<ABMultiValueGetCount(phone); k++)
            {
                NSString * iPhone = (NSString*)ABMultiValueCopyValueAtIndex(phone, k);
                iPhone = [iPhone stringByReplacingOccurrencesOfString:@"+86" withString:@""];
                iPhone = [iPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
                iPhone = [iPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
                if (![iPhone isMatchedByRegex:@"^(13|15|18|17|14)\\d{9}$"])
                {
                    continue;
                }
                else
                {
                    [m_phoneDic setObject:record forKey:[NSString stringWithFormat:@"%@%d",iPhone,recordID]];
                }
                
                char first=pinyinFirstLetter([personname characterAtIndex:0]);
                NSString *sectionName;
                if ((first>='a'&&first<='z')||(first>='A'&&first<='Z'))
                {
                    if([self searchResult:personname searchText:@"曾"])
                        sectionName = @"Z";
                    else if([self searchResult:personname searchText:@"解"])
                        sectionName = @"X";
                    else if([self searchResult:personname searchText:@"仇"])
                        sectionName = @"Q";
                    else if([self searchResult:personname searchText:@"朴"])
                        sectionName = @"P";
                    else if([self searchResult:personname searchText:@"查"])
                        sectionName = @"Z";
                    else if([self searchResult:personname searchText:@"能"])
                        sectionName = @"N";
                    else if([self searchResult:personname searchText:@"乐"])
                        sectionName = @"Y";
                    else if([self searchResult:personname searchText:@"单"])
                        sectionName = @"S";
                    else
                        sectionName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([personname characterAtIndex:0])] uppercaseString];
                }
                else
                {
                    sectionName=[[NSString stringWithFormat:@"%c",'#'] uppercaseString];
                }
                [[m_sectionDic objectForKey:sectionName] addObject:[NSArray arrayWithObjects:record,[NSNumber numberWithInt:k],nil]];
            }
        }
        for (int i = 0; i < [[m_sectionDic allKeys] count]; i++)
        {
            NSString *ikey = [NSString stringWithFormat:@"%c",'A'+i];
            if ( [[m_sectionDic objectForKey:ikey] count] == 0 )
            {
                [m_sectionDic removeObjectForKey:ikey];
            }
        }
        if ( [[m_sectionDic objectForKey:@"#"] count] == 0 )
        {
            [m_sectionDic removeObjectForKey:@"#"];
        }
    }

    else
    {
        [self performSelector:@selector(loadContacts) withObject:nil afterDelay:0.1f];
    }
}
-(void)searchWithString:(NSString *)searchString
{
    //[m_filteredArray removeAllObjects];
    NSString * regex = @"(^[0-9]+$)";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([searchString length]!=0)
    {
        //判断是否是数字
        if ([pred evaluateWithObject:searchString])
        {
            NSArray *phones=[m_phoneDic allKeys];
            for (NSString *phone in phones)
            {
                if ([self searchResult:phone searchText:searchString])
                {
                    ABRecordRef person=[m_phoneDic objectForKey:phone];
                    ABRecordID recordID=ABRecordGetRecordID(person);
                    NSString *ff=[NSString stringWithFormat:@"%d",recordID];
                    NSString *name=(NSString *)ABRecordCopyCompositeName(person);
                    name = [NSString stringWithFormat:@"%@",name];
                    name = [name stringByReplacingOccurrencesOfString:@"(null)" withString:@"未设名称"];
                    NSMutableDictionary *record=[[NSMutableDictionary alloc] init];
                    [record setObject:name forKey:@"name"];
                    [record setObject:[phone substringToIndex:(phone.length-ff.length)] forKey:@"phone"];
                    [record setObject:[NSNumber numberWithInt:recordID] forKey:@"ID"];
                    [m_filteredArray addObject:record];
                    [record release];
                }
            }
        }else{
        
            //搜索对应分类下的数组
            NSString *sectionName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([searchString characterAtIndex:0])] uppercaseString];
            NSArray *array=[m_sectionDic objectForKey:sectionName];
            for (int j=0;j<[array count];j++)
            {
                ABRecordRef person=[[array objectAtIndex:j] objectAtIndex:0];
                int n = [[[array objectAtIndex:j] objectAtIndex:1] intValue];
                NSString *name=(NSString *)ABRecordCopyCompositeName(person);
                if ([self searchResult:name searchText:searchString])
                {
                    //先按输入的内容搜索
                    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
                    NSString * personPhone = (NSString*)ABMultiValueCopyValueAtIndex(phone, n);
                    ABRecordID recordID=ABRecordGetRecordID(person);
                    NSMutableDictionary *record=[[NSMutableDictionary alloc] init];
                    [record setObject:name forKey:@"name"];
                    [record setObject:personPhone forKey:@"phone"];
                    [record setObject:[NSNumber numberWithInt:recordID] forKey:@"ID"];
                    [m_filteredArray addObject:record];
                    [record release];
                }
                else
                {
                    //按拼音搜索
                    NSString *string = @"";
                    NSString *firststring=@"";
                    for (int i = 0; i < [name length]; i++)
                    {
                        if([string length] < 1)
                            string = [NSString stringWithFormat:@"%@", [POAPinyin quickConvert:[name substringWithRange:NSMakeRange(i,1)]]];
                        else
                            string = [NSString stringWithFormat:@"%@%@",string, [POAPinyin quickConvert:[name substringWithRange:NSMakeRange(i,1)]]];
                        if([firststring length] < 1)
                        {
                            firststring = [NSString stringWithFormat:@"%c", pinyinFirstLetter([name characterAtIndex:i])];
                        }
                        else
                        {
                            if ([name characterAtIndex:i]!=' ')
                            {
                                firststring = [NSString stringWithFormat:@"%@%c",firststring,pinyinFirstLetter([name characterAtIndex:i])];
                            }
                        }
                    }
                    if ([self searchResult:string searchText:searchString]||[self searchResult:firststring searchText:searchString])
                    {
                        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
                        NSString * personPhone = (NSString*)ABMultiValueCopyValueAtIndex(phone, n);
                        ABRecordID recordID=ABRecordGetRecordID(person);
                        NSMutableDictionary *record=[[NSMutableDictionary alloc] init];
                        [record setObject:name forKey:@"name"];
                        [record setObject:personPhone forKey:@"phone"];
                        [record setObject:[NSNumber numberWithInt:recordID] forKey:@"ID"];
                        [m_filteredArray addObject:record];
                        [record release];
                    }
                }
            }
        

        
        
        }
    }
    UITableView *tableView = (UITableView *)[self.view viewWithTag:1];
    [tableView reloadData];
}
-(BOOL)searchResult:(NSString *)contactName searchText:(NSString *)searchT
{
	NSComparisonResult result = [contactName compare:searchT options:NSCaseInsensitiveSearch range:NSMakeRange(0, searchT.length)];
	if (result == NSOrderedSame)
		return YES;
	else
		return NO;
}




- (void)dealloc
{
    [m_phoneDic release];
    [m_filteredArray release];
    [m_sectionDic release];
    [_tableViewCallLog release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableViewCallLog:nil];
    [super viewDidUnload];
}
@end
