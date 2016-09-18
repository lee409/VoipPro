//
//  BalanceViewController.m
//  VOIP
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BalanceViewController.h"
#import "ExButton.h"

@implementation BalanceViewController

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
    [self addAavigationView:@"账户设置" aback:@"back.png"];
    [self adaptiveIos1];
//    UIColor *icolor = [UIColor colorWithRed:26.0f/255.0f green:158.0f/255.0f blue:119.0f/255.0f alpha:1.0f];
//    [self.bt_sure setBackgroundColor:icolor];
    self.m_account.text = [Utility shareInstance].u_account;
    [self query_request2];
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - 49) style:UITableViewStylePlain];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.rowHeight = 50;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     self.butarray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<2; i++) {
       ExButton *btn1 = [ExButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(0, 0, kDeviceWidth, 50);
        [btn1 addTarget:self action:@selector(openOrClose:) forControlEvents:UIControlEventTouchUpInside];
      //  [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"me_set_%d_n",i+1]] forState:UIControlStateNormal];
        btn1.tag = 10+i;
        [_butarray addObject:btn1];
      //  [btn release];

    }
    
    
    [self.view addSubview:self.myTableView];
    }
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)query_request
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    mbp.labelText = @"   请稍等...   ";
    NSMutableArray *insm = [NSMutableArray array];
    [insm addObject:@"query_cmd"];
    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Ret",@"",@"Val",@"",@"Date", nil];
    [insm addObject:ixml];
    NSString *iurl = [NSString stringWithFormat:@"http://%@/api/queryaccount.php?regnum=%@",IP,self.m_account.text];
    [insm addObject:iurl];
    m_request = [[HttpDataRequests alloc] init:insm];
    m_request.delegate = self;
}

-(void)query_request2
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    mbp.labelText = @"   请稍等...   ";
    NSMutableArray *insm = [NSMutableArray array];
    [insm addObject:@"query_cmd"];
    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"noInformation", nil];
    [insm addObject:ixml];
    NSString *iurl = [NSString stringWithFormat:@"http://%@/call.php?action=wap_getbalance&acctname=%@&password=%@",IP,self.m_account.text,[Utility getMD5:[Utility shareInstance].u_password]];
    [insm addObject:iurl];
    m_request = [[HttpDataRequests alloc] init:insm];
    m_request.delegate = self;
    NSLog(@"md5 = %@",iurl);
}

