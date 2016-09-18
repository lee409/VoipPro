//
//  MoreViewController.h
//  VOIP
//
//  Created by apple on 14-3-19.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BalanceViewController.h"
#import "CorrelationViewController.h"
#import "AboutViewController.h"
#import "ChangePasswordViewController.h"
#import "CallerIDPrivacyViewController.h"
#import <MessageUI/MFMessageComposeViewController.h>
//#import "UMFeedback.h"
#import "SysInfoViewController.h"
#import "ShareViewController.h"
#import "CallSelectView.h"

@interface MoreViewController : UIViewController<HttpDataRequestsDelegate,MFMessageComposeViewControllerDelegate,CallSelectViewDelegate>
{
    HttpDataRequests *m_request;
}
@end
