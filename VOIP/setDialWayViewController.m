//
//  setDialWayViewController.m
//  VOIP
//
//  Created by apple on 14-6-21.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "setDialWayViewController.h"

@implementation setDialWayViewController

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
    [self addAavigationView:@"呼叫方式" aback:@"back.png"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//分区。
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
//每个区有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
//每行的行高。
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}
//设置Section的页脚
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSString *result = nil;
    if (section == 2)
    {
        result = @"亲，推荐您使用智能拨打方式奥……";
    }
    return result;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        UIImageView*imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me_dial_set_bg"]];
        cell.backgroundView = imageView;
        cell.textLabel.textColor = [UIColor grayColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.textColor = [UIColor grayColor];
        if (indexPath.section==0)
        {
            
            cell.textLabel.text = [Utility getDialWay:indexPath.section];
            cell.detailTextLabel.text = @"Wifi自动直拨，非Wifi回拨，省钱省流量";
        }
        else  if (indexPath.section==1)
        {
            cell.textLabel.text = [Utility getDialWay:indexPath.section];
            cell.detailTextLabel.text = @"仅发起呼叫时耗流量小于2K";
        }
        else  if (indexPath.section==2)
        {
            cell.textLabel.text = [Utility getDialWay:indexPath.section];
            cell.detailTextLabel.text = @"通话消耗流量约4K/秒";
        }
        else  if (indexPath.section==3)
        {
            cell.textLabel.text = [Utility getDialWay:indexPath.section];
            cell.detailTextLabel.text = @"每次呼叫时选择拨号方式";
        }
    }
    if ( [[Utility shareInstance].u_dialWay intValue] == indexPath.section  )
    {
        UIImageView*imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"set_dialset_button1_s"]];
        cell.accessoryView = imageView;
    }
    else
    {
        
         UIImageView*imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"set_dialset_button1_n"]];
        cell.accessoryView = imageView;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //cell.accessoryType = UITableViewCellAccessoryCheckmark;
    UIImageView*imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"set_dialset_button1_s"]];
    cell.accessoryView = imageView;
    [Utility shareInstance].u_dialWay = [NSString stringWithFormat:@"%d",indexPath.section];
    NSString *sql1 = [NSString stringWithFormat:@"UPDATE %@ SET s_dialWay = '%@'",USERDATA,[Utility shareInstance].u_dialWay];
    sql1 = [sql1 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    [[Utility shareInstance] sql_inser_data:sql1,nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadData];
}

@end
