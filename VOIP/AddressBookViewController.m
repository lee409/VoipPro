//
//  AddressBookViewController.m
//  VOIP
//
//  Created by apple on 14-3-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "AddressBookViewController.h"
#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationDrop.h"
#import "LewPopupViewAnimationSlide.h"
#import "Reachability.h"
#import "AddressBookModel.h"

@implementation AddressBookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        m_sectionDic= [[NSMutableDictionary alloc] init];
        m_phoneDic=[[NSMutableDictionary alloc] init];
        m_sortedKeys=[[NSMutableArray alloc] init];
        m_filteredArray=[[NSMutableArray alloc] init];
         self.linkManArray = [NSMutableArray array];
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self loadContacts];
    [self requestLinkMan];
    
    [self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    if (IOS_VERSION_7_OR_ABOVE)
    {
        UIColor *icolor = CHANGEColorWith(0x4cafff,1.0);
        self.tableView.sectionIndexColor = icolor;
        self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UISearchBar *isearchBar = (UISearchBar *)self.tableView.tableHeaderView;
        [isearchBar setBackgroundImage:[self createImageWithColor:icolor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        // isearchBar.barTintColor = [UIColor colorWithRed:34.0f/255.0f green:179.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
        //[isearchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"ip_input.png"] forState:UIControlStateNormal];
        //        for(id cc in [isearchBar subviews])
        //        {
        //            if([cc isKindOfClass:[UIButton class]])
        //            {
        //                UIButton *btn = (UIButton *)cc;
        //                [btn setTitle:@"取消" forState:UIControlStateNormal];
        //            }
        //        }
        
    }
    
    UIButton* ilogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [ilogin setFrame:CGRectMake(0, 0, 25, 25)];
    [ilogin setShowsTouchWhenHighlighted:YES];
    [ilogin setBackgroundImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [ilogin addTarget:self action:@selector(rightBarButtonItemBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:ilogin] autorelease];
}
-(void)rightBarButtonItemBack:(id)sender
{
    //[self addNewPerson];
}
//- (void)addNewPerson
//{
//    CFErrorRef error = NULL;
//    // Create New Contact
//    ABRecordRef person = ABPersonCreate ();
//    
//    // Add phone number
//    ABMutableMultiValueRef multiValue =
//    ABMultiValueCreateMutable(kABStringPropertyType);
//    
//    ABMultiValueAddValueAndLabel(multiValue, nil, kABPersonPhoneMainLabel,
//                                 NULL);
//    
//    ABRecordSetValue(person, kABPersonPhoneProperty, multiValue, &error);
//    
//    
//    ABNewPersonViewController *newPersonCtrl = [[ABNewPersonViewController alloc] init];
//    newPersonCtrl.newPersonViewDelegate = self;
//    newPersonCtrl.displayedPerson = person;
//    CFRelease(person); // TODO check
//    
//    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:newPersonCtrl];
//    UIColor *icolor = CHANGEColorWith(0x4cafff,1.0);
//    
//    [navCtrl.navigationBar setBackgroundImage:[self createImageWithColor:icolor] forBarMetrics:UIBarMetricsDefault];
//    navCtrl.navigationBar.barStyle = UIBarStyleBlackOpaque;
//    [self.parentViewController presentViewController:navCtrl animated:YES completion:nil];
//    [newPersonCtrl release];
//    [navCtrl release];
//}
//- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController didCompleteWithNewPerson:(ABRecordRef)person
//{
//    [newPersonViewController dismissViewControllerAnimated:YES completion:nil];
//}
-(void)requestLinkMan{
    
        NSString*linkManStr = @"1111";
    
        for (int i = 0; i < _linkManArray.count; i++) {
    
            linkManStr = [NSString stringWithFormat:@"%@|%@",linkManStr, _linkManArray[i]];
        }
        NSLog(@"1111%@",linkManStr);
    
    
        NSMutableArray *insm = [NSMutableArray array];
        [insm addObject:@"query_cmd"];
        NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Ret",@"",@"AcctName", nil];
        [insm addObject:ixml];
        NSString *iurl = [NSString stringWithFormat:@"http://%@/api/get_friend_info.php?mobileList=%@",IP,linkManStr];
    
    
        [insm addObject:iurl];
    
    
        m_request = [[HttpDataRequests alloc] init:insm];
        m_request.delegate = self;
    
    
    
    }
-(void)HttpCallBack:(id)adata atag:(InternetState)atag acmd:(NSString*)acmd
    {
        if (![[Utility getError:atag] isEqualToString:@"OK"] )
        {
            [[iToast makeToast:[Utility getError:atag]] show];
        }
        else
        {
            NSData*date = [adata dataUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"f1111sss%@",date);
            NSDictionary *stateDit = [NSJSONSerialization JSONObjectWithData:date options:NSJSONReadingMutableContainers error:nil];
    
            NSString*stare = [NSString stringWithFormat:@"%@",stateDit[@"state"]];
    
    
            if ([stare isEqualToString:@"1"]) {
    
                NSArray*msg =  stateDit[@"msg"];
    
                NSLog(@"hh%@",msg);
                self.filteredArray = msg;
                [self.tableView reloadData];
    
                //        1,创建系统通讯录的实例
                ABAddressBookRef addressBook = [Utility shareInstance].u_addressBook;
                //    2,得到授权   注意 在block块中写的代码是分线程执行的  分线程不可以刷新UI  要转到主线程中刷新UI
                ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                });
    
                //            授权成功后获得通讯录的信息
                //            获得所有联系人信息
                NSArray *array = ( NSArray *) ABAddressBookCopyArrayOfAllPeople(addressBook);
                self.modelArray = [[NSMutableArray alloc]initWithCapacity:0];
    
                for (int i=0; i<array.count; i++) {
                    //                得到联系人的每一条记录
                    ABRecordRef record = ( ABRecordRef)([array objectAtIndex:i]);
                    //                得到联系人的全名
                    NSString *name =( NSString *)ABRecordCopyCompositeName(record);
                    //                得到多值记录
                    ABMultiValueRef multivalue = ABRecordCopyValue(record, kABPersonPhoneProperty);
    
                    //                根据索引取值
                    NSString *phone = ( NSString *)(ABMultiValueCopyValueAtIndex(multivalue, 0));
                    //                封装成model
    
                    for (int i = 0 ; i<_filteredArray.count; i ++) {
                        if ([[self trimString:phone] isEqualToString:_filteredArray[i]]) {
                            AddressBookModel *person = [[AddressBookModel alloc]init];
                            person.name = name;
                            //        用来处理电话号码中的括号还有横线
                            person.homePhone = _filteredArray[i];
    
                            [_modelArray addObject:person];
    
                        }
                    }
    
    
    
    
                }
            }
    
        }
    
    
    
    
    }
    -(NSString *)trimString:(NSString *)phone
    {
        //NSLog(@"####-----%@",phone);
        //    用字符串来代替字符串中的某个字符
        phone = [phone stringByReplacingOccurrencesOfString:@"(" withString:@""];
        phone = [phone stringByReplacingOccurrencesOfString:@")" withString:@""];
        phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
        phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        
        return phone;
    }






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - Table View
//返回索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.tableView])
    {
        NSMutableArray *indices = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
        for (int i = 0; i < [m_sortedKeys count]; i++)
        {
            [indices addObject:[m_sortedKeys objectAtIndex:i]];
        }
        return indices;
    }
    return nil;
}
//响应点击索引时的委托方法
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (title == UITableViewIndexSearch)
    {
        [self.tableView scrollRectToVisible:self.searchDisplayController.searchBar.frame animated:NO];
        return -1;
    }
    return  [m_sortedKeys indexOfObject:title];
}
//返回section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.tableView])
    {
        return [m_sortedKeys count];
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 18;
    
    
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
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [Utility shareInstance].u_calledHuiboOrZhibo = @"1";
            [[Utility shareInstance] callPhonaPage:self];
            break;
        case 1:
            [[iToast makeToast:@"该功能暂时未开启，请联系开发商！"] show];
            break;
        default:
            break;
    }
}
//设置每个区有多少行共有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableView])
    {
        NSString *key=[NSString stringWithFormat:@"%@",[m_sortedKeys objectAtIndex:section]];
        return  [[m_sectionDic objectForKey:key] count];
    }
    else if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        return [m_filteredArray count];
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //    NSLog(@"%s",__func__);
    static NSString *headerViewID = @"headerViewID";
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewID];
    UIImageView*imageView;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerViewID];
        UIView*view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        headerView.backgroundView = view;
        imageView = [[UIImageView alloc]init];
        
        imageView.frame = CGRectMake(0, 0, kDeviceWidth, 18);
        imageView.image = [UIImage imageNamed:@"分类-A"];
        
        [headerView addSubview:imageView];
        
    }
    
    
    
    return headerView;
    
    
}




