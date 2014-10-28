//
//  vmVO.h
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-29.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VmVO : RemoteObject

@property NSString *isInstallTools;
@property int runTime;
@property NSString *createDate;

@property NSString *isDynamicCpu;
@property NSString *isDynamicMem;
@property NSString *memoryType;

@property int vmId;
@property NSString *name;
@property NSString *ip;
@property NSString *state;
@property int vcpu;
@property int memory;
@property int storage;
@property NSString *osType;
@property int poolId;
@property NSString *poolName;
@property int ownerHostId;
@property NSString *ownerHostName;

- (NSString *) isInstallTools_text;
- (NSString*)osType_imageName;
- (NSString*)osType_imageName_big;
- (NSString*)state_text;
- (UIColor *)state_color;
- (NSString *)memoryType_text;
- (BOOL) isDynamicCpu_img;
- (BOOL) isDynamicMemWce_img;

- (void) getVmVOAsync:(FetchObjectCompletionBlock)completeBlock;
- (void) getVmVolumnListAsync:(FetchAllCompletionBlock)completionBlock;
- (void) getVmNicListAsync:(FetchAllCompletionBlock)completionBlock;
- (void) vmStop:(BasicCompletionBlock)completeBlock;

    
@end
