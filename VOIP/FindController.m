


#import "FindController.h"
#import "ItemHelpViewController.h"
#import "PayMoneyViewController.h"

@interface FindController ()
//<UITableViewDataSource,UITableViewDelegate>
//{
//    BOOL _isLoading2;
//    ADView *m_adView;
//}
//@property(nonatomic,strong)NSMutableArray*buttonImage;
//@property(nonatomic,strong)NSMutableArray*buttonTitle;
//@property(nonatomic,strong)NSMutableArray *allURL;
//@property(nonatomic,assign) UITableView *tableView;
@property (retain, nonatomic)  UIScrollView *ScrollView;

@end

@implementation FindController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
        
}
-(void)dealloc{
    [super dealloc];
    [_dateStr release];
}
- (void)viewWillAppear:(BOOL)animated
{
//    [self query_pinpai_ad];//数据请求品牌
//    [self query_lubo_ad];//数据请求轮播
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
       if (self.dateStr) {
        [self addAavigationView:self.dateStr aback:@"back.png"];
    }else{
        [self addAavigationView:@"商城中心" aback:nil];
    }
    
    
    
    // Do any additional setup after loading the view from its nib.
//    UITableView*table=[[UITableView alloc]initWithFrame:CGRectMake(0,150,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-49 - self.navigationController.navigationBar.frame.size.height - 20 - 150)];
//    table.delegate=self;
//    table.dataSource=self;
//    table.rowHeight=100;
//    table.backgroundColor=[UIColor whiteColor];
//    self.tableView = table;
//    [self.view addSubview:table];
//    
//    self.buttonImage = [[NSMutableArray alloc]init];//按钮图片
//    self.buttonTitle = [[NSMutableArray alloc]init];//按钮下面的文字
//    self.allURL = [[NSMutableArray alloc]init];//按钮每个连接（所有连接）
//    
//    [self pinpai];
//    [self lubo];
    
    _ScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,kDeviceWidth, kDeviceHeight)];
    _ScrollView.showsHorizontalScrollIndicator=NO;
    _ScrollView.showsVerticalScrollIndicator=NO;
    _ScrollView.scrollsToTop=NO;
    _ScrollView.bounces = NO;
   
    
   
    _ScrollView.contentSize=CGSizeMake(kDeviceWidth, kDeviceHeight+156);
   
    [self.view addSubview:_ScrollView];
    
    [self addSubShowView];
    
    
    
}
-(void)addSubShowView{
    int rowCount = 2;
    float top = 6;
    float space = 5;
    float btnWidth = (kDeviceWidth -3*space)/rowCount;
    float btnHeight = 116*kDeviceWidth/375;
    for (int i = 0; i < 8; i++) {
        float kx ;
        float ky ;
        kx = space + i%rowCount* (btnWidth + space);
        ky = top + i/rowCount*(btnHeight + top);
            
            UIButton *viewButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [viewButton setFrame:CGRectMake(kx, ky, btnWidth, btnHeight)];
            viewButton.tag = i+1;
            [viewButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"mall_%d_n",i+1]] forState:UIControlStateNormal];
            [viewButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"mall_%d_s",i+1]] forState:UIControlStateHighlighted];
            [viewButton addTarget:self action:@selector(viewButtonAction :) forControlEvents:UIControlEventTouchUpInside];
            [_ScrollView addSubview:viewButton];
            
       
    }
    
    
}

