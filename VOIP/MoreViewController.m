//
//  MoreViewController.m
//  VOIP
//
//  Created by apple on 14-3-19.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "MoreViewController.h"
#import "ErweimaView.h"
#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationDrop.h"

#import "LewPopupViewAnimationSlide.h"

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addAavigationView:@"设置" aback:@"back.png"];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createServiceCallButton];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////行高。
//- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 44;
//}
//分组。
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 4;
//}
//显示行数。
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
        return 7;
}
//即将出来时候
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@""]];
    cell.backgroundColor=cell.backgroundColor=changecellbackColor;


}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
       // [cell.textLabel setTextColor:[UIColor grayColor]];
        
    }
    if(indexPath.section == 0)
    {
        switch (indexPath.row)
        {

            case 0:
                cell.accessoryType = YES;
                [cell.textLabel setText:@"账号设置"];
                
              
                cell.imageView.image = [UIImage imageNamed:@"me_set_icon1"];

               
                break;
            case 1:
                cell.accessoryType = YES;
               [cell.textLabel setText:@"拨号设置"];
                cell.imageView.image = [UIImage imageNamed:@"me_set_icon2"];
              
                break;
            case 2:
                cell.accessoryType=YES;
                [cell.textLabel setText:@"使用说明"];
                cell.imageView.image = [UIImage imageNamed:@"me_set_icon3"];

                
                       break;
            case 3:
                cell.accessoryType = YES;
                [cell.textLabel setText:@"关于我们"];
                cell.imageView.image = [UIImage imageNamed:@"me_set_icon4"];

                break;
            case 4:
                cell.accessoryType = YES;
                [cell.textLabel setText:@"版本检测"];
                cell.imageView.image = [UIImage imageNamed:@"me_set_icon5"];
                
              
                  break;
            case 5:
                cell.accessoryType = YES;
                 [cell.textLabel setText:@"分享好友"];
                cell.imageView.image = [UIImage imageNamed:@"me_set_icon6"];
                
                  break;
            case 6:
                cell.accessoryType = YES;
                 [cell.textLabel setText:@"安全退出"];
                cell.imageView.image = [UIImage imageNamed:@"me_set_icon7"];
                
                  break;
            default:
                break;
        }
    }
