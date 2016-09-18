//
//  SysInfoViewController.h
//  VOIP
//
//  Created by hermit on 14-12-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"

typedef enum{
    SysInfoType = 0,//系统信息
    AttentionType = 1,//相关说明
    CooperationType = 2,//合作加盟
    HomeType = 3,//关于我们
    
}InfoType;

@interface SysInfoViewController : UIViewController

@property (assign,nonatomic) InfoType type;
@property (retain, nonatomic) IBOutlet UITextView *textView;


@end
