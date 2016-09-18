//
//  CallPageViewController.m
//  VOIP
//
//  Created by apple on 14-4-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CallPageViewController.h"


extern CallPageViewController *m_CallPageViewController;
extern SystemSoundID beepSound12;

@implementation CallPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//日期转字符串
- (NSString * )NSDateToNSString: (NSDate * )date
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"MM-dd HH:mm"];
    NSString *dateString = [formatter stringFromDate:date];
    [formatter release];
    return dateString;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //广告拨打界面
   // [self get_image];//得到图片
   
    m_CallPageViewController = self;
    
    if ([[Utility shareInstance].u_beforeCallMusic isEqualToString:@"0"])
    {
          //音效模式
//        NSBundle *mainBundle = [NSBundle mainBundle];
//        AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[mainBundle pathForResource:@"ring" ofType:@"mp3"] isDirectory:NO], &beepSound12);
//        AudioServicesPlaySystemSound(beepSound12);
        NSString*musicFilePath=[[NSBundle mainBundle]pathForResource:@"ring" ofType:@"mp3"];//创建音乐文件路径
        NSURL*musicURL=[[NSURL alloc]initFileURLWithPath:musicFilePath];
        AVAudioPlayer*thePlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:musicURL error:nil];
        
        //创建播放器
        m_player=thePlayer;//赋值给自己定义的类变量
        m_player.numberOfLoops=MAXFLOAT;
        [m_player prepareToPlay];
        [m_player setVolume:1.0];
        [m_player play];
        
        [musicURL release];
        //[thePlayer  release];
        //听筒模式
       // [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        
    }
    
    if ([[Utility shareInstance].u_calledName isEqualToString:[Utility shareInstance].u_calledNumber])
    {
        self.m_label3.hidden = YES;
        self.m_label4.text = [Utility shareInstance].u_calledNumber;
        self.m_label5.text = [[Utility shareInstance] selectInfoByPhone:self.m_label4.text];
    }
    else
    {
        self.m_label3.text = [Utility shareInstance].u_calledName;
        self.m_label4.text = [Utility shareInstance].u_calledNumber;
        self.m_label5.text = [[Utility shareInstance] selectInfoByPhone:self.m_label4.text];
    }
    
    self.m_label3.text = [Utility shareInstance].u_calledName;
    self.m_label4.text = [Utility shareInstance].u_calledNumber;
    self.m_label5.text = [[Utility shareInstance] selectInfoByPhone:self.m_label4.text];
    
    NSDate *tomorrow = [NSDate dateWithTimeIntervalSinceNow:0];
    [Utility shareInstance].u_calledTime = [self NSDateToNSString:tomorrow];
    [Utility shareInstance].u_calledOutOrIn = @"0";
    
    [self dial_request];
}





//这个是唐工给的拨打界面的图片的方法代码
//获取图片
//- (void)get_image{
//    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//沙盒
//    NSString *path = [documents[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",CALL_AD,CALL_AD_PLIST]];//路径
//    //图片信息
//    NSArray *array = [NSArray arrayWithContentsOfFile:path];
//    
//    if (array != nil && array.count > 0) {
//        
//        
//        int i = arc4random() % (array.count); //随机函数
//        
//        NSDictionary *dict = array[i];
//        NSString * imageName = dict[@"p_img_full"];
//        NSString *path = [documents[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",CALL_AD,imageName]];//读取路径图片的名字
//        UIImage *image = [UIImage imageWithContentsOfFile:path];
//        [self.call_image setImage:image];
//    }
//    
//}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dial_request
{
    NSMutableArray *insm = [NSMutableArray array];
    [insm addObject:@"call_cmd"];
    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Ret",nil];
    [insm addObject:ixml];
    NSString *iurl ;
    if ([[Utility shareInstance].u_callShow isEqualToString:@"0"])
    {
        iurl = [NSString stringWithFormat:@"http://%@/api/subcalltask.php?caller=%@&called=%@",IP,[Utility shareInstance].u_account,[Utility shareInstance].u_calledNumber];
    }
    else
    {
        iurl = [NSString stringWithFormat:@"http://%@/api/subcalltask.php?caller=%@&called=9%@",IP,[Utility shareInstance].u_account,[Utility shareInstance].u_calledNumber];
    }
    [insm addObject:iurl];
    m_request = [[HttpDataRequests alloc] init:insm];
    m_request.delegate = self;
    }


