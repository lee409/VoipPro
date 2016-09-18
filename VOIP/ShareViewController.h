//
//  ShareViewController.h
//  VOIP
//
//  Created by hermit on 14-11-28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "UMSocial.h"
#import "UMSocialControllerService.h"

#import "HttpDataRequests.h"
@protocol ShareViewControllerDelegate <NSObject>

@optional
- (void)shareFinish;

@end

@interface ShareViewController : UIViewController<UMSocialUIDelegate>

@property (strong, nonatomic) NSString *shareText;
@property (strong,nonatomic) NSString *shareUrl;
@property (assign, nonatomic) id <ShareViewControllerDelegate> delegate;

@property (strong,nonatomic) NSString *pid;

@end
