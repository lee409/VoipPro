//
//  ShowMainViewController.m
//  VOIP
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShowMainViewController.h"

@interface ShowMainViewController ()

@end

@implementation ShowMainViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
        
    if (updateTime != nil) {
        [updateTime invalidate];
        updateTime = nil;
    }
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    updateTime = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(update)
                                                userInfo:nil
                                                 repeats:YES];//计算时间
    
    
}
- (void)update
{
    int a  = [self.numBerLabel.text intValue];
    
    a = a-1;
   self.numBerLabel.text = [NSString stringWithFormat:@"%d",a ];
    if (a == 0) {
        [self passAction];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)passAction{
    AppDelegate*appDelegate1 = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate1 loadMainView2];
    
    
}

- (IBAction)passButtonAction:(UIButton *)sender {
    AppDelegate*appDelegate1 = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate1 loadMainView2];
    
}
- (void)dealloc {
    [_numBerLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setNumBerLabel:nil];
    [super viewDidUnload];
}
@end
