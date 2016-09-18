//
//  CallerIDPrivacyViewController.m
//  VOIP
//
//  Created by apple on 14-4-8.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CallerIDPrivacyViewController.h"

@implementation CallerIDPrivacyViewController

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
    [self addAavigationView:@"拨号设置" aback:@"back.png"];
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
    return 44;
}
//设置Section的页脚
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSString *result = nil;
    if (section == 10)
    {
        result = @"关闭来电显示后，对方将无法识别主叫身分！开启来电，资费将增加！";
    }
    else if (section == 0)
    {
        result = @"建议开启按键震动，这样有助于您更好的操作拨号键盘。";
    }
    else if (section == 1)
    {
        result = @"按键声音开启有助于您更好的操作拨号键盘。";
    }
    else if (section == 2)
    {
        result = @"开关回拨等待音";
    }
    return result;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section==10)
        {
            cell.textLabel.text = @"来电显示";
            UISwitch *m_set1 = [[UISwitch alloc] initWithFrame:CGRectMake(230, 6, 30, 10)];
            if ([[Utility shareInstance].u_callShow isEqualToString:@"0"])
            {
                [m_set1 setOn:YES];
            }
            else
            {
                [m_set1 setOn:NO];
            }
            [m_set1 addTarget:self action:@selector(switchSet1) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:m_set1];
            [m_set1 release];
        }
        else  if (indexPath.section==0)
        {
            UIImageView*imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me_dial_set_3"]];
            cell.backgroundView = imageView;
            UISwitch *m_set2 = [[UISwitch alloc] initWithFrame:CGRectMake(kDeviceWidth-65, 6, 30, 10)];
            m_set2.transform = CGAffineTransformMakeScale(0.8, 0.8);
            
            m_set2.onTintColor = CHANGEColorWith(0x4cafff,1.0);
            //m_set2.enabled = NO;
            if ([[Utility shareInstance].u_keyboardShake isEqualToString:@"0"])
            {
                [m_set2 setOn:YES];
            }
            else
            {
                [m_set2 setOn:NO];
            }
            [m_set2 addTarget:self action:@selector(switchSet2) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:m_set2];
            [m_set2 release];
        }
        else  if (indexPath.section==1)
        {
            
            UIImageView*imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me_dial_set_2"]];
            cell.backgroundView = imageView;
            UISwitch *m_set3 = [[UISwitch alloc] initWithFrame:CGRectMake(kDeviceWidth-65, 6, 30, 10)];
            m_set3.transform = CGAffineTransformMakeScale(0.8, 0.8);
            
            m_set3.onTintColor = CHANGEColorWith(0x4cafff,1.0);           // m_set3.enabled = NO;
            if ([[Utility shareInstance].u_keyboardVoice isEqualToString:@"0"])
            {
                [m_set3 setOn:YES];
            }
            else
            {
                [m_set3 setOn:NO];
            }
            [m_set3 addTarget:self action:@selector(switchSet3) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:m_set3];
            [m_set3 release];
        }
        else  if (indexPath.section==2)
        {
          
            UIImageView*imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me_dial_set_1"]];
            cell.backgroundView = imageView;
            UISwitch *m_set4 = [[UISwitch alloc] initWithFrame:CGRectMake(kDeviceWidth-65, 6, 30, 10)];
            m_set4.transform = CGAffineTransformMakeScale(0.8, 0.8);
            
            m_set4.onTintColor = CHANGEColorWith(0x4cafff,1.0);
            if ([[Utility shareInstance].u_beforeCallMusic isEqualToString:@"0"])
            {
                [m_set4 setOn:YES];
            }
            else
            {
                [m_set4 setOn:NO];
            }
            [m_set4 addTarget:self action:@selector(switchSet4) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:m_set4];
            [m_set4 release];
        }
    }
    
    if (indexPath.section==3)
    {
        //cell.textLabel.text = @"呼叫方式";
        
        
//        NSString *itype = [NSString stringWithFormat:@"（%@）",[Utility getDialWay:[[Utility shareInstance].u_dialWay intValue]]];
//        cell.detailTextLabel.text = itype;
//        UIColor *icolor1 = [UIColor colorWithRed:128.0f/255.0f green:13.0f/255.0f blue:13.0f/255.0f alpha:1.0f];
//        cell.detailTextLabel.textColor = icolor1;
//        cell.accessoryType = YES;
        UIImageView*imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me_dial_set_0_s"]];
        cell.backgroundView = imageView;
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3 && indexPath.row == 0)
    {
        setDialWayViewController *ctl = [[setDialWayViewController alloc] initWithNibName:@"setDialWayViewController" bundle:nil];
        ctl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctl animated:YES];
        [ctl release];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)switchSet1
{
    if ([[Utility shareInstance].u_callShow isEqualToString:@"0"])
    {
        [Utility shareInstance].u_callShow = @"1";
    }
    else
    {
        [Utility shareInstance].u_callShow = @"0";
    }
    NSString *sql1 = [NSString stringWithFormat:@"UPDATE %@ SET s_callShow = '%@'",USERDATA,[Utility shareInstance].u_callShow];
    sql1 = [sql1 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    [[Utility shareInstance] sql_inser_data:sql1,nil];
}
-(void)switchSet2
{
    if ([[Utility shareInstance].u_keyboardShake isEqualToString:@"0"])
    {
        [Utility shareInstance].u_keyboardShake = @"1";
    }
    else
    {
        [Utility shareInstance].u_keyboardShake = @"0";
    }
    NSString *sql1 = [NSString stringWithFormat:@"UPDATE %@ SET s_keyboardShake = '%@'",USERDATA,[Utility shareInstance].u_keyboardShake];
    sql1 = [sql1 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    [[Utility shareInstance] sql_inser_data:sql1,nil];
}
-(void)switchSet3
{
    if ([[Utility shareInstance].u_keyboardVoice isEqualToString:@"0"])
    {
        [Utility shareInstance].u_keyboardVoice = @"1";
    }
    else
    {
        [Utility shareInstance].u_keyboardVoice = @"0";
    }
    NSString *sql1 = [NSString stringWithFormat:@"UPDATE %@ SET s_keyboardVoice = '%@'",USERDATA,[Utility shareInstance].u_keyboardVoice];
    sql1 = [sql1 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    [[Utility shareInstance] sql_inser_data:sql1,nil];
}
-(void)switchSet4
{
    if ([[Utility shareInstance].u_beforeCallMusic isEqualToString:@"0"])
    {
        [Utility shareInstance].u_beforeCallMusic = @"1";
    }
    else
    {
        [Utility shareInstance].u_beforeCallMusic = @"0";
    }
    NSString *sql1 = [NSString stringWithFormat:@"UPDATE %@ SET s_beforeCallMusic = '%@'",USERDATA,[Utility shareInstance].u_beforeCallMusic];
    sql1 = [sql1 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    [[Utility shareInstance] sql_inser_data:sql1,nil];
}

@end
