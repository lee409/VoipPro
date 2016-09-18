//
//  JumpPageViewController.m
//  VOIP
//
//  Created by apple on 14-4-3.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "JumpPageViewController.h"
#import "AppDelegate.h"
@implementation JumpPageViewController

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
    //[self setScreen];
    // Do any additional setup after loading the view from its nib.
    if (iPhone5)
    {
        UIImage *image = [UIImage imageNamed:@"Default-568h@2x"];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    }
    else
    {
        UIImage *image = [UIImage imageNamed:@"Default@2x"];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
        
    }
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
