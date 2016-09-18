//
//  AddressBookBigViewController.m
//  Move
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AddressBookBigViewController.h"
#import <AddressBook/AddressBook.h>
#import "AddressBookViewController.h"
#import "AddressBookFriendViewController.h"


@interface AddressBookBigViewController ()<UIScrollViewDelegate,UIPageViewControllerDelegate,ABNewPersonViewControllerDelegate> {
    UISegmentedControl* _segmentedControl;
    
    UIScrollView* _scrollView;
    
    AddressBookViewController* _leftViewController;
    AddressBookFriendViewController* _rightViewController;
}


@end

@implementation AddressBookBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addAavigationView:@"" aback:nil];
    [self adaptiveIos1];
//    UIButton* ilogin = [UIButton buttonWithType:UIButtonTypeCustom];
//    [ilogin setFrame:CGRectMake(0, 0, 16, 16)];
//    [ilogin setShowsTouchWhenHighlighted:YES];
//    [ilogin setBackgroundImage:[UIImage imageNamed:@"contact_nav_sdd_n"] forState:UIControlStateNormal];
//    [ilogin setBackgroundImage:[UIImage imageNamed:@"contact_nav_sdd_s"] forState:UIControlStateHighlighted];
//    [ilogin addTarget:self action:@selector(rightBarButtonItemBack:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:ilogin];
    
    UIButton* ilogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [ilogin setFrame:CGRectMake(0, 0, 25, 25)];
    [ilogin setShowsTouchWhenHighlighted:YES];
    [ilogin setBackgroundImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [ilogin addTarget:self action:@selector(rightBarButtonItemBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:ilogin] autorelease];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"全部", @"好友"]];
    //     UIImage *lmyImage = [UIImage imageNamed:@"contacts_nav_btn_s"];
    //    UIImage *rmyImage = [UIImage imageNamed:@"contacts_nav_btn_n"];
    //    [_segmentedControl insertSegmentWithImage:lmyImage atIndex:0 animated:NO];
    //    [_segmentedControl insertSegmentWithImage:rmyImage atIndex:1 animated:NO];
    //_segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    
    //_segmentedControl.tintColor = [UIColor blueColor];
    _segmentedControl.selectedSegmentIndex = 0;
    [_segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = _segmentedControl;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth,kDeviceHeight - 49)];
    
    _scrollView.contentSize = CGSizeMake(kDeviceWidth * 2, 0);
    
    //一次滑动一页。
    _scrollView.pagingEnabled = YES;
    
    
    //不显示滚动条。
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    
    [self.view addSubview:_scrollView];
    
    AddressBookViewController*linkManViewController = [[AddressBookViewController alloc] initWithNibName:@"AddressBookViewController" bundle:nil];
    linkManViewController.view.frame = CGRectMake(0, 0, kDeviceWidth,kDeviceHeight - 49);
    
    [_scrollView addSubview:linkManViewController.view];
    [self addChildViewController:linkManViewController];
    [linkManViewController didMoveToParentViewController:self];
    AddressBookFriendViewController*linkManFriendViewController = [[AddressBookFriendViewController alloc]init];
    linkManFriendViewController.view.frame = CGRectMake(kDeviceWidth, 0, kDeviceWidth,kDeviceHeight - 49);
    
    [_scrollView addSubview:linkManFriendViewController.view];
    [self addChildViewController:linkManFriendViewController];
    [linkManFriendViewController didMoveToParentViewController:self];
    _leftViewController = linkManViewController;
    _rightViewController = linkManFriendViewController;
    
    
}
- (void)valueChanged:(UISegmentedControl* )sender {
    [_scrollView setContentOffset:CGPointMake(kDeviceWidth * sender.selectedSegmentIndex, 0) animated:YES];
    
    _rightViewController.modelArray = _leftViewController.modelArray;
    [_rightViewController.LinkTableView reloadData];
    //或者禁用 iOS 7 自动偏移的新特性。
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _segmentedControl.selectedSegmentIndex = scrollView.contentOffset.x / kDeviceWidth;
    _rightViewController.modelArray = _leftViewController.modelArray;
    [_rightViewController.LinkTableView reloadData];
}

-(void)rightBarButtonItemBack:(id)sender
{
    [self addNewPerson];
}
- (void)addNewPerson
{
    CFErrorRef error = NULL;
    // Create New Contact
    ABRecordRef person = ABPersonCreate ();
    
    // Add phone number
    ABMutableMultiValueRef multiValue =
    ABMultiValueCreateMutable(kABStringPropertyType);
    
    ABMultiValueAddValueAndLabel(multiValue, nil, kABPersonPhoneMainLabel,
                                 NULL);
    
    ABRecordSetValue(person, kABPersonPhoneProperty, multiValue, &error);
    
    
    ABNewPersonViewController *newPersonCtrl = [[ABNewPersonViewController alloc] init];
    newPersonCtrl.newPersonViewDelegate = self;
    newPersonCtrl.displayedPerson = person;
    CFRelease(person); // TODO check
    
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:newPersonCtrl];
    UIColor *icolor = CHANGEColorWith(0x4cafff,1.0);
    [navCtrl.navigationBar setBackgroundImage:[self createImageWithColor:icolor] forBarMetrics:UIBarMetricsDefault];
    navCtrl.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self.parentViewController presentViewController:navCtrl animated:YES completion:nil];
    
    
}
- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController didCompleteWithNewPerson:(ABRecordRef)person
{
    [newPersonViewController dismissViewControllerAnimated:YES completion:nil];
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

@end
