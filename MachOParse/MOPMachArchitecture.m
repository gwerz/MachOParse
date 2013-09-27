//
//  MOPMachArchitecture.m
//  MachOParse
//
//  Created by Sam Marshall on 9/26/13.
//  Copyright (c) 2013 Sam Marshall. All rights reserved.
//

#import "MOPMachArchitecture.h"
#import <mach-o/loader.h>
#import "MOPLoadCommand.h"

@implementation MOPMachArchitecture

@synthesize offset = _offset;
@synthesize header = _header;
@synthesize lcSegments = _lcSegments;

- (instancetype)initWithArchData:(NSData *)data isFat:(BOOL)fat atOffset:(uint32_t)offset {
	self = [super init];
	if (self) {
		if (fat) {
			// fat arch header
			uint32_t fatOffset = 0;
			[data getBytes:&fatOffset range:NSMakeRange(offset+sizeof(cpu_type_t)+sizeof(cpu_subtype_t), sizeof(uint32_t))];
			offset += fatOffset;
		}
		_offset = offset;
		NSData *headerData = [data subdataWithRange:NSMakeRange(offset, sizeof(struct mach_header))];
		_header = [[MOPMachHeader alloc] initWithMachHeader:headerData];
		if (_header.magic == MH_MAGIC_64 || _header.magic == MH_CIGAM_64) {
			uint32_t reserved = 0;
			[data getBytes:&reserved range:NSMakeRange(offset+sizeof(struct mach_header), sizeof(uint32_t))];
			_header.reserved = reserved;
		}
		offset += ((_header.magic == MH_MAGIC_64 || _header.magic == MH_CIGAM_64) ? sizeof(struct mach_header_64) : sizeof(struct mach_header));
		NSData *segmentData = [data subdataWithRange:NSMakeRange(offset, _header.sizeOfCmds)];
		NSMutableArray *loadCommands = [[NSMutableArray alloc] initWithCapacity:0];
		uint32_t segmentOffset = 0;
		for (uint32_t i = 0; i < _header.ncmds; i++) {
			NSData *segmentHeader = [segmentData subdataWithRange:NSMakeRange(segmentOffset, sizeof(struct load_command))];
			uint32_t segmentSize = [MOPLoadCommand commandSize:segmentHeader];
			NSData *commandData = [segmentData subdataWithRange:NSMakeRange(segmentOffset, segmentSize)];
			MOPLoadCommand *segment = [[MOPLoadCommand alloc] initWithCommand:commandData];
			[loadCommands addObject:segment];
		}
		_lcSegments = [NSArray arrayWithArray:loadCommands];
	}
	return self;
}

@end
