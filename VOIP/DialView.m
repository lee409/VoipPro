//
//  DialView.m
//  VOIP
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "DialView.h"
#import "AppDelegate.h"
#import "CallRecordsViewController.h"

extern SystemSoundID beepSound0;
extern SystemSoundID beepSound1;
extern SystemSoundID beepSound2;
extern SystemSoundID beepSound3;
extern SystemSoundID beepSound4;
extern SystemSoundID beepSound5;
extern SystemSoundID beepSound6;
extern SystemSoundID beepSound7;
extern SystemSoundID beepSound8;
extern SystemSoundID beepSound9;
extern SystemSoundID beepSound10;
extern SystemSoundID beepSound11;

@implementation DialView

- (void)initWithFrame
{
    
    
    m_recognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    m_recognizerDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:m_recognizerDown];
    [m_recognizerDown release];
    
    
    //m_data = [[NSMutableArray alloc] initWithObjects:@"用Q宝，你就省省吧",nil];
   // m_data = [[NSMutableArray alloc] initWithArray:[self getAdMsg]];//网络请求滚动字幕
    m_message = [[UILabel alloc] initWithFrame:CGRectMake(0, 17, self.m_viewText.frame.size.width, self.m_viewText.frame.size.height-33)];
    [m_message setBackgroundColor:[UIColor whiteColor] ];
    [m_message setTextAlignment:NSTextAlignmentCenter];
    m_message.font = [UIFont fontWithName:@"TrebuchetMS" size:18];
    UIColor *icolor = [UIColor colorWithRed:255.0f/255.0f green:59.0f/255.0f blue:53.0f/255.0f alpha:1.0f];
    [m_message setTextColor:icolor];
    //[m_message setText:[m_data lastObject]];
    m_message.tag = 0;
    [self.m_viewText addSubview:m_message];
    [m_message release];
    m_topTimer= [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(topHandleTimer:) userInfo:nil repeats:YES];
    
    peoplePickerCtrl = [[ABPeoplePickerNavigationController alloc] init];
    peoplePickerCtrl.navigationBar.barStyle = UIBarStyleBlackOpaque;
    peoplePickerCtrl.peoplePickerDelegate = self;
    [peoplePickerCtrl.navigationBar setBackgroundImage:[self createImageWithColor:icolor] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)setMsgData:(NSString *)msgData
{
    [m_message setText:msgData];
    CGSize textSize = [m_message.text sizeWithFont:m_message.font];
    CGRect frame = m_message.frame;
    
    if (frame.size.width < textSize.width )
    {
        frame.size.width = textSize.width;
        m_message.frame = frame;
    }
    m_offset = 0;
}

- (void)topHandleTimer:(NSTimer*)theTimer
{
    [m_message.layer removeAllAnimations];
    
    m_offset += 1;
    
    m_message.transform = CGAffineTransformMakeTranslation( -m_offset, 0);
    
    if (m_offset > m_message.frame.size.width) {
        m_offset = -self.frame.size.width;
    }
}

//滑动隐藏
- (void)handleSwipeFrom:(UISwipeGestureRecognizer*)recognizer
{
    CustomTabbar *mainTabBarController = ((AppDelegate *)[UIApplication sharedApplication].delegate).mainTabBarController;
    [mainTabBarController when_tabbar_is_selected:0];
   
}


- (NSArray *)getAdMsg
{

    return 0;
    
}


- (void)dealloc
{
    [peoplePickerCtrl release];
    
    [m_data release];
    [m_topTimer invalidate];
    m_topTimer = nil;
    
    [self removeGestureRecognizer:m_recognizerDown];
    [_m_phoneNumber release];
    [_m_viewText release];
    [super dealloc];
}
- (IBAction)m_button1:(id)sender {
    [self bt_pubilc:@"1"];
}

- (IBAction)m_button2:(id)sender {
    [self bt_pubilc:@"2"];
}

- (IBAction)m_button3:(id)sender {
    [self bt_pubilc:@"3"];
}

- (IBAction)m_button4:(id)sender {
    [self bt_pubilc:@"4"];
}

- (IBAction)m_button5:(id)sender {
    [self bt_pubilc:@"5"];
}

- (IBAction)m_button6:(id)sender {
    [self bt_pubilc:@"6"];
}

- (IBAction)m_button7:(id)sender {
    [self bt_pubilc:@"7"];
}

- (IBAction)m_button8:(id)sender {
    [self bt_pubilc:@"8"];
}

- (IBAction)m_button9:(id)sender {
    [self bt_pubilc:@"9"];
}

- (IBAction)m_button10:(id)sender {
    [(CallRecordsViewController*)self.superview.nextResponder go_callsetting];
}

