//
//  RecommendViewController.h
//  Move
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MessageUI/MFMessageComposeViewController.h>

@interface RecommendViewController : UIViewController
@property (retain, nonatomic) NSString *shareText;
@property (retain,nonatomic) NSString *shareUrl;
- (IBAction)shareAction:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UILabel *peopleNumberLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UIScrollView *shareScrolllView;

@end
