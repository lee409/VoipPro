//
//  CorrelationViewController.m
//  VOIP
//
//  Created by apple on 14-4-19.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CorrelationViewController.h"

@implementation CorrelationViewController

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
    [self addAavigationView:@"相关说明" aback:@"back.png"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//显示行数。
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
//行高。
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = YES;
        if(indexPath.row == 0)
        {
            [cell.textLabel setText:@"最新优惠"];
            cell.imageView.image = [UIImage imageNamed:@"1image.png"];
        }
        else if(indexPath.row == 1)
        {
            [cell.textLabel setText:@"资费说明"];
            cell.imageView.image = [UIImage imageNamed:@"2image.png"];
        }
        else if(indexPath.row == 2)
        {
            [cell.textLabel setText:@"充值说明"];
            cell.imageView.image = [UIImage imageNamed:@"4image.png"];
        }
        else if(indexPath.row == 3)
        {
            [cell.textLabel setText:@"帮助说明"];
            cell.imageView.image = [UIImage imageNamed:@"5image.png"];
        }
    }
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemHelpViewController *ctl = [[ItemHelpViewController alloc] initWithNibName:@"ItemHelpViewController" bundle:nil];
    ctl.m_data = indexPath.row;
    ctl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctl animated:YES];
    [ctl release];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
