//
//  ItemHelpViewController.h
//  VOIP
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"

@interface ItemHelpViewController : UIViewController<UIWebViewDelegate>{
}
@property(nonatomic, assign) int m_data;
@property (retain, nonatomic) IBOutlet UIWebView *m_webview;
@property(strong,nonatomic) NSString *m_url;
@property(strong,nonatomic) NSString *m_name;
@end
