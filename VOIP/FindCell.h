//
//  TableViewCell.h
//  Demo
//
//  Created by 许宇勤 on 14/12/24.
//  Copyright (c) 2014年 许宇勤. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TableViewDelegate <NSObject>

- (void)goShop:(NSString*)url  name:(NSString*)name;

@end

@interface FindCell : UITableViewCell

@property(nonatomic,strong)NSArray*cellButtonImage;
@property(nonatomic,strong)NSMutableArray*cellButtonTitle;
@property(nonatomic,strong)NSMutableArray*lableURL;
@property(nonatomic,assign) id <TableViewDelegate> delegate;
@end
