#import "Utility.h"
#import "CallPageViewController.h"
#import "CallPageViewController2.h"

@implementation Utility

@synthesize u_bool;
@synthesize u_addressBook;
@synthesize u_database1;
@synthesize u_database2;

@synthesize u_account;
@synthesize u_password;

@synthesize u_dialWay;

@synthesize u_sipPhone;
@synthesize u_sipPwd;
@synthesize u_sipServer;


@synthesize u_callShow;
@synthesize u_keyboardShake;
@synthesize u_keyboardVoice;
@synthesize u_beforeCallMusic;

@synthesize u_calledNumber;
@synthesize u_calledName;
@synthesize u_calledTime;
@synthesize u_calledOutOrIn;
@synthesize u_calledDuration;
@synthesize u_calledHuiboOrZhibo;
@synthesize u_calledState;

+(Utility *)shareInstance
{
    static Utility *instance = nil;
    if (instance == nil)
    {
        instance = [[Utility alloc] initData];
    }
    return instance;
}

-(id)initData
{
    CFErrorRef error = nil;
    u_addressBook = ABAddressBookCreateWithOptions(NULL,&error);
    if (  &ABAddressBookCreateWithOptions != NULL )
    {
        //ios 6以上读取方法
        ABAddressBookRequestAccessWithCompletion(u_addressBook, ^(bool granted, CFErrorRef error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    u_bool = NO;
                }
                else if (!granted)
                {
                    u_bool = NO;
                }
                else
                {
                    u_bool = YES;
                }
            });
        });
    }
    else
    {
        //ios 4/5读取方法
        u_bool = YES;
    }
    //打开归属地数据库。
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"db"];
    if (sqlite3_open([path1 UTF8String], &u_database1) !=  SQLITE_OK)
    {
        sqlite3_close(u_database1);
        NSAssert(0, @"Failed to open database");
    }
    return self;
}
//打开数据库。
-(void)sqlOpen:(NSString*)asqlFile
{
    NSArray *path2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *pathname = [[path2 objectAtIndex:0] stringByAppendingPathComponent:asqlFile];
	if (sqlite3_open([pathname UTF8String],&u_database2) != SQLITE_OK)
    {
        sqlite3_close(u_database2);
        NSAssert(0, @"Failed to open database");
	}
}


-(NSString*)selectInfoByPhone:(NSString *)phonenumber
{
    NSString *isrt = [NSString string];
    if (phonenumber.length >= 7)
    {
        sqlite3_stmt *stmt1;
        NSString *isql2 = [NSString stringWithFormat:@"SELECT number2.city FROM phonenumberwithcity AS number1 LEFT JOIN citywithnumber AS number2 ON number1.city = number2.uid where number1.uid='%@'",[phonenumber substringToIndex:7]];
        if (sqlite3_prepare_v2(u_database1, [isql2 UTF8String], -1, &stmt1, nil) == SQLITE_OK)
        {
            while (sqlite3_step(stmt1) == SQLITE_ROW)
            {
                NSString *icity = [NSString stringWithCString:(char*)sqlite3_column_text(stmt1,0) encoding:NSUTF8StringEncoding];
                isrt = [isrt stringByAppendingString:icity];
            }
            sqlite3_finalize(stmt1);
        }
        
        sqlite3_stmt *stmt2;
        NSString *isql1 = [NSString stringWithFormat:@"SELECT number2.mobile FROM numbermobile AS number1 LEFT JOIN mobilenumber AS number2 ON number1.mobile = number2.uid where number1.uid='%@'",[phonenumber substringToIndex:3]];
        if (sqlite3_prepare_v2(u_database1, [isql1 UTF8String], -1, &stmt2, nil) == SQLITE_OK)
        {
            while (sqlite3_step(stmt2) == SQLITE_ROW)
            {
                NSString *imobile = [NSString stringWithCString:(char*)sqlite3_column_text(stmt2,0) encoding:NSUTF8StringEncoding];
                isrt = [isrt stringByAppendingString:imobile];
            }
            sqlite3_finalize(stmt2);
        }
    }
    else
    {
        isrt = @"未知";
    }
    return isrt;
}
-(void)sql_inser_data:(id)actionNum, ...
{
    NSMutableArray *argsArray = [[NSMutableArray alloc] init];
    va_list params; //定义一个指向个数可变的参数列表指针；
    va_start(params,actionNum);//va_start  得到第一个可变参数地址,
    id arg;
    if (actionNum)
    {
        //将第一个参数添加到array
        id prev = actionNum;
        [argsArray addObject:prev];
        //va_arg 指向下一个参数地址
        //这里是问题的所在 网上的例子，没有保存第一个参数地址，后边循环，指针将不会在指向第一个参数
        while( (arg = va_arg(params,id)) )
        {
            if ( arg )
            {
                [argsArray addObject:arg];
            }
        }
        //置空
        va_end(params);
        char *erroMsg;
        //这里循环 将看到所有参数
        for (NSString *asql in argsArray)
        {
            if (sqlite3_exec (u_database2, [asql UTF8String], NULL, NULL, &erroMsg) != SQLITE_OK)
            {
                //[[iToast makeToast:@"数据库操作失败！"] show];
            }
        }
    }
    [argsArray release];
}

