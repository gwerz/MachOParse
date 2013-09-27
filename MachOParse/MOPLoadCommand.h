//
//  MOPLoadCommand.h
//  MachOParse
//
//  Created by Sam Marshall on 9/26/13.
//  Copyright (c) 2013 Sam Marshall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOPLoadCommand : NSObject

@property (nonatomic, readwrite) uint32_t cmdType;
@property (nonatomic, readwrite) uint32_t cmdSize;
@property (nonatomic, strong) NSData *cmdData;

+ (uint32_t)commandSize:(NSData *)data;
- (instancetype)initWithCommand:(NSData *)data;
- (id)generateCommandClass;

@end
