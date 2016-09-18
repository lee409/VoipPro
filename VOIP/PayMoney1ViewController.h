//
//  PayMoney1ViewController.h
//  VOIP
//
//  Created by apple on 16/6/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "Reachability.h"
#import "ASIFormDataRequest.h"

@interface PayMoney1ViewController : UIViewController<ASIHTTPRequestDelegate>

- (IBAction)zhiFuBaoPayAction:(UIButton *)sender;
- (IBAction)weiXiPayAction:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UILabel *numPayLabel;
@property (retain, nonatomic) IBOutlet UILabel *numberPhoneLabel;

@property(nonatomic,retain)NSString*labelNumstr;
@property(nonatomic,retain)NSString*moneyStr;
@property(nonatomic,retain)NSString*topup_type;
@property(nonatomic,retain)NSString*subject;

@end