-(void) dial_request2
{
    NSMutableArray *insm = [NSMutableArray array];
    [insm addObject:@"call_cmd"];
    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Ret",nil];
    [insm addObject:ixml];
    NSString *iurl ;
    if ([[Utility shareInstance].u_callShow isEqualToString:@"0"])
    {
        iurl = [NSString stringWithFormat:@"http://120.76.78.99:5060/chs/callback.jsp?caller=%@&callees=%@&number=10018&password=10018wap",[Utility shareInstance].u_account,[Utility shareInstance].u_calledNumber];
    }
    else
    {
        iurl = [NSString stringWithFormat:@"http://120.76.78.99:5060/chs/callback.jsp?caller=%@&callees=9%@&number=10018&password=10018wap",[Utility shareInstance].u_account,[Utility shareInstance].u_calledNumber];
    }
//    [insm addObject:iurl];
//    m_request = [[HttpDataRequests alloc] init:insm];
//    m_request.delegate = self;
    NSURL *url = [NSURL URLWithString:iurl];
    ASIHTTPRequest *request  = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];//异步请求

    
}


-(void)HttpCallBack:(id)adata atag:(InternetState)atag acmd:(NSString*)acmd
{
    if (![[Utility getError:atag] isEqualToString:@"OK"] )
    {
        [Utility shareInstance].u_calledState = @"0";
        [[iToast makeToast:[Utility getError:atag]] show];
        self.m_label1.text = [Utility getError:atag];
        self.m_label2.hidden = YES;
        [self performSelector:@selector(closePage1) withObject:nil afterDelay:2.0f];
    }
    else
    {
        if ([acmd isEqualToString:@"call_cmd"])
        {
            if ( ![[Utility getErrorCALL:[[adata objectForKey:@"Ret"] intValue]] isEqualToString:@"OK"] )
            {
                [Utility shareInstance].u_calledState = @"1";
                [[iToast makeToast:@"呼叫失败，请重新呼叫!"] show];
                self.m_label1.text = @"呼叫失败，请重新呼叫!";
                self.m_label2.hidden = YES;
                self.m_label6.text=@"呼叫失败";
                [self performSelector:@selector(closePage1) withObject:nil afterDelay:2.0f];
            }
            else
            {
                [Utility shareInstance].u_calledState = @"2";
                self.m_label1.text = @"提醒您 电话正在接通中";
                self.m_label6.text=@"呼叫成功";
                [self performSelector:@selector(timeCallBack) withObject:nil afterDelay:1.0f];
            }
        }
    }
    [self inserData];
    m_request.delegate=nil;
    [m_request release];
    m_request = nil;
}
-(void)timeCallBack
{
    int is = [self.m_label2.text intValue]-1 ;
    if (is>=0)
    {
        self.m_label2.text = [NSString stringWithFormat:@"%d",is];
        [self performSelector:@selector(timeCallBack) withObject:nil afterDelay:1.0f];
    }
    else
    {
        [self closePage1];
    }
}
/*
名字 s_name     [Utility shareInstance].u_calledName
手机号 s_phone       [Utility shareInstance].u_calledNumber
时间 s_callTime     [Utility shareInstance].u_calledTime
状态 s_outOrIn      [Utility shareInstance].u_calledOutOrIn     0呼出 1打入
拨打时长 s_duration       [Utility shareInstance].u_calledDuration    默认0
直拨还是回拨 s_huiboOrZhibo     [Utility shareInstance].u_calledHuiboOrZhibo  0代表直拨 1回拨 2系统呼出
拨打成功或失败状态 s_callstate   [Utility shareInstance].u_calledState     0代表没有网 1是返回失败 2是成功
 */
