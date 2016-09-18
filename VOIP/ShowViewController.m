//
//  ShowViewController.m
//  VOIP
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShowViewController.h"

@interface ShowViewController ()

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    screenScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,kDeviceWidth, kDeviceHeight)];
    screenScroll.showsHorizontalScrollIndicator=NO;
    screenScroll.showsVerticalScrollIndicator=NO;
    screenScroll.scrollsToTop=NO;
    screenScroll.bounces = NO;
    if (IOS_VERSION_7_OR_ABOVE)
    self.automaticallyAdjustsScrollViewInsets=NO;
    screenScroll.pagingEnabled=YES;
    screenScroll.contentSize=CGSizeMake(kDeviceWidth*3, kDeviceHeight);
     screenScroll.delegate=self;
    [self.view addSubview:screenScroll];
    
    pageControl=[[UIPageControl alloc]init];
    pageControl.frame = CGRectMake((kDeviceWidth - 50)/2, kDeviceHeight - 60, 0, 0);
    pageControl.hidden = YES;
    imageView = [[UIImageView alloc]init];
    
    imageView.frame = CGRectMake((kDeviceWidth - 50)/2, kDeviceHeight - 60, 50, 10);
    
    
    
    button = [[UIButton alloc]init];
    button.frame = CGRectMake(52, kDeviceHeight - 80-45, kDeviceWidth - 104, 45);
    [button setBackgroundImage:[UIImage imageNamed:@"立即体验_n"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"立即体验_s"] forState:UIControlStateHighlighted];
    
    [button addTarget:self action:@selector(last) forControlEvents:UIControlEventTouchUpInside];
    UIImageView*imageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"跳过_n"]];
    
    NSLog(@"dd%@",NSStringFromCGRect(imageView1.frame));
    NSLog(@"dhhd%f",CGRectGetWidth(imageView1.frame));
    
    button1 = [[UIButton alloc]init];
    button1.frame = CGRectMake(kDeviceWidth-15-CGRectGetWidth(imageView1.frame), 33, CGRectGetWidth(imageView1.frame), CGRectGetHeight(imageView1.frame));
    
    [button1 setBackgroundImage:[UIImage imageNamed:@"跳过_n"] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:@"跳过_s"] forState:UIControlStateHighlighted];
    
    [button1 addTarget:self action:@selector(last) forControlEvents:UIControlEventTouchUpInside];
    
    pageControl.numberOfPages = 3;
    //设置当前选中的点的索引
    //    pageCon.currentPage = 2;
    //设置没有选中的点的颜色
    // pageControl.pageIndicatorTintColor = [UIColor greenColor];
    //设置选中的点的颜色
    //pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    //设置pageControl为不可控制
    pageControl.userInteractionEnabled=NO;
    //设置透明度，1.0表示不透明
    pageControl.alpha=1.0;
    //设置当前页面为第一张
    pageControl.currentPage=0;
    [self.view addSubview:pageControl];
    [self.view addSubview:imageView];
    [self.view addSubview:button1];
    //添加欢迎界面的点
    [self screenDots];
    for (int i=0; i<3; i++)
    {
        UIImageView*screenImage=[[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth*i, 0, kDeviceWidth, kDeviceHeight)];
        
        screenImage.userInteractionEnabled=YES;
        
        screenImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"Guide-page%d",i+1]];
        
        [screenScroll addSubview:screenImage];
        if (i==2) {
            
            [screenImage addSubview:button];
            
            
        }
        
        // NSLog(@"imagename====%@",screenImage);
    }
    [screenScroll setScrollEnabled:YES];
    
    
}
//设置界面上的点
- (void)screenDots
{
    
    
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Pagination%d",(pageControl.currentPage+1)]];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page=fabs(screenScroll.contentOffset.x/kDeviceWidth);
    if (page !=pageControl.currentPage) {
        [pageControl setCurrentPage:page];
        [self screenDots];
    }
    // NSLog(@"结果是=%0.2f",screenScroll.contentOffset.x);
    
    
    //    if (screenScroll.contentOffset.x>320*4+30)
    //    {
    //        [self last];
    //    }
}
- (void)last
{
    AppDelegate*appDelegate1 = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate1 loadMainView1];
    
}
-(void)dealloc{
    [super dealloc];
    [screenView release];
    [screenScroll release];
    [pageControl release];
    [imageView release];
    [button release];
    [button1 release];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
