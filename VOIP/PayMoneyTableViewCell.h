//
//  PayMoneyTableViewCell.h
//  VOIP
//
//  Created by apple on 16/6/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayMoneyTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *payImage;
@property (retain, nonatomic) IBOutlet UILabel *contextLabel;
@property (retain, nonatomic) IBOutlet UIImageView *prettyImage;

@property (retain, nonatomic) IBOutlet UILabel *moneyNumLabel;

@end
