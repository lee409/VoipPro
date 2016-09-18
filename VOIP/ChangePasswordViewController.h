//
//  ChangePasswordViewController.h
//  VOIP
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpDataRequests.h"
#import "Utility.h"

@interface ChangePasswordViewController : UIViewController<HttpDataRequestsDelegate>
{
    HttpDataRequests *m_request;
}
@property (retain, nonatomic) IBOutlet UITextField *m_oldPassword;
@property (retain, nonatomic) IBOutlet UITextField *m_newPassword1;
@property (retain, nonatomic) IBOutlet UITextField *m_newPassword2;
@property (retain, nonatomic) IBOutlet UIButton *bt_sure;
- (IBAction)bt_updateAcknowledge:(id)sender;
@end
