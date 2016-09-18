//
//  AddressBookViewController.h
//  VOIP
//
//  Created by apple on 14-3-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pinyin.h"
#import "POAPinyin.h"
#import "RegexKitLite.h"
#import "Utility.h"
#import "CallSelectView.h"
#import "AppDelegate.h"

@interface AddressBookViewController : UITableViewController<HttpDataRequestsDelegate,UIActionSheetDelegate,UISearchDisplayDelegate,CallSelectViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    HttpDataRequests *m_request;
    NSMutableDictionary *m_sectionDic;
    NSMutableDictionary *m_phoneDic;
    NSMutableArray *m_sortedKeys;
    NSMutableArray *m_filteredArray;
}
@property(nonatomic,strong)NSMutableArray*modelArray;
@property(nonatomic,strong)NSMutableArray*linkManArray;
@property(nonatomic,strong)NSArray*filteredArray;

@end