-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableView])
    {
        NSString *key=[NSString stringWithFormat:@"%@",[m_sortedKeys objectAtIndex:section]];
        return key;
    }
    else if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        return [NSString stringWithFormat:@"共搜索到%d条",[m_filteredArray count]];
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![tableView isEqual:self.tableView])
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
            
            cell.m_string2.frame = CGRectMake(20, 30, 200, 20);
            cell.m_string2.font = [UIFont systemFontOfSize:11.0f];
            cell.m_string2.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
            
            cell.m_string3.frame = CGRectMake(110, 30, 100, 20);
            cell.m_string3.font = [UIFont systemFontOfSize:11.0f];
            cell.m_string3.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
            cell.m_string3.textAlignment = NSTextAlignmentRight;
            cell.imageTopu.frame =  CGRectMake(kDeviceWidth - 15 - 22, 14, 22, 22);
            
        }
        NSDictionary *person=[m_filteredArray objectAtIndex:indexPath.row];
        NSString *sname = [[person objectForKey:@"name"] stringByReplacingOccurrencesOfString:@" " withString:@""];
        cell.m_string1.text= sname;
        NSString * iPhone = [person objectForKey:@"phone"];
        iPhone = [iPhone stringByReplacingOccurrencesOfString:@"+86" withString:@""];
        iPhone = [iPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
        iPhone = [iPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
        cell.m_string2.text = iPhone;
        cell.m_string3.text = [[Utility shareInstance] selectInfoByPhone:iPhone];
        for (int i = 0 ; i<_filteredArray.count; i ++) {
                        if ([iPhone isEqualToString:_filteredArray[i]]) {
                            cell.imageTopu.image = [UIImage imageNamed:@"contacts_logo"];
                            break;
                        }else{
                            cell.imageTopu.image = nil;
                            
                        }
                    }
        
        
        return cell;
    }
    else
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
            
            cell.m_string2.frame = CGRectMake(20, 30, 200, 20);
            cell.m_string2.font = [UIFont systemFontOfSize:11.0f];
            cell.m_string2.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
            
            cell.m_string3.frame = CGRectMake(110, 30, 100, 20);
            cell.m_string3.font = [UIFont systemFontOfSize:11.0f];
            cell.m_string3.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
            cell.m_string3.textAlignment = NSTextAlignmentRight;
            cell.imageTopu.frame =  CGRectMake(kDeviceWidth - 15 - 22, 14, 22, 22);
            
        }
        NSString *key=[NSString stringWithFormat:@"%@",[m_sortedKeys objectAtIndex:indexPath.section]];
        NSMutableArray *record=[[m_sectionDic objectForKey:key] objectAtIndex:indexPath.row];
        NSString *sname = (NSString *)ABRecordCopyCompositeName([record objectAtIndex:0]);
        sname = [NSString stringWithFormat:@"%@",sname];
        sname = [sname stringByReplacingOccurrencesOfString:@" " withString:@""];
        sname = [sname stringByReplacingOccurrencesOfString:@"(null)" withString:@"未设名称"];
        cell.m_string1.text= sname;
        ABMultiValueRef phone = ABRecordCopyValue([record objectAtIndex:0], kABPersonPhoneProperty);
        NSString * iPhone = (NSString*)ABMultiValueCopyValueAtIndex(phone, [[record objectAtIndex:1] intValue]);
        iPhone = [iPhone stringByReplacingOccurrencesOfString:@"+86" withString:@""];
        iPhone = [iPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
        iPhone = [iPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
        cell.m_string2.text = iPhone;
        cell.m_string3.text = [[Utility shareInstance] selectInfoByPhone:iPhone];
        for (int i = 0 ; i<_filteredArray.count; i ++) {
                        if ([iPhone isEqualToString:_filteredArray[i]]) {
                            cell.imageTopu.image = [UIImage imageNamed:@"contacts_logo"];
                            break;
                        }else{
                            cell.imageTopu.image = nil;
                            
                        }
                    }
        
        
        
        return cell;
    }
    return nil;
}
#pragma mark -
#pragma mark - 处理号码
-(void)loadContacts
{
    [m_sectionDic removeAllObjects];
    [m_phoneDic removeAllObjects];
    [m_sortedKeys removeAllObjects];
    
    if ([Utility shareInstance].u_bool)
    {
        for (int i = 0; i < ALPHA.length-1; i++)
        {
            [m_sectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'A'+i]];
        }
        [m_sectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'#']];
        
        ABAddressBookRef myAddressBook = [Utility shareInstance].u_addressBook;
        CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(myAddressBook);
        CFMutableArrayRef mresults=CFArrayCreateMutableCopy(kCFAllocatorDefault,CFArrayGetCount(results),results);
        CFArraySortValues(mresults,CFRangeMake(0, CFArrayGetCount(results)),(CFComparatorFunction) ABPersonComparePeopleByName,(void*) ABPersonGetSortOrdering());
        
        //遍历所有联系人
        for (int k=0;k<CFArrayGetCount(mresults);k++)
        {
            ABRecordRef record=CFArrayGetValueAtIndex(mresults,k);
            NSString *personname = (NSString *)ABRecordCopyCompositeName(record);
            ABMultiValueRef phone = ABRecordCopyValue(record, kABPersonPhoneProperty);
            ABRecordID recordID=ABRecordGetRecordID(record);
            //得到手机号码
            for (int k = 0; k<ABMultiValueGetCount(phone); k++)
            {
                NSString * iPhone = (NSString*)ABMultiValueCopyValueAtIndex(phone, k);
                iPhone = [iPhone stringByReplacingOccurrencesOfString:@"+86" withString:@""];
                iPhone = [iPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
                iPhone = [iPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
                if (![iPhone isMatchedByRegex:@"^(13|15|18|17|14)\\d{9}$"])
                {
                    continue;
                }
                else
                {
                     [_linkManArray addObject:iPhone];
                    [m_phoneDic setObject:record forKey:[NSString stringWithFormat:@"%@%d",iPhone,recordID]];
                }
                
                char first=pinyinFirstLetter([personname characterAtIndex:0]);
                NSString *sectionName;
                if ((first>='a'&&first<='z')||(first>='A'&&first<='Z'))
                {
                    if([self searchResult:personname searchText:@"曾"])
                        sectionName = @"Z";
                    else if([self searchResult:personname searchText:@"解"])
                        sectionName = @"X";
                    else if([self searchResult:personname searchText:@"仇"])
                        sectionName = @"Q";
                    else if([self searchResult:personname searchText:@"朴"])
                        sectionName = @"P";
                    else if([self searchResult:personname searchText:@"查"])
                        sectionName = @"Z";
                    else if([self searchResult:personname searchText:@"能"])
                        sectionName = @"N";
                    else if([self searchResult:personname searchText:@"乐"])
                        sectionName = @"Y";
                    else if([self searchResult:personname searchText:@"单"])
                        sectionName = @"S";
                    else
                        sectionName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([personname characterAtIndex:0])] uppercaseString];
                }
                else
                {
                    sectionName=[[NSString stringWithFormat:@"%c",'#'] uppercaseString];
                }
                [[m_sectionDic objectForKey:sectionName] addObject:[NSArray arrayWithObjects:record,[NSNumber numberWithInt:k],nil]];
            }
        }
        for (int i = 0; i < [[m_sectionDic allKeys] count]; i++)
        {
            NSString *ikey = [NSString stringWithFormat:@"%c",'A'+i];
            if ( [[m_sectionDic objectForKey:ikey] count] == 0 )
            {
                [m_sectionDic removeObjectForKey:ikey];
            }
        }
        if ( [[m_sectionDic objectForKey:@"#"] count] == 0 )
        {
            [m_sectionDic removeObjectForKey:@"#"];
        }
        [m_sortedKeys addObjectsFromArray:[[m_sectionDic allKeys] sortedArrayUsingSelector:@selector(compare:)]];
        if ([[m_sortedKeys objectAtIndex:0] isEqualToString:@"#"])
        {
            [m_sortedKeys removeObject:@"#"];
            [m_sortedKeys addObject:@"#"];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请在iPhone的“设置>隐私>通讯录”选项中，允许5G开心聊访问你的通讯录，这样你可以更快更准确地添加TA" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}
-(BOOL)searchResult:(NSString *)contactName searchText:(NSString *)searchT
{
    NSComparisonResult result = [contactName compare:searchT options:NSCaseInsensitiveSearch range:NSMakeRange(0, searchT.length)];
    if (result == NSOrderedSame)
        return YES;
    else
        return NO;
}


#pragma mark -
#pragma UISearchDisplayDelegate
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self performSelectorOnMainThread:@selector(searchWithString:) withObject:searchString waitUntilDone:YES];
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}




