//
//  SysInfoViewController.m
//  VOIP
//
//  Created by hermit on 14-12-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "SysInfoViewController.h"

@interface SysInfoViewController ()

@end

@implementation SysInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *type = @"";
    if (self.type == SysInfoType) {
         [self addAavigationView:@"系统信息" aback:@"back.png"];
        type = @"systeminfo";
    }else if (self.type == AttentionType){
        [self addAavigationView:@"相关说明" aback:@"back.png"];
        type = @"attentions";
    }else if (self.type == CooperationType){
        [self addAavigationView:@"合作加盟" aback:@"back.png"];
       type = @"cooperation_join";
    }else if (self.type == HomeType){
        [self addAavigationView:@"关于我们" aback:@"back.png"];
       type = @"home";
    }
    [self queryMsg:type];
}

- (void)queryMsg:(NSString *)type;
{
     NSURL *url = [NSURL URLWithString:[[Utility commonTextPushPath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableString *xmlString = [NSMutableString stringWithString:@"<?xml version='1.0' encoding='UTF-8'?>"];
    [xmlString appendString:@"<data>"];
    [xmlString appendFormat:@"<type>%@</type>",type];
    [xmlString appendFormat:@"<uid>%@</uid>",USERID];
    [xmlString appendFormat:@"<phone>%@</phone>",[Utility shareInstance].u_account];
    [xmlString appendString:@"</data>"];
    // 2. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    // 3. Connection异步
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *reponse, NSData *data, NSError *error) {
    
        if (data != nil) {
             NSDictionary *dicts = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            if ([dicts[@"status"] isEqualToString:@"1"]) {
                NSDictionary *d = dicts[@"data"][0];
                NSString *content = d[@"content"];
                //NSLog(@"内容 =  %@",content);
                content = [content stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
                
                [self.textView setText:content];
                
            }
        }
        
    }];
    
}


- (void)dealloc {
    [_textView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTextView:nil];
    [super viewDidUnload];
}
@end
