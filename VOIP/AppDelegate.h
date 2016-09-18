//
//  AppDelegate.h
//  VOIP
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "CustomTabbar.h"
#import "CallRecordsViewController.h"
#import "AddressBookViewController.h"
#import "PayViewController.h"
#import "MoreViewController.h"
#import "PeopleCentreViewController.h"
#import "LogInViewController.h"
#import "JumpPageViewController.h"
#import "FindController.h"
#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCallCenter.h>
#import "GetFeeView.h"
#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationSlide.h"
#import "OpenUrlViewController.h"
#import "linphonecore.h"
#import "LinphoneManager.h"
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,HttpDataRequestsDelegate,GetFeeViewDelegate,WXApiDelegate>
{
    HttpDataRequests *m_request;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CustomTabbar *mainTabBarController;
@property (strong, nonatomic) GetFeeView *getFeeview;


//- (void)loadMainView0;
- (void)loadMainView1;
- (void)loadMainView2;
-(void)login_request;
@end
//15915806324