-(void)searchWithString:(NSString *)searchString
{
    [m_filteredArray removeAllObjects];
    NSString * regex = @"(^[0-9]+$)";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([searchString length]!=0)
    {
        if ([pred evaluateWithObject:searchString])
        {
            //判断是否是数字
            NSArray *phones=[m_phoneDic allKeys];
            for (NSString *phone in phones)
            {
                if ([self searchResult:phone searchText:searchString])
                {
                    ABRecordRef person=[m_phoneDic objectForKey:phone];
                    ABRecordID recordID=ABRecordGetRecordID(person);
                    NSString *ff=[NSString stringWithFormat:@"%d",recordID];
                    NSString *name=(NSString *)ABRecordCopyCompositeName(person);
                    name = [NSString stringWithFormat:@"%@",name];
                    name = [name stringByReplacingOccurrencesOfString:@"(null)" withString:@"未设名称"];
                    NSMutableDictionary *record=[[NSMutableDictionary alloc] init];
                    [record setObject:name forKey:@"name"];
                    [record setObject:[phone substringToIndex:(phone.length-ff.length)] forKey:@"phone"];
                    [record setObject:[NSNumber numberWithInt:recordID] forKey:@"ID"];
                    [m_filteredArray addObject:record];
                    [record release];
                }
            }
        }
        else
        {
            //搜索对应分类下的数组
            NSString *sectionName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([searchString characterAtIndex:0])] uppercaseString];
            NSArray *array=[m_sectionDic objectForKey:sectionName];
            for (int j=0;j<[array count];j++)
            {
                ABRecordRef person=[[array objectAtIndex:j] objectAtIndex:0];
                int n = [[[array objectAtIndex:j] objectAtIndex:1] intValue];
                NSString *name=(NSString *)ABRecordCopyCompositeName(person);
                if ([self searchResult:name searchText:searchString])
                {
                    //先按输入的内容搜索
                    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
                    NSString * personPhone = (NSString*)ABMultiValueCopyValueAtIndex(phone, n);
                    ABRecordID recordID=ABRecordGetRecordID(person);
                    NSMutableDictionary *record=[[NSMutableDictionary alloc] init];
                    [record setObject:name forKey:@"name"];
                    [record setObject:personPhone forKey:@"phone"];
                    [record setObject:[NSNumber numberWithInt:recordID] forKey:@"ID"];
                    [m_filteredArray addObject:record];
                    [record release];
                }
                else
                {
                    //按拼音搜索
                    NSString *string = @"";
                    NSString *firststring=@"";
                    for (int i = 0; i < [name length]; i++)
                    {
                        if([string length] < 1)
                            string = [NSString stringWithFormat:@"%@", [POAPinyin quickConvert:[name substringWithRange:NSMakeRange(i,1)]]];
                        else
                            string = [NSString stringWithFormat:@"%@%@",string, [POAPinyin quickConvert:[name substringWithRange:NSMakeRange(i,1)]]];
                        if([firststring length] < 1)
                        {
                            firststring = [NSString stringWithFormat:@"%c", pinyinFirstLetter([name characterAtIndex:i])];
                        }
                        else
                        {
                            if ([name characterAtIndex:i]!=' ')
                            {
                                firststring = [NSString stringWithFormat:@"%@%c",firststring,pinyinFirstLetter([name characterAtIndex:i])];
                            }
                        }
                    }
                    if ([self searchResult:string searchText:searchString]||[self searchResult:firststring searchText:searchString])
                    {
                        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
                        NSString * personPhone = (NSString*)ABMultiValueCopyValueAtIndex(phone, n);
                        ABRecordID recordID=ABRecordGetRecordID(person);
                        NSMutableDictionary *record=[[NSMutableDictionary alloc] init];
                        [record setObject:name forKey:@"name"];
                        [record setObject:personPhone forKey:@"phone"];
                        [record setObject:[NSNumber numberWithInt:recordID] forKey:@"ID"];
                        [m_filteredArray addObject:record];
                        [record release];
                    }
                }
            }
        }
    }
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


