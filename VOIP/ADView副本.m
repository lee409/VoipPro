//
//  ADView.m
//  VOIP
//
//  Created by hermit on 14-9-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ADView.h"
//#define kImageCount 5

@interface ADView()
{
    NSTimer *m_timer;
}
@property(assign,nonatomic)NSInteger imageCount;

@end

@implementation ADView


- (void)setImageNameList:(NSArray *)imageNameList
{
   
    //图片名称数组
    _imageNameList = imageNameList;
    //图片个数
    self.imageCount = imageNameList.count;
    
    UIScrollView *scroll = self.m_scrollView;
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
   
    //2、初始化数据 因为要多添加收尾两张图片，因此需要建立一个kImageCount+2的数组
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.imageCount + 2];
    for (NSInteger i = 0; i < self.imageCount; i++) {
        NSString *imageName = self.imageNameList[i];
         NSString *path = [documents[0] stringByAppendingPathComponent:imageName];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        [array addObject:imageView];
    }
    
    UIImage *lastImage = [UIImage imageNamed:self.imageNameList[self.imageCount - 1]];
    UIImageView *lastImageView = [[UIImageView alloc]initWithImage:lastImage];
    [array insertObject:lastImageView atIndex:0];
    
    UIImage *firstImage = [UIImage imageNamed:self.imageNameList[0]];
    UIImageView *firstImageView = [[UIImageView alloc]initWithImage:firstImage];
    [array addObject:firstImageView];
    
    CGFloat width = scroll.bounds.size.width;
    CGFloat height = scroll.bounds.size.height;
    CGFloat y = scroll.bounds.origin.y;
    //3、把UIImage添加到UIScrollView
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIImageView *imageView = obj;
        [imageView setFrame:CGRectMake(idx * width, y, width, height)];
        [scroll addSubview:imageView];
    }];
    //4、设置滚动视图的属性
    //1)允许分页
    [scroll setPagingEnabled:YES];
    //2)关闭弹簧效果
    [scroll setBounces:NO];
    //3)关闭滚动条
    [scroll setShowsHorizontalScrollIndicator:NO];
    //4)设置滚动区域
    [scroll setContentSize:CGSizeMake(width * (self.imageCount + 2), height)];
    // 5) 设置代理
    [scroll setDelegate:self];
    // 6）设置contentOffset显示第一张图片
    [scroll setContentOffset:CGPointMake(width, 0)];
    
    //5、增加分页控件
    UIPageControl * pageControl = [[UIPageControl alloc]init];
    // 1) 根据指定的页数，返回分页控件最合适的大小
    CGSize size = [pageControl sizeForNumberOfPages:self.imageCount];
    [pageControl setFrame:CGRectMake(0, 0, size.width, size.height)];
    // 2) 设置分页控件的位置
    [pageControl setCenter:CGPointMake(width / 2, height - 20)];
    
    // 3) 设置分页控件的页数
    [pageControl setNumberOfPages:self.imageCount];
    [pageControl setCurrentPage:0];
    // 4) 设置分页控件指示器的颜色
    [pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [pageControl setPageIndicatorTintColor:[UIColor blackColor]];
    // 5) 添加分页控件的监听方法
    [pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    self.m_pageControl = pageControl;
    // 6) 添加到视图
    [self addSubview:pageControl];
    
    //创建定时器
    if (m_timer == nil && self.imageCount > 1) {
        m_timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(setCorrentPage) userInfo:nil repeats:YES];
    }

    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //1、创建滚动视图
        UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:frame];
        [self addSubview:scroll];
        self.m_scrollView = scroll;
        
    
    }
    return self;
}

- (void)setCorrentPage
{
    NSInteger currentPage = self.m_pageControl.currentPage;
    if (currentPage == self.imageCount - 1) {
        self.m_pageControl.currentPage = 0;
    }else{
        self.m_pageControl.currentPage++;
    }
    [self pageChanged:self.m_pageControl];
    
}

#pragma mark - 分页控件页面变化监听方法
// 此方法是用户点击分页控件时调用，
// 点当前页的左侧，页数递减
// 点当前页的右侧，页数递增
- (void)pageChanged:(UIPageControl *)sender
{
   // NSLog(@"分页了 %d", sender.currentPage);
    // 根据变化到的页数，计算scrollView的contentOffset
    CGFloat offsetX = (sender.currentPage + 1) * self.m_scrollView.bounds.size.width;
    
    [self.m_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
#pragma mark - UIScrollView代理方法
#pragma mark 滚动视图减速事件
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 1. 判断当前所在页面的页数
    NSInteger pageNo = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    // 2. 如果是第0页，表示当前在最后一页
    // 3. 如果是第kImageCount + 1页，表示当前在第一页
    if (0 == pageNo || self.imageCount + 1 == pageNo) {
        if (0 == pageNo) {
            pageNo = self.imageCount;
        } else {
            pageNo = 1;
        }
        
        // 注意不要使用动画属性
        [scrollView setContentOffset:CGPointMake(pageNo * scrollView.bounds.size.width, 0)];
    }
    
    // 4. 其他页面不用处理
    // 5. 设置分页控件的页码
    [self.m_pageControl setCurrentPage:pageNo - 1];

}
- (void)dealloc
{
    [_imageNameList release];
    [_m_pageControl release];
    [_m_scrollView release];
    [m_timer invalidate];
    m_timer = nil;
    [super dealloc];
}

@end
