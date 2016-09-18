//
//  BalanceTableViewCell.m
//  VOIP
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BalanceTableViewCell.h"
#import "Utility.h"

@implementation BalanceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)dealloc {
    [_numBerLabel release];
    [_accountLabel release];
    [_timeLabel release];
    [_passTimeLabel release];
    [_orginTextField release];
    [_passWordTextField release];
    [_againPassWordTextField release];
  
    [_tureButton release];
    [super dealloc];
}

- (IBAction)tureAction:(UIButton *)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (self.orginTextField.text.length <= 0)
    {
        [[iToast makeToast:@"请输入原密码"] show];
    }
    else if ( ![self.orginTextField.text isMatchedByRegex: [Utility shareInstance].u_password ])
    {
        [[iToast makeToast:@"原密码输入有误"] show];
    }
    else if (self.passWordTextField.text.length <= 0)
    {
        [[iToast makeToast:@"请输入4～18位新密码"] show];
    }
    else if ( !(self.passWordTextField.text.length >= 4 && self.passWordTextField.text.length <= 18) )
    {
        [[iToast makeToast:@"新密码必须4～18位"] show];
    }
    else if (self.againPassWordTextField.text.length <= 0)
    {
        [[iToast makeToast:@"请确认密码"] show];
    }
    else if ( ![self.passWordTextField.text isEqualToString:self.againPassWordTextField.text] )
    {
        [[iToast makeToast:@"新密码和确认密码不一致，请重新输入"] show];
    }
    else
    {
        if ([self.delegate1 respondsToSelector:@selector(BalanceTableViewCell2:str1:str2:) ]) {
            [self.delegate1 BalanceTableViewCell2:self str1:self.orginTextField.text str2:self.againPassWordTextField.text];
        }
    }
    
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


@end
