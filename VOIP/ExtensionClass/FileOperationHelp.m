//
//  FileOperationHelp.m
//  VOIP
//
//  Created by hermit on 14-11-25.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "FileOperationHelp.h"

@implementation FileOperationHelp


-(void)writeArray:(NSArray *)array withFileName:(NSString *)fileName withDir:(NSString *)fileDir
{
    [self createDirWithFileName:fileDir];
    
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documents[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",fileDir,fileName]];
    [array writeToFile:path atomically:YES];
}

-(void)writeDict:(NSMutableDictionary *)dict withFileName:(NSString *)name withDir:(NSString *)fileDir
{
    
    [self createDirWithFileName:fileDir];
    
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documents[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",fileDir,name]];
    [dict writeToFile:path atomically:YES];
}

- (void)writeImage:(NSData *)imageData withFileName:(NSString *)fileName withDir:(NSString *)fileDir
{
    [self createDirWithFileName:fileDir];
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documents[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",fileDir,fileName]];
    // 3. 将NSData写入文件
    [imageData writeToFile:path atomically:YES];
}
//删除文件的方法
-(void)deleteFileWithName:(NSString *)fileName withDir:(NSString *)fileDir
{
    //文件路径
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documents[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",fileDir,fileName]];
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:path error:nil];
}

-(void)deleteOldFile:(NSArray *)oldFileNames withNewFileNames:(NSArray *)newFileNames withDir:(NSString *)fileDir
{
    
    for (NSInteger i = 0; i < oldFileNames.count; i++) {
        NSString *oldName = oldFileNames[i];
        for (NSInteger k = 0; k < newFileNames.count; k++) {
            
            NSString *newName = newFileNames[k];
            if ([oldName isEqualToString:newName]) {
                break;
            }
            else if(k == newFileNames.count - 1)//不存在则删除
            {
                [self deleteFileWithName:oldName withDir:fileDir];
            }
        }
    }
}

-(void)createDirWithFileName:(NSString *)fileName
{
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *imageDir = [documents[0] stringByAppendingPathComponent:fileName];
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
}



//yes 表示有新图片 no表示没有新的图片
-(BOOL)loadImageWithImageInfo:(NSArray *)imageInfo withSaveFileDir:(NSString *)fileDir withSavePlistFileName:(NSString *)fileName
{
    @autoreleasepool {
        //是否有图片下载
        BOOL hasNewImage = true;
        //是否下载了新的图片
        BOOL b = false;
        //保存旧图片名称
        NSMutableArray *oldNameArr = [[NSMutableArray alloc]init];
        //保存新图片名称
        NSMutableArray *newNameArr = [[NSMutableArray alloc]init];
        
        NSArray *array = imageInfo;
        NSArray *arrayM = [[NSArray alloc]init];
        NSMutableArray *newImageInfo = [[NSMutableArray alloc]init];
        //文件路径
        NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [documents[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",fileDir,fileName]];
        arrayM = [NSArray arrayWithContentsOfFile:path];
        
        for (NSInteger i = 0; i < array.count; i++) {
            //新图片信息
            NSDictionary *dict = array[i];
            //取出图片名称
            if (dict[@"p_img_full"] == nil) {
                continue;
            }
            NSArray *separatedName = [dict[@"p_img_full"] componentsSeparatedByString:@"/"];
            NSString *newImageName = separatedName[separatedName.count - 1];
            [newNameArr addObject:newImageName];
            //判断图片是否存在
            if (arrayM != nil && arrayM.count > 0) {
                for (NSInteger k = 0; k < arrayM.count; k++) {
                    //旧图片信息
                    NSDictionary *dictM = arrayM[k];
                    NSString *oldImageName = dictM[@"p_img_full"];
                    
                    if (i == 0) {
                        [oldNameArr addObject:oldImageName];
                    }
                    
                    //此图片已存在
                    if ([newImageName isEqualToString:oldImageName]) {
                        hasNewImage = false;
                        NSMutableDictionary *temDict = [NSMutableDictionary dictionaryWithCapacity:5];
                        [temDict setValue:newImageName forKey:@"p_img_full"];
                        [temDict setValue:dict[@"p_url"] forKey:@"p_url"];
                       [temDict setValue:dict[@"p_desc"] forKey:@"p_desc"];
                        [newImageInfo addObject:temDict];
                        break;
                    }
                    else if (k == arrayM.count -1)
                    {
                        //有新图片
                        hasNewImage = true;
                    }
                }
            }
            
            
            if (hasNewImage) {
                NSError *error;
                NSURL *url2 = [NSURL URLWithString:dict[@"p_img_full"]];
                NSURLRequest *request = [NSURLRequest requestWithURL:url2];
                NSHTTPURLResponse *response;
                NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                if (response.statusCode == 200) {
                    b = true;
                    //[dict setValue:newImageName forKey:@"p_img_full"];
                    
                    NSMutableDictionary *temDict = [NSMutableDictionary dictionaryWithCapacity:5];
                  
                    [temDict setValue:newImageName forKey:@"p_img_full"];
                    [temDict setValue:dict[@"p_url"] forKey:@"p_url"];
                    [temDict setValue:dict[@"p_desc"] forKey:@"p_desc"];
                    [newImageInfo addObject:temDict];
                    //保存图片
                    [self writeImage:data withFileName:newImageName withDir:fileDir];
                   // NSLog(@"下载成功");
                    
                }
                
            }
        }
        
        if (newImageInfo.count > 0) {
            [self writeArray:newImageInfo withFileName:fileName withDir:fileDir];
        }
        
        [self deleteOldFile:oldNameArr withNewFileNames:newNameArr withDir:fileDir];
        
        
        return b;
        
    }
}
@end
