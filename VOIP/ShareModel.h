//
//  ShareModel.h
//  Move
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface ShareModel : NSObject
+(instancetype)shareModel;

+(void)shareModel:(UIViewController*)controller snsName:(NSString *)snsName  shareImage:(UIImage *)shareImage shareText:(NSString *)shareText;

@property (strong,nonatomic) NSString *shareUrl;



@end
