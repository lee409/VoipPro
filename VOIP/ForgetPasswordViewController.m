//
//  ForgetPasswordViewController.m
//  Move
//
//  Created by apple on 16/6/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ForgetPasswordNextViewController.h"

@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
    if (updateTime != nil) {
        [updateTime invalidate];
        updateTime = nil;
    }
}
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
    [_numberTextField release];
    [_verificationCodeTextField release];
    [_numLabel release];
    [_GetverificationCodeButton release];
    [super dealloc];
}
- (IBAction)GetverificationCodeAction:(UIButton *)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (self.numberTextField.text.length <= 0)
    {
        [[iToast makeToast:@"请输入手机号码"] show];
    }
    else if (![self.numberTextField.text isMatchedByRegex:@"^(13|15|17|18|14)\\d{9}$"])
    {
        [[iToast makeToast:@"请输入正确的手机号码"] show];
    }
    else
    {
        //[[iToast makeToast:@"正在获取验证码，请注意查收"] show];
        [self forget_request];
        
    }
    
    
    
}
- (IBAction)nextAction:(UIButton *)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (self.numberTextField.text.length <= 0)
    {
        [[iToast makeToast:@"请输入手机号码"] show];
    }
    else if (![self.numberTextField.text isMatchedByRegex:@"^(13|15|17|18|14)\\d{9}$"])
    {
        [[iToast makeToast:@"请输入正确的手机号码"] show];
    }
    else if (self.verificationCodeTextField.text.length <= 0)
    {
        [[iToast makeToast:@"请输入验证码"] show];
    }
    else
    {
        [self forget_request1];
    }
    
}

-(void)forget_request{
    
    updateTime = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(update)
                                                userInfo:nil
                                                 repeats:YES];//计算时间
    
    self.numLabel.hidden = NO;
    self.GetverificationCodeButton.hidden = YES;
    
    NSString *iurl1 = [NSString stringWithFormat:@"http://120.76.78.99/api/smsapi/sms_send.php?mobile=%@&sms_type=other&system_type=2",self.numberTextField.text];
    NSLog(@"%@",iurl1);
    request1 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[iurl1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    request1.tag = 10;
    request1.timeOutSeconds = 30L;
    [request1 setDelegate:self];
    [request1 startAsynchronous];
    
    
}
- (void)update
{
    static int a  = 60;
    a = a-1;
    self.numLabel.text = [NSString stringWithFormat:@"%d",a ];
    if (a == 0) {
        
        self.numLabel.hidden = YES;
        self.numLabel.text = @"60";
        self.GetverificationCodeButton.hidden = NO;
        a  = 60;
        
        if (updateTime != nil) {
            [updateTime invalidate];
            updateTime = nil;
            
            
        }
        
    }
}



-(void)forget_request1{
    NSString *iurl = [NSString stringWithFormat:@"http://120.76.78.99/api/smsapi/modify_passwd.php?act=submit&mobile=%@&vali_code=%@",self.numberTextField.text,self.verificationCodeTextField.text];
    request2 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[iurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    request2.tag = 20;
    request2.timeOutSeconds = 30L;
    [request2 setDelegate:self];
    [request2 startAsynchronous];
    
    
}
- (void)requestStarted:(ASIHTTPRequest *)request
{
    //NSLog(@"请求开始");
    
}

//请求完成
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    if (request.tag == 10) {
        NSLog(@"1111sss%@",request.responseData );
        NSLog(@"1111sss%@",request.responseString );
        NSData*date = [request.responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"f1111sss%@",date);
        NSDictionary *stateDit = [NSJSONSerialization JSONObjectWithData:date options:NSJSONReadingMutableContainers error:nil];
        NSString*state = stateDit[@"state"];
        NSLog(@"sss%@",state);
        NSString*msg = stateDit[@"msg"];
        NSLog(@"ccc%@",msg);
        
        
        
        //       NSString*responseString = request.responseString;
        //        NSLog(@"11sss%@",request.responseString);
        //        NSString*state = stateDit[@"state"];
        //        NSLog(@"sss%@",state);
        //        NSString*msg = stateDit[@"msg"];
        //        NSLog(@"ccc%@",msg);
        // NSLog(@"ssaaa%@",state);
        //        NSArray*resustOut = [responseString componentsSeparatedByString:@","];
        //        for (NSString*str in resustOut) {
        //         if ([str rangeOfString:@"msg"].location != NSNotFound) {
        //            NSString*ss = [str componentsSeparatedByString:@":"][1];
        //             NSData*date = [ss dataUsingEncoding:NSUTF8StringEncoding];
        //             NSString*dd = [[NSString alloc]initWithData:date encoding:NSUTF8StringEncoding];
        //
        //
        //             NSLog(@"sssss%@",dd);
        //
        //            [[iToast makeToast:dd] show];
        //             break;
        //
        //            }
        //
        //
        //
        //        }
        [[iToast makeToast:msg] show];
        
    }else if (request.tag == 20){
        
        NSLog(@"2222sss%@",request.responseData );
        NSLog(@"2222sss%@",request.responseString );
        
        
        NSDictionary *stateDit = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        NSString*state = stateDit[@"state"];
        NSLog(@"sss%@",state);
        NSString*msg = stateDit[@"msg"];
        NSLog(@"ccc%@",msg);
        
        
        
        if ([state isEqualToString:@"1"]) {
            ForgetPasswordNextViewController *forgetVC = [[ForgetPasswordNextViewController alloc] initWithNibName:@"ForgetPasswordNextViewController" bundle:nil];
            forgetVC.numBerStr = self.numberTextField.text;
            [self.navigationController pushViewController:forgetVC animated:YES];
            [forgetVC release];
        }
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
