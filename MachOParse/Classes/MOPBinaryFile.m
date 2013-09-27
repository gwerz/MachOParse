//
//  MOPBinaryFile.m
//  MachOParse
//
//  Created by Sam Marshall on 9/26/13.
//  Copyright (c) 2013 Sam Marshall. All rights reserved.
//

#import "MOPBinaryFile.h"
#import <mach-o/fat.h>
#import <mach-o/loader.h>
#import "MOPMachArchitecture.h"

@implementation MOPBinaryFile

@synthesize filePath = _filePath;
@synthesize size = _size;
@synthesize architectures = _architectures;

- (instancetype)initWithFileURL:(NSURL *)fileURL {
	self = [super init];
	if (self) {
		BOOL loadFile = false;
		if (fileURL) {
			BOOL isDirectory;
			if ([[NSFileManager defaultManager] fileExistsAtPath:[fileURL absoluteString] isDirectory:&isDirectory]) {
				if (!isDirectory) {
					loadFile = true;
				}
			}
		}
		if (loadFile) {
			NSData *binaryData = [[NSData alloc] initWithContentsOfURL:fileURL];
			_size = [binaryData length];
			BOOL fatArch = [self isFat:binaryData];
			uint32_t count = (fatArch ? [self architectureCount:binaryData] : 1);
			NSMutableArray *archTemp = [[NSMutableArray alloc] initWithCapacity:0];
			uint32_t offset = (fatArch ? sizeof(struct fat_header) : 0);
			uint32_t magic = 0;
			[binaryData getBytes:&magic length:sizeof(uint32_t)];
			for (uint32_t i = 0; i < count; i++) {
				MOPMachArchitecture *arch = [[MOPMachArchitecture alloc] initWithArchData:binaryData isFat:fatArch atOffset:offset];
				if (fatArch)
					arch.header.magic = magic;
				[archTemp addObject:arch];
				offset += (fatArch ? sizeof(struct fat_arch) : 0);
			}
			_architectures = [NSArray arrayWithArray:archTemp];
		}
	}
	return self;
}

- (BOOL)isFat:(NSData *)data {
	uint32_t header;
	[data getBytes:&header length:sizeof(uint32_t)];
	return ((header == FAT_MAGIC || header == FAT_CIGAM) ? true : false);
}

- (uint32_t)architectureCount:(NSData *)data {
	uint32_t architectures = 0;
	[data getBytes:&architectures range:NSMakeRange(sizeof(uint32_t), sizeof(uint32_t))];
	return architectures;
}

@end
