//
//  DatacenterVO.h
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-27.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatacenterVO : RemoteObject
@property int id;
@property NSString *name;;
@property NSString *wceIpAddress;
@property int wcePort;
@property NSString *wceAccount;
@property NSString *wcePassword;
@property NSString *remark;
@property NSString *createTime;
@property NSString *lastUpdateTime;
@property BOOL busCanDel;
@property BOOL vdcCanDel;
@property BOOL resCaseCanDel;

- (void) getDatacenterVOAsync:(FetchObjectCompletionBlock)completionBlock;
+ (void) getDatacenterListAsync:(FetchObjectCompletionBlock)completionBlock;

- (void) getDatacenterStatWinserverVOAsync:(FetchObjectCompletionBlock)completionBlock;
- (void) getBusDomainsListAsync:(FetchObjectCompletionBlock)completionBlock;
- (void) getBusinessListAsync:(FetchObjectCompletionBlock)completionBlock;
- (void) getBusinessListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList;
//- (void) getBusinessAllAsync:(FetchObjectCompletionBlock)completionBlock;
- (void) getBusinessUnallocatedAsync:(FetchObjectCompletionBlock)completionBlock;
- (void) getPoolListAsync:(FetchObjectCompletionBlock)completionBlock;
- (void) getPoolListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList;
- (void) getHostListAsync:(FetchObjectCompletionBlock)completionBlock;
- (void) getHostListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList;
- (void) getVmListAsync:(FetchObjectCompletionBlock)completionBlock;
- (void) getVmListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList;
- (void) getStorageListAsync:(FetchObjectCompletionBlock)completionBlock;
- (void) getStorageListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList;

- (void) getPoolSubVOAsync:(FetchObjectCompletionBlock)completionBlock;

- (void) getHostSubVOAsync:(FetchObjectCompletionBlock)completionBlock;

- (void) getVmSubVOAsync:(FetchObjectCompletionBlock)completionBlock;

- (void) getStorageSubVOAsync:(FetchObjectCompletionBlock)completionBlock;

- (void) getNetworkListAsync:(FetchObjectCompletionBlock)completionBlock withType:(BOOL)isExternal referTo:(NSMutableArray*)referList;

- (void) getIpPoolsAsync:(FetchObjectCompletionBlock)completionBlock;
- (void) getIpPoolsDetailAsync:(FetchObjectCompletionBlock)completionBlock withPoolId:(int)poolId;
- (void) getHostByIdAsync:(FetchObjectCompletionBlock)completionBlock widthHostId:(int)hostid;

- (void) getNetworkIpVmAsync:(FetchObjectCompletionBlock)completionBlock;

@end
