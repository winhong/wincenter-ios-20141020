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
@property int maxMem;
@property int minMem;

- (NSString *) isInstallTools_text;
- (NSString*)osType_imageName;
- (NSString*)osType_imageName_big;
- (NSString*)state_text;
- (UIColor *)state_color;
- (NSString *)memoryType_text;
- (BOOL) isDynamicCpu_img;
- (BOOL) isDynamicMemWce_img;
- (float)storage_value;
- (NSString*)storage_unit;

- (void) getVmVOAsync:(FetchObjectCompletionBlock)completeBlock;
- (void) getVmVolumnListAsync:(FetchObjectCompletionBlock)completionBlock;
- (void) getVmVolumnListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList;
- (void) getVmNicListAsync:(FetchObjectCompletionBlock)completionBlock withType:(BOOL)isExternal referTo:(NSMutableArray*)referList;
- (void) vmRestart:(BasicCompletionBlock)completionBlock;
- (void) vmStart:(BasicCompletionBlock)completionBlock;
- (void) vmStop:(BasicCompletionBlock)completeBlock;
- (void) vmGetMigrateTargets:(FetchObjectCompletionBlock)completionBlock;
- (void) vmMigrate:(BasicCompletionBlock)completionBlock widthTargetHostId:(int)hostId;
- (void) vmConfigCPU:(BasicCompletionBlock)completionBlock withVCPU:(int)vcpu withCPUCap:(int)cpuCap withCPUWeight:(int)cpuWeight;
- (void) vmConfigMemory:(BasicCompletionBlock)completionBlock withReservation:(int)reservation withMinMem:(int)minMem;

- (void) getRaphaelAsync:(FetchObjectCompletionBlock)completionBlock;
- (void) getPerformanceAsync:(FetchObjectCompletionBlock)completionBlock withStartTime:(float)startTime;

@end
