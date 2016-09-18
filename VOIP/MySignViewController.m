//
//  MySignViewController.m
//  Move
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MySignViewController.h"
#import "FDCalendar.h"
#import "ItemHelpViewController.h"

@interface MySignViewController ()<HttpDataRequestsDelegate>
{
    HttpDataRequests *m_request;
    HttpDataRequests *m_request1;
    HttpDataRequests *m_request2;
    UILabel*signLabel1;
    UILabel*signLabel4;
    UILabel*centersignLabel;
    UILabel*centersignLabel2;
    UILabel*centersignLabel4;
    UILabel*centersignLabel7;
    UIButton *viewButton1;
    UIButton *viewButton2;
    NSString*staryStr;
    
    
    
}
@property (retain, nonatomic)  UIScrollView *ScrollView;

@property (retain, nonatomic)FDCalendar *calendar;

@end

@implementation MySignViewController
-(void)dealloc{
    [super dealloc];
    [m_request release];
    [m_request1 release];
    [m_request2 release];
    [signLabel1 release];
    [signLabel4 release];
    [centersignLabel release];
    [centersignLabel2 release];
    [centersignLabel4 release];
    [centersignLabel7 release];
    [viewButton1 release];
    [viewButton2 release];
    [staryStr release];
    [_ScrollView release];
    [_calendar release];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addAavigationView:@"签到中心" aback:@"back.png"];
    [self adaptiveIos1];
    _ScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,kDeviceWidth, kDeviceHeight-64)];
    _ScrollView.showsHorizontalScrollIndicator=NO;
    _ScrollView.showsVerticalScrollIndicator=NO;
    _ScrollView.scrollsToTop=NO;
    _ScrollView.bounces = NO;
    
    
    
    _ScrollView.contentSize=CGSizeMake(kDeviceWidth, kDeviceHeight+100);
    
    [self.view addSubview:_ScrollView];
    
   [self requestDate];
    
    [self addSubShowView];
    
    
    
    
}

