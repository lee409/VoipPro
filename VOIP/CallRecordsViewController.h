//
//  CallRecordsViewController.h
//  VOIP
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpDataRequests.h"
#import "ADView.h"
#import "DialView.h"
#import "Utility.h"
#import "FileOperationHelp.h"
#import "CallSelectView.h"
@interface CallRecordsViewController : UIViewController<UIActionSheetDelegate,HttpDataRequestsDelegate,ADViewOpenUrlDelegate,CallSelectViewDelegate>
{
    NSMutableDictionary *m_phoneDic;
    NSMutableArray *m_filteredArray;
    NSMutableArray *m_callRecords;
    NSMutableDictionary *m_sectionDic;
    UIButton *m_balance;
    HttpDataRequests *m_request;
    ADView *m_adView;
    DialView *m_dialView;
    BOOL m_first_request_ad;
     UIView *m_dialCallBar;
    NSMutableDictionary *m_DialAphla;
    
}
-(void)searchingAddressList:(NSString*)istring;
-(NSString*)Back_filteredArray;
-(NSString*)Back_filteredArray_phone;
@property (retain, nonatomic) IBOutlet UITableView *tableViewCallLog;
-(void)tableView_reloadData;
-(void)go_callsetting;
- (void)showDialCallBar:(BOOL) b;
@end