//    else if (indexPath.section == 1)
//    {
//        switch (indexPath.row)
//        {
//            case 0:
//                cell.accessoryType = YES;
//                [cell.textLabel setText:@"官网"];
//                cell.imageView.image = [UIImage imageNamed:@"ic_website.png"];
//                
//                break;
//                
//            case 1:
//                cell.accessoryType = YES;
//                [cell.textLabel setText:@"软件名片"];
//                cell.imageView.image = [UIImage imageNamed:@"ic_erweima.png"];
//                
//                break;
//            case 2:
//                cell.accessoryType = YES;
//                [cell.textLabel setText:@"版本更新"];
//                cell.imageView.image = [UIImage imageNamed:@"ic_update.png"];
//                break;
//            case 3:
//                cell.accessoryType = YES;
//                [cell.textLabel setText:@"拨打设置"];
//                cell.imageView.image = [UIImage imageNamed:@"call_setting.png"];
//                break;
//            default:
//                break;
//        }
//    }
//    else if (indexPath.section == 2)
//    {
//        switch (indexPath.row)
//        {
//            
//            case 0:
//            
//                cell.accessoryType = YES;
//                [cell.textLabel setText:@"系统消息"];
//                cell.imageView.image = [UIImage imageNamed:@"modify_BindPhone.png"];
//            
//                break;
//            case 1:
//                cell.accessoryType = YES;
//                [cell.textLabel setText:@"合作加盟"];
//                cell.imageView.image = [UIImage imageNamed:@"ic_hezuo.png"];
//                break;
//            case 2:
//                cell.accessoryType = YES;
//                [cell.textLabel setText:@"相关说明"];
//                cell.imageView.image = [UIImage imageNamed:@"about_instruction.png"];
//                break;
//            case 3:
//            
//                cell.accessoryType = YES;
//                [cell.textLabel setText:@"关于我们"];
//                cell.imageView.image = [UIImage imageNamed:@"about_us.png"];
//
//            
//                break;
//            default:
//                break;
//        }
//    }
//    else if (indexPath.section == 3)
//    {
//        switch (indexPath.row)
//        {
//            case 0:
//                [cell.textLabel setText:@"退出当前账号"];
//                UIColor *icolor1 = [UIColor colorWithRed:128.0f/255.0f green:13.0f/255.0f blue:13.0f/255.0f alpha:1.0f];
//                cell.textLabel.textColor = icolor1;
//                cell.imageView.image = [UIImage imageNamed:@""];
//                break;
//            default:
//                break;
//        }
//    }
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
//        UITableViewCell*cell = [tableView cellForRowAtIndexPath:indexPath];
//         cell.imageView.image = [UIImage imageNamed:@"me_set_账号设置_s"];
         BalanceViewController *ctl = [[BalanceViewController alloc]init];
        ctl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctl animated:YES];
        [ctl release];
         
    }else if(indexPath.section==0&&indexPath.row==1){
        CallerIDPrivacyViewController *ctlb = [[CallerIDPrivacyViewController alloc]initWithNibName:@"CallerIDPrivacyViewController" bundle:nil];
        ctlb.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctlb animated:YES];
        [ctlb release];
    
    }else if (indexPath.section==0&&indexPath.row==2)
    {
        ItemHelpViewController *ctl = [[ItemHelpViewController alloc]initWithNibName:@"ItemHelpViewController" bundle:nil];
        ctl.m_name = @"相关说明";
        ctl.m_data = 1;
        ctl.m_url = @"http://www.yidongchangliao.com/Common/sm.html";
        ctl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctl animated:YES];
        [ctl release];
       
        
        
    }else if (indexPath.section == 0 && indexPath.row == 3) {
        ItemHelpViewController *ctl = [[ItemHelpViewController alloc]initWithNibName:@"ItemHelpViewController" bundle:nil];
        ctl.m_name = @"关于我们";
        ctl.m_data = 0;
        ctl.m_url = @"http://www.yidongchangliao.com";
        ctl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctl animated:YES];
        [ctl release];
        
        
        
    }
    else if (indexPath.section == 0 && indexPath.row == 4){
         [self download_request];
        
        
    }else if (indexPath.section == 0 && indexPath.row == 5){
        
        ShareViewController *ctl = [[ShareViewController alloc]initWithNibName:@"ShareViewController" bundle:nil];
        ctl.shareUrl = [NSString stringWithFormat:@"http://%@/api/share/register.php?m=%@",IP,[Utility shareInstance].u_account];
        ctl.shareText = @"hi,我正在使用【移动畅聊】免费打电话,推荐你用一下。下载地址：http://www.pgyer.com/YDCL";
        ctl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctl animated:YES];
        
        [ctl release];
        
    }else if (indexPath.section == 0 && indexPath.row == 6){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定退出当前账号吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
           [alert show];
           [alert release];
    }
    
    
    //else if (indexPath.section == 1 && indexPath.row == 0){
//        ItemHelpViewController *ctl = [[ItemHelpViewController alloc]initWithNibName:@"ItemHelpViewController" bundle:nil];
//        
//        
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        NSString *website = [userDefaults objectForKey:WEBSITE_URL];
//        if (website != nil && website.length > 0) {
//            ctl.m_name = @"官网";
//            ctl.m_data = 2;
//            ctl.m_url = website;
//            ctl.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:ctl animated:YES];
//            [ctl release];
//        }
//        
//        
//    
//    }else if (indexPath.section == 1 && indexPath.row == 1){
//
//
//        ErweimaView *view = [ErweimaView defaultPopupView];
//        view.parentVC = self;
//        
//        [self lew_presentPopupView:view animation:[LewPopupViewAnimationDrop new] dismissed:^{
//            NSLog(@"动画结束");
//        }];
//    
//    }
//    else if (indexPath.section == 1 && indexPath.row == 2){
//        [self download_request];
//    
//    }else if (indexPath.section == 1 && indexPath.row == 3){
//        CallerIDPrivacyViewController *call = [[CallerIDPrivacyViewController alloc]initWithNibName:@"CallerIDPrivacyViewController" bundle:nil];
//        call.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:call animated:YES];
//        [call release];
//    }
//    
//    else if (indexPath.section == 2 && indexPath.row == 0) {
//
//        SysInfoViewController *ctl = [[SysInfoViewController alloc] initWithNibName:@"SysInfoViewController" bundle:nil];
//        ctl.type = SysInfoType;
//        ctl.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:ctl animated:YES];
//        [ctl release];
//        
//        
//    }else if (indexPath.section == 2 && indexPath.row == 1){
//        SysInfoViewController *ctl = [[SysInfoViewController alloc] initWithNibName:@"SysInfoViewController" bundle:nil];
//        ctl.type = CooperationType;
//        ctl.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:ctl animated:YES];
//        [ctl release];
//       
//    }else if (indexPath.section == 2 && indexPath.row == 2){
//        SysInfoViewController *ctl = [[SysInfoViewController alloc] initWithNibName:@"SysInfoViewController" bundle:nil];
//        ctl.type = AttentionType;
//        ctl.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:ctl animated:YES];
//        [ctl release];
//    }else if (indexPath.section == 2 && indexPath.row == 3){
//    
//        
//        SysInfoViewController *ctl = [[SysInfoViewController alloc] initWithNibName:@"SysInfoViewController" bundle:nil];
//        ctl.type = HomeType;
//        ctl.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:ctl animated:YES];
//        [ctl release];
//
//    }
//    
//    else if (indexPath.section == 3 && indexPath.row == 0) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定退出当前账号吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alert show];
//        [alert release];
//    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//客服电话
- (void)createServiceCallButton
{
    UIButton* ilogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [ilogin setFrame:CGRectMake(0, 0, 80, 25)];
    [ilogin setShowsTouchWhenHighlighted:YES];
    //[ilogin setBackgroundImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [ilogin setTitle:@"客服电话" forState:UIControlStateNormal];
    [ilogin addTarget:self action:@selector(rightBarButtonItemBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:ilogin] autorelease];
    
}

