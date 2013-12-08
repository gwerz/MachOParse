//
//  MOPLCHeader.h
//  MachOParse
//
//  Created by Sam Marshall on 9/27/13.
//  Copyright (c) 2013 Sam Marshall. All rights reserved.
//

#ifndef MachOParse_MOPLCHeader_h
#define MachOParse_MOPLCHeader_h

#import <Cocoa/Cocoa.h>
#import <objc/runtime.h>
#import <mach-o/loader.h>

enum MOPCommandType {
	CT_char = 1,
	CT_uint8_t = 2,
	CT_uint16_t = 3,
	CT_uint32_t = 4,
	CT_uint64_t = 5,
	CT_vm_prot_t = 6,
	CT_pointer = 7,
	CT_array = 8,
	CT_union = 9
};

struct MOPCommandDefintion {
	char *name;
	enum MOPCommandType type;
	uint32_t size;
};

@interface MOPLoadCommandHeader : NSObject
@property (nonatomic, readwrite) uint32_t cmd;
@property (nonatomic, readwrite) uint32_t cmdsize;
@end

#pragma mark -
#pragma mark LC_Segment

struct MOPCommandDefintion LCSegmentDefintion[] = {
	{"cmd", CT_uint32_t, 1},
	{"cmdsize", CT_uint32_t, 1},
	{"segname", CT_char, 16},
	{"vmaddr", CT_uint32_t, 1},
	{"vmsize", CT_uint32_t, 1},
	{"fileoff", CT_uint32_t, 1},
	{"filesize", CT_uint32_t, 1},
	{"maxprot", CT_vm_prot_t, 1},
	{"initprot", CT_vm_prot_t, 1},
	{"nsects", CT_uint32_t, 1},
	{"flags", CT_uint32_t, 1},
	{"segments", CT_array, 1}
};

@interface MOPLCSegment : NSObject
@property (nonatomic, strong) MOPLoadCommandHeader *header;
@property (nonatomic, readwrite) char *segname; // char[16]
@property (nonatomic, readwrite) uint32_t vmaddr;
@property (nonatomic, readwrite) uint32_t vmsize;
@end

#pragma mark -
#pragma mark LC_SymTab

struct MOPCommandDefintion LCSymTabDefintion[] = {
	{"cmd", CT_uint32_t, 1},
	{"cmdsize", CT_uint32_t, 1},
	{"symoff", CT_uint32_t, 1},
	{"nsyms", CT_uint32_t, 1},
	{"stroff", CT_uint32_t, 1},
	{"strsize", CT_uint32_t, 1}
};

@interface MOPLCSymTab : NSObject
@property (nonatomic, strong) MOPLoadCommandHeader *header;
@end

#pragma mark -
#pragma mark LC_SymSeg

struct MOPCommandDefintion LCSymSegDefintion[] = {
	{"cmd", CT_uint32_t, 1},
	{"cmdsize", CT_uint32_t, 1},
	{"offset", CT_uint32_t, 1},
	{"size", CT_uint32_t, 1}
};

@interface MOPLCSymSeg : NSObject
@property (nonatomic, strong) MOPLoadCommandHeader *header;
@end

#pragma mark -
#pragma mark LC_Thread

@interface MOPLCThread : NSObject
@property (nonatomic, strong) MOPLoadCommandHeader *header;
@end

#pragma mark -
#pragma mark LC_UnixThread

@interface MOPLCUnixThread : NSObject
@property (nonatomic, strong) MOPLoadCommandHeader *header;
@end

#pragma mark -
#pragma mark LC_LoadFVMLib

struct MOPCommandDefintion LCLoadFVMLibDefintion[] = {
	{"cmd", CT_uint32_t, 1},
	{"cmdsize", CT_uint32_t, 1},
	{"name", CT_union, 1},
	{"minor_version", CT_uint32_t, 1},
	{"header_addr", CT_uint32_t, 1}
};

