//
//  MOPLoadCommand.m
//  MachOParse
//
//  Created by Sam Marshall on 9/26/13.
//  Copyright (c) 2013 Sam Marshall. All rights reserved.
//

#import "MOPLoadCommand.h"
#import <mach-o/loader.h>
#import "MOPLCHeader.h"

@implementation MOPLoadCommand

@synthesize cmdType = _cmdType;
@synthesize cmdSize = _cmdSize;
@synthesize cmdData = _cmdData;

+ (uint32_t)commandSize:(NSData *)data {
	uint32_t size = 0;
	[data getBytes:&size range:NSMakeRange(sizeof(uint32_t), sizeof(uint32_t))];
	return size;
}

- (instancetype)initWithCommand:(NSData *)data {
	self = [super init];
	if (self) {
		_cmdData = [NSData dataWithData:data];
		[_cmdData getBytes:&_cmdType range:NSMakeRange(0, sizeof(uint32_t))];
		[_cmdData getBytes:&_cmdSize range:NSMakeRange(sizeof(uint32_t), sizeof(uint32_t))];
	}
	return self;
}

#ifndef MAC_OS_X_VERSION_10_9
#define	LC_ENCRYPTION_INFO_64 	0x2C 	/* 64-bit encrypted segment information */
#define LC_LINKER_OPTION 		0x2D	/* linker options in MH_OBJECT files */
#endif

- (id)generateCommandClass {
	id command;
	switch (_cmdType) {
		case LC_SEGMENT:
			command = [[MOPLCSegment alloc] init];
			break;
		case LC_SYMTAB:
			command = [[MOPLCSymTab alloc] init];
			break;
		case LC_SYMSEG:
			command = [[MOPLCSymSeg alloc] init];
			break;
		case LC_THREAD:
			command = [[MOPLCThread alloc] init];
			break;
		case LC_UNIXTHREAD:
			command = [[MOPLCUnixThread alloc] init];
			break;
		case LC_LOADFVMLIB:
			command = [[MOPLCLoadFVMLib alloc] init];
			break;
		case LC_IDFVMLIB:
			command = [[MOPLCIdFVMLib alloc] init];
			break;
		case LC_IDENT:
			command = [[MOPLCIdent alloc] init];
			break;
		case LC_FVMFILE:
			command = [[MOPLCFVMFile alloc] init];
			break;
		case LC_PREPAGE:
			command = [[MOPLCPrePage alloc] init];
			break;
		case LC_DYSYMTAB:
			command = [[MOPLCDySymTab alloc] init];
			break;
		case LC_LOAD_DYLIB:
			command = [[MOPLCLoadDylib alloc] init];
			break;
		case LC_ID_DYLIB:
			command = [[MOPLCIdDylib alloc] init];
			break;
		case LC_LOAD_DYLINKER:
			command = [[MOPLCLoadDylinker alloc] init];
			break;
		case LC_ID_DYLINKER:
			command = [[MOPLCIdDylinker alloc] init];
			break;
		case LC_PREBOUND_DYLIB:
			command = [[MOPLCPreBoundDylib alloc] init];
			break;
		case LC_ROUTINES:
			command = [[MOPLCRoutines alloc] init];
			break;
		case LC_SUB_FRAMEWORK:
			command = [[MOPLCSubFramework alloc] init];
			break;
		case LC_SUB_UMBRELLA:
			command = [[MOPLCSubUmbrella alloc] init];
			break;
		case LC_SUB_CLIENT:
			command = [[MOPLCSubClient alloc] init];
			break;
		case LC_SUB_LIBRARY:
			command = [[MOPLCSubLibrary alloc] init];
			break;
		case LC_TWOLEVEL_HINTS:
			command = [[MOPLCTwoLevelHints alloc] init];
			break;
		case LC_PREBIND_CKSUM:
			command = [[MOPLCPrebindChecksum alloc] init];
			break;
		case LC_LOAD_WEAK_DYLIB:
		case LC_SEGMENT_64:
		case LC_ROUTINES_64:
		case LC_UUID:
		case LC_RPATH:
		case LC_CODE_SIGNATURE:
		case LC_SEGMENT_SPLIT_INFO:
		case LC_REEXPORT_DYLIB:
		case LC_LAZY_LOAD_DYLIB:
		case LC_ENCRYPTION_INFO:
		case LC_DYLD_INFO:
		case LC_DYLD_INFO_ONLY:
		case LC_LOAD_UPWARD_DYLIB:
		case LC_VERSION_MIN_MACOSX:
		case LC_VERSION_MIN_IPHONEOS:
		case LC_FUNCTION_STARTS:
		case LC_DYLD_ENVIRONMENT:
		case LC_MAIN:
		case LC_DATA_IN_CODE:
		case LC_SOURCE_VERSION:
		case LC_DYLIB_CODE_SIGN_DRS:
		case LC_ENCRYPTION_INFO_64:
		case LC_LINKER_OPTION:
		case LC_REQ_DYLD:
		default:
			break;
	}
	return command;
}

@end