-(void)inserData
{
    NSString *acreate = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ROW INTEGER PRIMARY KEY,s_name,s_phone,s_callTime,s_outOrIn,s_duration,s_huiboOrZhibo,s_callstate,s_affiliation)",CALLRECORDS];
    NSString *ainsert = [NSString stringWithFormat:@"INSERT INTO %@ (s_name,s_phone,s_callTime,s_outOrIn,s_duration,s_huiboOrZhibo,s_callstate,s_affiliation) VALUES('%@','%@','%@','%@','%@','%@','%@','%@')",CALLRECORDS,[Utility shareInstance].u_calledName,[Utility shareInstance].u_calledNumber,[Utility shareInstance].u_calledTime,[Utility shareInstance].u_calledOutOrIn,[Utility shareInstance].u_calledDuration,[Utility shareInstance].u_calledHuiboOrZhibo,[Utility shareInstance].u_calledState,self.m_label5.text];
    ainsert = [ainsert stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    [[Utility shareInstance] sql_inser_data:acreate,ainsert,nil];
}

-(void)closePage1
{
    // AudioServicesDisposeSystemSoundID(beepSound12);
    if (m_player != nil && m_player.isPlaying) {
        [m_player pause];
        [m_player stop];
        [m_player release];
        m_player = nil;
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)closePage2
{
    if (m_player != nil && m_player.isPlaying) {
        [m_player pause];
        [m_player stop];
        [m_player release];
        m_player = nil;
    }
  //  AudioServicesDisposeSystemSoundID(beepSound12);
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)bt_theEndOfThe:(id)sender {
    [[iToast makeToast:@"结束"] show];
    [self closePage1];
}



- (void)dealloc
{
    NSLog(@"通话界面销毁");
 // AudioServicesDisposeSystemSoundID(beepSound12);
    if (m_player != nil && m_player.isPlaying) {
        [m_player pause];
        [m_player stop];
        [m_player release];
        m_player = nil;
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    m_CallPageViewController = nil;
    [_m_label1 release];
    [_m_label3 release];
    [_m_label4 release];
    [_m_label5 release];
  //  [_call_image release];
    [_m_label6 release];
    [super dealloc];
}

//请求开始
- (void)requestStarted:(ASIHTTPRequest *)request
{
    //NSLog(@"请求开始");
    
}

//请求完成
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSLog(@"%@",[request responseString]);
    
    NSString *returnContent = [request responseString];
    if (returnContent) {
        NSArray *array = [returnContent componentsSeparatedByString:@"|"];
        if (![array[0] isEqualToString:@"0"]) {
            [Utility shareInstance].u_calledState = @"1";
            [[iToast makeToast:@"呼叫失败，请重新呼叫!"] show];
            self.m_label1.text = @"呼叫失败，请重新呼叫!";
            self.m_label2.hidden = YES;
            [self performSelector:@selector(closePage1) withObject:nil afterDelay:2.0f];
        }else
        {
            [Utility shareInstance].u_calledState = @"2";
            self.m_label1.text = @"正在为您接通，请注意回铃。。。";
            [self performSelector:@selector(timeCallBack) withObject:nil afterDelay:1.0f];
        }
    }
    [self inserData];
    
}

//请求失败
- (void)requestFailed:(ASIHTTPRequest *)request
{
    
    [Utility shareInstance].u_calledState = @"1";
    [[iToast makeToast:@"呼叫失败，请检查网络!"] show];
    self.m_label1.text = @"呼叫失败，请检查网络!";
    self.m_label2.hidden = YES;
    [self performSelector:@selector(closePage1) withObject:nil afterDelay:2.0f];
    
    NSLog(@"请求失败");
}




- (void)viewDidUnload {
  //  [self setCall_image:nil];
    [self setM_label6:nil];
    [super viewDidUnload];
}
@end
