//
//  AddressBookFriendViewController.m
//  Move
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AddressBookFriendViewController.h"
#import "Utility.h"
#import "CallSelectView.h"
#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationDrop.h"
#import "LewPopupViewAnimationSlide.h"
#import "Reachability.h"
#import "AddressBookModel.h"


@interface AddressBookFriendViewController ()<UITableViewDataSource,UITableViewDelegate,CallSelectViewDelegate>
@end

@implementation AddressBookFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.LinkTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64-49) style:UITableViewStylePlain];
    self.LinkTableView.delegate = self;
    self.LinkTableView.dataSource = self;
    
    
    self.LinkTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.LinkTableView];
    
    
}
//设置每个区有多少行共有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArray.count;
}


//行高。
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
//点击进入好友详细资料。
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    publicTableViewCell1 *cell = (publicTableViewCell1 *)[tableView cellForRowAtIndexPath:indexPath];
    [Utility shareInstance].u_calledName = cell.m_string1.text;
    [Utility shareInstance].u_calledNumber = cell.m_string2.text;
    
    NSString *itype = [Utility shareInstance].u_dialWay;
    if ( [itype isEqualToString:@"0"] )//智能拨打
    {
        if ( [[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable )
        {
            [Utility shareInstance].u_calledHuiboOrZhibo = @"0";
            [[Utility shareInstance] callPhonaPage:self];
        }
        else
        {
            [Utility shareInstance].u_calledHuiboOrZhibo = @"1";
            [[Utility shareInstance] callPhonaPage:self];
        }
    }//回拨
    else if ( [itype isEqualToString:@"1"] )
    {
        [Utility shareInstance].u_calledHuiboOrZhibo = @"1";
        [[Utility shareInstance] callPhonaPage:self];
    }//直拨
    else if ( [itype isEqualToString:@"2"] )
    {
        [Utility shareInstance].u_calledHuiboOrZhibo = @"0";
        [[Utility shareInstance] callPhonaPage:self];
        
    }//手动选择
    else if ( [itype isEqualToString:@"3"] )
    {
        CallSelectView *view = [CallSelectView defaultPopupView];
        view.parentVC = self;
        view.delegate = self;
        LewPopupViewAnimationSlide *animation = [[LewPopupViewAnimationSlide alloc]init];
        animation.type = LewPopupViewAnimationSlideTypeBottomBottomEdge;
        [self lew_presentPopupView:view animation:animation dismissed:^{
            
        }];
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    publicTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[publicTableViewCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        UIImageView*imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dial_Callhistory_bg"]];
        
        cell.backgroundView = imageView;
        cell.m_string1.frame = CGRectMake(20, 5, 200, 20);
        cell.m_string1.font = [UIFont boldSystemFontOfSize:15.0f];
        cell.m_string1.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        
        cell.m_string2.frame = CGRectMake(20, 30, 116, 20);
        cell.m_string2.font = [UIFont systemFontOfSize:11.0f];
        cell.m_string2.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        
        cell.m_string3.frame = CGRectMake(110, 30, 100, 20);
        cell.m_string3.font = [UIFont systemFontOfSize:11.0f];
        cell.m_string3.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        cell.m_string3.textAlignment = NSTextAlignmentRight;
        cell.imageTopu.frame =  CGRectMake(kDeviceWidth - 15 - 22, 14, 22, 22);
        
    }
    
    AddressBookModel *people = (AddressBookModel*)_modelArray[indexPath.row];
    
    
    NSString *sname  = [NSString stringWithFormat:@"%@",people.name];
    sname = [sname stringByReplacingOccurrencesOfString:@" " withString:@""];
    sname = [sname stringByReplacingOccurrencesOfString:@"(null)" withString:@"未设名称"];
    cell.m_string1.text= sname;
    
    cell.m_string2.text = people.homePhone;
    cell.m_string3.text = [[Utility shareInstance] selectInfoByPhone:people.homePhone];
    
    cell.imageTopu.image = [UIImage imageNamed:@"contacts_logo"];
    
    return cell;
    
    return nil;
}
- (void)callSelect:(NSInteger)tag
{
    if (tag == 0) {
        //免费电话
        [Utility shareInstance].u_calledHuiboOrZhibo = @"0";
        [[Utility shareInstance] callPhonaPage:self];
        
    }else{
        //普通电话
        [Utility shareInstance].u_calledHuiboOrZhibo = @"1";
        [[Utility shareInstance] callPhonaPage:self];
        
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

@end
