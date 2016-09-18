#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <sqlite3.h>
#import <CommonCrypto/CommonDigest.h>
#import "iToast.h"
#import "MBProgressHUD.h"
#import "RegexKitLite.h"
//#import "MobClick.h"

#define MCID [[[NSBundle mainBundle] infoDictionary] objectForKey:@"MCID"]
#define PRODUCT [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRODUCT"]
#define PLATFORM [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PLATFORM"]
#define USERID [[[NSBundle mainBundle] infoDictionary] objectForKey:@"USERID"]
#define VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//#define IP @"120.26.121.12"
//#define IP @"139.196.188.130"
 #define IP @"120.76.78.99"

#define DOWNLOAD   @"http://www.voip818.com/download.php?" //更新地址

//#define SERVICE_CALL @"service_call" //客服电话
#define SERVICE_CALL @"4000222099" //客服电话
#define WEBSITE_URL @"website_url" //官网

#define VERSIONTAG @"3" //当前版本标识。

#define DIAL_AD @"dialad"
#define DIAL_AD_PLIST @"image.plist"

#define CALL_AD @"Call"//不同的文件夹下面 和下面的pist文件
#define CALL_AD_PLIST @"image.plist"

#define PINPAI_LUNBO @"pinpailunbo"//
#define PINPAI_LUNBO_PLIST @"image.plist"
//品牌信息存放目录
#define PINPAI_FILEDIR @"pinpai"
#define PINPAI_PLIST @"image.plist"

#define USERDATA  @"UserData"
#define CALLRECORDS  @"CallRecords"
//#define UMENG_APPKEY @"5546073067e58edd56003768"
#define UMENG_APPKEY @"57562b6567e58e6c2000066b"
#define CHANNELNUMBER @"5G开心聊官网"
#define APPNAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

#define IOS_VERSION_7_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)? (YES):(NO))
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define ALPHA	@"ABCDEFGHIJKLMNOPQRSTUVWXYZ#"

#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width


#define changecellbackColor [UIColor colorWithRed:255.0/225.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]
#define CHANGEColorWith(hex,opa)  [UIColor colorWithRed:((float)((hex & 0XFF0000)>>16))/255.0 green:((float)((hex & 0X00FF00)>>8))/255.0 blue:((float)(hex & 0X0000FF))/255.0 alpha:opa]
typedef enum {
    INTERNETSUCCEED = 0,
    INTERNETFAIL = 1 ,
    UNINTERNET = 2,
    UNUSUALDATA = 3
} InternetState;

@interface Utility: NSObject
{
}
@property(nonatomic, assign) BOOL u_bool;
@property(nonatomic, assign) ABAddressBookRef u_addressBook;
@property(nonatomic, assign) sqlite3 *u_database1;
@property(nonatomic, assign) sqlite3 *u_database2;

@property(nonatomic, retain) NSString *u_account;
@property(nonatomic, copy) NSString *u_password;

@property(nonatomic, retain) NSString *u_callShow;
@property(nonatomic, retain) NSString *u_keyboardShake;
@property(nonatomic, retain) NSString *u_keyboardVoice;
@property(nonatomic, retain) NSString *u_beforeCallMusic;
@property(nonatomic, retain) NSString *u_dialWay;

@property(nonatomic, retain) NSString *u_sipPhone;
@property(nonatomic, retain) NSString *u_sipPwd;
@property(nonatomic, retain) NSString *u_sipServer;

@property(nonatomic, retain) NSString *u_calledNumber;
@property(nonatomic, retain) NSString *u_calledName;
@property(nonatomic, retain) NSString *u_calledTime;
@property(nonatomic, retain) NSString *u_calledOutOrIn;
@property(nonatomic, retain) NSString *u_calledDuration;
@property(nonatomic, retain) NSString *u_calledHuiboOrZhibo;
@property(nonatomic, retain) NSString *u_calledState;
@property(nonatomic, retain) NSString *orderPay;

+(Utility *)shareInstance;
-(id)initData;
-(void)sqlOpen:(NSString*)asqlFile;
-(NSString*)selectInfoByPhone:(NSString *)phonenumber;
-(NSArray*) sql_readData:(NSString*)aread acount:(int)acount;
-(void)sql_inser_data:(id)actionNum, ...;
-(void)callPhonaPage:(UIViewController*)aself;
+ (int)convertToInt:(NSString*)strtemp;
+(NSString *) getErrorDOWNLOAD: (int) nErrorCode;
+(NSString *) getErrorCALL: (int) nErrorCode;
+(NSString *) getErrorCHONGZHI: (int) nErrorCode;
+(NSString *) getErrorCHANGEPASSWORD: (int) nErrorCode;
+(NSString *) getErrorQUERY: (int) nErrorCode;
+(NSString *) getErrorLOGIN: (int) nErrorCode;
+(NSString *) getError: (int) nErrorCode;
+(NSString *) getErrorREGISTER:(int) nErrorCode;
+(NSString *) getMD5:(NSString *) string;
+(NSString *) getDialWay: (int) nType;
+(NSString *) commonPicPushPath;
+(NSString *) commonTextPushPath;
+(NSString *) queryMoreInfoPath;
+(NSString *) submitSignPath;
@end


@interface NSObject(addmethods)
-(CGRect)customFrame:(CGRect)ar4 ar5:(CGRect)ar5;
- (UIImage *) createImageWithColor: (UIColor *) color;
@end


@interface UIViewController(background)
-(void)adaptiveIos1;
-(void)addAavigationView:(NSString*)atitle aback:(NSString*)aback;
@end


@interface publicTableViewCell1 : UITableViewCell
@property(nonatomic, assign) UIImageView *m_img1;
@property(nonatomic, assign) UILabel *m_string1;
@property(nonatomic, assign) UILabel *m_string2;
@property(nonatomic, assign) UILabel *m_string3;
@property(nonatomic, assign) UILabel *m_string4;
@property(nonatomic, assign) UILabel *m_string5;
@property(nonatomic, assign) UILabel *m_string6;
@property(nonatomic, strong) UIImageView *imageTopu;
@end
