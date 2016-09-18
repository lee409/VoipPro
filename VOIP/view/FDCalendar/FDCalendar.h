//
//  FDCalendar.h
//  FDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDCalendarItem.h"
#import "Utility.h"
@interface FDCalendar : UIView

- (instancetype)initWithCurrentDate:(NSDate *)date;

@property (strong, nonatomic) FDCalendarItem *centerCalendarItem;
@property (strong, nonatomic) FDCalendarItem *leftCalendarItem;

@property (strong, nonatomic) FDCalendarItem *rightCalendarItem;

@end
