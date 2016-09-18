//
//  CallPageViewController2.m
//  VOIP
//
//  Created by apple on 14-6-3.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CallPageViewController2.h"

@implementation CallPageViewController2

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

    //解决IOS7上的显示问题。
    if ( !IOS_VERSION_7_OR_ABOVE )
    {
        for(id view in self.view.subviews)
        {
            UIView *ithis = (UIView*)view;
            ithis.frame = CGRectMake(ithis.frame.origin.x, ithis.frame.origin.y-20, ithis.frame.size.width, ithis.frame.size.height);
        }
    }
    
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    
    //处理直拨
    NSString *displayName = nil;
    if([LinphoneManager isLcReady])
    {
        ABRecordRef contact = [[[LinphoneManager instance] fastAddressBook] getContact:[Utility shareInstance].u_calledNumber];
        if(contact)
        {
            displayName = [FastAddressBook getContactDisplayName:contact];
        }
        [[LinphoneManager instance] call:[Utility shareInstance].u_calledNumber displayName:displayName transfer:FALSE];
    }
    
    if (displayName == nil)
    {
        [Utility shareInstance].u_calledName = @"未知号码";
    }
    else
    {
        [Utility shareInstance].u_calledName = displayName;
    }
    self.m_label3.text = [Utility shareInstance].u_calledName;
    self.m_label4.text = [Utility shareInstance].u_calledNumber;
    self.m_label5.text = [[Utility shareInstance] selectInfoByPhone:self.m_label4.text];
    
    NSDate *tomorrow = [NSDate dateWithTimeIntervalSinceNow:0];
    [Utility shareInstance].u_calledTime = [self NSDateToNSString:tomorrow];
    [Utility shareInstance].u_calledOutOrIn = @"0";
    
    [Utility shareInstance].u_calledState = @"2";
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    NSLog(@"通话界面销毁");
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    [_m_label1 release];
    [_m_label2 release];
    [_m_label3 release];
    [_m_label4 release];
    [_m_label5 release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setM_label1:nil];
    [self setM_label2:nil];
    [self setM_label3:nil];
    [self setM_label4:nil];
    [self setM_label5:nil];
    [super viewDidUnload];
}
- (IBAction)bt_theEndOfThe:(id)sender
{
    if([LinphoneManager isLcReady])
    {
        [self inserData];
        [Utility shareInstance].u_calledDuration = nil;
        
        [[iToast makeToast:@"结束"] show];
        [self dismissViewControllerAnimated:NO completion:nil];
        
        LinphoneCore* lc = [LinphoneManager getLc];
        LinphoneCall* currentcall = linphone_core_get_current_call(lc);
        if (linphone_core_is_in_conference(lc) || // In conference
            (linphone_core_get_conference_size(lc) > 0 && [CallPageViewController2 callCount:lc] == 0) // Only one conf
            )
        {
            linphone_core_terminate_conference(lc);
        }
        else if(currentcall != NULL)
        { // In a call
            linphone_core_terminate_call(lc, currentcall);
        }
        else
        {
            const MSList* calls = linphone_core_get_calls(lc);
            if (ms_list_size(calls) == 1)
            { // Only one call
                linphone_core_terminate_call(lc,(LinphoneCall*)(calls->data));
            }
        }
    }
}

- (IBAction)bt_handsFree:(id)sender
{
    if ([LinphoneManager instance].speakerEnabled)
    {
//        UIColor *icolor = [UIColor colorWithRed:20.0f/255.0f green:160.0f/255.0f blue:60.0f/255.0f alpha:1.0f];
        UIButton *ib = (UIButton *)sender;
        [ib setBackgroundImage:[UIImage imageNamed:@"dial_page2_HF-button_n" ] forState:UIControlStateNormal];
        [[LinphoneManager instance] setSpeakerEnabled:FALSE];
    }
    else
    {
        UIButton *ib = (UIButton *)sender;
        [ib setBackgroundImage:[UIImage imageNamed:@"dial_page2_HF-button-_s" ] forState:UIControlStateNormal];
        [[LinphoneManager instance] setSpeakerEnabled:TRUE];
    }
}

