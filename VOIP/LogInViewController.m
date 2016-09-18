//
//  LogInViewController.m
//  VOIP
//
//  Created by apple on 14-3-22.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "LogInViewController.h"
#import "ForgetPasswordViewController.h"


@implementation LogInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self addAavigationView:@"登陆" aback:nil];
     [self addAavigationView:@"登陆" aback:nil];      
    
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
    int addLength = string.length;
    int delLength = range.length;
    int nowLength = textField.text.length;
    int totolLength = nowLength + addLength - delLength;
    
    if (textField == self.m_fieldPhone)
    {
        if (totolLength > 11) {
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
- (IBAction)bt_login:(id)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (self.m_fieldPhone.text.length <= 0)
    {
        [[iToast makeToast:@"请输入手机号码"] show];
    }
    else if (![self.m_fieldPhone.text isMatchedByRegex:@"^(13|15|17|18|14)\\d{9}$"])
    {
        [[iToast makeToast:@"请输入正确的手机号码"] show];
    }
    else if (self.m_fieldPassword.text.length <= 0)
    {
        [[iToast makeToast:@"请输入密码"] show];
    }
    else if ( !(self.m_fieldPassword.text.length >= 4 && self.m_fieldPassword.text.length <= 18) )
    {
        [[iToast makeToast:@"密码必须4～18位"] show];
    }
    else
    {
        [self login_request];
       
    }
}

- (IBAction)bt_register:(id)sender {
    RegisterViewController *ctl = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:ctl animated:YES];
    [ctl release];
}

- (IBAction)forgetPassword:(UIButton *)sender {
    ForgetPasswordViewController *forgetVC = [[ForgetPasswordViewController alloc] initWithNibName:@"ForgetPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:forgetVC animated:YES];
    [forgetVC release];
    
    
}
//登录。
-(void)login_request
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    mbp.labelText = @"   请稍等...   ";
    NSMutableArray *insm = [NSMutableArray array];
    [insm addObject:@"login_cmd"];
    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Ret",@"",@"AcctName", nil];
    [insm addObject:ixml];
    NSString *iurl = [NSString stringWithFormat:@"http://%@/api/userlogin.php?regnum=%@&regpwd=%@",IP,self.m_fieldPhone.text,self.m_fieldPassword.text];
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
        if ([acmd isEqualToString:@"login_cmd"])
        {
            if ( ![[Utility getErrorLOGIN:[[adata objectForKey:@"Ret"] intValue]] isEqualToString:@"OK"] )
            {
                [[iToast makeToast:[Utility getErrorLOGIN:[[adata objectForKey:@"Ret"] intValue]]] show];
            }
            else
            {
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
    [_m_fieldPassword release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setM_fieldPassword:nil];
    [super viewDidUnload];
}
@end
