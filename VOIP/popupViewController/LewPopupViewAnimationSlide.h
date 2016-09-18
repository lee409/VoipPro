//
//  LewPopupViewAnimationSlide.h
//  LewPopupViewController
//
//  Created by deng on 15/3/5.
//  Copyright (c) 2015年 pljhonglu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+LewPopupViewController.h"

typedef NS_ENUM(NSUInteger, LewPopupViewAnimationSlideType) {
    LewPopupViewAnimationSlideTypeBottomTop,
    LewPopupViewAnimationSlideTypeBottomBottom,
    LewPopupViewAnimationSlideTypeTopTop,
    LewPopupViewAnimationSlideTypeTopBottom,
    LewPopupViewAnimationSlideTypeLeftLeft,
    LewPopupViewAnimationSlideTypeLeftRight,
    LewPopupViewAnimationSlideTypeRightLeft,
    LewPopupViewAnimationSlideTypeRightRight,
    LewPopupViewAnimationSlideTypeBottomBottomEdge,//低边缘
    LewPopupViewAnimationSlideTypeBottomBottomNoneDiss
};

@interface LewPopupViewAnimationSlide : NSObject<LewPopupAnimation>
@property (nonatomic,assign)LewPopupViewAnimationSlideType type;

@end