-(void)viewButtonAction:(UIButton*)sender{
    if (sender.tag == 1) {
         PayMoneyViewController *payMoneyVC = [[PayMoneyViewController alloc]initWithNibName:@"PayMoneyViewController" bundle:nil];
        payMoneyVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:payMoneyVC animated:YES];
        [payMoneyVC release];
        
    }else if (sender.tag == 2){
        ItemHelpViewController *ctl = [[ItemHelpViewController alloc]initWithNibName:@"ItemHelpViewController" bundle:nil];
        ctl.m_name = @"话费流量";
        ctl.m_data = 2;
        ctl.m_url = @"http://m.baidu.com/from=1001192j/bd_page_type=1/ssid=0/uid=0/pu=usm%400%2Csz%401320_1001%2Cta%40iphone_2_5.0_3_537/baiduid=94721706DD3B3F50C149E79673D41B43/w=0_10_%E8%AF%9D%E8%B4%B9%E5%85%85%E5%80%BC/t=iphone/l=1/tc?ref=www_iphone&lid=5518139709665669207&order=2&vit=osres&tj=www_normal_2_0_10_title&waput=3&waplogo=1&cltj=normal_title&dict=-1&title=%E6%89%8B%E6%9C%BA%E8%AF%9D%E8%B4%B9%E5%85%85%E5%80%BC%E4%B8%AD%E5%BF%83&sec=12296&di=3e69e24112ff72d8&bdenc=1&tch=124.0.0.0.0.0&nsrc=IlPT2AEptyoA_yixCFOxXnANedT62v3IJRqOKycKR7v5oUzyqRK";
        ctl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctl animated:YES];
        [ctl release];
        
        
        
    }else if (sender.tag == 3){
        ItemHelpViewController *ctl = [[ItemHelpViewController alloc]initWithNibName:@"ItemHelpViewController" bundle:nil];
        ctl.m_name = @"查快递";
        ctl.m_data = 2;
        ctl.m_url = @"http://m.kuaidi100.com/";
        ctl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctl animated:YES];
        [ctl release];
  

    }else if (sender.tag ==4){
        ItemHelpViewController *ctl = [[ItemHelpViewController alloc]initWithNibName:@"ItemHelpViewController" bundle:nil];
        ctl.m_name = @"查航班";
        ctl.m_data = 2;
        ctl.m_url = @"http://flight.supfree.net/";
        ctl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctl animated:YES];
        [ctl release];
        
        
    }else if (sender.tag ==5){
        ItemHelpViewController *ctl = [[ItemHelpViewController alloc]initWithNibName:@"ItemHelpViewController" bundle:nil];
        ctl.m_name = @"查违章";
        ctl.m_data = 2;
        ctl.m_url = @"http://m.weizhang8.cn/";
        ctl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctl animated:YES];
        [ctl release];

        
        
    }else if (sender.tag ==6){
        ItemHelpViewController *ctl = [[ItemHelpViewController alloc]initWithNibName:@"ItemHelpViewController" bundle:nil];
        ctl.m_name = @"游戏中心";
        ctl.m_data = 2;
        ctl.m_url = @"http://www.4399.com";
        ctl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctl animated:YES];
        [ctl release];
        
    }else if (sender.tag ==7){
        ItemHelpViewController *ctl = [[ItemHelpViewController alloc]initWithNibName:@"ItemHelpViewController" bundle:nil];
        ctl.m_name = @"查天气";
        ctl.m_data = 2;
        ctl.m_url = @"http://m.weather.com.cn/mweather15d/101280101.shtml";
        ctl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctl animated:YES];
        [ctl release];
    }else{
        ItemHelpViewController *ctl = [[ItemHelpViewController alloc]initWithNibName:@"ItemHelpViewController" bundle:nil];
        ctl.m_name = @"淘宝";
        ctl.m_data = 2;
        ctl.m_url = @"http://www.taobao.com";
        ctl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctl animated:YES];
        [ctl release];
    }
    
    
    
}

