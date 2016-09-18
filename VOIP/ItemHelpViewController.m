//
//  ItemHelpViewController.m
//  VOIP
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ItemHelpViewController.h"

@implementation ItemHelpViewController

@synthesize m_data;
@synthesize m_url;

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
    
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    mbp.labelText = @"   正在加载！请稍等...   ";
    
    self.m_webview.dataDetectorTypes = UIDataDetectorTypeNone;
    self.m_webview.delegate = self;
    
    [self addAavigationView:self.m_name aback:@"back.png"];
    [self.m_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:m_url]]];
    
    
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
}


//得到信息的名字
- (NSString *)getMsg:(NSString *)name
{
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//取出沙盒
    NSString *path = [documents[0] stringByAppendingPathComponent:@"msg.plist"];//读取msg.plist文件
   // NSLog(@"path===%@",path);
    NSString * ad_msg = @"" ;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];//字典方法，读取文件路径
    if (dict != nil) {
        
        ad_msg = [dict valueForKey:name];
        
    }
    return  ad_msg;
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (m_data == 0)
    {
        
        NSString *js_fit_code = [NSString stringWithFormat:@"var meta = document.createElement('meta');"
                                 "meta.name = 'viewport';"
                                 "meta.content = 'width=device-width, initial-scale=0.5,minimum-scale=0.1, maximum-scale=2.0, user-scalable=yes';"
                                 "document.getElementsByTagName('head')[0].appendChild(meta);"
                                 ];
        [_m_webview stringByEvaluatingJavaScriptFromString:js_fit_code];
    }
    if (m_data == 1)
    {
        
        NSString *js_fit_code = [NSString stringWithFormat:@"var meta = document.createElement('meta');"
                                 "meta.name = 'viewport';"
                                 "meta.content = 'width=device-width, initial-scale=0.9,minimum-scale=0.1, maximum-scale=2.0, user-scalable=yes';"
                                 "document.getElementsByTagName('head')[0].appendChild(meta);"
                                 ];
        [_m_webview stringByEvaluatingJavaScriptFromString:js_fit_code];
    }
    if (m_data == 2)
    {
        
        NSString *js_fit_code = [NSString stringWithFormat:@"var meta = document.createElement('meta');"
                                 "meta.name = 'viewport';"
                                 "meta.content = 'width=device-width, initial-scale=1.0,minimum-scale=0.1, maximum-scale=2.0, user-scalable=yes';"
                                 "document.getElementsByTagName('head')[0].appendChild(meta);"
                                 ];
        [_m_webview stringByEvaluatingJavaScriptFromString:js_fit_code];
    }
    
     [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nonnull NSError *)error{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];    
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
