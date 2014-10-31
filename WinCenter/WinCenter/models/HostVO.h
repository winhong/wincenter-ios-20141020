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

@property float storage;
@property int virtualMachineNum;
@property NSString *state;

@property float memory;

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

- (void) getHostVOAsync:(FetchObjectCompletionBlock)completeBlock;
- (void) getHostStatVOAsync:(FetchObjectCompletionBlock)completeBlock;
- (void) getHostNetworkListAsync:(FetchObjectCompletionBlock)completionBlock withType:(BOOL)isExternal referTo:(NSMutableArray*)referList;
- (void) getHostNicListAsync:(FetchObjectCompletionBlock)completionBlock withType:(BOOL)isGrouped referTo:(NSMutableArray*)referList;
- (void) getStorageListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList;
- (void) getVmListAsync:(FetchObjectCompletionBlock)completionBlock;
- (void) getVmListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList;
- (void) getActivityVmAsync:(FetchObjectCompletionBlock)completionBlock;
- (void) getPerformanceAsync:(FetchObjectCompletionBlock)completionBlock withStartTime:(int)startTime;

@end