//#pragma 请求轮播网络
//- (void)query_lubo_ad
//{
//
//
//    NSURL *url=[NSURL URLWithString:[[Utility commonPicPushPath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//     NSMutableString *xmlString = [NSMutableString stringWithString:@"<?xml version='1.0' encoding='UTF-8'?>"];
//    [xmlString appendString:@"<data>"];
//    [xmlString appendString:@"<type>commentation_pic</type>"];
//    [xmlString appendFormat:@"<uid>%@</uid>",USERID];
//    [xmlString appendFormat:@"<phone>%@</phone>",[Utility shareInstance].u_account];
//    [xmlString appendString:@"</data>"];
//  //2.Request
//    NSMutableURLRequest*request=[NSMutableURLRequest requestWithURL:url];//网址连接
//    [request setHTTPMethod:@"POST"];//请求方式
//    [request setHTTPBody:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];//(NSData *)后面是data数据
//  //3. Connection异步
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        if (data!=nil) {
//    
//            NSDictionary *dicts=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//            // NSLog(@"ViewController.m中的轮播数据显示 =dicts = %@",dicts);
//            if ([dicts[@"status"] isEqualToString:@"1"]) {
//                NSArray *array=dicts[@"data"];
//              //  NSLog(@"ViewController.m中的轮播数据显示=array=%@",array);
//                if (array!=nil && array.count>0) {
//                    
//                    NSMutableArray *arrayM=[[NSMutableArray alloc]init];
//                    for (NSDictionary *d in array) {
//                        NSMutableDictionary *item=[[NSMutableDictionary alloc]init];
//                        [item setValue:d[@"img"] forKey:@"p_img_full"];//写入pilist文件中
//                        [item setValue:d[@"url"] forKeyPath:@"p_url"];//写入pilist文件中
//                        [arrayM addObject:item];
//                    }
//                    [self performSelectorOnMainThread:@selector(threadLoadImage:) withObject:arrayM waitUntilDone:YES];
//                }
//            }
//        }
//    }];
//}
//
//
////下载图片
//- (void)threadLoadImage:(NSArray *)imageInfo
//{
//    
//    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(loadImage:) object:imageInfo];
//    // 启动线程
//    [thread start];
//}
//
//
//- (void)loadImage:(NSArray *)imageInfo
//{
//    FileOperationHelp *fileOperation = [[FileOperationHelp alloc]init];
//    
//    BOOL b = [fileOperation loadImageWithImageInfo:imageInfo withSaveFileDir:PINPAI_LUNBO withSavePlistFileName:PINPAI_LUNBO_PLIST];
//    
//    if (b) {
//        [self lubo];
//    }
//    [fileOperation release];
//}
//
//
//- (void)lubo
//{
//    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//沙盒
//    NSString *path = [documents[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",PINPAI_LUNBO ,PINPAI_LUNBO_PLIST]];//路径
//   // NSLog(@"path=%@",path);//找不到文件夹
//    
//    NSArray *array = [NSArray arrayWithContentsOfFile:path];
//    NSMutableArray *arrayM = [[NSMutableArray alloc]init];
//    NSMutableDictionary *imageUrlDict = [[NSMutableDictionary alloc]init];
//    if (array != nil && array.count > 0)
//    {
//        for (NSInteger i = 0; i < array.count; i++)
//        {
//            NSDictionary *dict = array[i];
//            NSString * imageName = dict[@"p_img_full"];
//            NSString * imageUrl = dict[@"p_url"];
//            [arrayM addObject:imageName];
//            [imageUrlDict setValue:imageUrl forKey:imageName];
//        }
//    }
//    if (imageUrlDict.count > 0)
//    {
//        if (m_adView)
//        {
//            //图片名称/图片链接地址
//            m_adView.imageUrlDict = imageUrlDict;
//            //图片名称
//            m_adView.imageNameList = arrayM;
//        }
//        else
//        {
//            CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150);
//            m_adView = [[ADView alloc]initWithFrame:frame];
//            m_adView.fileDir = PINPAI_LUNBO;
//            m_adView.imageNameList = arrayM;
//            m_adView.imageUrlDict = imageUrlDict;
//            m_adView.delegate = self;
//            [self.view addSubview:m_adView];
//        }
//    }
//}
//
//
//- (void)pinpai
//{
//    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//沙盒
//    NSString *path = [documents[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",PINPAI_FILEDIR ,PINPAI_PLIST]];//路径
//    
//     NSArray *arrayPlist = [NSArray arrayWithContentsOfFile:path];
//    
//    if (arrayPlist != nil && arrayPlist.count > 0)
//    {
//        [self.buttonImage removeAllObjects];
//        [self.buttonTitle removeAllObjects];
//        [self.allURL removeAllObjects];
//        
//        int k = 0;
//        if ((arrayPlist.count % 4) == 0) {
//            k = arrayPlist.count / 4;
//        }else{
//            k = arrayPlist.count / 4 + 1;
//        }
//        
//        for (int i = 0; i < k; i++) {
//            
//            NSMutableArray *imagePaths = [[NSMutableArray alloc]init];//图片路径
//            NSMutableArray *titles = [[NSMutableArray alloc]init];//品牌名称
//            NSMutableArray *urlArray = [[NSMutableArray alloc]init];//连接地址
//            
//            for (int j = 0 * i; j < 4 ; j++)
//            {
//                int index = i * 4 + j;
//                if (index < arrayPlist.count) {
//                    NSDictionary *dict = arrayPlist[index];
//                    NSString * imgPath = [documents[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",PINPAI_FILEDIR ,dict[@"p_img_full"]]];
//                    NSString *title = dict[@"p_desc"];//这是描述的字段
//                    NSString *url = dict[@"p_url"];
//                    [imagePaths addObject:imgPath];
//                    [titles addObject:title];
//                    [urlArray addObject:url];
//                }
//                
//            }
//            
//            [self.buttonImage addObject:imagePaths];//按钮图片
//           // NSLog(@"ViewController.m=imagePaths=%@",imagePaths);
//            [self.buttonTitle addObject:titles];//按钮下面的文字
//           // NSLog(@"ViewController.m=titles=%@",titles);
//            [self.allURL addObject:urlArray];//按钮每个连接（所有连接）
//          //  NSLog(@"ViewController.m=urlArray=%@",urlArray);
//        }
//        
//        
//        [self.tableView reloadData];
//    }
//    
//}
//
//
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分格线
//    return self.buttonImage.count;//根据数据返回多少，创建多少个
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    static NSString*cellIndentifier=@"cell_identifier";
//    //这个是xib实现中的cell
//    FindCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
//    if (cell==nil) {
//        cell=[[[NSBundle mainBundle]loadNibNamed:@"FindCell" owner:nil options:nil]firstObject];
//    }
//    cell.cellButtonImage=[self.buttonImage objectAtIndex:indexPath.row];
//    cell.cellButtonTitle=[self.buttonTitle objectAtIndex:indexPath.row];
//    cell.delegate = self;
//    cell.lableURL = [self.allURL objectAtIndex:indexPath.row];
//    
//    return cell;
//}
//
//- (void)goShop:(NSString *)url name:(NSString *)name
//{
//    if (url.length > 0) {
//        ItemHelpViewController *ctl = [[ItemHelpViewController alloc]initWithNibName:@"ItemHelpViewController" bundle:nil];
//        ctl.m_data = 2;
//        ctl.m_name = name;
//        url = [url stringByReplacingOccurrencesOfRegex:@"&amp;" withString:@"&"];
//        ctl.m_url = url;
//        ctl.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:ctl animated:YES];
//        [ctl release];
//                
//    }
//}
//
//- (void)ADopenUrl:(NSString *)url withName:(NSString *)name
//{
//    if (url.length > 0) {
//        ItemHelpViewController *ctl = [[ItemHelpViewController alloc]initWithNibName:@"ItemHelpViewController" bundle:nil];
//        ctl.m_data = 2;
//        ctl.m_name = name;
//        ctl.m_url = url;
//        ctl.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:ctl animated:YES];
//        [ctl release];
//        
//    }
//
//}
//
//#pragma mark 网络请求品牌
//- (void)query_pinpai_ad
//{
//    _isLoading2 = true;
//    NSURL *url = [NSURL URLWithString:[[Utility commonPicPushPath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSMutableString *xmlString = [NSMutableString stringWithString:@"<?xml version='1.0' encoding='UTF-8'?>"];
//    [xmlString appendString:@"<data>"];
//    [xmlString appendString:@"<type>product_list_pic</type>"];
//    [xmlString appendFormat:@"<uid>%@</uid>",USERID];
//    [xmlString appendFormat:@"<phone>%@</phone>",[Utility shareInstance].u_account];
//    [xmlString appendString:@"</data>"];
//    // 2. Request
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];
//    // 3. Connection异步
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *reponse, NSData *data, NSError *error) {
//        
//        
//        if (data != nil) {
//            NSDictionary *dicts = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//           // NSLog(@"pragma mark 请求品牌dicts%@",dicts);
//            
//            if ([dicts[@"status"] isEqualToString:@"1"]) {
//                NSArray *array = dicts[@"data"];
//                if (array != nil && array.count > 0) {
//                    
//                    NSMutableArray *arrayM = [[NSMutableArray alloc]init];
//                    for (NSDictionary *d in array) {
//                        NSMutableDictionary *item = [[NSMutableDictionary alloc]init];
//                        [item setValue:d[@"img"] forKey:@"p_img_full"];
//                        [item setValue:d[@"url"] forKey:@"p_url"];
//                        [item setValue:d[@"des"] forKey:@"p_desc"];//和后台的描述一样的p_desc,就是描述
//                        [arrayM addObject:item];
//                    }
//                   // NSLog(@"arrayM==%@",arrayM);
//                    
//                    [self performSelectorOnMainThread:@selector(threadLoadImage2:) withObject:arrayM waitUntilDone:YES];
//                }else
//                {
//                    _isLoading2 = false;
//                }
//            }
//            else
//            {
//                _isLoading2 = false;
//            }
//        }else
//        {
//            _isLoading2 = false;
//        }
//        
//    }];
//}
//
////下载图片
//- (void)threadLoadImage2:(NSArray *)imageInfo
//{
//    
//    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(loadImage2:) object:imageInfo];
//    // 启动线程
//    [thread start];
//}
//
//
//- (void)loadImage2:(NSArray *)imageInfo
//{
//    FileOperationHelp *fileOperation = [[FileOperationHelp alloc]init];
//    
//    BOOL b = [fileOperation loadImageWithImageInfo:imageInfo withSaveFileDir:PINPAI_FILEDIR withSavePlistFileName:PINPAI_PLIST];
//    
//    
//    if (b)
//    {
//        [self pinpai];
//    }
//    [fileOperation release];
//}

@end
