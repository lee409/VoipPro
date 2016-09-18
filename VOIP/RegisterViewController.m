//
//  RegisterViewController.m
//  VOIP
//
//  Created by apple on 14-3-26.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "RegisterViewController.h"

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
    if (updateTime != nil) {
        [updateTime invalidate];
        updateTime = nil;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self addAavigationView:nil aback:@"back.png"];
   
    [self addAavigationView:@"注册" aback:@"back.png"];
    
    [self adaptiveIos1];

   
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
//完成按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger addLength = string.length;
    NSInteger delLength = range.length;
    NSInteger nowLength = textField.text.length;
    NSInteger totolLength = nowLength + addLength - delLength;
    
    if (textField == self.m_fieldPhone)
    {
        if (totolLength > 11) {
            return FALSE;
        }
    }
    else if (textField == self.m_fieldCardId)
    {
        if (totolLength > 18) {
            return FALSE;
        }
    }
    else if (textField == self.m_fieldPassword)
    {
        if (totolLength > 18) {
            return FALSE;
        }
    }
    return TRUE;
}
- (IBAction)bt_registerButton:(id)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (self.m_fieldPhone.text.length <= 0)
    {
        [[iToast makeToast:@"请输入手机号码"] show];
    }
    else if (![self.m_fieldPhone.text isMatchedByRegex:@"^(13|15|17|18|14)\\d{9}$"])
    {
        [[iToast makeToast:@"请输入正确的手机号码"] show];
    }
    else if (self.m_fieldCardId.text.length <= 0)
    {
        [[iToast makeToast:@"请输入密码"] show];
    }
    else if (self.m_fieldCardId.text.length < 4)
    {
        [[iToast makeToast:@"密码必须4～18位"] show];
    }
    else if (self.m_fieldPassword.text.length <= 0)
    {
        [[iToast makeToast:@"请再次输入密码"] show];
    }
    else if (! [self.m_fieldPassword.text isEqualToString:self.m_fieldCardId.text])
    {
        [[iToast makeToast:@"两次输入密码不同"] show];
    }else if (self.verificationCode.text.length <= 0)
    {
        [[iToast makeToast:@"请输入验证码"] show];
    }else if (! [self.verificationCodeStr isEqualToString:self.verificationCode.text])
    {
        [[iToast makeToast:@"你输入的验证码错误"] show];
    }
    else
    {
        [self register_request];
    }
}
//注册。
-(void)register_request
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    mbp.labelText = @"   请稍等...   ";
    NSMutableArray *insm = [NSMutableArray array];
    [insm addObject:@"register_cmd"];
    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Ret", nil];
    [insm addObject:ixml];
    NSString *iurl =[NSString stringWithFormat:@"http://%@/api/userregister.php?regnum=%@&regpwd=%@&acct=admin001&airpwd=123456789",IP,self.m_fieldPhone.text,self.m_fieldPassword.text];
    [insm addObject:iurl];
    m_request = [[HttpDataRequests alloc] init:insm];
    m_request.delegate = self;
}
//登录。
-(void)login_request
{
    NSMutableArray *insm = [NSMutableArray array];
    [insm addObject:@"login_cmd"];
    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Ret",@"",@"AcctName", nil];
    [insm addObject:ixml];
    NSString *iurl = [NSString stringWithFormat:@"http://%@/api/userlogin.php?regnum=%@&regpwd=%@&acct=admin001&airpwd=123456789",IP,self.m_fieldPhone.text,self.m_fieldPassword.text];
    [insm addObject:iurl];
    if (m_request)
    {
        m_request.delegate=nil;
        [m_request release];
        m_request = nil;
    }
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
        if ([acmd isEqualToString:@"register_cmd"])
        {
            if ( ![[Utility getErrorREGISTER:[[adata objectForKey:@"Ret"] intValue]] isEqualToString:@"OK"] )
            {
                [[iToast makeToast:[Utility getErrorREGISTER:[[adata objectForKey:@"Ret"] intValue]]] show];
            }
            else
            {
                [self login_request];
                return;
            }
        } else if ([acmd isEqualToString:@"login_cmd"])
        {
            if ( ![[Utility getErrorLOGIN:[[adata objectForKey:@"Ret"] intValue]] isEqualToString:@"OK"] )
            {
                [[iToast makeToast:[Utility getErrorLOGIN:[[adata objectForKey:@"Ret"] intValue]]] show];
            }
            else
            {
              //  [MobClick event:@"1" label:VERSION];
                
                //初始化数据。
                [Utility shareInstance].u_account = self.m_fieldPhone.text;
                [Utility shareInstance].u_password = self.m_fieldPassword.text;
                
                [Utility shareInstance].u_sipPhone = [adata objectForKey:@"AcctName"];
                [Utility shareInstance].u_sipPwd = self.m_fieldPassword.text;
                [Utility shareInstance].u_sipServer = IP;
                
                //登录成功后，存储当前用户。
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:self.m_fieldPhone.text forKey:@"USER_1"];
                [defaults synchronize];
                
                //打开用户数据库
                [[Utility shareInstance] sqlOpen:self.m_fieldPhone.text];
                
                //跳转
                AppDelegate *iapp = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [iapp performSelector:@selector(loadMainView2) withObject:nil afterDelay:0.1f];
            }
        }
    

    }
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    m_request.delegate=nil;
    [m_request release];
    m_request = nil;
}
- (void)dealloc {
    [_m_fieldPhone release];
    [_m_fieldCardId release];
    [_m_fieldPassword release];
    [_bt_sure release];
    [_verificationCode release];
    [_verificationCodeLable release];
    [_verificationCodeBut release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setBt_sure:nil];
    [self setVerificationCode:nil];
    [self setVerificationCodeLable:nil];
    [self setVerificationCodeBut:nil];
    [super viewDidUnload];
}
- (IBAction)verificationCodeAction:(UIButton *)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (self.m_fieldPhone.text.length <= 0)
    {
        [[iToast makeToast:@"请输入手机号码"] show];
    }
    else if (![self.m_fieldPhone.text isMatchedByRegex:@"^(13|15|17|18|14)\\d{9}$"])
    {
        [[iToast makeToast:@"请输入正确的手机号码"] show];
    }else{
         NSString *iurl = [NSString stringWithFormat:@"http://120.26.121.12/api/sms.php?mobile=%@",self.m_fieldPhone.text];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[iurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    request.tag = 10;
    request.timeOutSeconds = 30L;
    [request setDelegate:self];
    [request startAsynchronous];
    updateTime = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(update)
                                                userInfo:nil
                                                 repeats:YES];//计算时间
    
    self.verificationCodeLable.hidden = NO;
    self.verificationCodeBut.hidden = YES;
    }
}
//请求开始
- (void)requestStarted:(ASIHTTPRequest *)request
{
    //NSLog(@"请求开始");
    
}

//请求完成
- (void)requestFinished:(ASIHTTPRequest *)request
{
    // NSLog(@"请求完成");
    //    NSDictionary *dic = request.responseHeaders;
    //    NSLog(@"aa%@",dic);
    //
    //    NSLog(@"hh%@",request.responseString);
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
   
    NSString*state = request.responseString;
    self.verificationCodeStr = state;
    NSLog(@"ssaaa%@",state);
       //NSLog(@"%@",[request responseString]);
    
}

//请求失败
- (void)requestFailed:(ASIHTTPRequest *)request
{
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    [[iToast makeToast:@"请求失败,请检查网络"] show];
    NSLog(@"请求失败");
}
- (void)update
{
   static int a  = 60;
        a = a-1;
    self.verificationCodeLable.text = [NSString stringWithFormat:@"%d",a ];
    if (a == 0) {
        
        self.verificationCodeLable.hidden = YES;
        self.verificationCodeBut.hidden = NO;
        if (updateTime != nil) {
            [updateTime invalidate];
            updateTime = nil;
            if ( !self.verificationCodeStr) {
                [[iToast makeToast:@"获取验证码失败"] show];
                
            }
         
       
        }

    }
}

@end
