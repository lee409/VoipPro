//
//  MYTableViewCell.m
//  Move
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MYTableViewCell.h"

@implementation MYTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_myLableText1 release];
    [_myLableText2 release];
    [_myShowImage release];
    [super dealloc];
}
@end
