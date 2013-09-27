//
//  MOPLoadCommand.h
//  MachOParse
//
//  Created by Sam Marshall on 9/26/13.
//  Copyright (c) 2013 Sam Marshall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOPLoadCommand : NSObject

- (instancetype)initWithCommand:(NSData *)data;

+ (uint32_t)commandSize:(NSData *)data;

- (id)generateCommandClass;

@end
