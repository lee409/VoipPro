//
//  RegisterViewController.h
//  VOIP
//
//  Created by apple on 14-3-26.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "HttpDataRequests.h"
#import "AppDelegate.h"

@interface RegisterViewController : UIViewController<UITextFieldDelegate,HttpDataRequestsDelegate,ASIHTTPRequestDelegate>
{
    HttpDataRequests *m_request;
    NSTimer *updateTime;
    
}
@property (retain, nonatomic) IBOutlet UITextField *m_fieldPhone;
@property (retain, nonatomic) IBOutlet UITextField *m_fieldCardId; 
@property (retain, nonatomic) IBOutlet UIButton *bt_sure;
@property (retain, nonatomic) IBOutlet UITextField *m_fieldPassword;
- (IBAction)bt_registerButton:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *verificationCode;
@property(retain,nonatomic)NSString*verificationCodeStr;
- (IBAction)verificationCodeAction:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet UILabel *verificationCodeLable;
@property (retain, nonatomic) IBOutlet UIButton *verificationCodeBut;

@end
