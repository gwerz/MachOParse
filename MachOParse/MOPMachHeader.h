//
//  MOPMachHeader.h
//  MachOParse
//
//  Created by Sam Marshall on 9/26/13.
//  Copyright (c) 2013 Sam Marshall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOPMachHeader : NSObject

@property (nonatomic, readwrite) uint32_t magic;
@property (nonatomic, readwrite) cpu_type_t cpuType;
@property (nonatomic, readwrite) cpu_subtype_t cpuSubType;
@property (nonatomic, readwrite) uint32_t fileType;
@property (nonatomic, readwrite) uint32_t ncmds;
@property (nonatomic, readwrite) uint32_t sizeOfCmds;
@property (nonatomic, readwrite) uint32_t flags;
@property (nonatomic, readwrite) uint32_t reserved;

- (instancetype)initWithMachHeader:(NSData *)headerData;

@end
