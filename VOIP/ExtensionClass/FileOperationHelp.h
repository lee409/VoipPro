//
//  FileOperationHelp.h
//  VOIP
//
//  Created by hermit on 14-11-25.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileOperationHelp : NSObject


-(BOOL) loadImageWithImageInfo:(NSArray *)imageInfo withSaveFileDir:(NSString *)fileDir withSavePlistFileName:(NSString *)fileName;//
-(void)writeDict:(NSMutableDictionary *)dict withFileName:(NSString *)name withDir:(NSString *)fileDir;
@end
