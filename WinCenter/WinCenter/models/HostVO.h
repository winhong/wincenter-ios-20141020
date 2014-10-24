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
- (void) getHostNetworkExternalListAsync:(FetchAllCompletionBlock)completionBlock;
- (void) getHostNetworkInternalListAsync:(FetchAllCompletionBlock)completionBlock;
- (void) getHostNicUngroupedListAsync:(FetchAllCompletionBlock)completionBlock;
- (void) getHostNicGroupedListAsync:(FetchAllCompletionBlock)completionBlock;
- (void) getStorageListAsync:(FetchAllCompletionBlock)completionBlock;
- (void) getVmListAsync:(FetchAllCompletionBlock)completionBlock;
- (void) getActivityVmAsync:(FetchObjectCompletionBlock)completionBlock;
- (void) getPerformanceAsync:(FetchObjectCompletionBlock)completionBlock;

@end
