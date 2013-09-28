//
//  MOPMachHeader.m
//  MachOParse
//
//  Created by Sam Marshall on 9/26/13.
//  Copyright (c) 2013 Sam Marshall. All rights reserved.
//

#import "MOPMachHeader.h"
#import <mach-o/loader.h>

@implementation MOPMachHeader

@synthesize magic = _magic;
@synthesize cpuType = _cpuType;
@synthesize cpuSubType = _cpuSubType;
@synthesize fileType = _fileType;
@synthesize ncmds = _ncmds;
@synthesize sizeOfCmds = _sizeOfCmds;
@synthesize flags = _flags;
@synthesize reserved = _reserved;

- (instancetype)initWithMachHeader:(NSData *)headerData {
	self = [super init];
	if (self) {
		[headerData getBytes:&_magic range:NSMakeRange(0, sizeof(uint32_t))];
		[headerData getBytes:&_cpuType range:NSMakeRange(sizeof(uint32_t), sizeof(cpu_type_t))];
		[headerData getBytes:&_cpuSubType range:NSMakeRange(sizeof(uint32_t)+sizeof(cpu_type_t), sizeof(cpu_subtype_t))];
		[headerData getBytes:&_fileType range:NSMakeRange(sizeof(uint32_t)+sizeof(cpu_type_t)+sizeof(cpu_subtype_t), sizeof(uint32_t))];
		[headerData getBytes:&_ncmds range:NSMakeRange(sizeof(uint32_t)+sizeof(cpu_type_t)+sizeof(cpu_subtype_t)+sizeof(uint32_t), sizeof(uint32_t))];
		[headerData getBytes:&_sizeOfCmds range:NSMakeRange(sizeof(uint32_t)+sizeof(cpu_type_t)+sizeof(cpu_subtype_t)+sizeof(uint32_t)+sizeof(uint32_t), sizeof(uint32_t))];
		[headerData getBytes:&_flags range:NSMakeRange(sizeof(uint32_t)+sizeof(cpu_type_t)+sizeof(cpu_subtype_t)+sizeof(uint32_t)+sizeof(uint32_t)+sizeof(uint32_t), sizeof(uint32_t))];
		if (_magic == 0xfeedfacf || _magic == 0xcffaedfe)
			[headerData getBytes:&_reserved range:NSMakeRange(sizeof(struct mach_header), sizeof(uint32_t))];
	}
	return self;
}

- (NSString *)nameOfFileType {
	NSString *name = @"Unknown";
	switch (_fileType) {
		case MH_OBJECT:
			name = @"Object";
			break;
		case MH_EXECUTE:
			name = @"Executable";
			break;
		case MH_FVMLIB:
			name = @"Fixed VM Shared Library";
			break;
		case MH_CORE:
			name = @"Core";
			break;
		case MH_PRELOAD:
			name = @"Preloaded Executable";
			break;
		case MH_DYLIB:
			name = @"Dynamically Bound Shared Library";
			break;
		case MH_DYLINKER:
			name = @"Dynamic Link Editor";
			break;
		case MH_BUNDLE:
			name = @"Dynamically Bound Bundle";
			break;
		case MH_DYLIB_STUB:
			name = @"Shared Library Stub";
			break;
		case MH_DSYM:
			name = @"Companion File";
			break;
		case MH_KEXT_BUNDLE:
			name = @"Kernel Extension Bundle";
			break;
		default:
			break;
	}
	return name;
}

@end