+(NSString *)commonPicPushPath
{
    NSString *path = [NSString stringWithFormat:@"http://%@/api/pic.php?",IP];
    
    return path;
}

+(NSString *)commonTextPushPath
{
    NSString *path = [NSString stringWithFormat:@"http://%@/api/text.php?",IP];
    
    return path;
}

+ (NSString *)queryMoreInfoPath
{
    NSString *path = [NSString stringWithFormat:@"http://%@/api/more_info.php?",IP];
    
    return path;
}
//签到
+ (NSString *)submitSignPath
{
    NSString *path = [NSString stringWithFormat:@"http://%@/api/signgetfee.php?",IP];
    
    return path;
}

+(NSString *) getDialWay: (int) nType
{
    NSString * typeString = nil;
    switch (nType)
    {
        case 0:
            typeString = @"智能拨打";
            break;
        case 1:
            typeString = @"默认回拨";
            break;
        case 2:
            typeString = @"默认直拨";
            break;
        case 3:
            typeString = @"手动选择";
            break;
        default:
            typeString = @"未知类型";
            break;
    }
    return typeString;
}


+(NSString *) getMD5:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
    
}





-(NSArray*) sql_readData:(NSString*)aread acount:(int)acount
{
    NSMutableArray *str = [NSMutableArray array];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(u_database2, [aread UTF8String], -1, &statement, nil) == SQLITE_OK)
    {
        while (sqlite3_step(statement)==SQLITE_ROW)
        {
            NSMutableArray *msg = [NSMutableArray array];
            for (int i=0; i<acount; i++)
            {
                [msg addObject:[NSString stringWithCString:(char*)sqlite3_column_text(statement,i) encoding:NSUTF8StringEncoding]];
            }
            [str addObject:msg];
        }
        sqlite3_finalize(statement);
    }
    return str;
}
-(void)callPhonaPage:(UIViewController*)aself
{
    if (iPhone5)
    {
        if ( [[Utility shareInstance].u_calledHuiboOrZhibo isEqualToString:@"0"] )
        {
            CallPageViewController2 *ctl = [[CallPageViewController2 alloc] initWithNibName:@"CallPageViewController2" bundle:nil];
            [aself presentViewController:ctl animated:NO completion:nil];
            [ctl release];
        }
        else if ( [[Utility shareInstance].u_calledHuiboOrZhibo isEqualToString:@"1"] )
        {
            CallPageViewController *ctl = [[CallPageViewController alloc] initWithNibName:@"CallPageViewController" bundle:nil];
            [aself presentViewController:ctl animated:NO completion:nil];
            [ctl release];
        }
    }
    else
    {
        if ( [[Utility shareInstance].u_calledHuiboOrZhibo isEqualToString:@"0"] )
        {
            CallPageViewController2 *ctl = [[CallPageViewController2 alloc] initWithNibName:@"CallPageViewControllerCommon2" bundle:nil];
            [aself presentViewController:ctl animated:NO completion:nil];
            [ctl release];
        }
        else if ( [[Utility shareInstance].u_calledHuiboOrZhibo isEqualToString:@"1"] )
        {
            CallPageViewController *ctl = [[CallPageViewController alloc] initWithNibName:@"CallPageViewControllerCommon" bundle:nil];
            [aself presentViewController:ctl animated:NO completion:nil];
            [ctl release];
        }
    }
}








