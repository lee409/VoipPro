//
//  ChangePasswordViewController.m
//  VOIP
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ChangePasswordViewController.h"

@implementation ChangePasswordViewController

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
    [self addAavigationView:@"修改密码" aback:@"back.png"];
    [self adaptiveIos1];
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.。
}
-(void)changePassword_request
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    mbp.labelText = @"   请稍等...   ";
    NSMutableArray *insm = [NSMutableArray array];
    [insm addObject:@"changePassword_cmd"];
    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Ret", nil];
    [insm addObject:ixml];
    NSString *iurl = [NSString stringWithFormat:@"http://%@/hlwclm/editpassword.php? regnum=%@& oldpwd=%@&newpwd=%@",IP,[Utility shareInstance].u_account,self.m_oldPassword.text,self.m_newPassword1.text];
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
        if ([acmd isEqualToString:@"changePassword_cmd"])
        {
            if ( ![[Utility getErrorCHANGEPASSWORD:[[adata objectForKey:@"Ret"] intValue]] isEqualToString:@"OK"] )
            {
                [[iToast makeToast:[Utility getErrorCHANGEPASSWORD:[[adata objectForKey:@"Ret"] intValue]]] show];
            }
            else
            {
               // [MobClick event:@"2"];
                
                [Utility shareInstance].u_password = self.m_newPassword1.text;
                
                NSString *sql1 = [NSString stringWithFormat:@"UPDATE %@ SET s_password = '%@'",USERDATA,[Utility shareInstance].u_password];
                sql1 = [sql1 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
                [[Utility shareInstance] sql_inser_data:sql1,nil];
                
                [[iToast makeToast:[NSString stringWithFormat:@"新密码“%@”设置成功！",[Utility shareInstance].u_password]] show];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    m_request.delegate=nil;
    [m_request release];
    m_request = nil;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
	[super touchesBegan:touches withEvent:event];
}
//完成按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.m_oldPassword == textField)
        [self.m_newPassword1 becomeFirstResponder];
    else if(self.m_newPassword1 == textField)
         [self.m_newPassword2 becomeFirstResponder];
    else if(self.m_newPassword2 == textField)
        [textField resignFirstResponder];
    return YES;
}
- (IBAction)bt_updateAcknowledge:(id)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (self.m_oldPassword.text.length <= 0)
    {
        [[iToast makeToast:@"请输入原密码"] show];
    }
    else if ( ![self.m_oldPassword.text isMatchedByRegex: [Utility shareInstance].u_password ])
    {
        [[iToast makeToast:@"原密码输入有误"] show];
    }
    else if (self.m_newPassword1.text.length <= 0)
    {
        [[iToast makeToast:@"请输入4～18位新密码"] show];
    }
    else if ( !(self.m_newPassword1.text.length >= 4 && self.m_newPassword1.text.length <= 18) )
    {
        [[iToast makeToast:@"新密码必须4～18位"] show];
    }
    else if (self.m_newPassword2.text.length <= 0)
    {
        [[iToast makeToast:@"请确认密码"] show];
    }
    else if ( ![self.m_newPassword1.text isEqualToString:self.m_newPassword2.text] )
    {
        [[iToast makeToast:@"新密码和确认密码不一致，请重新输入"] show];
    }
    else
    {
        [self changePassword_request];
    }
}
- (void)dealloc {
    [_m_oldPassword release];
    [_m_newPassword1 release];
    [_m_newPassword2 release];
    [_bt_sure release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setBt_sure:nil];
    [super viewDidUnload];
}
@end
