//
//  ADView.h
//  VOIP
//
//  Created by hermit on 14-9-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADView : UIView<UIScrollViewDelegate>
{
    
}
@property(retain,nonatomic) UIScrollView *m_scrollView;//滚动视图
@property(retain,nonatomic) UIPageControl *m_pageControl;//分页控件
@property(strong,nonatomic) NSArray *imageNameList;
@property(strong,nonatomic) NSArray *imageViewList;
@end
