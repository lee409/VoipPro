//
//  SignView.h
//  Move
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"


@class SignView;

@protocol SignViewDelegate <NSObject>

-(void)signView:(SignView *)signView tag:(NSInteger)tag;
@end
@interface SignView : UIView
@property (nonatomic, retain)UILabel*centersignLabel3;

@property (nonatomic, retain)UIViewController *parentVC;
@property (nonatomic,assign) id <SignViewDelegate> delegate;
+ (instancetype)defaultPopupView;


@end
