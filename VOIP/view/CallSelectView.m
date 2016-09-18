//
//  CallSelectView.m
//  VOIP
//
//  Created by hermit on 15/5/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CallSelectView.h"
#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationDrop.h"
#import "LewPopupViewAnimationSlide.h"


@implementation CallSelectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil];
        _innerView.frame = frame;
        [_displayNameTitle setText:[Utility shareInstance].u_calledName];
        [self addSubview:_innerView];
    }
    return self;
}

+ (instancetype)defaultPopupView{
    return [[CallSelectView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 303)];
}

- (IBAction)bt_free_call:(id)sender
{
    [self.delegate callSelect:0];
    
    [self closePopView];
}

- (IBAction)bt_nor_call:(id)sender
{
    [self.delegate callSelect:1];
    [self closePopView];
}

- (IBAction)bt_cancel:(id)sender
{
    [self closePopView];
}

- (void)closePopView
{
    LewPopupViewAnimationSlide *animation = [[LewPopupViewAnimationSlide alloc]init];
    animation.type = LewPopupViewAnimationSlideTypeTopBottom;
    [_parentVC lew_dismissPopupViewWithanimation:animation];
}

@end
