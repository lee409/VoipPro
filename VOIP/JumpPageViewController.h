//
//  JumpPageViewController.h
//  VOIP
//
//  Created by apple on 14-4-3.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"

@interface JumpPageViewController : UIViewController
{
    
    
    UIView *screenView;//创建一个View用于加载滚动界面
    UIScrollView *screenScroll;//滚动界面
    UIPageControl*pageControl;//滚动界面上面的视图
    
}
@end
