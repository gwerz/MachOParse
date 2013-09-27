//
//  MOPMachArchitecture.h
//  MachOParse
//
//  Created by Sam Marshall on 9/26/13.
//  Copyright (c) 2013 Sam Marshall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOPMachHeader.h"

@interface MOPMachArchitecture : NSObject

@property (nonatomic, readwrite) uint32_t offset;
@property (nonatomic, strong) MOPMachHeader *header;
@property (nonatomic, strong) NSArray *lcSegments;

- (instancetype)initWithArchData:(NSData *)data isFat:(BOOL)fat atOffset:(uint32_t)offset;

@end
