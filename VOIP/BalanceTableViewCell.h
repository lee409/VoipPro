//
//  BalanceTableViewCell.h
//  VOIP
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BalanceTableViewCell;
@protocol BalanceTableViewCellDelegate <NSObject>

@optional
//-(void)BalanceTableViewCell:(BalanceTableViewCell*)BalanceTableViewCell1;
-(void)BalanceTableViewCell2:(BalanceTableViewCell*)BalanceTableViewCell2  str1:(NSString*)str1  str2:(NSString*)str2;


@end

@interface BalanceTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *numBerLabel;
@property (retain, nonatomic) IBOutlet UILabel *accountLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UILabel *passTimeLabel;

@property (retain, nonatomic) IBOutlet UITextField *orginTextField;
@property (retain, nonatomic) IBOutlet UITextField *passWordTextField;
@property (retain, nonatomic) IBOutlet UITextField *againPassWordTextField;
- (IBAction)tureAction:(UIButton *)sender;

@property(nonatomic,assign) id <BalanceTableViewCellDelegate> delegate1;
@property (retain, nonatomic) IBOutlet UIButton *tureButton;

@end