- (IBAction)bt_muteSwitch:(id)sender
{
    UIMicroButton *ib = (UIMicroButton *)sender;
    if ( [ib onUpdate] )
    {
//        UIColor *icolor = [UIColor colorWithRed:20.0f/255.0f green:160.0f/255.0f blue:60.0f/255.0f alpha:1.0f];
//        [ib setBackgroundColor:icolor];
 [ib setBackgroundImage:[UIImage imageNamed:@"dial_page2_mute-button_n" ] forState:UIControlStateNormal];
        
        [ib onOn];
    }
    else
    {
       // [ib setBackgroundColor:[UIColor redColor]];
       [ib setBackgroundImage:[UIImage imageNamed:@"dial_page2_mute_button_s" ] forState:UIControlStateNormal];
        
        [ib onOff];
    }
}

- (IBAction)bt_callPause:(id)sender
{
    UIPauseButton *ib = (UIPauseButton *)sender;
    if ( ib.tag ==1 )
    {
        ib.tag =2;
        NSLog(@"1111111111111");
        UIColor *icolor = [UIColor colorWithRed:20.0f/255.0f green:160.0f/255.0f blue:60.0f/255.0f alpha:1.0f];
        [ib setBackgroundColor:icolor];
        [ib onOn];
    }
    else
    {
        ib.tag =1;
        NSLog(@"222222222222");
        [ib setBackgroundColor:[UIColor redColor]];
        [ib onOff];
    }
}

+ (bool)isInConference:(LinphoneCall*) call
{
    if (!call)
        return false;
    return linphone_call_is_in_conference(call);
}
+ (int)callCount:(LinphoneCore*) lc
{
    int count = 0;
    const MSList* calls = linphone_core_get_calls(lc);
    
    while (calls != 0)
    {
        if (![CallPageViewController2 isInConference:((LinphoneCall*)calls->data)])
        {
            count++;
        }
        calls = calls->next;
    }
    return count;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(callUpdate:)
                                                 name:kLinphoneCallUpdate
                                               object:nil];//通知中心
    
    updateTime = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(update)
                                                userInfo:nil
                                                 repeats:YES];//计算时间
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kLinphoneCallUpdate
                                                  object:nil];
    
    if (updateTime != nil) {
        [updateTime invalidate];
        updateTime = nil;
    }
}

- (void)update
{
    LinphoneCore* lc = [LinphoneManager getLc];
    LinphoneCall* call = linphone_core_get_current_call(lc);
    if(call)
    {
        int duration = linphone_call_get_duration(call);
        self.m_label2.text = [NSString stringWithFormat:@"%02i:%02i", (duration/60), duration - 60 * (duration / 60), nil];
        
        if ( duration > 0 && duration < 60)
        {
            [Utility shareInstance].u_calledDuration = [NSString stringWithFormat:@"%d秒",duration];
        }
        else if (duration >=60 && duration < 3600)
        {
            [Utility shareInstance].u_calledDuration = [NSString stringWithFormat:@"%d分%d秒",duration/60,duration%60];
        }
        else if (duration >= 3600)
        {
            [Utility shareInstance].u_calledDuration = [NSString stringWithFormat:@"%d时%d分%d秒",duration/3600,(duration%3600)/60,(duration%3600)%60];
        }
    }
    else
    {
        [LinphoneLogger logc:LinphoneLoggerWarning format:"Cannot update call cell: null call or data"];
    }
}

- (void)callUpdate:(NSNotification*)notif {
    LinphoneCallState state = [[notif.userInfo objectForKey: @"state"] intValue];
    switch (state)
    {
		case LinphoneCallConnected:
            self.m_label1.text = @"已接通";
            break;
        case LinphoneCallError:
		case LinphoneCallEnd:
            [self bt_theEndOfThe:nil];
			break;
        default:
            break;
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

@end
