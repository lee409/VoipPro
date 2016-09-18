//
//  PeopleCentreViewController.m
//  VOIP
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PeopleCentreViewController.h"
#import "MoreViewController.h"
#import "MYTableViewCell.h"
#import "LewPopupViewAnimationSpring.h"
#import "SignView.h"
#import "MySignViewController.h"
#import "RecommendViewController.h"
#import "ShareModel.h"

@interface PeopleCentreViewController ()<HttpDataRequestsDelegate,ASIHTTPRequestDelegate,ASIProgressDelegate,UITableViewDelegate,UITableViewDataSource,SignViewDelegate>{
    HttpDataRequests *m_request;
    HttpDataRequests *m_request1;
    //NSString*m_balancestr1;
    NSString*m_deadlinestr2;
    UIButton*button1;
    UIButton*button2;
   

}
@property(nonatomic,retain)UITableView*tableView;
@property(nonatomic,strong)NSArray*myArray;
@property(nonatomic,strong)NSArray*myArray1;
@property(nonatomic,strong)NSArray*myArray2;
@property(nonatomic,strong)UILabel*signLabel7;
@property(nonatomic,strong)UILabel*signLabel8;
@property(nonatomic,copy)NSString*m_deadline;

@end

@implementation PeopleCentreViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    UIImage *image = [UIImage imageNamed:@"me_set_n"];
//    [self.navigationController.navigationBar setBackgroundImage:image
//                                                  forBarMetrics:UIBarMetricsCompact];
    

}
-(void)dealloc{
    [super dealloc];
  
    [m_deadlinestr2 release];
    [button1 release];
    [button2 release];
    [_tableView release];
    [_myArray release];
    [_myArray1 release];
    [_myArray2 release];
    [_signLabel7 release];
    [_signLabel8 release];
    [_m_deadline release];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addAavigationView:@"我的" aback:nil];
    [self adaptiveIos1];
    [self query_request2];
    
    UIButton*rightBut = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
    [rightBut setBackgroundImage:[UIImage imageNamed:@"me_set_n"] forState:UIControlStateNormal];
    [rightBut setBackgroundImage:[UIImage imageNamed:@"me_set_s"] forState:UIControlStateHighlighted];
    [rightBut addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightButton = [[UIBarButtonItem alloc]initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = rightButton;
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGB:255 green:255 blue:255 alpha:1.0]] forBarMetrics:UIBarMetricsDefault];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-49 - 64) style:UITableViewStylePlain];
    //self.tableView.bounces = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    //    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 1)];
    //    v.backgroundColor = [UIColor blackColor];
    //    [tableView setTableFooterView:v];
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 96.0*kDeviceWidth/375.0;
    
