//
//  FoundViewController.m
//  VOIP
//
//  Created by hermit on 14-9-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "FoundViewController.h"
#import "Utility.h"
#import "Reachability.h"

#define kImageMagin 5.0
#define kImageHeight 150
@interface FoundViewController ()
{
    UIScrollView *_scroll;
    BOOL _isLoading1;
    BOOL _isLoading2;
}
@end

@implementation FoundViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    if (netStatus) {
        
        
        
        if (!_isLoading1) {
            
          //  NSLog(@"_isLoading1==%hhd",_isLoading1);
             [self query_lubo_ad];
        }
        if (!_isLoading2) {

         //   NSLog(@"_isLoading2==%hhd",_isLoading2);
             [self query_pinpai_ad];
        }
       
       
    }
    else
    {
        [iToast makeToast:@"无网络"];
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addAavigationView:@"发现" aback:nil];
    
    CGRect frame = self.view.frame;
    _scroll = [[UIScrollView alloc]initWithFrame:frame];
    [_scroll setBackgroundColor:[UIColor whiteColor]];
    self.view = _scroll;
    [self lubo];
    [self pinpai];
}



- (void)lubo
{
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//沙盒
    NSString *path = [documents[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",PINPAI_LUNBO ,PINPAI_LUNBO_PLIST]];//路径
    
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arrayM = [[NSMutableArray alloc]init];
    NSMutableDictionary *imageUrlDict = [[NSMutableDictionary alloc]init];
    if (array != nil && array.count > 0)
    {
        for (NSInteger i = 0; i < array.count; i++)
        {
            NSDictionary *dict = array[i];
            NSString * imageName = dict[@"p_img_full"];
            NSString * imageUrl = dict[@"p_url"];
            [arrayM addObject:imageName];
            [imageUrlDict setValue:imageUrl forKey:imageName];
        }
    }
    if (imageUrlDict.count > 0)
    {
        if (m_adView)
        {
            //图片名称/图片链接地址
            m_adView.imageUrlDict = imageUrlDict;
            //图片名称
            m_adView.imageNameList = arrayM;
        }
        else
        {
            CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120);
            m_adView = [[ADView alloc]initWithFrame:frame];
            m_adView.fileDir = PINPAI_LUNBO;
            m_adView.imageNameList = arrayM;
            m_adView.imageUrlDict = imageUrlDict;
            m_adView.delegate = self;
            [_scroll addSubview:m_adView];
        }
    }
    
}

- (void)pinpai
{
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//沙盒
    NSString *path = [documents[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",PINPAI_FILEDIR ,PINPAI_PLIST]];//路径
    
    NSArray *array = [NSArray arrayWithContentsOfFile:path];

   
    
    if (array != nil && array.count > 0)
    {
        
        for (UIView *view in _scroll.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                [view removeFromSuperview];
            }
        }
        
        CGFloat y = 120 - kImageHeight;
        CGFloat w = (self.view.frame.size.width - 3 * kImageMagin) / 2;
        for (NSInteger i = 0; i < array.count; i++) {
            NSDictionary *dict = array[i];
            NSString * imageName = dict[@"p_img_full"];
            NSString * imageUrl = dict[@"p_url"];
            NSString *imagePath = [documents[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",PINPAI_FILEDIR ,imageName]];
           // NSLog(@"imagePath===%@",imagePath);
            UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
            UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
           // NSLog(@"image===%@",image);
           // NSLog(@"imageView===%@",imageView);
            
            CGRect frame ;
            if (i  % 2 == 0)
            {
                y = y + kImageMagin  + kImageHeight ;
                frame = CGRectMake(kImageMagin, y, w, kImageHeight);
            }
            else
            {
                frame = CGRectMake(w + 2 * kImageMagin , y, w, kImageHeight);
            }
            
            
            
            [imageView setFrame:frame];
            MyTapGestureRecognizer *singleTap = [[MyTapGestureRecognizer alloc]initWithTarget:self action:@selector(onImageClicked:)];
            singleTap.string = imageUrl;
            [imageView addGestureRecognizer:singleTap];
            imageView.userInteractionEnabled = YES;
        
            imageView.exclusiveTouch = YES;
            
            
            [_scroll addSubview:imageView];
            [singleTap release];

            [imageView release];
            

        }
        
        [_scroll setContentSize:CGSizeMake(_scroll.frame.size.width, y + kImageMagin + kImageHeight)];
        
    }
    
    
}

- (void)onImageClicked:(UITapGestureRecognizer *)sender
{
    MyTapGestureRecognizer *v = (MyTapGestureRecognizer *)sender;
    if (v.string != nil && [v.string rangeOfString:@"http"].length > 0) {
        ItemHelpViewController *ctl = [[ItemHelpViewController alloc] initWithNibName:@"ItemHelpViewController" bundle:nil];
        ctl.m_data = 2;
        ctl.m_url = v.string;//添加连接
        ctl.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBar.hidden = NO;
        [self.navigationController pushViewController:ctl animated:YES];
        [ctl release];
        
       // NSLog(@"%@",v.string);
    }
}

- (void)query_lubo_ad
{
    
    _isLoading1 = true;
    
    NSURL *url = [NSURL URLWithString:[[Utility queryCommentationPic] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableString *xmlString = [NSMutableString stringWithString:@"<?xml version='1.0' encoding='UTF-8'?>"];
    [xmlString appendString:@"<data>"];
    [xmlString appendFormat:@"<uid>%@</uid>",USERID];
    [xmlString appendString:@"<phone_type>2</phone_type>"];
    [xmlString appendString:@"</data>"];
    // 2. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    // 3. Connection异步
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *reponse, NSData *data, NSError *error) {
        
        
        if (data != nil) {
            NSDictionary *dicts = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
           
            
            if ([dicts[@"status"] isEqualToString:@"1"]) {
                NSArray *array = dicts[@"data"];
                if (array != nil && array.count > 0) {
                    
                    NSMutableArray *arrayM = [[NSMutableArray alloc]init];
                    for (NSDictionary *d in array) {
                        NSMutableDictionary *item = [[NSMutableDictionary alloc]init];
                        [item setValue:d[@"cp_img_full"] forKey:@"p_img_full"];
                        [item setValue:d[@"cp_url"] forKey:@"p_url"];
                        [arrayM addObject:item];
                    }
                    
                    [self performSelectorOnMainThread:@selector(threadLoadImage:) withObject:arrayM waitUntilDone:YES];
                }
                else
                {
                    _isLoading1 = false;
                }
            }
            else
            {
                _isLoading1 = false;
            }
        }
        else
        {
            _isLoading1 = false;
        }
    }];
}

- (void)query_pinpai_ad
{
    _isLoading2 = true;
    NSURL *url = [NSURL URLWithString:[[Utility queryProductListPic] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableString *xmlString = [NSMutableString stringWithString:@"<?xml version='1.0' encoding='UTF-8'?>"];
    [xmlString appendString:@"<data>"];
    [xmlString appendFormat:@"<uid>%@</uid>",USERID];
    [xmlString appendString:@"<phone_type>2</phone_type>"];
    [xmlString appendString:@"</data>"];
    // 2. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    // 3. Connection异步
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *reponse, NSData *data, NSError *error) {
        
        
        if (data != nil) {
            NSDictionary *dicts = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            if ([dicts[@"status"] isEqualToString:@"1"]) {
                NSArray *array = dicts[@"data"];
                if (array != nil && array.count > 0) {
                    
                    NSMutableArray *arrayM = [[NSMutableArray alloc]init];
                    for (NSDictionary *d in array) {
                        NSMutableDictionary *item = [[NSMutableDictionary alloc]init];
                        [item setValue:d[@"plp_img_full"] forKey:@"p_img_full"];
                        [item setValue:d[@"plp_url"] forKey:@"p_url"];
                        [arrayM addObject:item];
                    }
                    
                    [self performSelectorOnMainThread:@selector(threadLoadImage2:) withObject:arrayM waitUntilDone:YES];
                }else
                {
                    _isLoading2 = false;
                }
            }
            else
            {
                _isLoading2 = false;
            }
        }else
        {
            _isLoading2 = false;
        }
        
    }];
}




//下载图片
- (void)threadLoadImage:(NSArray *)imageInfo
{
   
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(loadImage:) object:imageInfo];
    // 启动线程
    [thread start];
}


- (void)loadImage:(NSArray *)imageInfo
{
    FileOperationHelp *fileOperation = [[FileOperationHelp alloc]init];

    BOOL b = [fileOperation loadImageWithImageInfo:imageInfo withSaveFileDir:PINPAI_LUNBO withSavePlistFileName:PINPAI_LUNBO_PLIST];
    
    _isLoading1 = false;
    if (b) {
        [self lubo];
    }
    [fileOperation release];
}

//下载图片
- (void)threadLoadImage2:(NSArray *)imageInfo
{
    
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(loadImage2:) object:imageInfo];
    // 启动线程
    [thread start];
}


- (void)loadImage2:(NSArray *)imageInfo
{
    FileOperationHelp *fileOperation = [[FileOperationHelp alloc]init];
    
    BOOL b = [fileOperation loadImageWithImageInfo:imageInfo withSaveFileDir:PINPAI_FILEDIR withSavePlistFileName:PINPAI_PLIST];
   
    _isLoading2 = false;
    if (b)
    {
        [self pinpai];
    }
    [fileOperation release];
}




//点击图片的背景时候，点击连接到跳转另外界面
- (void)ADopenUrl:(NSString *)url withName:(NSString *)name
{
    ItemHelpViewController *ctl = [[ItemHelpViewController alloc] initWithNibName:@"ItemHelpViewController" bundle:nil];
    ctl.m_data = 2;
    ctl.m_url = url;
    ctl.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:ctl animated:YES];
    [ctl release];
}

- (void)dealloc
{
    [super dealloc];
    [_scroll release];
}

@end
