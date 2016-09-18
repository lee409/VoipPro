#import <UIKit/UIKit.h>
#import "Utility.h"
#import "ExButton.h"
#import "CallRecordsViewController.h"
#import "DialView.h"
#import "ADView.h"
@interface CustomTabbar : UITabBarController
{
}
@property(nonatomic, assign) NSMutableArray *m_tableArray;
-(void)theCustomTabbar;
- (void)when_tabbar_is_selected:(int)tabID;
@end