//    UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 263*kDeviceWidth/375+8*kDeviceWidth/375)];
//    imageView.image = [UIImage imageNamed:@"me_bg"];
//    UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 263*kDeviceWidth/375, kDeviceWidth, 8*kDeviceWidth/375)];
//    view.backgroundColor = [UIColor whiteColor];
//    [imageView addSubview:view];
    
       [rightBut release];
    [rightButton release];
    NSArray*array1 = [NSArray arrayWithObjects:@"每日签到",@"推荐畅聊",@"帮助中心",nil];
    NSArray*array2 = [NSArray arrayWithObjects:@"免费赚分钟数",@"送分钟数",@"点击寻求帮助",nil];
    NSArray*array3 = [NSArray arrayWithObjects:@"me_mod4_bg",@"me_mod_share_bg",@"me_mod4_bg",nil];
    self.myArray = array1;
    self.myArray1 = array2;
    self.myArray2 = array3;
  
    UIView*topView = [self addTableHeaderView];
    
    self.tableView.tableHeaderView = topView;
    [self.view addSubview:self.tableView];
 
    
    
}
-(UIView*)addTableHeaderView{
    //     JHMyTopView *topView = [JHMyTopView defaultPopupView];
    //    topView.delegate = self;
    
    
    UIView*topBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth,280*kDeviceWidth/375.0)];
    // topBackView.backgroundColor = CHANGEColorWith(0x4cafff,1.0);
    UIView*topBackView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth,140*kDeviceWidth/375.0)];
    topBackView.backgroundColor = CHANGEColorWith(0x4cafff,1.0);
    
    UIView*topBackView2 = [[UIView alloc]initWithFrame:CGRectMake(0,140*kDeviceWidth/375.0, kDeviceWidth/3.0, 140*kDeviceWidth/375.0)];
    
    UIImageView*signImageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me_time_bg"]];
    
    signImageView1. frame = CGRectMake(0, 0, kDeviceWidth/3.0, 140*kDeviceWidth/375.0);
    
    //[topBackView2 addSubview:signImageView1];
    
    
    UILabel*signLabel = [[UILabel alloc]init];
    signLabel.font = [UIFont systemFontOfSize:14.0];
    signLabel.text = @"剩余时长";
    signLabel.textColor = CHANGEColorWith(0x7c99d6,1.0);
    CGSize textSize = [signLabel.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:14.0] }];
    signLabel.bounds = CGRectMake(0, 0, textSize.width, textSize.height);
    signLabel.center = CGPointMake( signImageView1.center.x, signImageView1.center.y-textSize.height-5 );
    
    UILabel*signLabel1 = [[UILabel alloc]init];
    signLabel1.font = [UIFont systemFontOfSize:23.0];
    signLabel1.textColor = CHANGEColorWith(0x3b6cde,1.0);
    //signLabel1.text = @"166";
    
    signLabel1.textAlignment = NSTextAlignmentCenter;
    signLabel1.center = CGPointMake(signImageView1.center.x, signImageView1.center.y );
    self.signLabel7 = signLabel1;
    
    UILabel*signLabel2 = [[UILabel alloc]init];
    signLabel2.font = [UIFont systemFontOfSize:14.0];
    signLabel2.text = @"分钟";
    signLabel2.textColor = CHANGEColorWith(0x7c99d6,1.0);
    CGSize textSize2 = [signLabel2.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:14.0] }];
    signLabel2.bounds = CGRectMake(0, 0, textSize2.width, textSize2.height);
    signLabel2.center = CGPointMake(signImageView1.center.x, signImageView1.center.y+textSize.height+5 );
    [topBackView2 addSubview:signImageView1];
    [topBackView2 addSubview:signLabel];
    [topBackView2 addSubview:signLabel1];
    [topBackView2 addSubview:signLabel2];
    [signImageView1 release];
    [signLabel release];
    [signLabel1 release];
    [signLabel2 release];
    
    UIView*topBackView3 = [[UIView alloc]initWithFrame:CGRectMake(kDeviceWidth/3.0 - 1, CGRectGetHeight(topBackView1.frame), kDeviceWidth/3.0, 140*kDeviceWidth/375.0)];
    
    UIImageView*signImageView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me_money_bg"]];
    
    signImageView2. frame = CGRectMake(0, 0, kDeviceWidth/3.0, 140*kDeviceWidth/375.0);
    
    //[topBackView2 addSubview:signImageView1];
    
    
    UILabel*signLabel3 = [[UILabel alloc]init];
    signLabel3.font = [UIFont systemFontOfSize:14.0];
    signLabel3.text = @"剩余话费";
    signLabel3.textColor = CHANGEColorWith(0x7c99d6,1.0);
    CGSize textSize3 = [signLabel3.text sizeWithAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:14.0] }];
    signLabel3.bounds = CGRectMake(0, 0, textSize3.width, textSize3.height);
    signLabel3.center = CGPointMake(signImageView1.center.x, signImageView1.center.y-textSize.height-5);
    
    UILabel*signLabel4 = [[UILabel alloc]init];
    signLabel4.font = [UIFont systemFontOfSize:23.0];
    signLabel4.textColor = CHANGEColorWith(0x3b6cde,1.0);
    signLabel4.textAlignment = NSTextAlignmentCenter;
    //signLabel4.text = @"166";
    //    CGSize textSize4 = [signLabel4.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:23.0]}];
    //    signLabel4.bounds = CGRectMake(0, 0, textSize4.width, textSize4.height);
    signLabel4.center = CGPointMake(signImageView2.center.x, signImageView2.center.y );
    self.signLabel8 = signLabel4;
    
    UILabel*signLabel5 = [[UILabel alloc]init];
    signLabel5.font = [UIFont systemFontOfSize:14.0];
    signLabel5.text = @"元";
    signLabel5.textColor = CHANGEColorWith(0x7c99d6,1.0);
    CGSize textSize5 = [signLabel5.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:14.0] }];
    signLabel5.bounds = CGRectMake(0, 0, textSize5.width, textSize5.height);
    signLabel5.center = CGPointMake(signImageView1.center.x, signImageView1.center.y+textSize.height+5 );
    [topBackView3 addSubview:signImageView2];
    [topBackView3 addSubview:signLabel3];
    [topBackView3 addSubview:signLabel4];
    [topBackView3 addSubview:signLabel5];
    
    
    
    UIButton *viewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    viewButton.frame = CGRectMake(kDeviceWidth/1.5 - 2, CGRectGetHeight(topBackView1.frame), kDeviceWidth/3.0 + 1, 140*kDeviceWidth/375.0);
    [viewButton setBackgroundImage:[UIImage imageNamed:@"me_mod_recharge"] forState:UIControlStateNormal];
    [viewButton setBackgroundImage:[UIImage imageNamed:@"me_mod_recharge"] forState:UIControlStateHighlighted];
    [viewButton addTarget:self action:@selector(changeMoneyAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *viewButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    viewButton1.bounds = CGRectMake(0, 0, 166*kDeviceWidth/375.0, 166*kDeviceWidth/375.0);
    viewButton1.center = CGPointMake(topBackView.center.x, topBackView.center.y-35*kDeviceWidth/375.0 );
    [viewButton1 setBackgroundImage:[UIImage imageNamed:@"me_img_head2"] forState:UIControlStateNormal];
    [viewButton1 setBackgroundImage:[UIImage imageNamed:@"me_img_head2"] forState:UIControlStateHighlighted];
    [viewButton1 addTarget:self action:@selector(changeImageAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel*signLabel6 = [[UILabel alloc]init];
    signLabel6.font = [UIFont systemFontOfSize:21.0];
    NSMutableString*buffer = [NSMutableString stringWithString:[Utility shareInstance].u_account];
    [buffer insertString:@"-" atIndex:3];
    [buffer insertString:@"-" atIndex:8];
    signLabel6.text = buffer;
    
    signLabel6.textColor = [UIColor whiteColor];
    CGSize textSize6 = [signLabel6.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:21.0] }];
    signLabel6.bounds = CGRectMake(0, 0, textSize6.width, textSize6.height);
    signLabel6.center = CGPointMake(topBackView.center.x, topBackView.center.y - (viewButton1.frame.size.height)/2-35*kDeviceWidth/375.0);
    [topBackView addSubview:topBackView1];
    [topBackView addSubview:topBackView2];
    [topBackView addSubview:topBackView3];
    
    [topBackView addSubview:viewButton];
    [topBackView addSubview:viewButton1];
    [topBackView addSubview:signLabel6];
    
    [topBackView1 release];
    [topBackView2 release];
    [topBackView3 release];
    [viewButton release];
    [viewButton1 release];
    [signLabel6 release];
    
    return topBackView;
}



-(void)query_request2
{
   // MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
  //  mbp.labelText = @"   请稍等...   ";
    NSMutableArray *insm = [NSMutableArray array];
    [insm addObject:@"query_cmd"];
    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"noInformation", nil];
    [insm addObject:ixml];
    NSString *iurl = [NSString stringWithFormat:@"http://%@/call.php?action=wap_getbalance&acctname=%@&password=%@",IP,[Utility shareInstance].u_account,[Utility getMD5:[Utility shareInstance].u_password]];
    [insm addObject:iurl];
    m_request = [[HttpDataRequests alloc] init:insm];
    m_request.delegate = self;
    NSLog(@"md5 = %@",iurl);
}
-(void)SignViewRequest{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    mbp.labelText = @"   请稍等...   ";
    NSMutableArray *insm = [NSMutableArray array];
    [insm addObject:@"query_cmd1"];
    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Ret",@"",@"AcctName", nil];
    [insm addObject:ixml];
    NSString *iurl = [NSString stringWithFormat:@"http://%@/api/sign.php?mobile=%@&system_type=%@",IP,[Utility shareInstance].u_account,@"2"];
   
    [insm addObject:iurl];
    
    m_request1 = [[HttpDataRequests alloc] init:insm];
    m_request1.delegate = self;
    
    
}



