//
//  ShangbiCardPayViewController.m
//  VOIP
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ShangbiCardPayViewController.h"

@implementation ShangbiCardPayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self adaptiveIos1];
   
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addAavigationView:@"充值卡充值" aback:@"back.png"];
    self.m_phoneNumber.text = [NSString stringWithFormat:@"%@",[Utility shareInstance].u_account];
    self.m_phoneNumber.userInteractionEnabled = NO;
    _ScrollView.showsHorizontalScrollIndicator=NO;
    _ScrollView.showsVerticalScrollIndicator=NO;
    _ScrollView.scrollsToTop=NO;
    _ScrollView.bounces = NO;
    _ScrollView.contentSize=CGSizeMake(kDeviceWidth, kDeviceHeight + 120);

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
	[super touchesBegan:touches withEvent:event];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    int addLength = string.length;
    int delLength = range.length;
    int nowLength = textField.text.length;
    int totolLength = nowLength + addLength - delLength;
    
    if (textField == self.m_shangbiCard)
    {
        if (totolLength > 18) {
            return FALSE;
        }
    }
    else if (textField == self.m_passWord)
    {
        if (totolLength > 18) {
            return FALSE;
        }
    }
    return TRUE;
}
- (IBAction)bt_topUp:(id)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (self.m_phoneNumber.text.length <= 0)
    {
        [[iToast makeToast:@"请输入手机号码"] show];
    }
    else if (![self.m_phoneNumber.text isMatchedByRegex:@"^(13|15|17|18|14)\\d{9}$"])
    {
        [[iToast makeToast:@"请输入正确的手机号码"] show];
    }
    else if (self.m_shangbiCard.text.length <= 0)
    {
        [[iToast makeToast:@"请输入卡号"] show];
    }
    else if ( self.m_shangbiCard.text.length < 4 )
    {
        [[iToast makeToast:@"卡号必须4～18位"] show];
    }
    else if (self.m_passWord.text.length <= 0)
    {
        [[iToast makeToast:@"请输入卡密码"] show];
    }
    else if ( self.m_passWord.text.length < 4 )
    {
        [[iToast makeToast:@"卡密码必须4～18位"] show];
    }
    else
    {
        [self shangbiCardPay_request];
    }
}
-(void)shangbiCardPay_request
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    mbp.labelText = @"   请稍等...   ";
    NSMutableArray *insm = [NSMutableArray array];
    [insm addObject:@"chongzhi_cmd"];
    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Ret",@"",@"Val", nil];
    [insm addObject:ixml];
    NSString *iurl = [NSString stringWithFormat:@"http://%@/api/addaccount.php?regnum=%@&cardno=%@&addpwd=%@&cardtype=3&money=3",IP,self.m_phoneNumber.text,self.m_shangbiCard.text,self.m_passWord.text];
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
        if ([acmd isEqualToString:@"chongzhi_cmd"])
        {
            if ( ![[Utility getErrorCHONGZHI:[[adata objectForKey:@"Ret"] intValue]] isEqualToString:@"OK"] )
            {
                [[iToast makeToast:[Utility getErrorCHONGZHI:[[adata objectForKey:@"Ret"] intValue]]] show];
            }
            else
            {
               
                
                [[iToast makeToast:[NSString stringWithFormat:@"充值成功，账户余额%@元",[adata objectForKey:@"Val"]]] show];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    m_request.delegate=nil;
    [m_request release];
    m_request = nil;
}
- (void)dealloc {
    [_m_phoneNumber release];
    [_m_shangbiCard release];
    [_m_passWord release];
    [_bt_sure release];
    [_ScrollView release];
    [super dealloc];
}



- (void)viewDidUnload {
    [self setBt_sure:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
}
@end
