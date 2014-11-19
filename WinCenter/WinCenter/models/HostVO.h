//
//  HostVO.h
//  0805
//
//  Created by 黄茂坚 on 14-8-5.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HostVO : RemoteObject

@property int resourcePoolId;
@property NSString *resourcePoolName;
@property int hostId;
@property NSString *hostName;

@property NSString *ip;


@property int virtualMachineNum;
@property NSString *state;


@property float memory;
@property float storage;
@property float localStorage;
@property float availCpu;
@property float availMemory;
@property float availStorage;


@property int networkNum;

@property NSString *virtualVersion;
@property NSString *virtualSoftware;
@property NSString *versionDate;
@property int startRunTime;

@property int cpuSpeed;//MHz
@property NSString *model;
@property NSString *vendor;
@property int cpuSlots;
@property int cpu;
 

- (NSString*)state_text;
- (UIColor *)state_color;
- (float)storage_value;
- (NSString*)storage_unit;
- (float)localStorage_value;
- (NSString*)localStorage_unit;
- (NSString*)resourcePoolName_text;

- (void) getHostVOAsync:(FetchObjectCompletionBlock)completeBlock;
- (void) getHostStatVOAsync:(FetchObjectCompletionBlock)completeBlock;
- (void) getHostNetworkListAllAsync:(FetchObjectCompletionBlock)completionBlock;
- (void) getHostNetworkListAsync:(FetchObjectCompletionBlock)completionBlock withType:(BOOL)isExternal referTo:(NSMutableArray*)referList;
- (void) getHostNicListAsync:(FetchObjectCompletionBlock)completionBlock withType:(BOOL)isGrouped referTo:(NSMutableArray*)referList;
- (void) getStorageListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList;
- (void) getVmListAsync:(FetchObjectCompletionBlock)completionBlock;
- (void) getVmListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList;
- (void) getActivityVmAsync:(FetchObjectCompletionBlock)completionBlock;
- (void) getPerformanceAsync:(FetchObjectCompletionBlock)completionBlock withStartTime:(float)startTime;

@end