-(void)HttpCallBack:(id)adata atag:(InternetState)atag acmd:(NSString*)acmd
{
    if (![[Utility getError:atag] isEqualToString:@"OK"] )
    {
        [[iToast makeToast:[Utility getError:atag]] show];
    }
    else
    {
        
        
        //NSLog(@"ffffff%@",is);
        if ([acmd isEqualToString:@"query_cmd"])
        {
            NSString *is = (NSString*)adata;
            if ( (is.length > 0) && ([is rangeOfString:@"账户余额"].length > 0) && ([is rangeOfString:@"有效期至"].length > 0)) {
                NSArray *array = [adata componentsSeparatedByString:@"<br/>"];
                NSString *str = array[0];
                NSRange range = [str rangeOfString:@"账户余额"];
                NSString *balance = [[str substringFromIndex:range.location] componentsSeparatedByString:@":"][1];
                
             //   NSString *date = [array[1] componentsSeparatedByString:@":"][1];
                
                NSString*str1 = [[NSString stringWithFormat:@"%@",balance] stringByReplacingOccurrencesOfString:@"元" withString:@""];
                float a = [str1 floatValue];
               
                self.signLabel7.text = [NSString stringWithFormat:@"%0.0f",a/0.08];
                self.signLabel8.text = str1;
                CGSize textSize1 = [self.signLabel7.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:23.0] }];
                
                self.signLabel7.bounds = CGRectMake(0, 0, textSize1.width, textSize1.height);
                
                CGSize textSize2 = [self.signLabel8.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:23.0] }];
                
                self.signLabel8.bounds = CGRectMake(0, 0, textSize2.width, textSize2.height);
                //  [self.tableView reloadData];
            }else{
                
                [iToast makeToast:@"查询失败"];
            }
            
            m_request.delegate=nil;
            [m_request release];
            m_request = nil;
            
            
        }else if ([acmd isEqualToString:@"query_cmd1"]){
            NSData*date = [adata dataUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"f1111sss%@",date);
            NSDictionary *stateDit = [NSJSONSerialization JSONObjectWithData:date options:NSJSONReadingMutableContainers error:nil];
            NSString*stare = stateDit[@"state"];
            
            [[iToast makeToast:stateDit[@"msg"]]show];
            
            if ([stare isEqualToString:@"1"]) {
                
                NSString*minuteStr = stateDit[@"minute"];
                NSLog(@"bbbb%@",minuteStr);
                [self signSucceed:@"10"];
                [self query_request2];
                
            }else if ([stare isEqualToString:@"2"]){
                
                MySignViewController*SignViewController = [[MySignViewController alloc]init];
                SignViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:SignViewController animated:YES];
                
            }
            
            
        }
    
}
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];

}
-(void)signSucceed:(NSString*)minuteStr{
    SignView *view = [SignView defaultPopupView];
    //view.backgroundColor = [UIColor clearColor];
    
    NSString*minuteStr1 = [NSString stringWithFormat:@"+%@",minuteStr];
    view.centersignLabel3.text = minuteStr1;
    
    
    view.parentVC = self;
    view.delegate = self;
    
    [self lew_presentPopupView:view animation:[LewPopupViewAnimationSpring new] dismissed:^{
        NSLog(@"动画结束");
    }];
    
    
}



