//
//  ADView.m
//  VOIP
//
//  Created by hermit on 14-9-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ADView.h"
@interface ADView()
{
    NSTimer *m_timer;
    UITapGestureRecognizer * m_tapGR;
}
@property(assign,nonatomic)NSInteger imageCount;
@property(strong,nonatomic)NSArray *m_imageNameList;
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
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.imageCount];
    for (NSInteger i = 0; i < self.imageCount; i++) {
        NSString *imageName = self.imageNameList[i];
         NSString *path = [documents[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",self.fileDir,imageName]];
        [array addObject:path];
       // NSLog(@"imageName = %@",path);
    }
    self.m_imageNameList = array;
    CGFloat width = scroll.bounds.size.width;
    CGFloat height = scroll.bounds.size.height;
    [self.m_scrollView setContentSize:CGSizeMake((self.imageCount + 2) * width, height)];
    [self setScrollContentWithPage:0];
    //  设置分页控件的页数
    CGSize size = [self.m_pageControl sizeForNumberOfPages:self.imageCount];
    [self.m_pageControl setFrame:CGRectMake(0, 0, size.width, size.height)];
    //  设置分页控件的位置
    [self.m_pageControl setCenter:CGPointMake(width / 2, height-20)];
    [self.m_pageControl setNumberOfPages:self.imageCount];
    [self.m_pageControl setCurrentPage:0];
    //创建定时器
    if (m_timer == nil && self.imageCount > 1) {
        m_timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(setCorrentPage) userInfo:nil repeats:YES];
        
    }
   
}
- (void)startTimer
{
    if (m_timer != nil) {
    
        //[m_timer setFireDate:[NSDate distantPast]];
    }
}
- (void)stopTimer
{
    if (m_timer != nil) {
        //[m_timer setFireDate:[NSDate distantFuture]];
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
        
        //2、创建图像视图的数组
        NSMutableArray *imageViewList = [NSMutableArray arrayWithCapacity:3];
        for (NSInteger i = 0; i < 3; i++) {
            //子控件的大小与父控件一致
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:scroll.bounds];
            [imageViewList addObject:imageView];
            //将三张图像视图添加到scrollView上，后续直接设置即可
            [scroll addSubview:imageView];
        }
        self.imageViewList = imageViewList;
        //3、设置滚动视图的属性
        //1)、设置滚动区域
        CGFloat width = scroll.bounds.size.width;
        //2)、取消弹簧
        [scroll setBounces:NO];
        //3)、取消水平滚动
        [scroll setShowsHorizontalScrollIndicator:NO];
        //4)、设置代理
        [scroll setDelegate:self];
        //5)、设置分页
        [scroll setPagingEnabled:YES];
        //6)、设置偏移位置
        [scroll setContentOffset:CGPointMake(width, 0)];
        //scroll set
        //4、增加分页控件
        UIPageControl * pageControl = [[UIPageControl alloc]init];
        // 4) 设置分页控件指示器的颜色
        [pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:34.0f/255.0f green:179.0f/255.0f blue:200.0f/255.0f alpha:1.0f]];
        [pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
        // 5) 添加分页控件的监听方法
     //   [pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
        self.m_pageControl = pageControl;
        // 6) 添加到视图
        [self addSubview:pageControl];
        //初始化监听器
        m_tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Onclik:)];
        [scroll addGestureRecognizer:m_tapGR];
    }
    return self;
}
- (void)setCorrentPage
{
     UIScrollView *scrollView = self.m_scrollView;
    // 1. 判断当前所在页面的页数
    NSInteger pageNo = scrollView.contentOffset.x / scrollView.bounds.size.width;
   // NSLog(@"pageNo = %d",pageNo);
    // 2. 如果是第0页，表示当前在最后一页
    // 3. 如果是第kImageCount + 1页，表示当前在第一页
    if (0 == pageNo || (self.imageCount) == pageNo) {
        if (0 == pageNo) {
            pageNo = self.imageCount;
            
        } else {
            pageNo = 1;
        }
    }
    else
    {
        pageNo++;
    }
    // 注意：其他页面同样需要处理，因为，图片缓存数组中只有三张图片
    // 因此，每次滚动完成之后，都需要做设置页面图像的工作
    [self setScrollContentWithPage:(pageNo - 1)];
    

    [scrollView setContentOffset:CGPointMake(pageNo * scrollView.bounds.size.width, 0)];
    
    self.m_pageControl.currentPage = pageNo - 1;
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

#pragma mark - 根据页号，设置滚动视图显示内容
// 参数page是从0开始的
- (void)setScrollContentWithPage:(NSInteger)page
{
    // 需要page-1 page page+1 三个页面
    // 如果是0：99 0 1
    // 如果是1: 0 1 2
    // 如果是99：98 99 0
    // 需要注意的时第一张图片中为了避免出现负数，可以先与图片总数相加再去模处理
   // NSLog(@"%d %d %d", (page + self.imageCount - 1) % self.imageCount, page, (page + 1) % self.imageCount);
    
    // 知道对应的图片文件名的数组下标，可以直接设置imageView数组中的图像
    CGFloat width = self.m_scrollView.bounds.size.width;
    CGFloat height = self.m_scrollView.bounds.size.height;
    NSInteger startI = (page + self.imageCount - 1) % self.imageCount;
    
    for (NSInteger i = 0; i < 3; i++) {
        NSInteger index = (startI + i) % self.imageCount;
        NSString *imageName = self.m_imageNameList[index];
        
        UIImage *image = [UIImage imageWithContentsOfFile:imageName];
        
        // 取出图像视图数组中的图像视图
        UIImageView *imageView = self.imageViewList[i];
        // 设置图像
        [imageView setImage:image];
        
        // 挪动位置，需要连续设置三张图片的位置
        // 至于图片的内容，可以不用去管了
        // 因为多了两张缓存的页面，因此page=0时，数组中的第0张图片应该显示在1的位置
        [imageView setFrame:CGRectMake((page + i) * width, 0, width, height)];
    }
}

#pragma mark - UIScrollView代理方法
#pragma mark 滚动视图减速事件
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 1. 判断当前所在页面的页数
    NSInteger pageNo = scrollView.contentOffset.x / scrollView.bounds.size.width;
   // NSLog(@"pageNo = %d",pageNo);
    // 2. 如果是第0页，表示当前在最后一页
    // 3. 如果是第kImageCount + 1页，表示当前在第一页
    BOOL needAdjust = NO;
    if (0 == pageNo || (self.imageCount + 1) == pageNo) {
        if (0 == pageNo) {
            pageNo = self.imageCount;
           
        } else {
            pageNo = 1;
        }
        
        // 设置偏移
        needAdjust = YES;
    }
    // 注意：其他页面同样需要处理，因为，图片缓存数组中只有三张图片
    // 因此，每次滚动完成之后，都需要做设置页面图像的工作
    [self setScrollContentWithPage:(pageNo - 1)];
    
    // 如果是第一页和最后一页的缓存页面上，需要挪动位置
    if (needAdjust) {
        [scrollView setContentOffset:CGPointMake(pageNo * scrollView.bounds.size.width, 0)];
    }
    self.m_pageControl.currentPage = pageNo - 1;
}

#pragma mark 事件监听器
- (void)Onclik:(id)sender
{
    NSString *currentImageName = self.imageNameList[self.m_pageControl.currentPage];
    NSString *url = self.imageUrlDict[currentImageName];
    if (url != nil && [url rangeOfString:@"http"].length > 0) {
        if (self.delegate) {
            [self.delegate ADopenUrl:url withName:nil];
        }
    }
}

- (void)dealloc
{
    [_imageNameList release];
    [_imageViewList release];
    [_m_pageControl release];
    [_m_scrollView release];
    [m_timer invalidate];
    m_timer = nil;
    [super dealloc];
}

@end