-(void)HttpCallBack:(id)adata atag:(InternetState)atag acmd:(NSString*)acmd
{
    if (![[Utility getError:atag] isEqualToString:@"OK"] )
    {
        [[iToast makeToast:[Utility getError:atag]] show];
    }
    else
    {
        NSString *is = (NSString*)adata;
        
        //NSLog(@"ffffff%@",is);
        if ([acmd isEqualToString:@"query_cmd"])
        {
            //            if ( ![[Utility getErrorQUERY:[[adata objectForKey:@"Ret"] intValue]] isEqualToString:@"OK"] )
            //            {
            //                self.m_balance.text = [Utility getErrorQUERY:[[adata objectForKey:@"Ret"] intValue]];
            //                self.m_deadline.text = [Utility getErrorQUERY:[[adata objectForKey:@"Ret"] intValue]];
            //                [[iToast makeToast:[Utility getErrorQUERY:[[adata objectForKey:@"Ret"] intValue]]] show];
            //            }
            //            else
            //            {
            //                self.m_balance.text = [NSString stringWithFormat:@"%@ 元",[adata objectForKey:@"Val"]];
            //                self.m_deadline.text = [NSString stringWithFormat:@"%@",[adata objectForKey:@"Date"]];
            //            }
            if ( (is.length > 0) && ([is rangeOfString:@"账户余额"].length > 0) && ([is rangeOfString:@"有效期至"].length > 0)) {
                NSArray *array = [adata componentsSeparatedByString:@"<br/>"];
                NSString *str = array[0];
                NSRange range = [str rangeOfString:@"账户余额"];
                NSString *balance = [[str substringFromIndex:range.location] componentsSeparatedByString:@":"][1];
                
                NSString *date = [array[1] componentsSeparatedByString:@":"][1];
                self.m_balance.text = [NSString stringWithFormat:@"%@",balance];
                self.m_deadline.text = [NSString stringWithFormat:@"%@",date];
                
            }else{
                
                [iToast makeToast:@"查询失败"];
            }
            
            m_request.delegate=nil;
            [m_request release];
            m_request = nil;
            
            
        }else if ([acmd isEqualToString:@"changePassword_cmd"])
            {
                if ( ![[Utility getErrorCHANGEPASSWORD:[[adata objectForKey:@"Ret"] intValue]] isEqualToString:@"OK"] )
                {
                    [[iToast makeToast:[Utility getErrorCHANGEPASSWORD:[[adata objectForKey:@"Ret"] intValue]]] show];
                }
                else
                {
                 //   [MobClick event:@"2"];
                    
                    [Utility shareInstance].u_password = self.str3;
                    
                    NSString *sql1 = [NSString stringWithFormat:@"UPDATE %@ SET s_password = '%@'",USERDATA,[Utility shareInstance].u_password];
                    sql1 = [sql1 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
                    [[Utility shareInstance] sql_inser_data:sql1,nil];
                    
                   // [[iToast makeToast:[NSString stringWithFormat:@"新密码“%@”设置成功！",[Utility shareInstance].u_password]] show];
                    [[iToast makeToast:@"密码设置成功！"] show];
                    
                    NSLog(@"fff%@",self.str3);
                   // [self.navigationController popViewControllerAnimated:YES];
                }
            }
       
        m_request1.delegate=nil;
        [m_request1 release];
        m_request1 = nil;
    }
    
   [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
}



//请求开始
- (void)requestStarted:(ASIHTTPRequest *)request
{
    //NSLog(@"请求开始");
    
}

//请求完成
- (void)requestFinished:(ASIHTTPRequest *)request
{
    // NSLog(@"请求完成");
    NSString *retrurnContent = [request responseString];
    NSArray *array = [retrurnContent componentsSeparatedByString:@";"];
    //NSLog(@"%@",array[3]);
    NSArray *array2 = [array[0] componentsSeparatedByString:@"|"];
    //NSLog(@"%@",array2[0]);
    
    if ([array2[0] isEqualToString:@"0"])
    {
        self.m_balance.text = [NSString stringWithFormat:@"%@",array[2]];
        self.m_deadline.text = array[3];
    }else
    {
        [[iToast makeToast:@"查询失败"] show];
    }
    
    
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    //NSLog(@"%@",[request responseString]);
    
}

//请求失败
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [[iToast makeToast:@"请求失败,请检查网络"] show];
    NSLog(@"请求失败");
}



- (void)bt_goPay:(id)sender
{
    [((AppDelegate*)[UIApplication sharedApplication].delegate).mainTabBarController when_tabbar_is_selected:2];
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return  180;
    }
    return 166;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isOpen[section] == YES) {
        return 1;
  
    }
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentfier1 =@"cell1";
    static NSString *cellIndentfier2 =@"cell2";

    BalanceTableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell =[tableView dequeueReusableCellWithIdentifier:cellIndentfier1];
            if (!cell)
            {
                cell =[[[NSBundle mainBundle]loadNibNamed:@"BalanceTableViewCell" owner:nil options:nil]objectAtIndex:0];
                cell.delegate1= self;
            }

        }
        cell.numBerLabel.text = [Utility shareInstance].u_account;

        cell.accountLabel.text = self.m_balance.text;
        cell.passTimeLabel.text = self.m_deadline.text;
        NSString*str = [self.m_balance.text stringByReplacingOccurrencesOfString:@"元" withString:@""];
        float a = [str floatValue];
        NSLog(@"fff%@",str);
        cell.timeLabel.text = [NSString stringWithFormat:@"%0.0f分钟",a/0.08];

    }
    else if(indexPath.section == 1){
        if (indexPath.row == 0)
        {
            cell =[tableView dequeueReusableCellWithIdentifier:cellIndentfier2];
            if (!cell)
            {
                cell =[[[NSBundle mainBundle]loadNibNamed:@"BalanceTableViewCell" owner:nil options:nil]objectAtIndex:1];
                cell.delegate1 = self;
                
                
            }
        }
       }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
      
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //    NSLog(@"%s",__func__);
    static NSString *headerViewID = @"headerViewID1";
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewID];
    
    if (headerView == nil) {
        headerView = [[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerViewID]autorelease];

        
    }
    
    ExButton *btn = (ExButton *)[_butarray objectAtIndex:section];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.titleLabel.font =  [UIFont systemFontOfSize:14];
    if (_isOpen[section]==YES) {
        [btn setBackgroundImage:[UIImage imageNamed:@"me_set_bg_s"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];        if (section == 0) {
            
            [btn setTitle:@"     账户信息查看" forState:UIControlStateNormal];
            
            
        }else{
            
            
            [btn setTitle:@"     账户密码修改" forState:UIControlStateNormal];
        }
        
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:@"me_set_bg_n"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        if (section == 0) {
            
            
            [btn setTitle:@"     账户信息查看" forState:UIControlStateNormal];
            
        }else{
            
            
            [btn setTitle:@"     账户密码修改" forState:UIControlStateNormal];
            
        }
        
    }
    //    记录当前区号
    btn.sectionFlag = (int)section;
    
    
    [headerView addSubview:btn];
        
    
    
    
    
    return headerView;
    
    
}
-(void)openOrClose:(ExButton *)btn
{
    
    _isOpen[btn.sectionFlag] = ! _isOpen[btn.sectionFlag];
    //    刷新列表
    [self. myTableView reloadData];
    
    
    
    
    
}

-(void)BalanceTableViewCell2:(BalanceTableViewCell*)BalanceTableViewCell2  str1:(NSString*)str1  str2:(NSString*)str2{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    mbp.labelText = @"   请稍等...   ";
    NSMutableArray *insm = [NSMutableArray array];
    [insm addObject:@"changePassword_cmd"];
    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Ret", nil];
    [insm addObject:ixml];
    NSString *iurl = [NSString stringWithFormat:@"http://%@/api/editpassword.php? regnum=%@& oldpwd=%@&newpwd=%@",IP,[Utility shareInstance].u_account,str1,str2];
    [insm addObject:iurl];
    m_request1 = [[HttpDataRequests alloc] init:insm];
    m_request1.delegate = self;
    self.str3 = str2;
    
    
}


- (void)dealloc {
   
    [super dealloc];
    [_m_account release];
    [_m_balance release];
    [_m_deadline release];
    [_bt_sure release];
    [_myTableView release];
    [_butarray release];


}
- (void)viewDidUnload {
    [self setBt_sure:nil];
    [super viewDidUnload];
}
@end
