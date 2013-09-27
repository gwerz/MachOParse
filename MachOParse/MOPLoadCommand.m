//
//  MOPLoadCommand.m
//  MachOParse
//
//  Created by Sam Marshall on 9/26/13.
//  Copyright (c) 2013 Sam Marshall. All rights reserved.
//

#import "MOPLoadCommand.h"

@implementation MOPLoadCommand

- (instancetype)initWithCommand:(NSData *)data {
	self = [super init];
	if (self) {
		
	}
	return self;
}

+ (uint32_t)commandSize:(NSData *)data {
	uint32_t size = 0;
	[data getBytes:&size range:NSMakeRange(sizeof(uint32_t), sizeof(uint32_t))];
	return size;
}

- (id)generateCommandClass {
	return nil;
}

@end
