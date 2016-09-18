#import "CustomTabbar.h"

@implementation CustomTabbar

@synthesize m_tableArray;

-(void)theCustomTabbar
{
    UIColor *icolor1 = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [[self tabBar] setBackgroundImage:[self createImageWithColor:icolor1]];
    
    NSMutableArray *itab_title = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",nil];
    m_tableArray = [[NSMutableArray alloc] init];
	for (int i = 0; i < 4; i++)
	{
        ExButton *ibtn = [ExButton buttonWithType:UIButtonTypeCustom];
		[ibtn setFrame:CGRectMake(i*80, 0, 80, 49)];
        [ibtn setTitleEdgeInsets:UIEdgeInsetsMake(30, 2, 0, 0)];
        ibtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [ibtn setTitle:[itab_title objectAtIndex:i] forState:UIControlStateNormal];
        [ibtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [ibtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [ibtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [ibtn setTag:i];
        if (i==0)
        {
            ibtn.m_bool = YES;
            [ibtn setBackgroundImage:[UIImage imageNamed:@"1tabBar"] forState:UIControlStateNormal];
            [ibtn setBackgroundImage:[UIImage imageNamed:@"1tabBar"] forState:UIControlStateHighlighted];
            [ibtn setBackgroundImage:[UIImage imageNamed:@"1tabBar_up"] forState:UIControlStateSelected];
        }
        else if (i==1)
        {
            [ibtn setBackgroundImage:[UIImage imageNamed:@"2tabBar"] forState:UIControlStateNormal];
            [ibtn setBackgroundImage:[UIImage imageNamed:@"2tabBar"] forState:UIControlStateHighlighted];
            [ibtn setBackgroundImage:[UIImage imageNamed:@"2tabBar_up"] forState:UIControlStateSelected];
        }
        else if (i==2)
        {
            [ibtn setBackgroundImage:[UIImage imageNamed:@"3tabBar"] forState:UIControlStateNormal];
            [ibtn setBackgroundImage:[UIImage imageNamed:@"3tabBar"] forState:UIControlStateHighlighted];
            [ibtn setBackgroundImage:[UIImage imageNamed:@"3tabBar_up"] forState:UIControlStateSelected];
        }
        else if (i==3)
        {
            [ibtn setBackgroundImage:[UIImage imageNamed:@"4tabBar"] forState:UIControlStateNormal];
            [ibtn setBackgroundImage:[UIImage imageNamed:@"4tabBar"] forState:UIControlStateHighlighted];
            [ibtn setBackgroundImage:[UIImage imageNamed:@"4tabBar_up"] forState:UIControlStateSelected];
        }
        
        [ibtn addTarget:self action:@selector(button_clicked_tag:) forControlEvents:UIControlEventTouchUpInside];
		[self.tabBar addSubview:ibtn];
        [m_tableArray addObject:ibtn];
	}
    [itab_title release];
    [self when_tabbar_is_selected:0];
}
- (void)when_tabbar_is_selected:(int)tabID
{
    for (int i=0; i<[m_tableArray count]; i++)
    {
        ExButton *ibtn = [m_tableArray objectAtIndex:i];
        if ( tabID == i)
        {
            if (tabID==0)
            {
                if (ibtn.m_bool == YES)
                {
                    ibtn.m_bool = NO;
                    [ibtn setBackgroundImage:[UIImage imageNamed:@"1tabBar"] forState:UIControlStateNormal];
                    [ibtn setBackgroundImage:[UIImage imageNamed:@"1tabBar"] forState:UIControlStateHighlighted];
                    [ibtn setBackgroundImage:[UIImage imageNamed:@"1tabBar_up"] forState:UIControlStateSelected];
                    [self upturning:ibtn];
                }
                else
                {
                    ibtn.m_bool = YES;
                    [ibtn setBackgroundImage:[UIImage imageNamed:@"0tabBar"] forState:UIControlStateNormal];
                    [ibtn setBackgroundImage:[UIImage imageNamed:@"0tabBar"] forState:UIControlStateHighlighted];
                    [ibtn setBackgroundImage:[UIImage imageNamed:@"0tabBar_up"] forState:UIControlStateSelected];
                    [self descend:ibtn];
                }
                [ibtn setSelected:YES];
                continue;
            }
            else
            {
                [ibtn setSelected:YES];
                [ibtn setUserInteractionEnabled:NO];
            }
        }
        else
        {
            if (tabID !=0)
            {
                ExButton *ibtn1 = [m_tableArray objectAtIndex:0];
                ibtn1.m_bool = YES;
                [ibtn1 setBackgroundImage:[UIImage imageNamed:@"1tabBar"] forState:UIControlStateNormal];
                [ibtn1 setBackgroundImage:[UIImage imageNamed:@"1tabBar"] forState:UIControlStateHighlighted];
                [ibtn1 setBackgroundImage:[UIImage imageNamed:@"1tabBar_up"] forState:UIControlStateSelected];
                [self descend:ibtn1];
            }
            [ibtn setSelected:NO];
            [ibtn setUserInteractionEnabled:YES];
        }
    }
    self.selectedIndex = tabID;
}
- (void)button_clicked_tag:(id)sender
{
    [self when_tabbar_is_selected:[sender tag]];
}
//上翻
- (void)upturning:(ExButton *)abtn
{
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:(int)UIViewAnimationCurveEaseIn
                     animations:^{
                         UINavigationController *oneNavigationController = (UINavigationController *)[self.viewControllers objectAtIndex:0];
                         CallRecordsViewController *oneViewController = (CallRecordsViewController*)[oneNavigationController.viewControllers objectAtIndex:0];
                         for(UIView *view in oneViewController.view.subviews)
                         {
                             if([view isKindOfClass:[DialView class]])
                             {
                                 CGRect irect;
                                 irect.origin.x = view.frame.origin.x;
                                 irect.origin.y = oneViewController.view.frame.size.height - view.frame.size.height;
                                 irect.size.width = view.frame.size.width;
                                 irect.size.height = view.frame.size.height;
                                 view.frame = irect;
                             }else if ([view isKindOfClass:[ADView class]])
                             {
                                 view.hidden = NO;
                                 ADView *adView =(ADView*)[view retain];
                                 [adView startTimer];
                                 [adView release];
                                 
                             }
                             else if ([view isKindOfClass:[UITableView class]])
                             {
                                 CGRect frame = view.frame;
                                 frame.origin.y = 0;
                                 view.frame =frame;
                             }
                         }
                         
                         [abtn setUserInteractionEnabled:NO];
                     }
                     completion:^(BOOL finished){
                         [abtn setUserInteractionEnabled:YES];
                     }];
    
}
//下翻
- (void)descend:(ExButton *)abtn
{
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:(int)UIViewAnimationCurveEaseIn
                     animations:^{
                         UINavigationController *oneNavigationController = (UINavigationController *)[self.viewControllers objectAtIndex:0];
                         CallRecordsViewController *oneViewController = (CallRecordsViewController*)[oneNavigationController.viewControllers objectAtIndex:0];
                         for(UIView *view in oneViewController.view.subviews)
                         {
                             if([view isKindOfClass:[DialView class]])
                             {
                                 CGRect irect;
                                 irect.origin.x = view.frame.origin.x;
                                 irect.origin.y = oneViewController.view.frame.size.height;
                                 irect.size.width = view.frame.size.width;
                                 irect.size.height = view.frame.size.height;
                                 view.frame = irect;
                             }else if ([view isKindOfClass:[ADView class]])
                             {
                                 view.hidden = YES;
                                 ADView *adView =(ADView *)[view retain];
                                 [adView stopTimer];
                                 [adView release];
                             }
                         }
                        [abtn setUserInteractionEnabled:NO];
                     }
                     completion:^(BOOL finished){
                         [abtn setUserInteractionEnabled:YES];
                     }];
}




- (void)dealloc
{
    [m_tableArray release];
    [super dealloc];
}


@end
