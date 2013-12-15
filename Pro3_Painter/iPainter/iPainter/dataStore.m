//
//  dataStore.m
//  NK
//
//  Created by ceq on 13-11-5.
//  Copyright (c) 2013年 nnkou. All rights reserved.
//

#import "dataStore.h"

@implementation dataStore
-(id)initWithPath:(NSString *)_path{
    if(self=[super init]){
        docPath = [NSHomeDirectory() stringByAppendingPathComponent:_path];
    }
    return self;
}
-(NSString *)getDocumentsDirectory{
    return docPath;
}
-(NSString *)newFile:(NSString *)_fileName{
    NSString *filePath= [docPath stringByAppendingPathComponent:_fileName];
    file=filePath;
    return filePath;
}
-(BOOL)writeFile:(NSData *)_data{
    return [_data writeToFile:file atomically:YES];
}
-(void)deleteFile{
    NSFileManager* pFM =[NSFileManager defaultManager];
    [pFM removeItemAtPath:file error:nil];
}
-(NSData *)readFile{
    NSData *data = [NSData dataWithContentsOfFile:file];
    return data;
}
@end