-(void)addSubShowView{
    UIView*topBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 171.0)];
    topBackView.backgroundColor = CHANGEColorWith(0x4cafff,1.0);
    
    UILabel*signLabel = [[UILabel alloc]init];
    signLabel.font = [UIFont systemFontOfSize:14.0];
    signLabel.text = @"累计签到";
    signLabel.textColor = [UIColor whiteColor];
    CGSize textSize = [signLabel.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:14.0] }];
    signLabel.frame = CGRectMake(16, 15, textSize.width, textSize.height);
    
    signLabel1 = [[UILabel alloc]init];
    signLabel1.font = [UIFont systemFontOfSize:18.0];
    signLabel1.textColor = CHANGEColorWith(0xff2848,1.0);
    signLabel1.textAlignment = NSTextAlignmentCenter;
    
    signLabel1.frame = CGRectMake(16+textSize.width+2, 15, 40, textSize.height);
    
    UILabel*signLabel2 = [[UILabel alloc]init];
    signLabel2.font = [UIFont systemFontOfSize:14.0];
    signLabel2.text = @"天";
    signLabel2.textColor = [UIColor whiteColor];
    CGSize textSize2 = [signLabel2.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:14.0] }];
    signLabel2.frame = CGRectMake(16+textSize.width+44, 15, textSize2.width, textSize2.height);
    UIButton *viewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    viewButton.frame = CGRectMake(kDeviceWidth-15-textSize.width-16, 15, textSize.width+16, textSize.height);
    [viewButton setTitle:@"签到攻略" forState:UIControlStateNormal];
    [viewButton setImage:[UIImage imageNamed:@"sign_mod1_icon_question"] forState:UIControlStateNormal];
    viewButton.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;    //viewButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    //[viewButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    // viewButton.imageEdgeInsets = UIEdgeInsetsMake(0,13,0,0);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
    [viewButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [viewButton addTarget:self action:@selector(signButtonAction :) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView*signImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sign_img_bg"]];
    
    signImageView. bounds = CGRectMake(0, 0, CGRectGetWidth(signImageView.frame), CGRectGetWidth(signImageView.frame));
    signImageView.center = CGPointMake(topBackView.center.x, topBackView.center.y +10);
    
    
    UILabel*signLabel3 = [[UILabel alloc]init];
    signLabel3.font = [UIFont systemFontOfSize:18.0];
    signLabel3.text = @"已连续签到";
    signLabel3.textColor = CHANGEColorWith(0x3f6fe0,1.0);
    CGSize textSize3 = [signLabel3.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:18.0] }];
    signLabel3.bounds = CGRectMake(0, 0, textSize3.width, textSize3.height);
    signLabel3.center = CGPointMake(signImageView.center.x, signImageView.center.y - 15);
    signLabel3.textAlignment = NSTextAlignmentCenter;
    signLabel4 = [[UILabel alloc]init];
    signLabel4.font = [UIFont systemFontOfSize:25.0];
    //signLabel3.text = @"已经连续签到";
    signLabel4.textColor = CHANGEColorWith(0xff2848,1.0);
    // signLabel4.text = @"10天";
    //    CGSize textSize3 = [signLabel3.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:18.0] }];
    signLabel4.bounds = CGRectMake(0, 0, textSize3.width, textSize3.height+10);
    signLabel4.center = CGPointMake(signImageView.center.x, signImageView.center.y + 15 );
    signLabel4.textAlignment = NSTextAlignmentCenter;
    
    [topBackView addSubview:signLabel];
    [topBackView addSubview:signLabel1];
    [topBackView addSubview:signLabel2];
    [topBackView addSubview:viewButton];
    [topBackView addSubview:signImageView];
    [topBackView addSubview:signLabel3];
    [topBackView addSubview:signLabel4];
    
    [signLabel release];
    [signLabel2 release];
    [viewButton release];
    [signImageView release];
    [signLabel3 release];
    
    //    int rowCount = 2;
    //    float top = 6;
    //    float space = 5;
    //    float btnWidth = (kDeviceWidth -3*space)/rowCount;
    //    float btnHeight = 116*kDeviceWidth/375;
    //    for (int i = 0; i < 8; i++) {
    //        float kx ;
    //        float ky ;
    //        kx = space + i%rowCount* (btnWidth + space);
    //        ky = top + i/rowCount*(btnHeight + top);
    //
    //        UIButton *viewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //        [viewButton setFrame:CGRectMake(kx, ky, btnWidth, btnHeight)];
    //        viewButton.tag = i+1;
    //        [viewButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"mall_%d_n",i+1]] forState:UIControlStateNormal];
    //        [viewButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"mall_%d_s",i+1]] forState:UIControlStateHighlighted];
    //        [viewButton addTarget:self action:@selector(viewButtonAction :) forControlEvents:UIControlEventTouchUpInside];
    [_ScrollView addSubview:topBackView];
    [topBackView release];
    //
    //
    //    }
    
    //    UIImageView*signImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, topBackView.frame.size.height, KScreenWidth, 15)];
    //    signImageView1.backgroundColor = [UIColor grayColor];
    //     [_ScrollView addSubview:signImageView1];
    
    
    
    UIView*centerBackView = [[UIView alloc]initWithFrame:CGRectMake(0, topBackView.frame.size.height, kDeviceWidth/2.0, 136.0)];
    
    UIImageView*centersignImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sign_mod2_bg"]];
    centersignImageView.frame = CGRectMake(0, 0, kDeviceWidth/2.0, 136.0);
    
    UIImageView*centersignImageView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"crown1"]];
    centersignImageView2.frame = CGRectMake(0, 0, CGRectGetWidth(centersignImageView2.frame), CGRectGetHeight(centersignImageView2.frame));
    UIImageView*centersignImageView3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sign_icon_days"]];
    centersignImageView3.bounds = CGRectMake(0, 0, CGRectGetWidth(centersignImageView3.frame), CGRectGetHeight(centersignImageView3.frame));
    centersignImageView3.center = CGPointMake(centerBackView.center.x, CGRectGetHeight(centersignImageView3.frame)/2);
    centersignLabel = [[UILabel alloc]init];
    centersignLabel.font = [UIFont systemFontOfSize:17.0];
    //signLabel3.text = @"已经连续签到";
    centersignLabel.textColor = CHANGEColorWith(0xffffff,1.0);
    //centersignLabel.text = @"10天";
    //    CGSize textSize3 = [signLabel3.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:18.0] }];
    centersignLabel.bounds = CGRectMake(0, 0, textSize3.width, textSize3.height);
    centersignLabel.center = CGPointMake(centerBackView.center.x, CGRectGetHeight(centersignImageView3.frame)/2);
    centersignLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel*centersignLabel1 = [[UILabel alloc]init];
    centersignLabel1.font = [UIFont systemFontOfSize:14.0];
    centersignLabel1.text = @"累计送";
    centersignLabel1.textColor = CHANGEColorWith(0x4cafff,1.0);
    CGSize centetextSize = [centersignLabel1.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:14.0] }];
    centersignLabel1.frame = CGRectMake(40*kDeviceWidth/375.0, CGRectGetHeight(centersignImageView3.frame), centetextSize.width, centetextSize.height);
    centersignLabel2 = [[UILabel alloc]init];
    centersignLabel2.font = [UIFont systemFontOfSize:25.0];
    centersignLabel2.textColor = CHANGEColorWith(0xff2848,1.0);
    ///centersignLabel2.text = @"26";
    centersignLabel2.textAlignment = NSTextAlignmentCenter;
    
    centersignLabel2.frame = CGRectMake(centersignLabel1.frame.origin.x+centetextSize.width+2, CGRectGetHeight(centersignImageView3.frame) - 5, 36, centetextSize.height+5);
    UILabel*centersignLabel3 = [[UILabel alloc]init];
    centersignLabel3.font = [UIFont systemFontOfSize:18.0];
    centersignLabel3.text = @"分钟";
    centersignLabel3.textColor = CHANGEColorWith(0x4cafff,1.0);
    CGSize centetextSize2 = [centersignLabel3.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:18.0] }];
    centersignLabel3.frame = CGRectMake(centersignLabel1.frame.origin.x+centetextSize.width+2 + 36, CGRectGetHeight(centersignImageView3.frame) - 4, centetextSize2.width, centetextSize2.height);
    viewButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    viewButton1.bounds = CGRectMake(0, 0, centetextSize.width+36+2+centetextSize2.width, 26);
    viewButton1.center = CGPointMake(centerBackView.center.x, centerBackView.frame.size.height-23);
    [viewButton1 setBackgroundImage:[UIImage imageNamed:@"sign_btn_get-_s"] forState:UIControlStateNormal];
    [viewButton1 setBackgroundImage:[UIImage imageNamed:@"sign_btn_get_n"] forState:UIControlStateHighlighted];
    [viewButton1 addTarget:self action:@selector(getMinuteAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [centerBackView addSubview:centersignImageView];
    [centerBackView addSubview:centersignImageView2];
    [centerBackView addSubview:centersignImageView3];
    [centerBackView addSubview:centersignLabel];
    [centerBackView addSubview:centersignLabel2];
    [centerBackView addSubview:centersignLabel1];
    [centerBackView addSubview:centersignLabel3];
    [centerBackView addSubview:viewButton1];
    [centersignImageView release];
    [centersignImageView2 release];
    [centersignImageView3 release];
    [centersignLabel1 release];
    [centersignLabel3 release];
    
    
    UIView*centerBackView1 = [[UIView alloc]initWithFrame:CGRectMake(kDeviceWidth/2.0, topBackView.frame.size.height, kDeviceWidth/2.0, 136.0)];
    
    UIImageView*centersignImageView4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sign_mod3_bg"]];
    centersignImageView4.frame = CGRectMake(0, 0, kDeviceWidth/2.0, 136.0);
    
    UIImageView*centersignImageView5 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"crown2"]];
    centersignImageView5.frame = CGRectMake(0, 0, CGRectGetWidth(centersignImageView5.frame), CGRectGetHeight(centersignImageView5.frame));
    UIImageView*centersignImageView6 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sign_icon_days"]];
    centersignImageView6.bounds = CGRectMake(0, 0, CGRectGetWidth(centersignImageView6.frame), CGRectGetHeight(centersignImageView6.frame));
    centersignImageView6.center = CGPointMake(centerBackView.center.x, CGRectGetHeight(centersignImageView6.frame)/2);
    centersignLabel4 = [[UILabel alloc]init];
    centersignLabel4.font = [UIFont systemFontOfSize:17.0];
    //signLabel3.text = @"已经连续签到";
    centersignLabel4.textColor = CHANGEColorWith(0xffffff,1.0);
    //centersignLabel4.text = @"10天";
    //    CGSize textSize3 = [signLabel3.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:18.0] }];
    centersignLabel4.bounds = CGRectMake(0, 0, textSize3.width, textSize3.height);
    centersignLabel4.center = CGPointMake(centerBackView.center.x, CGRectGetHeight(centersignImageView6.frame)/2);
    centersignLabel4.textAlignment = NSTextAlignmentCenter;
    
    UILabel*centersignLabel5 = [[UILabel alloc]init];
    centersignLabel5.font = [UIFont systemFontOfSize:14.0];
    centersignLabel5.text = @"累计送";
    centersignLabel5.textColor = CHANGEColorWith(0x4cafff,1.0);
    CGSize centetextSize5 = [centersignLabel5.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:14.0] }];
    centersignLabel5.frame = CGRectMake(40*kDeviceWidth/375.0, CGRectGetHeight(centersignImageView6.frame), centetextSize5.width, centetextSize5.height);
    centersignLabel7 = [[UILabel alloc]init];
    centersignLabel7.font = [UIFont systemFontOfSize:25.0];
    centersignLabel7.textColor = CHANGEColorWith(0xff2848,1.0);
    //centersignLabel7.text = @"26";
    centersignLabel7.textAlignment = NSTextAlignmentCenter;
    centersignLabel7.frame = CGRectMake(centersignLabel5.frame.origin.x+centetextSize5.width+2, CGRectGetHeight(centersignImageView6.frame) - 5, 36, centetextSize5.height+5);
    UILabel*centersignLabel8 = [[UILabel alloc]init];
    centersignLabel8.font = [UIFont systemFontOfSize:18.0];
    centersignLabel8.text = @"分钟";
    centersignLabel8.textColor = CHANGEColorWith(0x4cafff,1.0);
    CGSize centetextSize6 = [centersignLabel8.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:18.0] }];
    centersignLabel8.frame = CGRectMake(centersignLabel5.frame.origin.x+centetextSize5.width+2 + 36, CGRectGetHeight(centersignImageView6.frame) - 4, centetextSize6.width, centetextSize6.height);
    viewButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    viewButton2.bounds = CGRectMake(0, 0, centetextSize5.width+36+2+centetextSize6.width, 26);
    viewButton2.center = CGPointMake(centerBackView.center.x, centerBackView.frame.size.height-23);
    [viewButton2 setBackgroundImage:[UIImage imageNamed:@"sign_btn_get-_s"] forState:UIControlStateNormal];
    [viewButton2 setBackgroundImage:[UIImage imageNamed:@"sign_btn_get_n"] forState:UIControlStateHighlighted];
    [viewButton2 addTarget:self action:@selector(getMinuteAction1:) forControlEvents:UIControlEventTouchUpInside];
    [centerBackView1 addSubview:centersignImageView4];
    [centerBackView1 addSubview:centersignImageView5];
    [centerBackView1 addSubview:centersignImageView6];
    [centerBackView1 addSubview:centersignLabel4];
    [centerBackView1 addSubview:centersignLabel5];
    [centerBackView1 addSubview:centersignLabel7];
    [centerBackView1 addSubview:centersignLabel8];
    [centerBackView1 addSubview:viewButton2];
    
    
    
    [_ScrollView addSubview:centerBackView];
    [_ScrollView addSubview:centerBackView1];
    
    
    [centersignImageView4 release];
    [centersignImageView5 release];
    [centersignImageView6 release];
    [centersignLabel5 release];
    [centersignLabel8 release];
    [centerBackView release];
    [centerBackView1 release];
    
    UIImageView*signImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, topBackView.frame.size.height + centerBackView.frame.size.height, kDeviceWidth, 15)];
    signImageView1.image = [UIImage imageNamed:@"me_mod_shadow_up"];
    [_ScrollView addSubview:signImageView1];
    [signImageView1 release];
    
    self.calendar = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
    CGRect frame = _calendar.frame;
    frame.origin.y = signImageView1.frame.origin.y + 15;
    _calendar.frame = frame;
    [_ScrollView addSubview:_calendar];
    
    
}
-(void)requestDate{
    staryStr = @"1";
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    mbp.labelText = @"   请稍等...   ";
    NSMutableArray *insm = [NSMutableArray array];
    [insm addObject:@"query_cmd"];
    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Ret",@"",@"AcctName", nil];
    [insm addObject:ixml];
    NSString *iurl = [NSString stringWithFormat:@"http://%@/api/get_sign_info.php?mobile=%@",IP,[Utility shareInstance].u_account];
   
    [insm addObject:iurl];
    
    m_request = [[HttpDataRequests alloc] init:insm];
    m_request.delegate = self;
    
    
    
}
-(void)HttpCallBack:(id)adata atag:(InternetState)atag acmd:(NSString*)acmd
{
    if (![[Utility getError:atag] isEqualToString:@"OK"] )
    {
        [[iToast makeToast:[Utility getError:atag]] show];
    }
    else
    {
        NSData*date = [adata dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"f1111sss%@",date);
        NSDictionary *stateDit = [NSJSONSerialization JSONObjectWithData:date options:NSJSONReadingMutableContainers error:nil];
        NSString*stare = [NSString stringWithFormat:@"%@",stateDit[@"state"]];
        
        if ([staryStr isEqualToString:@"1"]) {
            if ([stare isEqualToString:@"1"]) {
                
                NSString*continue_day = [NSString stringWithFormat:@"%@", stateDit[@"continue_day"]];
                NSString*count_sign_day = [NSString stringWithFormat:@"%@",stateDit[@"count_sign_day"]];
                NSString*reward_count_minute = [NSString stringWithFormat:@"%@",stateDit[@"reward_count_minute"]];
                NSString*reward_continue_minute = [NSString stringWithFormat:@"%@",stateDit[@"reward_continue_minute"]];
                NSString*continue_reward_day = [NSString stringWithFormat:@"%@",stateDit[@"continue_reward_day"]];
                NSString*count_reward_day = [NSString stringWithFormat:@"%@",stateDit[@"count_reward_day"]];
                NSArray*sign_time = stateDit[@"sign_time"];
                
                NSLog(@"%@-----%@---%@---%@-----%@---%@---%@",continue_day,count_sign_day,reward_count_minute,reward_continue_minute,continue_reward_day,count_reward_day,sign_time);
                signLabel1.text = count_sign_day;
                
                NSString*signText = [NSString stringWithFormat:@"%@ 天",continue_day];
                signLabel4.text = signText;
                
                centersignLabel.text = signText;
                NSString*signText1 = [NSString stringWithFormat:@"%@ 天",count_sign_day];
                centersignLabel4.text = signText1;
                
                centersignLabel7.text = reward_count_minute;
                centersignLabel2.text = reward_continue_minute;
                
                [self signDate:sign_time];
                
            }else{
                [[iToast makeToast:stateDit[@"msg"]]show];
            }
        }else{
            
            if ([stare isEqualToString:@"1"]) {
                [[iToast makeToast:stateDit[@"msg"]]show];
                //[Utility shareInstance].refreshPayStare = @"1";
                
            }else if ([stare isEqualToString:@"-2"]){
                [[iToast makeToast:stateDit[@"msg"]]show];
                
            }else{
                [[iToast makeToast:@"目前还不能领取，再等等！"]show];
            }
            
            
        }
        
        
    }
    
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    
}

