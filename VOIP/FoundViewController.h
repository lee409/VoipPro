//
//  FoundViewController.h
//  VOIP
//
//  Created by hermit on 14-9-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADView.h"
#import "ItemHelpViewController.h"
#import "FileOperationHelp.h"
#import "MyTapGestureRecognizer.h"
#import "Utility.h"
@interface FoundViewController : UIViewController<ADViewOpenUrlDelegate>
{
    ADView *m_adView;
}
@property (strong,nonatomic) NSMutableArray *dataList;
@end
