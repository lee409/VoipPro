//
//  ForgetPasswordViewController.h
//  Move
//
//  Created by apple on 16/6/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpDataRequests.h"
#import "AppDelegate.h"
#import "Utility.h"

@interface ForgetPasswordViewController : UIViewController<ASIHTTPRequestDelegate>{
    NSTimer *updateTime;
    ASIHTTPRequest *request1;
    ASIHTTPRequest *request2;
    
    
}
@property (retain, nonatomic) IBOutlet UITextField *numberTextField;
- (IBAction)GetverificationCodeAction:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UITextField *verificationCodeTextField;
- (IBAction)nextAction:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UILabel *numLabel;
@property (retain, nonatomic) IBOutlet UIButton *GetverificationCodeButton;

@end