- (IBAction)m_button11:(id)sender {
    [self bt_pubilc:@"0"];
}

- (IBAction)m_button12:(id)sender {
    if (self.m_phoneNumber.text.length <= 11  )
    {
        self.m_phoneNumber.text = [self.m_phoneNumber.text stringByReplacingOccurrencesOfString:@"-" withString:@""];;
    }
    if ( self.m_phoneNumber.text.length > 0 )
    {
        self.m_phoneNumber.text = [self.m_phoneNumber.text substringToIndex:self.m_phoneNumber.text.length-1];
    }
    if ( self.m_phoneNumber.text.length<=0 )
    {
        self.m_viewText.hidden = NO;
        [(CallRecordsViewController*)self.superview.nextResponder showDialCallBar:NO];
    }
    [(CallRecordsViewController*)self.superview.nextResponder searchingAddressList:self.m_phoneNumber.text];
    
}

-(void)bt_pubilc:(NSString*)anumber
{
   
    
    if (self.m_phoneNumber.text.length>=13)
    {
        return;
    }
    [(CallRecordsViewController*)self.superview.nextResponder showDialCallBar:YES];
    self.m_phoneNumber.text = [self.m_phoneNumber.text stringByAppendingString:anumber];
    self.m_viewText.hidden = YES;
    if (self.m_phoneNumber.text.length > 0) {
        [self hideOrShowADView:YES];
        
    }else
    {
        [self hideOrShowADView:NO];
    }
    [(CallRecordsViewController*)self.superview.nextResponder searchingAddressList:self.m_phoneNumber.text];
    if ([self.m_phoneNumber.text isMatchedByRegex:@"^(13|15|18|14)\\d\{7}$"])
    {
        NSMutableString *istring = [NSMutableString stringWithString:self.m_phoneNumber.text];
        [istring insertString:@"-" atIndex:3];
        [istring insertString:@"-" atIndex:8];
        self.m_phoneNumber.text = istring;
    }
    if ([[Utility shareInstance].u_keyboardShake isEqualToString:@"0"])
    {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    if ([[Utility shareInstance].u_keyboardVoice isEqualToString:@"0"])
    {
        if ([anumber isEqualToString:@"0"]){
            AudioServicesPlaySystemSound(beepSound0);
        }
        else if ([anumber isEqualToString:@"1"]){
            AudioServicesPlaySystemSound(beepSound1);
        }
        else if ([anumber isEqualToString:@"2"]){
            AudioServicesPlaySystemSound(beepSound2);
        }
        else if ([anumber isEqualToString:@"3"]){
            AudioServicesPlaySystemSound(beepSound3);
        }
        else if ([anumber isEqualToString:@"4"]){
            AudioServicesPlaySystemSound(beepSound4);
        }
        else if ([anumber isEqualToString:@"5"]){
            AudioServicesPlaySystemSound(beepSound5);
        }
        else if ([anumber isEqualToString:@"6"]){
            AudioServicesPlaySystemSound(beepSound6);
        }
        else if ([anumber isEqualToString:@"7"]){
            AudioServicesPlaySystemSound(beepSound7);
        }
        else if ([anumber isEqualToString:@"8"]){
            AudioServicesPlaySystemSound(beepSound8);
        }
        else if ([anumber isEqualToString:@"9"]){
            AudioServicesPlaySystemSound(beepSound9);
        }
        else if ([anumber isEqualToString:@"*"]){
            AudioServicesPlaySystemSound(beepSound11);
        }
        else if ([anumber isEqualToString:@"#"]){
            AudioServicesPlaySystemSound(beepSound10);
        }
    }
}

- (void)bohao
{
        [Utility shareInstance].u_calledHuiboOrZhibo = @"1";
        [Utility shareInstance].u_calledNumber = [self.m_phoneNumber.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        CallRecordsViewController *iself = (CallRecordsViewController *)self.superview.nextResponder;
        if ([[iself Back_filteredArray] isEqualToString:@"匿名"])
        {
            [Utility shareInstance].u_calledName = [Utility shareInstance].u_calledNumber;
        }
        else
        {
            
            if ([[iself Back_filteredArray_phone] isEqualToString:[Utility shareInstance].u_calledNumber]) {
                [Utility shareInstance].u_calledName = [iself Back_filteredArray];
            }else{
                [Utility shareInstance].u_calledName = [Utility shareInstance].u_calledNumber;
            }
            
            
        }
        //[[Utility shareInstance] callPhonaPage:iself];
    
        self.m_phoneNumber.text = @"";
        self.m_viewText.hidden = NO;
        [(CallRecordsViewController*)self.superview.nextResponder searchingAddressList:self.m_phoneNumber.text];

}

- (IBAction)m_bohao:(id)sender
{

    
//    [Utility shareInstance].u_calledHuiboOrZhibo = @"1";
//    [Utility shareInstance].u_calledNumber = [self.m_phoneNumber.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
//    CallRecordsViewController *iself = (CallRecordsViewController *)self.superview.nextResponder;
//    if ([[iself Back_filteredArray] isEqualToString:@"匿名"])
//    {
//        [Utility shareInstance].u_calledName = [Utility shareInstance].u_calledNumber;
//    }
//    else
//    {
//        [Utility shareInstance].u_calledName = [iself Back_filteredArray];
//    }
//    [[Utility shareInstance] callPhonaPage:iself];
//    
//    self.m_phoneNumber.text = @"";
//    self.m_viewText.hidden = NO;
//    //显示广告
//    [self hideOrShowADView:NO];
//    
//
//    [(CallRecordsViewController*)self.superview.nextResponder searchingAddressList:self.m_phoneNumber.text];

    NSString *itype = [Utility shareInstance].u_dialWay;
    if ( [itype isEqualToString:@"0"] )//智能拨打
    {
        if ( [[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable )
        {
            [self callSelect:0];
        }
        else
        {
            [self callSelect:1];
        }
    }
    else if ( [itype isEqualToString:@"1"] )//回拨
    {
        [self callSelect:1];
    }
    else if ( [itype isEqualToString:@"2"] )//直拨
    {
       [self callSelect:0];
    }
    else if ( [itype isEqualToString:@"3"] )//手动选择
    {
        CallSelectView *view = [CallSelectView defaultPopupView];
         CallRecordsViewController *iself = (CallRecordsViewController *)self.superview.nextResponder;
        view.parentVC = iself;
        view.delegate = self;
        LewPopupViewAnimationSlide *animation = [[LewPopupViewAnimationSlide alloc]init];
        animation.type = LewPopupViewAnimationSlideTypeBottomBottomEdge;
        [iself lew_presentPopupView:view animation:animation dismissed:^{
            
        }];

    }
    

}

- (void)callSelect:(NSInteger)tag
{
    if (tag == 0) {
        [Utility shareInstance].u_calledHuiboOrZhibo = @"0";
        [Utility shareInstance].u_calledNumber = [self.m_phoneNumber.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        CallRecordsViewController *iself2 = (CallRecordsViewController *)self.superview.nextResponder;
        [[Utility shareInstance] callPhonaPage:iself2];
    }else{
        [Utility shareInstance].u_calledHuiboOrZhibo = @"1";
        [Utility shareInstance].u_calledNumber = [self.m_phoneNumber.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        CallRecordsViewController *iself = (CallRecordsViewController *)self.superview.nextResponder;
        if ([[iself Back_filteredArray] isEqualToString:@"匿名"])
        {
            [Utility shareInstance].u_calledName = [Utility shareInstance].u_calledNumber;
        }
        else
        {
            [Utility shareInstance].u_calledName = [iself Back_filteredArray];
        }
        [[Utility shareInstance] callPhonaPage:iself];
        
        self.m_phoneNumber.text = @"";
        self.m_viewText.hidden = NO;
        
        [self hideOrShowADView:NO];
        
        
        [(CallRecordsViewController*)self.superview.nextResponder searchingAddressList:self.m_phoneNumber.text];
    }
}

- (IBAction)m_houtui:(id)sender
{
    if (self.m_phoneNumber.text.length <= 11  )
    {
        self.m_phoneNumber.text = [self.m_phoneNumber.text stringByReplacingOccurrencesOfString:@"-" withString:@""];;
    }
    if ( self.m_phoneNumber.text.length > 0 )
    {
        self.m_phoneNumber.text = [self.m_phoneNumber.text substringToIndex:self.m_phoneNumber.text.length-1];
    }
    if ( self.m_phoneNumber.text.length<=0 )
    {
        self.m_viewText.hidden = NO;
        [self hideOrShowADView:NO];
        

    }
    [(CallRecordsViewController*)self.superview.nextResponder searchingAddressList:self.m_phoneNumber.text];
}

//隐藏view  ADView
-(void)hideOrShowADView:(BOOL)b
{
    CustomTabbar *mainTabBarController = ((AppDelegate *)[UIApplication sharedApplication].delegate).mainTabBarController;
    
    UINavigationController *oneNavigationController = (UINavigationController *)[mainTabBarController.viewControllers objectAtIndex:0];
    CallRecordsViewController *oneViewController = (CallRecordsViewController*)[oneNavigationController.viewControllers objectAtIndex:0];
    for(UIView *view in oneViewController.view.subviews)
    {
        if([view isKindOfClass:[ADView class]])
        {
            view.hidden = b;
            ADView *adView = [view retain];
    
            if (b)
            {
                
                [adView stopTimer];//隐藏时关闭定时器
            }
            else
            {
                [adView startTimer];
            }
            [adView release];
        }
        else if ([view isKindOfClass:[UITableView class]])
        {
            CGRect frame = view.frame;
            frame.origin.y = 0;
            view.frame =frame;
        }
    }

}

- (IBAction)m_addressBook:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"新建联系人",@"添加到现有联系人", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    UIViewController *iview = (UIViewController *)self.superview.nextResponder;
    [actionSheet showFromTabBar:(UITabBar *)[iview.parentViewController view]];
    actionSheet.tag = 1;
    [actionSheet release];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==0)
    {
        switch (buttonIndex)
        {
            case 0:
                [Utility shareInstance].u_calledHuiboOrZhibo = @"1";
                [Utility shareInstance].u_calledNumber = [self.m_phoneNumber.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
                CallRecordsViewController *iself = (CallRecordsViewController *)self.superview.nextResponder;
                if ([[iself Back_filteredArray] isEqualToString:@"匿名"])
                {
                    [Utility shareInstance].u_calledName = [Utility shareInstance].u_calledNumber;
                }
                else
                {
                    [Utility shareInstance].u_calledName = [iself Back_filteredArray];
                }
                [[Utility shareInstance] callPhonaPage:iself];
                
                self.m_phoneNumber.text = @"";
                self.m_viewText.hidden = NO;
              
                [self hideOrShowADView:NO];
                

                [(CallRecordsViewController*)self.superview.nextResponder searchingAddressList:self.m_phoneNumber.text];
                break;
            case 1:
                [[iToast makeToast:@"该功能暂时未开启，请联系开发商！"] show];
                break;
            default:
                break;
        }
    }
    else
    {
        switch (buttonIndex)
        {
            case 0: // Create new contact
                [self addNewPerson];
                break;
            case 1: // Add to existing Contact
                {
                    CallRecordsViewController *iself = (CallRecordsViewController *)self.superview.nextResponder;
                    [iself presentViewController:peoplePickerCtrl animated:YES completion:nil];
                }
                break;
            default:
                break;
        }
    }
}
- (void)addNewPerson
{
    CFErrorRef error = NULL;
    // Create New Contact
    ABRecordRef person = ABPersonCreate ();
    
    // Add phone number
    ABMutableMultiValueRef multiValue =
    ABMultiValueCreateMutable(kABStringPropertyType);
    
    ABMultiValueAddValueAndLabel(multiValue, [self.m_phoneNumber text], kABPersonPhoneMainLabel,
                                 NULL);
    
    ABRecordSetValue(person, kABPersonPhoneProperty, multiValue, &error);
    
    
    ABNewPersonViewController *newPersonCtrl = [[ABNewPersonViewController alloc] init];
    newPersonCtrl.newPersonViewDelegate = self;
    newPersonCtrl.displayedPerson = person;
    CFRelease(person); // TODO check
    
    UINavigationController *navCtrl = [[UINavigationController alloc]
                                       initWithRootViewController:newPersonCtrl];
    
    
    
    
    UIColor *icolor = [UIColor colorWithRed:50.0f/255.0f green:150.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    [navCtrl.navigationBar setBackgroundImage:[self createImageWithColor:icolor] forBarMetrics:UIBarMetricsDefault];
    
    
    navCtrl.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIViewController *iview = (UIViewController *)self.superview.nextResponder;
    [iview.parentViewController presentViewController:navCtrl animated:YES completion:nil];
    [newPersonCtrl release];
    [navCtrl release];
}
#pragma mark ABNewPersonViewControllerDelegate
- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController didCompleteWithNewPerson:(ABRecordRef)person
{
    [newPersonViewController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark ABPeoplePickerNavigationControllerDelegate
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    CFErrorRef error = NULL;
    BOOL status;
    ABMutableMultiValueRef multiValue;
    // Inserer le numéro dans la fiche de la personne
    // Add phone number
    CFTypeRef typeRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    if (ABMultiValueGetCount(typeRef) == 0)
        multiValue = ABMultiValueCreateMutable(kABStringPropertyType);
    else
        multiValue = ABMultiValueCreateMutableCopy (typeRef);
    
    // TODO type (mobile, main...)
    // TODO manage URI
    status = ABMultiValueAddValueAndLabel(multiValue, [self.m_phoneNumber text], kABPersonPhoneMainLabel,
                                          NULL);
    
    status = ABRecordSetValue(person, kABPersonPhoneProperty, multiValue, &error);
    status = ABAddressBookSave(peoplePicker.addressBook, &error);
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    return NO;
}
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}
@end