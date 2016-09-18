//
//  HttpDataRequests.m
//  CoinCertificate
//
//  Created by apple on 13-1-28.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HttpDataRequests.h"

@implementation HttpDataRequests

@synthesize delegate;

- (id)init:(NSMutableArray*) nmsg
{
    m_cmd = [nmsg objectAtIndex:0];
    m_data = [[NSMutableDictionary alloc] initWithDictionary:[nmsg objectAtIndex:1]];
    m_array = [[NSMutableArray alloc]init];

    NSString *iurl = [nmsg objectAtIndex:2];
    
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    if (!netStatus)
    {
        [self performSelector:@selector(noNetworkCallBack) withObject:nil afterDelay:0.1f];
    }
    else
    {
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[iurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        request.timeOutSeconds = 30L;
        [request setDelegate:self];
        [request startAsynchronous];
    }
    return self;
}
- (id)initWithData:(NSMutableArray*) nmsg
{
    m_cmd = [nmsg objectAtIndex:0];
    m_data = [[NSMutableDictionary alloc] initWithDictionary:[nmsg objectAtIndex:1]];
    m_array = [[NSMutableArray alloc]init];
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    if (!netStatus)
    {
        [self performSelector:@selector(noNetworkCallBack) withObject:nil afterDelay:0.1f];
    }
    else
    {
        ASIFormDataRequest *m_request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[nmsg objectAtIndex:2]]];
        [m_request setRequestMethod:@"POST"];
        m_request.timeOutSeconds = 30L;
        m_request.defaultResponseEncoding = NSUTF8StringEncoding;
        [m_request appendPostData: [[nmsg objectAtIndex:3] dataUsingEncoding:NSUTF8StringEncoding]];
        //异步请求。
        [m_request setShouldAttemptPersistentConnection:NO];
        [m_request setDelegate:self];
        [m_request startAsynchronous];
    }
    return self;
}
//返回成功
- (void)requestFinished:(ASIHTTPRequest *)request
{
    if(delegate)
    {
        //NSLog(@"返回的数据：%@",[request responseString]);

        if ([m_cmd isEqualToString:@"query_cmd"])
        {
            [delegate HttpCallBack:[request responseString] atag:INTERNETSUCCEED acmd:m_cmd];
        }else if ([m_cmd isEqualToString:@"query_cmd1"]){
            [delegate HttpCallBack:[request responseString] atag:INTERNETSUCCEED acmd:m_cmd];
        }else{
            NSData *responseData = [request responseData];
            
            NSXMLParser *SwXml = [[NSXMLParser alloc] initWithData:responseData];
            [SwXml setDelegate: self];
            [SwXml setShouldResolveExternalEntities: YES];
            [SwXml parse];
            [SwXml release];
        
        }
    }
}
//解析节点头
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    m_elementName = elementName;
   //  NSLog(@"m_elementName1 = %@",elementName);
    
}
//解析节内容
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
 
        if( [m_data objectForKey:m_elementName])
        {
            NSString *oldStr = [m_data valueForKey:m_elementName];//这是唐工11月6号修改的后台相关说明文字时出现打印3次，这是内部网络请求结果，用字符串拼接处理
            NSString *newStr = [NSString stringWithFormat:@"%@%@",oldStr,string];
            
            [m_data setValue:newStr forKey:m_elementName];
        }
    
    
}
//解析完成
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if(delegate)
    {

            [delegate HttpCallBack:m_data atag:INTERNETSUCCEED acmd:m_cmd];
            
        
        
    }
}
//解析失败
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    
    
    if(delegate)
    {
        [delegate HttpCallBack:m_data atag:UNUSUALDATA acmd:m_cmd];
    }
}
//返回失败
- (void)requestFailed:(ASIHTTPRequest *)request
{
    if(delegate)
    {
        [delegate HttpCallBack:nil atag:INTERNETFAIL acmd:m_cmd];
    }
}
//没有网络
-(void)noNetworkCallBack
{
    if(delegate)
    {
        [delegate HttpCallBack:nil atag:UNINTERNET acmd:m_cmd];
    }
}
- (void)dealloc
{
    [m_data release];
    m_data = nil;
    [m_array release];
    m_array = nil;
    
    [super dealloc];
}
@end
