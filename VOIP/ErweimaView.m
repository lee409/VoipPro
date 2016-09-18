//
//  ErweimaViewController.m
//  VOIP
//
//  Created by hermit on 15/5/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ErweimaView.h"



@implementation ErweimaView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil];
        _innerView.frame = frame;
        [self addSubview:_innerView];
    }
    return self;
}

+ (instancetype)defaultPopupView{
    return [[ErweimaView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
}
@end
