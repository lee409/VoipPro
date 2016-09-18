//
//  CallPageViewController2.h
//  VOIP
//
//  Created by apple on 14-6-3.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "LinphoneManager.h"
#import "UIMicroButton.h"
#import "UIPauseButton.h"

@interface CallPageViewController2 : UIViewController
{
    NSTimer *updateTime;
}
@property (retain, nonatomic) IBOutlet UILabel *m_label1;
@property (retain, nonatomic) IBOutlet UILabel *m_label2;
@property (retain, nonatomic) IBOutlet UILabel *m_label3;
@property (retain, nonatomic) IBOutlet UILabel *m_label4;
@property (retain, nonatomic) IBOutlet UILabel *m_label5;
- (IBAction)bt_theEndOfThe:(id)sender;
- (IBAction)bt_handsFree:(id)sender;
- (IBAction)bt_muteSwitch:(id)sender;
- (IBAction)bt_callPause:(id)sender;
@end