- (void)dealloc
{
    [m_sectionDic release];
    [m_phoneDic release];
    [m_sortedKeys release];
    [m_filteredArray release];
    [_modelArray release];
    [_linkManArray release];
    [_filteredArray release];
    [super dealloc];
}














//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self)
//    {
//        m_sectionDic= [[NSMutableDictionary alloc] init];
//        m_phoneDic=[[NSMutableDictionary alloc] init];
//        m_sortedKeys=[[NSMutableArray alloc] init];
//        m_filteredArray=[[NSMutableArray alloc] init];
//    }
//    return self;
//}
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//    [self loadContacts];
//      // [self requestLinkMan];
//    
//    [self.tableView reloadData];
//}
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//   
//    [self.view setBackgroundColor:[UIColor whiteColor]];
//    if (IOS_VERSION_7_OR_ABOVE)
//    {
//        UIColor *icolor = CHANGEColorWith(0x4cafff,1.0);
//        self.tableView.sectionIndexColor = icolor;
//        self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        UISearchBar *isearchBar = (UISearchBar *)self.tableView.tableHeaderView;
//        [isearchBar setBackgroundImage:[self createImageWithColor:icolor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//       // isearchBar.barTintColor = [UIColor colorWithRed:34.0f/255.0f green:179.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
//        //[isearchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"ip_input.png"] forState:UIControlStateNormal];
////        for(id cc in [isearchBar subviews])
////        {
////            if([cc isKindOfClass:[UIButton class]])
////            {
////                UIButton *btn = (UIButton *)cc;
////                [btn setTitle:@"取消" forState:UIControlStateNormal];
////            }
////        }
//        
//    }
//    self.linkManArray = [NSMutableArray array];
//    
//    
//}
////-(void)rightBarButtonItemBack:(id)sender
////{
////    [self addNewPerson];
////}
//
//
////- (void)addNewPerson
////{
////    CFErrorRef error = NULL;
////    // Create New Contact
////    ABRecordRef person = ABPersonCreate ();
////    
////    // Add phone number
////    ABMutableMultiValueRef multiValue =
////    ABMultiValueCreateMutable(kABStringPropertyType);
////    
////    ABMultiValueAddValueAndLabel(multiValue, nil, kABPersonPhoneMainLabel,
////                                 NULL);
////    
////    ABRecordSetValue(person, kABPersonPhoneProperty, multiValue, &error);
////    
////    
////    ABNewPersonViewController *newPersonCtrl = [[ABNewPersonViewController alloc] init];
////    newPersonCtrl.newPersonViewDelegate = self;
////    newPersonCtrl.displayedPerson = person;
////    CFRelease(person); // TODO check
////    
////    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:newPersonCtrl];
////    UIColor *icolor = CHANGEColorWith(0x4cafff,1.0);
////    
////    [navCtrl.navigationBar setBackgroundImage:[self createImageWithColor:icolor] forBarMetrics:UIBarMetricsDefault];
////    navCtrl.navigationBar.barStyle = UIBarStyleBlackOpaque;
////    [self.parentViewController presentViewController:navCtrl animated:YES completion:nil];
////    [newPersonCtrl release];
////    [navCtrl release];
////}
////- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController didCompleteWithNewPerson:(ABRecordRef)person
////{
////    [newPersonViewController dismissViewControllerAnimated:YES completion:nil];
////}
//-(void)requestLinkMan{
//    
//    NSString*linkManStr = @"1111";
//    
//    for (int i = 0; i < _linkManArray.count; i++) {
//        
//        linkManStr = [NSString stringWithFormat:@"%@|%@",linkManStr, _linkManArray[i]];
//    }
//    NSLog(@"1111%@",linkManStr);
//    
//    
//    NSMutableArray *insm = [NSMutableArray array];
//    [insm addObject:@"query_cmd"];
//    NSMutableDictionary *ixml = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Ret",@"",@"AcctName", nil];
//    [insm addObject:ixml];
//    NSString *iurl = [NSString stringWithFormat:@"http://%@/api/get_friend_info.php?mobileList=%@",IP,linkManStr];
//    
//    
//    [insm addObject:iurl];
//   
//    
//    m_request = [[HttpDataRequests alloc] init:insm];
//    m_request.delegate = self;
//
//    
//    
//}
//-(void)HttpCallBack:(id)adata atag:(InternetState)atag acmd:(NSString*)acmd
//{
//    if (![[Utility getError:atag] isEqualToString:@"OK"] )
//    {
//        [[iToast makeToast:[Utility getError:atag]] show];
//    }
//    else
//    {
//        NSData*date = [adata dataUsingEncoding:NSUTF8StringEncoding];
//        NSLog(@"f1111sss%@",date);
//        NSDictionary *stateDit = [NSJSONSerialization JSONObjectWithData:date options:NSJSONReadingMutableContainers error:nil];
//        
//        NSString*stare = [NSString stringWithFormat:@"%@",stateDit[@"state"]];
//        
//        
//        if ([stare isEqualToString:@"1"]) {
//            
//            NSArray*msg =  stateDit[@"msg"];
//            
//            NSLog(@"hh%@",msg);
//            self.filteredArray = msg;
//            [self.tableView reloadData];
//            
//            //        1,创建系统通讯录的实例
//            ABAddressBookRef addressBook = [Utility shareInstance].u_addressBook;
//            //    2,得到授权   注意 在block块中写的代码是分线程执行的  分线程不可以刷新UI  要转到主线程中刷新UI
//            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
//            });
//            
//            //            授权成功后获得通讯录的信息
//            //            获得所有联系人信息
//            NSArray *array = ( NSArray *) ABAddressBookCopyArrayOfAllPeople(addressBook);
//            self.modelArray = [[NSMutableArray alloc]initWithCapacity:0];
//            
//            for (int i=0; i<array.count; i++) {
//                //                得到联系人的每一条记录
//                ABRecordRef record = ( ABRecordRef)([array objectAtIndex:i]);
//                //                得到联系人的全名
//                NSString *name =( NSString *)ABRecordCopyCompositeName(record);
//                //                得到多值记录
//                ABMultiValueRef multivalue = ABRecordCopyValue(record, kABPersonPhoneProperty);
//                
//                //                根据索引取值
//                NSString *phone = ( NSString *)(ABMultiValueCopyValueAtIndex(multivalue, 0));
//                //                封装成model
//                
//                for (int i = 0 ; i<_filteredArray.count; i ++) {
//                    if ([[self trimString:phone] isEqualToString:_filteredArray[i]]) {
//                        AddressBookModel *person = [[AddressBookModel alloc]init];
//                        person.name = name;
//                        //        用来处理电话号码中的括号还有横线
//                        person.homePhone = _filteredArray[i];
//                        
//                        [_modelArray addObject:person];
//                        
//                    }
//                }
//                
//                
//                
//                
//            }
//        }
//        
//    }
//    
//    
//    
//    
//}
//-(NSString *)trimString:(NSString *)phone
//{
//    //NSLog(@"####-----%@",phone);
//    //    用字符串来代替字符串中的某个字符
//    phone = [phone stringByReplacingOccurrencesOfString:@"(" withString:@""];
//    phone = [phone stringByReplacingOccurrencesOfString:@")" withString:@""];
//    phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
//    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
//    
//    
//    return phone;
//}
//
//
//
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark -
//#pragma mark - Table View
////返回索引数组
//-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    if ([tableView isEqual:self.tableView])
//    {
//        NSMutableArray *indices = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
//        for (int i = 0; i < [m_sortedKeys count]; i++)
//        {
//            [indices addObject:[m_sortedKeys objectAtIndex:i]];
//        }
//        return indices;
//    }
//    return nil;
//}
////响应点击索引时的委托方法
//-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    if (title == UITableViewIndexSearch)
//    {
//        [self.tableView scrollRectToVisible:self.searchDisplayController.searchBar.frame animated:NO];
//        return -1;
//    }
//    return  [m_sortedKeys indexOfObject:title];
//}
////返回section的个数
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    if ([tableView isEqual:self.tableView])
//    {
//        return [m_sortedKeys count];
//    }
//    return 1;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//   return 18;
//    
//    
//}
//
////行高。
//- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 50;
//}
////点击进入好友详细资料。
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    publicTableViewCell1 *cell = (publicTableViewCell1 *)[tableView cellForRowAtIndexPath:indexPath];
//    [Utility shareInstance].u_calledName = cell.m_string1.text;
//    [Utility shareInstance].u_calledNumber = cell.m_string2.text;
//
//    NSString *itype = [Utility shareInstance].u_dialWay;
//    if ( [itype isEqualToString:@"0"] )//智能拨打
//    {
//        if ( [[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable )
//        {
//            [Utility shareInstance].u_calledHuiboOrZhibo = @"0";
//            [[Utility shareInstance] callPhonaPage:self];
//        }
//        else
//        {
//            [Utility shareInstance].u_calledHuiboOrZhibo = @"1";
//            [[Utility shareInstance] callPhonaPage:self];
//        }
//    }//回拨
//    else if ( [itype isEqualToString:@"1"] )
//    {
//        [Utility shareInstance].u_calledHuiboOrZhibo = @"1";
//        [[Utility shareInstance] callPhonaPage:self];
//    }//直拨
//    else if ( [itype isEqualToString:@"2"] )
//    {
//        [Utility shareInstance].u_calledHuiboOrZhibo = @"0";
//        [[Utility shareInstance] callPhonaPage:self];
//        
//    }//手动选择
//    else if ( [itype isEqualToString:@"3"] )
//    {
//        CallSelectView *view = [CallSelectView defaultPopupView];
//        view.parentVC = self;
//        view.delegate = self;
//        LewPopupViewAnimationSlide *animation = [[LewPopupViewAnimationSlide alloc]init];
//        animation.type = LewPopupViewAnimationSlideTypeBottomBottomEdge;
//        [self lew_presentPopupView:view animation:animation dismissed:^{
//            
//        }];
//    }
//
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    switch (buttonIndex)
//    {
//        case 0:
//            [Utility shareInstance].u_calledHuiboOrZhibo = @"1";
//            [[Utility shareInstance] callPhonaPage:self];
//            break;
//        case 1:
//            [[iToast makeToast:@"该功能暂时未开启，请联系开发商！"] show];
//            break;
//        default:
//            break;
//    }
//}
////设置每个区有多少行共有多少行
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if ([tableView isEqual:self.tableView])
//    {
//        NSString *key=[NSString stringWithFormat:@"%@",[m_sortedKeys objectAtIndex:section]];
//        return  [[m_sectionDic objectForKey:key] count];
//    }
//    else if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
//    {
//        return [m_filteredArray count];
//    }
//    return 0;
//}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    //    NSLog(@"%s",__func__);
//    static NSString *headerViewID = @"headerViewID";
//    
//    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewID];
//    UIImageView*imageView;
//    if (headerView == nil) {
//        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerViewID];
//        UIView*view = [[UIView alloc]init];
//        view.backgroundColor = [UIColor whiteColor];
//        headerView.backgroundView = view;
//        imageView = [[UIImageView alloc]init];
//        
//        imageView.frame = CGRectMake(0, 0, kDeviceWidth, 18);
//        imageView.image = [UIImage imageNamed:@"分类-A"];
//        
//        [headerView addSubview:imageView];
//        
//    }
//    
//    
//    
//    return headerView;
//    
//    
//}
//
//
//
//
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if ([tableView isEqual:self.tableView])
//    {
//        NSString *key=[NSString stringWithFormat:@"%@",[m_sortedKeys objectAtIndex:section]];
//        return key;
//    }
//    else if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
//    {
//        return [NSString stringWithFormat:@"共搜索到%d条",[m_filteredArray count]];
//    }
//    return nil;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (![tableView isEqual:self.tableView])
//    {
//        static NSString *CellIdentifier = @"Cell";
//        publicTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil)
//        {
//            cell = [[[publicTableViewCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//            UIImageView*imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"contacts_name_bg2_n"]];
//            
//            cell.backgroundView =  imageView;
//
//            
//            cell.m_string1.frame = CGRectMake(20, 5, 200, 20);
//            cell.m_string1.font = [UIFont boldSystemFontOfSize:15.0f];
//            cell.m_string1.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
//            
//            cell.m_string2.frame = CGRectMake(20, 30, 116, 20);
//            cell.m_string2.font = [UIFont systemFontOfSize:11.0f];
//            cell.m_string2.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
//            
//            cell.m_string3.frame = CGRectMake(110, 30, 100, 20);
//            cell.m_string3.font = [UIFont systemFontOfSize:11.0f];
//            cell.m_string3.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
//            cell.m_string3.textAlignment = NSTextAlignmentRight;
//            
//            cell.imageTopu.frame =  CGRectMake(kDeviceWidth - 15 - 22, 14, 22, 22);
//
//        }
//        NSDictionary *person=[m_filteredArray objectAtIndex:indexPath.row];
//        NSString *sname = [[person objectForKey:@"name"] stringByReplacingOccurrencesOfString:@" " withString:@""];
//        cell.m_string1.text= sname;
//        NSString * iPhone = [person objectForKey:@"phone"];
//        iPhone = [iPhone stringByReplacingOccurrencesOfString:@"+86" withString:@""];
//        iPhone = [iPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
//        iPhone = [iPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
//        for (int i = 0 ; i<_filteredArray.count; i ++) {
//            if ([iPhone isEqualToString:_filteredArray[i]]) {
//                cell.imageTopu.image = [UIImage imageNamed:@"contacts_logo"];
//                break;
//            }else{
//                cell.imageTopu.image = nil;
//                
//            }
//        }
//        
//        
//        cell.m_string2.text = iPhone;
//        cell.m_string3.text = [[Utility shareInstance] selectInfoByPhone:iPhone];
//        return cell;
//    }
//    else
//    {
//        static NSString *CellIdentifier = @"Cell";
//        publicTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil)
//        {
//            UIImageView*imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"contacts_name_bg2_n"]];
//            
//            cell.backgroundView =  imageView;
//            cell.m_string1.frame = CGRectMake(20, 5, 200, 20);
//            cell.m_string1.font = [UIFont boldSystemFontOfSize:15.0f];
//            cell.m_string1.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
//            
//            cell.m_string2.frame = CGRectMake(20, 30, 116, 20);
//            cell.m_string2.font = [UIFont systemFontOfSize:11.0f];
//            cell.m_string2.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
//            
//            cell.m_string3.frame = CGRectMake(110, 30, 100, 20);
//            cell.m_string3.font = [UIFont systemFontOfSize:11.0f];
//            cell.m_string3.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
//            cell.m_string3.textAlignment = NSTextAlignmentRight;
//            cell.imageTopu.frame =  CGRectMake(kDeviceWidth - 15 - 22, 14, 22, 22);
//        }
//        NSString *key=[NSString stringWithFormat:@"%@",[m_sortedKeys objectAtIndex:indexPath.section]];
//        NSMutableArray *record=[[m_sectionDic objectForKey:key] objectAtIndex:indexPath.row];
//        NSString *sname = (NSString *)ABRecordCopyCompositeName([record objectAtIndex:0]);
//        sname = [NSString stringWithFormat:@"%@",sname];
//        sname = [sname stringByReplacingOccurrencesOfString:@" " withString:@""];
//        sname = [sname stringByReplacingOccurrencesOfString:@"(null)" withString:@"未设名称"];
//        cell.m_string1.text= sname;
//        ABMultiValueRef phone = ABRecordCopyValue([record objectAtIndex:0], kABPersonPhoneProperty);
//        NSString * iPhone = (NSString*)ABMultiValueCopyValueAtIndex(phone, [[record objectAtIndex:1] intValue]);
//        iPhone = [iPhone stringByReplacingOccurrencesOfString:@"+86" withString:@""];
//        iPhone = [iPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
//        iPhone = [iPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
//        cell.m_string2.text = iPhone;
//        cell.m_string3.text = [[Utility shareInstance] selectInfoByPhone:iPhone];
//        for (int i = 0 ; i<_filteredArray.count; i ++) {
//            if ([iPhone isEqualToString:_filteredArray[i]]) {
//                cell.imageTopu.image = [UIImage imageNamed:@"contacts_logo"];
//                break;
//            }else{
//                cell.imageTopu.image = nil;
//                
//            }
//        }
//        
//        
//        return cell;
//    }
//    return nil;
//}
//#pragma mark -
//#pragma mark - 处理号码
//-(void)loadContacts
//{
//    [m_sectionDic removeAllObjects];
//    [m_phoneDic removeAllObjects];
//    [m_sortedKeys removeAllObjects];
//    
//    if ([Utility shareInstance].u_bool)
//    {
//        for (int i = 0; i < ALPHA.length-1; i++)
//        {
//            [m_sectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'A'+i]];
//        }
//        [m_sectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'#']];
//        
//        ABAddressBookRef myAddressBook = [Utility shareInstance].u_addressBook;
//        CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(myAddressBook);
//        CFMutableArrayRef mresults=CFArrayCreateMutableCopy(kCFAllocatorDefault,CFArrayGetCount(results),results);
//        CFArraySortValues(mresults,CFRangeMake(0, CFArrayGetCount(results)),(CFComparatorFunction) ABPersonComparePeopleByName,(void*) ABPersonGetSortOrdering());
//        
//        //遍历所有联系人
//        for (int k=0;k<CFArrayGetCount(mresults);k++)
//        {
//            ABRecordRef record=CFArrayGetValueAtIndex(mresults,k);
//            NSString *personname = (NSString *)ABRecordCopyCompositeName(record);
//            ABMultiValueRef phone = ABRecordCopyValue(record, kABPersonPhoneProperty);
//            ABRecordID recordID=ABRecordGetRecordID(record);
//            //得到手机号码
//            for (int k = 0; k<ABMultiValueGetCount(phone); k++)
//            {
//                NSString * iPhone = (NSString*)ABMultiValueCopyValueAtIndex(phone, k);
//                iPhone = [iPhone stringByReplacingOccurrencesOfString:@"+86" withString:@""];
//                iPhone = [iPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
//                iPhone = [iPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
//                if (![iPhone isMatchedByRegex:@"^(13|15|18|17|14)\\d{9}$"])
//                {
//                    continue;
//                }
//                else
//                {
//                    [m_phoneDic setObject:record forKey:[NSString stringWithFormat:@"%@%d",iPhone,recordID]];
//                }
//                
//                char first=pinyinFirstLetter([personname characterAtIndex:0]);
//                NSString *sectionName;
//                if ((first>='a'&&first<='z')||(first>='A'&&first<='Z'))
//                {
//                    if([self searchResult:personname searchText:@"曾"])
//                        sectionName = @"Z";
//                    else if([self searchResult:personname searchText:@"解"])
//                        sectionName = @"X";
//                    else if([self searchResult:personname searchText:@"仇"])
//                        sectionName = @"Q";
//                    else if([self searchResult:personname searchText:@"朴"])
//                        sectionName = @"P";
//                    else if([self searchResult:personname searchText:@"查"])
//                        sectionName = @"Z";
//                    else if([self searchResult:personname searchText:@"能"])
//                        sectionName = @"N";
//                    else if([self searchResult:personname searchText:@"乐"])
//                        sectionName = @"Y";
//                    else if([self searchResult:personname searchText:@"单"])
//                        sectionName = @"S";
//                    else
//                        sectionName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([personname characterAtIndex:0])] uppercaseString];
//                }
//                else
//                {
//                    sectionName=[[NSString stringWithFormat:@"%c",'#'] uppercaseString];
//                }
//                [[m_sectionDic objectForKey:sectionName] addObject:[NSArray arrayWithObjects:record,[NSNumber numberWithInt:k],nil]];
//            }
//        }
//        for (int i = 0; i < [[m_sectionDic allKeys] count]; i++)
//        {
//            NSString *ikey = [NSString stringWithFormat:@"%c",'A'+i];
//            if ( [[m_sectionDic objectForKey:ikey] count] == 0 )
//            {
//                [m_sectionDic removeObjectForKey:ikey];
//            }
//        }
//        if ( [[m_sectionDic objectForKey:@"#"] count] == 0 )
//        {
//            [m_sectionDic removeObjectForKey:@"#"];
//        }
//        [m_sortedKeys addObjectsFromArray:[[m_sectionDic allKeys] sortedArrayUsingSelector:@selector(compare:)]];
//        if ([[m_sortedKeys objectAtIndex:0] isEqualToString:@"#"])
//        {
//            [m_sortedKeys removeObject:@"#"];
//            [m_sortedKeys addObject:@"#"];
//        }
//    }
//    else
//    {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请在iPhone的“设置>隐私>通讯录”选项中，允许5G开心聊访问你的通讯录，这样你可以更快更准确地添加TA" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];
//    }
//}
//-(BOOL)searchResult:(NSString *)contactName searchText:(NSString *)searchT
//{
//	NSComparisonResult result = [contactName compare:searchT options:NSCaseInsensitiveSearch range:NSMakeRange(0, searchT.length)];
//	if (result == NSOrderedSame)
//		return YES;
//	else
//		return NO;
//}
//
//
//#pragma mark -
//#pragma UISearchDisplayDelegate
//-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
//{
//    [self performSelectorOnMainThread:@selector(searchWithString:) withObject:searchString waitUntilDone:YES];
//    return YES;
//}
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
//{
//    return YES;
//}
//
//
//
//
//-(void)searchWithString:(NSString *)searchString
//{
//    [m_filteredArray removeAllObjects];
//    NSString * regex = @"(^[0-9]+$)";
//    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    if ([searchString length]!=0)
//    {
//        if ([pred evaluateWithObject:searchString])
//        {
//            //判断是否是数字
//            NSArray *phones=[m_phoneDic allKeys];
//            for (NSString *phone in phones)
//            {
//                if ([self searchResult:phone searchText:searchString])
//                {
//                    ABRecordRef person=[m_phoneDic objectForKey:phone];
//                    ABRecordID recordID=ABRecordGetRecordID(person);
//                    NSString *ff=[NSString stringWithFormat:@"%d",recordID];
//                    NSString *name=(NSString *)ABRecordCopyCompositeName(person);
//                    name = [NSString stringWithFormat:@"%@",name];
//                    name = [name stringByReplacingOccurrencesOfString:@"(null)" withString:@"未设名称"];
//                    NSMutableDictionary *record=[[NSMutableDictionary alloc] init];
//                    [record setObject:name forKey:@"name"];
//                    [record setObject:[phone substringToIndex:(phone.length-ff.length)] forKey:@"phone"];
//                    [record setObject:[NSNumber numberWithInt:recordID] forKey:@"ID"];
//                    [m_filteredArray addObject:record];
//                    [record release];
//                }
//            }
//        }
//        else
//        {
//            //搜索对应分类下的数组
//            NSString *sectionName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([searchString characterAtIndex:0])] uppercaseString];
//            NSArray *array=[m_sectionDic objectForKey:sectionName];
//            for (int j=0;j<[array count];j++)
//            {
//                ABRecordRef person=[[array objectAtIndex:j] objectAtIndex:0];
//                int n = [[[array objectAtIndex:j] objectAtIndex:1] intValue];
//                NSString *name=(NSString *)ABRecordCopyCompositeName(person);
//                if ([self searchResult:name searchText:searchString])
//                {
//                    //先按输入的内容搜索
//                    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
//                    NSString * personPhone = (NSString*)ABMultiValueCopyValueAtIndex(phone, n);
//                    ABRecordID recordID=ABRecordGetRecordID(person);
//                    NSMutableDictionary *record=[[NSMutableDictionary alloc] init];
//                    [record setObject:name forKey:@"name"];
//                    [record setObject:personPhone forKey:@"phone"];
//                    [record setObject:[NSNumber numberWithInt:recordID] forKey:@"ID"];
//                    [m_filteredArray addObject:record];
//                    [record release];
//                }
//                else
//                {
//                    //按拼音搜索
//                    NSString *string = @"";
//                    NSString *firststring=@"";
//                    for (int i = 0; i < [name length]; i++)
//                    {
//                        if([string length] < 1)
//                            string = [NSString stringWithFormat:@"%@", [POAPinyin quickConvert:[name substringWithRange:NSMakeRange(i,1)]]];
//                        else
//                            string = [NSString stringWithFormat:@"%@%@",string, [POAPinyin quickConvert:[name substringWithRange:NSMakeRange(i,1)]]];
//                        if([firststring length] < 1)
//                        {
//                            firststring = [NSString stringWithFormat:@"%c", pinyinFirstLetter([name characterAtIndex:i])];
//                        }
//                        else
//                        {
//                            if ([name characterAtIndex:i]!=' ')
//                            {
//                                firststring = [NSString stringWithFormat:@"%@%c",firststring,pinyinFirstLetter([name characterAtIndex:i])];
//                            }
//                        }
//                    }
//                    if ([self searchResult:string searchText:searchString]||[self searchResult:firststring searchText:searchString])
//                    {
//                        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
//                        NSString * personPhone = (NSString*)ABMultiValueCopyValueAtIndex(phone, n);
//                        ABRecordID recordID=ABRecordGetRecordID(person);
//                        NSMutableDictionary *record=[[NSMutableDictionary alloc] init];
//                        [record setObject:name forKey:@"name"];
//                        [record setObject:personPhone forKey:@"phone"];
//                        [record setObject:[NSNumber numberWithInt:recordID] forKey:@"ID"];
//                        [m_filteredArray addObject:record];
//                        [record release];
//                    }
//                }
//            }
//        }
//    }
//}
//
//- (void)callSelect:(NSInteger)tag
//{
//    if (tag == 0) {
//        //免费电话
//        [Utility shareInstance].u_calledHuiboOrZhibo = @"0";
//        [[Utility shareInstance] callPhonaPage:self];
//
//    }else{
//        //普通电话
//        [Utility shareInstance].u_calledHuiboOrZhibo = @"1";
//        [[Utility shareInstance] callPhonaPage:self];
//
//    }
//}
//
//
//- (void)dealloc
//{
//    [m_sectionDic release];
//    [m_phoneDic release];
//    [m_sortedKeys release];
//    [m_filteredArray release];
//    [super dealloc];
//}
@end
