//
//  dataStore.h
//  NK
//
//  Created by ceq on 13-11-5.
//  Copyright (c) 2013年 nnkou. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface dataStore : NSObject
{
    NSString *docPath;
    NSString *file;
}
-(id)initWithPath:(NSString *)_path;
-(NSString *)getDocumentsDirectory;
-(NSString *)newFile:(NSString *)_fileName;
-(BOOL)writeFile:(NSData*)_data;
-(void)deleteFile;
-(NSData *)readFile;
@end
