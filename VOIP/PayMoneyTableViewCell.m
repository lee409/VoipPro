//
//  PayMoneyTableViewCell.m
//  VOIP
//
//  Created by apple on 16/6/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PayMoneyTableViewCell.h"

@implementation PayMoneyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_payImage release];
    [_contextLabel release];
    [_moneyNumLabel release];
    [super dealloc];
}
@end
