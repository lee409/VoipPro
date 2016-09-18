//
//  AboutViewController.m
//  VOIP
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController

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
    [self addAavigationView:@"关于我们"  aback:@"back.png"];
    [self adaptiveIos1];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)bt_button2_center:(id)sender {
    //系统信息
    ItemHelpViewController *ctl = [[ItemHelpViewController alloc] initWithNibName:@"ItemHelpViewController" bundle:nil];
    ctl.m_data = 0;
    ctl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctl animated:YES];
    [ctl release];
}

- (IBAction)bt_button_about:(id)sender {
    //相关说明
            ItemHelpViewController *ctl = [[ItemHelpViewController alloc] initWithNibName:@"ItemHelpViewController" bundle:nil];
            ctl.m_data = 1;
            ctl.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ctl animated:YES];
           [ctl release];
}

- (IBAction)bt_http_123:(id)sender {
    UIButton *ib = (UIButton *)sender;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ib.titleLabel.text]];
}

- (IBAction)bt_button1:(id)sender
{
    UIButton *ib = (UIButton *)sender;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ib.titleLabel.text]];
}
@end
