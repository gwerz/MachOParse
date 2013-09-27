//
//  MOPBinaryFile.h
//  MachOParse
//
//  Created by Sam Marshall on 9/26/13.
//  Copyright (c) 2013 Sam Marshall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOPBinaryFile : NSObject

@property (nonatomic, strong) NSURL *filePath;
@property (nonatomic, readwrite) uint64_t size;
@property (nonatomic, strong) NSArray *architectures;

- (instancetype)initWithFileURL:(NSURL *)fileURL;
- (BOOL)isFat:(NSData *)data;

@end
