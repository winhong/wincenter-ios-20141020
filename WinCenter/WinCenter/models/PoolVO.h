//
//  PoolVO.h
//  0805
//
//  Created by 黄茂坚 on 14-8-5.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PoolVO : RemoteObject

@property int resourcePoolId;
@property NSString *resourcePoolName;
@property int hostNumber;
@property int vmNumber;
@property int activeVmNumber;
@property float totalLogicalCpu;
@property NSString *hypervisor;
@property NSString *productVersion;
@property int versionDate;

@property float totalCpu;
@property float totalMemory;
@property float totalStorage;
@property float availCpu;
@property float availMemory;
@property float availStorage;
@property NSString *haEnabled;

-(NSString*)versionDate_text;

-(NSString*)hypervisor_text;

-(float)cpuRatio;

-(UIColor *)cpuRatioColor;

-(float)memoryRatio;

-(UIColor *)memoryRatioColor;

-(float)storageRatio;

-(UIColor *)storageRatioColor;

- (float)totalCpu_value;
- (NSString*)totalCpu_unit;

- (float)totalStorage_value;
- (NSString*)totalStorage_unit;

- (float)availCpu_value;
- (NSString*)availCpu_unit;

- (float)availStorage_value;
- (NSString*)availStorage_unit;

- (float)usedCpu_value;
- (NSString*)usedCpu_unit;

- (float)usedStorage_value;
- (NSString*)usedStorage_unit;


- (void) getPoolVOSync:(FetchObjectCompletionBlock)completeBlock;
- (void) getPoolVOAsync:(FetchObjectCompletionBlock)completeBlock;
- (void) getPoolElasticAsync:(FetchObjectCompletionBlock)completeBlock;
- (void) getHostListAsync:(FetchObjectCompletionBlock)completionBlock;
- (void) getHostListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList;
- (void) getStorageListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList;
- (NSArray *) getVmListWithlimit:(int)count error:(NSError **)error;
- (void) getVmListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList;
- (void) getHaMaxHostFailuresAsync:(FetchObjectCompletionBlock)completionBlock;
- (void) getHaInfoAsync:(FetchObjectCompletionBlock)completionBlock;
@end
