//
//  CallPageViewController.h
//  VOIP
//
//  Created by apple on 14-4-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpDataRequests.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface CallPageViewController : UIViewController<HttpDataRequestsDelegate,ASIProgressDelegate,ASIHTTPRequestDelegate>
{
    HttpDataRequests *m_request;
    AVAudioPlayer * m_player;
}
@property (retain, nonatomic) IBOutlet UILabel *m_label1;
@property (retain, nonatomic) IBOutlet UILabel *m_label2;
@property (retain, nonatomic) IBOutlet UILabel *m_label3;
@property (retain, nonatomic) IBOutlet UILabel *m_label4;
@property (retain, nonatomic) IBOutlet UILabel *m_label5;
@property (retain, nonatomic) IBOutlet UILabel *m_label6;
//@property (retain, nonatomic) IBOutlet UIImageView *call_image;//用故事版拖的imageview显示出来的
-(void)closePage2;
- (IBAction)bt_theEndOfThe:(id)sender;
@end
