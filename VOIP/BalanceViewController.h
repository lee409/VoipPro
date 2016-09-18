//
//  BalanceViewController.h
//  VOIP
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "HttpDataRequests.h"
#import "AppDelegate.h"
#import "BalanceTableViewCell.h"

@interface BalanceViewController : UIViewController<HttpDataRequestsDelegate,ASIHTTPRequestDelegate,ASIProgressDelegate,UITableViewDataSource,UITableViewDelegate,BalanceTableViewCellDelegate>
{
    HttpDataRequests *m_request;
     HttpDataRequests *m_request1;
    BOOL _isOpen[2];
  
 
   
}
@property (retain, nonatomic) IBOutlet UIButton *bt_sure;
@property (retain, nonatomic) IBOutlet UILabel *m_account;
@property (retain, nonatomic) IBOutlet UILabel *m_balance;
@property (retain, nonatomic) IBOutlet UILabel *m_deadline;
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,retain)NSMutableArray*butarray;
@property(nonatomic,retain)UITextField*textStr1;
@property(nonatomic,retain)UITextField*textStr2;
@property(nonatomic,retain)UITextField*textStr3;
@property(nonatomic,retain)NSString*str3;
- (void)bt_goPay:(id)sender;
@end
