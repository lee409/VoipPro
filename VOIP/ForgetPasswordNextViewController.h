//
//  ForgetPasswordNextViewController.h
//  Move
//
//  Created by apple on 16/6/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpDataRequests.h"
#import "AppDelegate.h"
#import "Utility.h"
@interface ForgetPasswordNextViewController : UIViewController<ASIHTTPRequestDelegate>
@property (retain, nonatomic) IBOutlet UITextField *PasswordTextField;
@property (retain, nonatomic) IBOutlet UITextField *againPasswordTextField;
- (IBAction)finishAction:(UIButton *)sender;
@property(retain,nonatomic)NSString*numBerStr;
@end
