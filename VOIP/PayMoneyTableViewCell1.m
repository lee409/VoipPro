//
//  PayMoneyTableViewCell1.m
//  VOIP
//
//  Created by apple on 16/6/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PayMoneyTableViewCell1.h"

@implementation PayMoneyTableViewCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_payImage1 release];
    [_numLabel1 release];
    [_numLabel2 release];
    [_moneyNumber release];
    [super dealloc];
}
@end
