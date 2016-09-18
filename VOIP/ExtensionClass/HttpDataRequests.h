//
//  HttpDataRequests.h
//  CoinCertificate
//
//  Created by apple on 13-1-28.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "Reachability.h"
#import "Utility.h"

@protocol HttpDataRequestsDelegate<NSObject>
-(void)HttpCallBack:(id)adata atag:(InternetState)atag acmd:(NSString*)acmd;

@end


@interface HttpDataRequests : NSObject <NSXMLParserDelegate>
{
    NSString *m_cmd;
    NSMutableDictionary *m_data;
    NSString *m_elementName;
    NSMutableArray *m_array;

}
@property (nonatomic, assign) id <HttpDataRequestsDelegate> delegate;
- (id)init:(NSMutableArray*) nmsg;
- (id)initWithData:(NSMutableArray*) nmsg;
@end