-(void)signDate:(NSArray*)signTimeArray{
   
    NSCharacterSet*set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$?^?'@#$%^&*()_+'\""];
       NSMutableArray*clearArray = [NSMutableArray array];
    for (int i = 0; i< signTimeArray.count; i ++) {
        NSString*str = signTimeArray[i];
        NSLog(@"66ssdate = %@",str);
        
        NSString*setClearStr = [str stringByTrimmingCharactersInSet:set];
        NSLog(@"ssdate = %@",setClearStr);
        [clearArray addObject:setClearStr];
        
    }
    
    _calendar.centerCalendarItem.signTime = clearArray;
    _calendar.leftCalendarItem.signTime = clearArray;
    _calendar.rightCalendarItem.signTime = clearArray;
    _calendar.centerCalendarItem.date = [NSDate date];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getMinuteAction:(UIButton*)sender{
    staryStr = @"2";
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    mbp.labelText = @"   请稍等...   ";
    NSMutableArray *insm = [NSMutableArray array];
    [insm addObject:@"query_cmd"];
    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Ret",@"",@"AcctName", nil];
    [insm addObject:ixml];
    NSString *iurl = [NSString stringWithFormat:@"http://%@/api/get_sign_reward.php?mobile=%@&reward_type=%@&minute=%@",IP,[Utility shareInstance].u_account,@"continue_minute",centersignLabel2.text];
    
    [insm addObject:iurl];
    
    m_request1 = [[HttpDataRequests alloc] init:insm];
    m_request1.delegate = self;
    
    
    
    
}
-(void)getMinuteAction1:(UIButton*)sender{
    staryStr = @"3";
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    mbp.labelText = @"   请稍等...   ";
    NSMutableArray *insm = [NSMutableArray array];
    [insm addObject:@"query_cmd"];
    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Ret",@"",@"AcctName", nil];
    [insm addObject:ixml];
    NSString *iurl = [NSString stringWithFormat:@"http://%@/api/get_sign_reward.php?mobile=%@&reward_type=%@&minute=%@",IP,[Utility shareInstance].u_account,@"count_minute",centersignLabel7.text];
    [insm addObject:iurl];
   
    
    m_request2 = [[HttpDataRequests alloc] init:insm];
    m_request2.delegate = self;
    
    
    
}

-(void)signButtonAction:(UIButton*)sender{
    
    ItemHelpViewController *HelpViewController = [[ItemHelpViewController alloc]initWithNibName:@"ItemHelpViewController" bundle:nil];
    HelpViewController.m_name = @"签到攻略";
    HelpViewController.m_data = 1;
    HelpViewController.m_url = @"http://www.yidongchangliao.com/index.php/Home/Common/qiandao.html";
    HelpViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:HelpViewController animated:YES];
    [HelpViewController release];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
