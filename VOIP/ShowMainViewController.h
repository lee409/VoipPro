//
//  ShowMainViewController.h
//  VOIP
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "AppDelegate.h"
@interface ShowMainViewController : UIViewController
{
    NSTimer *updateTime;
}



- (IBAction)passButtonAction:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UILabel *numBerLabel;

@end
