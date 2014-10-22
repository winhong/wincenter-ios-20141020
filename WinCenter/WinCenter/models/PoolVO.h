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
@property NSString *version;
@property int versionDate;

@property float totalCpu;
@property float totalMemory;
@property float totalStorage;
@property float availCpu;
@property float availMemory;
@property float availStorage;
@property NSString *haEnabled;


-(float)cpuRatio;

-(UIColor *)cpuRatioColor;

-(float)memoryRatio;

-(UIColor *)memoryRatioColor;

-(float)storageRatio;

-(UIColor *)storageRatioColor;

- (void) getPoolVOAsync:(FetchObjectCompletionBlock)completeBlock;
- (void) getPoolElasticAsync:(FetchObjectCompletionBlock)completeBlock;
    
- (NSArray *) getHostLisWithlimit:(int)count error:(NSError **)error;
- (void) getHostListAsync:(FetchAllCompletionBlock)completionBlock;
- (NSArray *) getStorageList:(NSError **)error;
- (void) getStorageListAsync:(FetchAllCompletionBlock)completionBlock;
- (NSArray *) getVmListWithlimit:(int)count error:(NSError **)error;
- (void) getVmListAsync:(FetchAllCompletionBlock)completionBlock;
@end
