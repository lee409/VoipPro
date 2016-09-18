//
//  ShangbiCardPayViewController.h
//  VOIP
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "HttpDataRequests.h"

@interface ShangbiCardPayViewController : UIViewController<HttpDataRequestsDelegate,ASIHTTPRequestDelegate,ASIProgressDelegate>
{
    HttpDataRequests *m_request;
}
@property (retain, nonatomic) IBOutlet UITextField *m_phoneNumber;
@property (retain, nonatomic) IBOutlet UITextField *m_shangbiCard;
@property (retain, nonatomic) IBOutlet UIButton *bt_sure;
@property (retain, nonatomic) IBOutlet UITextField *m_passWord;
@property (retain, nonatomic) IBOutlet UIScrollView *ScrollView;
- (IBAction)bt_topUp:(id)sender;
@end
