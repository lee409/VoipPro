//
//  ErweimaViewController.h
//  VOIP
//
//  Created by hermit on 15/5/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ErweimaView : UIView
@property (retain, nonatomic) IBOutlet UIView *innerView;
@property (nonatomic, weak)UIViewController *parentVC;


+ (instancetype)defaultPopupView;
@end
