//
//  TableViewCell.m
//  Demo
//
//  Created by 许宇勤 on 14/12/24.
//  Copyright (c) 2014年 许宇勤. All rights reserved.
//

#import "FindCell.h"

@interface FindCell ()

@property(nonatomic,strong)NSMutableArray*buttonArr;
@property(nonatomic,strong)NSMutableArray*labelArr;


@end

@implementation FindCell

- (void)awakeFromNib
{
    // Initialization code
    self.buttonArr=[NSMutableArray array];
    self.labelArr=[NSMutableArray array];
    self.lableURL=[NSMutableArray array];
#pragma 创建tableviewcell中4个按钮
    for (int i=0; i<4; i++) {
        
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(20+i*(55+20),20, 55, 55);
        [button addTarget:self action:@selector(tapButtonImage:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
      
        [self addSubview:button];
        [self.buttonArr addObject:button];
    }
#pragma 创建tableviewcell中下面的标签
    for (int i=0; i<4; i++) {
        
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(20+i*(55+20),78, 55, 15)];
        label.backgroundColor=[UIColor clearColor];
        label.textColor=[UIColor blackColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        [self addSubview:label];
        [self.labelArr addObject:label];
    }
}
-(void)setCellButtonImage:(NSArray *)cellButtonImage{
    
    _cellButtonImage=cellButtonImage;

    for (int i=0; i<cellButtonImage.count; i++) {
        
        NSString *name = [cellButtonImage objectAtIndex:i];
        UIButton*button=[self.buttonArr objectAtIndex:i];
        [button setImage:[UIImage imageWithContentsOfFile:name] forState:UIControlStateNormal];
    }
}
#pragma 手势点击tableviewcell
-(void)tapButtonImage:(UIButton*)button{
    
  
    [self.delegate goShop:self.lableURL[button.tag] name:_cellButtonTitle[button.tag]];
    
             
}
-(void)setCellButtonTitle:(NSMutableArray *)cellButtonTitle{
    
      _cellButtonTitle=cellButtonTitle;
    for (int i=0; i<cellButtonTitle.count; i++) {
        
        UILabel*label=[self.labelArr objectAtIndex:i];
        label.text=[cellButtonTitle objectAtIndex:i];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
