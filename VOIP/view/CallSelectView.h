//
//  CallSelectView.h
//  VOIP
//
//  Created by hermit on 15/5/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"

@protocol CallSelectViewDelegate <NSObject>

-(void)callSelect:(NSInteger)tag;
@end

@interface CallSelectView : UIView

@property (nonatomic,assign) id <CallSelectViewDelegate> delegate;
@property (retain, nonatomic) IBOutlet UIView *innerView;
@property (nonatomic, weak)UIViewController *parentVC;
+ (instancetype)defaultPopupView;
- (IBAction)bt_free_call:(id)sender;
- (IBAction)bt_nor_call:(id)sender;
- (IBAction)bt_cancel:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *displayNameTitle;

@end
