//
//  ADView.h
//  VOIP
//
//  Created by hermit on 14-9-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Utility.h"
#import "ItemHelpViewController.h"
@protocol ADViewOpenUrlDelegate<NSObject>
-(void)ADopenUrl:(NSString *)url withName:(NSString *)name;
@end

@interface ADView : UIView<UIScrollViewDelegate>
{
    
}
@property(nonatomic,assign) id <ADViewOpenUrlDelegate> delegate;

@property(retain,nonatomic) UIScrollView *m_scrollView;//滚动视图
@property(retain,nonatomic) UIPageControl *m_pageControl;//分页控件
@property(strong,nonatomic) NSArray *imageNameList;
@property(strong,nonatomic) NSArray *imageViewList;
@property(strong,nonatomic) NSString *fileDir;
@property(strong,nonatomic) NSDictionary *imageUrlDict;
@property(strong,nonatomic) NSDictionary *imageDescDict;
-(void)startTimer;//开启定时器
-(void)stopTimer;//关闭定时器
@end
