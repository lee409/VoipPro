//
//  LogInViewController.h
//  VOIP
//
//  Created by apple on 14-3-22.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterViewController.h"
#import "HttpDataRequests.h"
#import "AppDelegate.h"
#import "Utility.h"

@interface LogInViewController : UIViewController<UITextFieldDelegate,HttpDataRequestsDelegate>
{
    HttpDataRequests *m_request;
}
@property (retain, nonatomic) IBOutlet UITextField *m_fieldPhone;
@property (retain, nonatomic) IBOutlet UITextField *m_fieldPassword;
- (IBAction)bt_login:(id)sender;
- (IBAction)bt_register:(id)sender;
- (IBAction)forgetPassword:(UIButton *)sender;


@end