+ (int)convertToInt:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++)
    {
        if (*p)
        {
            p++;
            strlength++;
        }
        else
        {
            p++;
        }
    }
    return strlength;
}
//DOWNLOAD
+(NSString *) getErrorDOWNLOAD: (int) nErrorCode
{
    NSString * errorString = nil;
    switch (nErrorCode)
    {
        case -1:
            errorString = @"OK";
            break;
        case 0:
            errorString = @"有新版本！";
            break;
        default:
            errorString = @"发生未知错误，请重试";
            break;
    }
    return errorString;
}
//call_cmd
+(NSString *) getErrorCALL: (int) nErrorCode
{
    NSString * errorString = nil;
    switch (nErrorCode)
    {
        case 0:
            errorString = @"OK";
            break;
        default:
            errorString = @"失败";
            break;
    }
    return errorString;
}
//chongzhi_cmd
+(NSString *) getErrorCHONGZHI: (int) nErrorCode
{
    NSString * errorString = nil;
    switch (nErrorCode)
    {
        case 0:
            errorString = @"OK";
            break;
        default:
            errorString = @"充值失败！";
            errorString=[errorString stringByAppendingFormat:@" %d",nErrorCode];
            break;
    }
    return errorString;
}
//changePassword_cmd
+(NSString *) getErrorCHANGEPASSWORD: (int) nErrorCode
{
    NSString * errorString = nil;
    switch (nErrorCode)
    {
        case 0:
            errorString = @"OK";
            break;
        default:
            errorString = @"修改失败！";
            errorString=[errorString stringByAppendingFormat:@" %d",nErrorCode];
            break;
    }
    return errorString;
}
//query_cmd
+(NSString *) getErrorQUERY: (int) nErrorCode
{
    NSString * errorString = nil;
    switch (nErrorCode)
    {
        case 0:
            errorString = @"OK";
            break;
        case 1:
            errorString = @"查询失败";
            break;
        default:
            errorString = @"发生未知错误，请重试！";
            errorString=[errorString stringByAppendingFormat:@" %d",nErrorCode];
            break;
    }
    return errorString;
}
//login_cmd
+(NSString *) getErrorLOGIN: (int) nErrorCode
{
    NSString * errorString = nil;
    switch (nErrorCode)
    {
        case 0:
            errorString = @"OK";
            break;
        case 1:
            errorString = @"账号未注册！";
            break;
        case 2:
            errorString = @"密码错误！";
            break;
        default:
            errorString = @"发生未知错误，请重试";
            errorString=[errorString stringByAppendingFormat:@" %d",nErrorCode];
            break;
    }
    return errorString;
}

//register_cmd
+(NSString *) getErrorREGISTER: (int) nErrorCode
{
    NSString * errorString = nil;
    switch (nErrorCode)
    {
        case 0:
            errorString = @"OK";
            break;
        case 1:
            errorString = @"失败";
            break;
        case 2:
            errorString = @"手机号已注册";
            break;
        default:
            errorString = @"发生未知错误，请重试";
            errorString=[errorString stringByAppendingFormat:@" %d",nErrorCode];
            break;
    }
    return errorString;
}
//系统错误码
+(NSString *) getError: (int) nErrorCode
{
    NSString * errorString = nil;
    switch (nErrorCode)
    {
        case INTERNETSUCCEED:
            errorString = @"OK";
            break;
        case INTERNETFAIL:
            errorString = @"网络状况不好,数据请求失败--返回失败";
            break;
        case UNINTERNET:
            errorString = @"网络异常，请检查您的网络链接--没有网";
            break;
        case UNUSUALDATA:
            errorString = @"网络不稳定,服务器返回数据异常--解析失败";
            break;
        default:
            errorString = @"发生未知错误，请重试";
            break;
    }
    return errorString;
}
- (void)dealloc
{
    [u_account release];
    [u_password release];
    
    [u_callShow release];
    [u_keyboardShake release];
    [u_keyboardVoice release];
    [u_beforeCallMusic release];

    [u_calledNumber release];
    [u_calledName release];
    [u_calledTime release];
    [u_calledOutOrIn release];
    [u_calledDuration release];
    [u_calledHuiboOrZhibo release];
    [u_calledState release];

    CFRelease(u_addressBook);
    sqlite3_close(u_database1);
    sqlite3_close(u_database2);
    [super dealloc];
}
@end


