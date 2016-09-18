//
//  ForgetPasswordNextViewController.m
//  Move
//
//  Created by apple on 16/6/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ForgetPasswordNextViewController.h"

@interface ForgetPasswordNextViewController ()

@end

@implementation ForgetPasswordNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addAavigationView:@"忘记密码" aback:@"back.png"];
    
    [self adaptiveIos1];
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

- (void)dealloc {
    [_PasswordTextField release];
    [_againPasswordTextField release];
    [_numBerStr release];
    [super dealloc];
}
- (IBAction)finishAction:(UIButton *)sender {
    if (self.PasswordTextField.text.length <= 0)
    {
        [[iToast makeToast:@"请输入密码"] show];
    }
    else if (self.PasswordTextField.text.length < 4)
    {
        [[iToast makeToast:@"密码必须4～18位"] show];
    }
    else if (self.againPasswordTextField.text.length <= 0)
    {
        [[iToast makeToast:@"请再次输入密码"] show];
    }
    else if (! [self.PasswordTextField.text isEqualToString:self.againPasswordTextField.text])
    {
        [[iToast makeToast:@"两次输入密码不同"] show];
    }else{
        [self register_request2];
    }
    
    
}
-(void)register_request2{
    NSString *iurl = [NSString stringWithFormat:@"http://120.76.78.99/api/smsapi/modify_passwd.php?act=modify&mobile=%@&password_1=%@&password_2=%@",self.numBerStr,self.PasswordTextField.text,self.againPasswordTextField.text];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[iurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    request.tag = 20;
    request.timeOutSeconds = 30L;
    [request setDelegate:self];
    [request startAsynchronous];
    
    
}
- (void)requestStarted:(ASIHTTPRequest *)request
{
    //NSLog(@"请求开始");
    
}

//请求完成
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSDictionary *stateDit = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
    
    NSString*state = stateDit[@"state"];
    
    NSString*msg = stateDit[@"msg"];
    
    // NSLog(@"ssaaa%@",state);
    
    [[iToast makeToast:msg] show];
    
    
    if ([state isEqualToString:@"01"]) {
        AppDelegate*appDelegate1 = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [appDelegate1 loadMainView1];
    }
    
    
    
    //NSLog(@"%@",[request responseString]);
    
}

//请求失败
- (void)requestFailed:(ASIHTTPRequest *)request
{
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    [[iToast makeToast:@"请求失败,请检查网络"] show];
    NSLog(@"请求失败");
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


@end
