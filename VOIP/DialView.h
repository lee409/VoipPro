//
//  DialView.h
//  VOIP
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AddressBookUI/AddressBookUI.h>
#import "CallSelectView.h"
@interface DialView : UIView <UIActionSheetDelegate,ABNewPersonViewControllerDelegate,CallSelectViewDelegate,ABPeoplePickerNavigationControllerDelegate>
{
    UISwipeGestureRecognizer* m_recognizerDown;
    UILabel *m_message;
    NSTimer *m_topTimer;
    NSArray *m_data;
    ABPeoplePickerNavigationController *peoplePickerCtrl;
    CGFloat m_offset;
}
- (void)initWithFrame;
- (IBAction)m_button1:(id)sender;
- (IBAction)m_button2:(id)sender;
- (IBAction)m_button3:(id)sender;
- (IBAction)m_button4:(id)sender;
- (IBAction)m_button5:(id)sender;
- (IBAction)m_button6:(id)sender;
- (IBAction)m_button7:(id)sender;
- (IBAction)m_button8:(id)sender;
- (IBAction)m_button9:(id)sender;
- (IBAction)m_button10:(id)sender;
- (IBAction)m_button11:(id)sender;
- (IBAction)m_button12:(id)sender;
- (IBAction)m_bohao:(id)sender;
- (IBAction)m_houtui:(id)sender;
- (IBAction)m_addressBook:(id)sender;
- (void)bohao;
@property (retain, nonatomic) IBOutlet UILabel *m_phoneNumber;
@property (retain, nonatomic) IBOutlet UIView *m_viewText;
@property (strong,nonatomic) NSString *msgData;
@end
