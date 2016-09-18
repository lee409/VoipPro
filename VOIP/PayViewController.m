//
//  PayViewController.m
//  VOIP
//
//  Created by apple on 14-3-20.
//  Copyright (c) 2014年 apple. All rights reserved.
//




#import "PayViewController.h"
#import "ItemHelpViewController.h"


@implementation PayViewController

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
    [self addAavigationView:@"充值" aback:nil];
   
    
}

//分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

//显示行数

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }
    return 0;
}
//行高

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = YES;
        if( indexPath.section == 0 && indexPath.row == 0)
        {
            [cell.textLabel setText:@"移动畅聊"];
        }else if (indexPath.section == 1 && indexPath.row == 0)
        {
            [cell.textLabel setText:@"系统公告"];
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        ShangbiCardPayViewController *ctl = [[ShangbiCardPayViewController alloc]initWithNibName:@"ShangbiCardPayViewController" bundle:nil];
        ctl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctl animated:YES];
        [ctl release];
    }else if (indexPath.section == 1 && indexPath.row == 0){
        SysInfoViewController *ctl = [[SysInfoViewController alloc]initWithNibName:@"SysInfoViewController" bundle:nil];
        ctl.type = SysInfoType;
        [self.navigationController pushViewController:ctl animated:YES];
        [ctl release];
    }

}


- (void)dealloc {
    [super dealloc];
}
@end
