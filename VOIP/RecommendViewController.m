//
//  RecommendViewController.m
//  Move
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RecommendViewController.h"
#import "ShareModel.h"

@interface RecommendViewController ()<HttpDataRequestsDelegate,MFMessageComposeViewControllerDelegate>
{
    HttpDataRequests *m_request;
      
}

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addAavigationView:@"分享有礼" aback:@"back.png"];
    [self adaptiveIos1];
    _shareScrolllView.contentSize=CGSizeMake(kDeviceWidth, kDeviceHeight+100);
    
    [self requestDate];
    
}
-(void)requestDate{
    
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    mbp.labelText = @"   请稍等...   ";
    NSMutableArray *insm = [NSMutableArray array];
    [insm addObject:@"query_cmd"];
    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Ret",@"",@"AcctName", nil];
    [insm addObject:ixml];
    NSString *iurl = [NSString stringWithFormat:@"http://%@/api/share/get_share_api.php?mobile=%@",IP,[Utility shareInstance].u_account];
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
        // NSString*stare = [NSString stringWithFormat:@"%@",stateDictionary[@"state"]];
        
        NSString*people_num = [NSString stringWithFormat:@"%@", stateDit[@"people_num"]];
        NSString*count_minute = [NSString stringWithFormat:@"%@",stateDit[@"count_minute"]];
        NSLog(@"%@---%@",people_num,people_num);
        
        self.peopleNumberLabel.text = people_num;
        self.timeLabel.text = count_minute;
    
        
    }
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setShareUrl:(NSString *)shareUrl
{
    
    [ShareModel shareModel].shareUrl = shareUrl;
    
    
}





- (IBAction)shareAction:(UIButton *)sender {
    if (sender.tag == 1) {
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
        if([MFMessageComposeViewController canSendText])
        {
            controller.body = @"hi,我正在使用【移动畅聊】免费打电话,推荐你用一下。下载地址：https://www.pgyer.com/YDCL";
            controller.messageComposeDelegate = self;
            [self presentViewController:controller animated:YES completion:nil];
        }
        
    }else{
        NSString *snsName ;
        UIImage *shareImage = [UIImage imageNamed:@"Icon-76"];
        
        if (sender.tag == 2){
            [UMSocialData defaultData].extConfig.wechatSessionData.title = @"微信分享";
            snsName = @"wxsession";
        }else if (sender.tag == 3){
            snsName = @"wxtimeline";
            
        }else if (sender.tag == 4){
            [UMSocialData defaultData].extConfig.qzoneData.title = @"QQ空间分享";
            snsName = @"qzone";
            
        }else {
            [UMSocialData defaultData].extConfig.qqData.title = @"QQ分享";
            snsName = @"qq";
        }
        
       
        
        [ShareModel shareModel:self snsName:snsName shareImage:shareImage shareText:_shareText];
        
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



- (void)dealloc {
    [_peopleNumberLabel release];
    [_timeLabel release];
    [_shareScrolllView release];
    [_shareText release];
    [_shareUrl release];
    [m_request release];
    
    [super dealloc];
}
@end