#pragma mark --UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
//返回每一行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MycellIndentfier1 =@"Mycell";
    
    MYTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:MycellIndentfier1];
    if (!cell)
    {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"MYTableViewCell" owner:nil options:nil]objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    // cell.phoneNumberLabel.text = [JHUtility shareInstance].u_account;
    cell.myLableText1.text = _myArray[indexPath.row];
    cell.myLableText2.text = _myArray1[indexPath.row];
    cell.myShowImage.image = [UIImage imageNamed:_myArray2[indexPath.row]];
    
    return cell;
    
}






-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    取消选中的状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self SignViewRequest];
        //[self signSucceed];
        // [self signSucceed:@"10"];
        
        
    }
    if (indexPath.row == 1) {
        RecommendViewController*recommendViewController = [[RecommendViewController alloc]init];
        recommendViewController.shareUrl = [NSString stringWithFormat:@"http://%@/api/share/register.php?m=%@",IP,[Utility shareInstance].u_account];
        
        recommendViewController.shareText = @"hi,我正在使用【移动畅聊】免费打电话,推荐你使用一下。下载地址：http://www.pgyer.com/YDCL";
        
        recommendViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:recommendViewController animated:YES];
        [recommendViewController release];
        
    }
    if (indexPath.row == 2) {
        ItemHelpViewController *HelpViewController = [[ItemHelpViewController alloc]initWithNibName:@"ItemHelpViewController" bundle:nil];
        HelpViewController.m_name = @"使用帮助";
        HelpViewController.m_data = 2;
        HelpViewController.m_url = @"http://www.yidongchangliao.com/Common/use_help.html";
        HelpViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:HelpViewController animated:YES];
        [HelpViewController release];
 }
    
    
    
}




