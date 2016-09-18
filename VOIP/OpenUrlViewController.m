//
//  ItemHelpViewController.m
//  VOIP
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "OpenUrlViewController.h"

@implementation OpenUrlViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.m_webview.dataDetectorTypes = UIDataDetectorTypeNone;
  
        [self addAavigationView:@"" aback:nil];
        [self.m_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.fuao888.com"]]];
    
    
    self.m_webview.backgroundColor = [UIColor clearColor];
    self.m_webview.opaque = NO;
        
    //隐藏拖拽webview时上下的两个有阴影效果的subview。
    for (UIView *subView in [self.m_webview subviews])
    {
        if ([subView isKindOfClass:[UIScrollView class]])
        {
            for (UIView *shadowView in [subView subviews])
            {
                if ([shadowView isKindOfClass:[UIImageView class]])
                {
                    shadowView.hidden = YES;
                }
            }
        }
    }
    
    [self createbackButton];
}

//客服电话
- (void)createbackButton
{
    UIButton* ilogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [ilogin setFrame:CGRectMake(0, 0,12,21)];
    [ilogin setShowsTouchWhenHighlighted:YES];
    [ilogin setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [ilogin addTarget:self action:@selector(leftBarButtonItemBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:ilogin] autorelease];
    
}
-(void)leftBarButtonItemBack
{
    [self.m_webview goBack];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_m_webview release];
    [super dealloc];
}

@end