- (void)rightBarButtonItemBack:(id)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *service_call = [userDefaults objectForKey:SERVICE_CALL];
    [Utility shareInstance].u_calledName = @"客服电话";
    [Utility shareInstance].u_calledNumber = service_call;
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[Utility shareInstance].u_calledNumber]]];
//    CallSelectView *view = [CallSelectView defaultPopupView];
//    view.parentVC = self;
//    view.delegate = self;
//    
//    LewPopupViewAnimationSlide *animation = [[LewPopupViewAnimationSlide alloc]init];
//    animation.type = LewPopupViewAnimationSlideTypeBottomBottomEdge;
//    [self lew_presentPopupView:view animation:animation dismissed:^{
//        
//    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex)
    {
        sqlite3_close([Utility shareInstance].u_database2);
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"out" forKey:@"USER_1"];
        [defaults synchronize];
        AppDelegate *iapp = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [iapp loadMainView1];
    }
}
// 处理发送完的响应结果
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (result == MessageComposeResultCancelled)
        [[iToast makeToast:@"短信已取消！"] show];
    else if (result == MessageComposeResultSent)
    {
       // [MobClick event:@"5"];
        [[iToast makeToast:@"短信已发出！"] show];
    }
    else
        [[iToast makeToast:@"信息发送失败！！"] show];
}
//更新。
-(void)download_request
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    mbp.labelText = @"   请稍等...   ";
    NSMutableArray *insm = [NSMutableArray array];
    [insm addObject:@"download_cmd"];
    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Ret",@"",@"url", nil];
    [insm addObject:ixml];
  
    NSString *iurl = [NSString stringWithFormat:@"%@agent_id=%@&type=iphone&code=%@",DOWNLOAD,PRODUCT,VERSIONTAG];
    [insm addObject:iurl];
    m_request = [[HttpDataRequests alloc] init:insm];
    m_request.delegate = self;
 //   NSString *str = [NSString stringWithFormat:
                     
  //                   @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?"];
  //  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
  //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/jie-zou-da-shi/id493901993?mt=8"]];
    
    
}
-(void)HttpCallBack:(id)adata atag:(InternetState)atag acmd:(NSString*)acmd
{
    if (![[Utility getError:atag] isEqualToString:@"OK"] )
    {
        [[iToast makeToast:@"当前版本已是最新版！"] show];
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
            else
            {
                [[iToast makeToast:@"当前版本已是最新版！"] show];
            }
        }
    }
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    m_request.delegate=nil;
    [m_request release];
    m_request = nil;
}

- (void)callSelect:(NSInteger)tag
{
    if (tag == 0) {
        //免费电话
        [[Utility shareInstance] callPhonaPage:self];
    }else{
        //普通电话
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[Utility shareInstance].u_calledNumber]]];
    }
}


@end
