//
//  ShowViewController.h
//  VOIP
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "AppDelegate.h"
@interface ShowViewController : UIViewController<UIScrollViewDelegate>
{
    
    
    UIView *screenView;//创建一个View用于加载滚动界面
    UIScrollView *screenScroll;//滚动界面
    UIPageControl*pageControl;//滚动界面上面的视图
    UIImageView*imageView;
    UIButton*button;
    UIButton*button1;
    
}

@end