-(void)setAction{
    MoreViewController*setViewController = [[MoreViewController alloc]init];
    setViewController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:setViewController animated:YES];
    [setViewController release];
    
}


- (void)changeMoneyAction:(UIButton *)sender {
    ShangbiCardPayViewController *ctl = [[ShangbiCardPayViewController alloc]initWithNibName:@"ShangbiCardPayViewController" bundle:nil];
    ctl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctl animated:YES];
    [ctl release];
    
    
}


-(void)signView:(SignView *)signView tag:(NSInteger)tag{
    [ShareModel shareModel].shareUrl = [NSString stringWithFormat:@"http://%@/api/share/register.php?m=%@",IP,[Utility shareInstance].u_account];
    NSString *snsName ;
    UIImage *shareImage = [UIImage imageNamed:@"Icon-76"];
    NSString *shareText = @"hi,我正在使用【移动畅聊】免费打电话,推荐你使用一下。下载地址：http://www.pgyer.com/YDCL";
    
    if (tag == 1){
        [UMSocialData defaultData].extConfig.wechatSessionData.title = @"微信分享";
        snsName = @"wxsession";
    }else if (tag == 2){
        snsName = @"wxtimeline";
        
    }else if (tag == 3){
        
        [UMSocialData defaultData].extConfig.qqData.title = @"QQ分享";
        snsName = @"qq";
    }else
    {
        [UMSocialData defaultData].extConfig.qzoneData.title = @"QQ空间分享";
        snsName = @"qzone";
    }
    [ShareModel shareModel:self snsName:snsName shareImage:shareImage shareText:shareText];
    
}





- (void)helpAction:(UIButton *)sender {
    ItemHelpViewController *ctl = [[ItemHelpViewController alloc]initWithNibName:@"ItemHelpViewController" bundle:nil];
    ctl.m_name = @"使用帮助";
    ctl.m_data = 1;
    ctl.m_url = @"http://www.yidongchangliao.com/Common/use_help.html";
    ctl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctl animated:YES];
    [ctl release];

    
    
}

//- (void)backLoginAction:(UIButton *)sender {
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定退出当前账号吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alert show];
//    [alert release];
//    
//    
//    
//}


//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex)
//    {
//        sqlite3_close([Utility shareInstance].u_database2);
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:@"out" forKey:@"USER_1"];
//        [defaults synchronize];
//        AppDelegate *iapp = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        [iapp loadMainView1];
//    }
//}



@end