#pragma mark -
#pragma mark NSObject(addmethods)

@implementation NSObject(addmethods)

//设置按钮的坐标。
-(CGRect)customFrame:(CGRect)ar4 ar5:(CGRect)ar5
{
    CGRect irect;
    if(iPhone5)
    {
        irect =  ar5;
    }
    else
    {
        irect =  ar4;
    }
    return irect;
}
//UIColor转UIImage。
- (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end


#pragma mark -
#pragma mark UIViewController(background)

@implementation UIViewController(background)

-(void)adaptiveIos1
{
    float v = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (iPhone5)
    {
        if ( v >= 7.0f && v < 7.1f )
        {
            for(id view in self.view.subviews)
            {
                UIView *ithis = (UIView*)view;
                ithis.frame = CGRectMake(ithis.frame.origin.x, ithis.frame.origin.y+64, ithis.frame.size.width, ithis.frame.size.height);
            }
        }
    }
    else
    {
        if ( v >= 7.0f && v < 7.1f )
        {
            for(id view in self.view.subviews)
            {
                UIView *ithis = (UIView*)view;
                ithis.frame = CGRectMake(ithis.frame.origin.x, ithis.frame.origin.y+64, ithis.frame.size.width, ithis.frame.size.height);
            }
        }
    }
}
//修改导航栏颜色。
-(void)addAavigationView:(NSString*)atitle aback:(NSString*)aback
{
    UIColor *icolor = CHANGEColorWith(0x4cafff,1.0);
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:icolor] forBarMetrics:UIBarMetricsDefault];
    UIFont *font = [UIFont systemFontOfSize:20];
    CGSize size = [atitle sizeWithFont:font];
    CGRect rect = CGRectMake((self.view.frame.size.width - size.width)/2, (44 - size.height)/2, size.width, size.height);
   
    UILabel *title = [[UILabel alloc] initWithFrame:rect];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setTextAlignment:NSTextAlignmentCenter];
    title.textColor = [UIColor whiteColor];
    [title setFont:font];
    [title setText:atitle];
    self.navigationItem.titleView = title;
    [title release];
    
    if (aback)
    {
        UIButton* ilogin = [UIButton buttonWithType:UIButtonTypeCustom];
        [ilogin setFrame:CGRectMake(0, 0,10,16)];
        [ilogin setShowsTouchWhenHighlighted:YES];
        [ilogin setBackgroundImage:[UIImage imageNamed:aback] forState:UIControlStateNormal];
        [ilogin addTarget:self action:@selector(leftBarButtonItemBack) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:ilogin] autorelease];
    }
}
-(void)leftBarButtonItemBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end




#pragma mark -
#pragma mark publicTableViewCell1

@implementation publicTableViewCell1

@synthesize m_img1;
@synthesize m_string1;
@synthesize m_string2;
@synthesize m_string3;
@synthesize m_string4;
@synthesize m_string5;
@synthesize m_string6;
@synthesize imageTopu;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    m_img1 = [[UIImageView alloc] init];
    m_img1.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:m_img1];
    [m_img1 release];
    
    m_string1 = [[UILabel alloc] init];
    m_string1.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:m_string1];
    [m_string1 release];
    
    m_string2 = [[UILabel alloc] init];
    m_string2.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:m_string2];
    [m_string2 release];
    
    m_string3 = [[UILabel alloc] init];
    m_string3.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:m_string3];
    [m_string3 release];
    
    m_string4 = [[UILabel alloc] init];
    m_string4.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:m_string4];
    [m_string4 release];
    
    m_string5 = [[UILabel alloc] init];
    m_string5.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:m_string5];
    [m_string5 release];
    
    m_string6 = [[UILabel alloc] init];
    m_string6.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:m_string6];
    [m_string6 release];
    
    imageTopu = [[UIImageView alloc] init];
    //imageTopu.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:imageTopu];
    [imageTopu release];
    
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}
- (void)dealloc
{
    [super dealloc];
}
@end