@interface MOPLCLoadFVMLib : NSObject
@property (nonatomic, strong) MOPLoadCommandHeader *header;
@end

#pragma mark -
#pragma mark LC_IdFVMLib

struct MOPCommandDefintion LCIdFVMLibDefintion[] = {
	{"cmd", CT_uint32_t, 1},
	{"cmdsize", CT_uint32_t, 1},
	{"name", CT_union, 1},
	{"minor_version", CT_uint32_t, 1},
	{"header_addr", CT_uint32_t, 1}
};

@interface MOPLCIdFVMLib : NSObject
@property (nonatomic, strong) MOPLoadCommandHeader *header;
@end

#pragma mark -
#pragma mark LC_Ident

struct MOPCommandDefintion LCIdentDefintion[] = {
	{"cmd", CT_uint32_t, 1},
	{"cmdsize", CT_uint32_t, 1},
	{"strings", CT_array, 1}
};

@interface MOPLCIdent : NSObject
@property (nonatomic, strong) MOPLoadCommandHeader *header;
@end

#pragma mark -
#pragma mark LC_FVMFile

struct MOPCommandDefintion LCFVMFileDefintion[] = {
	{"cmd", CT_uint32_t, 1},
	{"cmdsize", CT_uint32_t, 1},
	{"name", CT_union, 1},
	{"header_addr", CT_uint32_t, 1}
};

@interface MOPLCFVMFile : NSObject
@property (nonatomic, strong) MOPLoadCommandHeader *header;
@end

#pragma mark -
#pragma mark LC_PrePage

@interface MOPLCPrePage : NSObject
@property (nonatomic, strong) MOPLoadCommandHeader *header;
@end

#pragma mark -
#pragma mark LC_DySymTab

struct MOPCommandDefintion LCDySymTabDefintion[] = {
	{"cmd", CT_uint32_t, 1},
	{"cmdsize", CT_uint32_t, 1},
	{"ilocalsym", CT_uint32_t, 1},
	{"nlocalsym", CT_uint32_t, 1},
	{"iextdefsym", CT_uint32_t, 1},
	{"nextdefsym", CT_uint32_t, 1},
	{"iundefsym", CT_uint32_t, 1},
	{"nundefsym", CT_uint32_t, 1},
	{"tocoff", CT_uint32_t, 1},
	{"ntoc", CT_uint32_t, 1},
	{"modtaboff", CT_uint32_t, 1},
	{"nmodtab", CT_uint32_t, 1},
	{"extrefsymoff", CT_uint32_t, 1},
	{"nextrefsymoff", CT_uint32_t, 1},
	{"indirectsymoff", CT_uint32_t, 1},
	{"nindirectsym", CT_uint32_t, 1},
	{"extreloff", CT_uint32_t, 1},
	{"nextrel", CT_uint32_t, 1},
	{"locreloff", CT_uint32_t, 1},
	{"nlocrel", CT_uint32_t, 1}
};

@interface MOPLCDySymTab : NSObject
@property (nonatomic, strong) MOPLoadCommandHeader *header;
@end



#import "MOPLCLoadDylib.h"
#import "MOPLCIdDylib.h"
#import "MOPLCLoadDylinker.h"
#import "MOPLCIdDylinker.h"
#import "MOPLCPreBoundDylib.h"
#import "MOPLCRoutines.h"
#import "MOPLCSubFramework.h"
#import "MOPLCSubUmbrella.h"
#import "MOPLCSubClient.h"
#import "MOPLCSubLibrary.h"
#import "MOPLCTwoLevelHints.h"
#import "MOPLCPrebindChecksum.h"
/*
 
#pragma mark -
#pragma mark LC_

struct MOPCommandDefintion LCDefintion[] = {
	{"cmd", CT_uint32_t, 1},
	{"cmdsize", CT_uint32_t, 1},
};

struct MOPCommand LC = {

};

@interface MOPLC : NSObject
@end

*/
#endif
