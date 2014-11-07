//
//  DatacenterVO.m
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-27.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import "DatacenterVO.h"

@implementation DatacenterVO

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:[NSNumber numberWithInt:self.id] forKey:@"id"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.id = ((NSNumber*)[aDecoder decodeObjectForKey:@"id"]).intValue;
    }
    return self;
}

+ (void) getDatacenterListAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[DatacenterListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getDatacenterListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:@"/pc/rm/dataCenters"];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[DatacenterListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getDatacenterStatWinserverVOAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[DatacenterStatVO alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getDatacenterStatWinserverVOAsync" ofType:@"json"]]].winserver, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.api.dataCenter.getDataCenterResource", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[DatacenterStatVO alloc] initWithJSONData:jsonResponse.rawBody].winserver, error);
    }];
}

- (void) getBusinessListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[BusinessListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getBusinessListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.wce.vApp.getVApps&params=firstResult%%3D%ld%%26maxResult%%3D%ld", self.id, referList.count, referList.count+per_page]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[BusinessListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getBusinessListAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[BusinessListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getBusinessListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.wce.vApp.getVApps", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[BusinessListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getBusDomainsListAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[BusDomainsListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getBusDomainsListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=0&apiKey=pc.api.busDomain.getBusDom&params=firstResult%%3D0%%26maxResult%%3D12%%26dataCenterId%%3D%d", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[BusDomainsListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}


- (void) getBusinessUnallocatedAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[BusinessListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getBusinessUnalloctedListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.wce.vApp.getVApps&params=busDomainId=null", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[BusinessListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
    
}

- (void) getPoolListAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[PoolListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getPoolListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.resourcePool.getResourcePools", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[PoolListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}
- (void) getPoolListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[PoolListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getPoolListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.resourcePool.getResourcePools&params=firstResult%%3D%ld%%26maxResult%%3D%ld", self.id, referList.count, referList.count+per_page]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[PoolListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getHostListAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[HostListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getHostListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.host.getHosts", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[HostListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
    
}

- (void) getHostListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[HostListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getHostListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.host.getHosts&params=firstResult%%3D%ld%%26maxResult%%3D%ld", self.id, referList.count, referList.count+per_page]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[HostListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
    
}

- (void) getVmListAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[VmListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getVmListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.vm.list", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[VmListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
    
}

- (void) getVmListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[VmListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getVmListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.vm.list&params=firstResult%%3D%ld%%26maxResult%%3D%ld", self.id, referList.count, referList.count+per_page]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[VmListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
    
}

- (void) getStorageListAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[StorageListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getStorageListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.storage.storagePools", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[StorageListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
    
}

- (void) getStorageListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[StorageListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getStorageListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.storage.storagePools&params=firstResult%%3D%ld%%26maxResult%%3D%ld", self.id, referList.count, referList.count+per_page]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[StorageListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
    
}

- (void) getPoolSubVOAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[PoolSubVO alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PoolSubVO.getPoolSubInfoAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.resourcePool.resoucePoolParams", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[PoolSubVO alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getHostSubVOAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[HostSubVO alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HostSubVO.getHostSubInfoAsync" ofType:@"json"]]].state, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.host.hostParams", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[HostSubVO alloc] initWithJSONData:jsonResponse.rawBody].state, error);
    }];
}


- (void) getVmSubVOAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[VmSubVO alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"VmSubVO.getVmSubInfoAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.vm.vmParams", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[VmSubVO alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getStorageSubVOAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[StorageSubVO alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StorageSubVO.getStorageSubInfoAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.storage.storageParams", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[StorageSubVO alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getNetworkListAsync:(FetchObjectCompletionBlock)completionBlock withType:(BOOL)isExternal referTo:(NSMutableArray*)referList{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[NetworkListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Network.getOutsideAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.network.getNetWorksList&params=type%%3D%@%%26firstResult%%3D%ld%%26maxResult%%3D%ld", self.id, (isExternal ? @"EXTERNAL" : @"INTERNAL"),  referList.count, referList.count+per_page]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[NetworkListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getIpPoolsAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[IpPoolsListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NetworkVO.getIpPoolsAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=0&apiKey=pc.api.ipPool.getIpPools"]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[IpPoolsListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getIpPoolsDetailAsync:(FetchObjectCompletionBlock)completionBlock withPoolId:(int)poolId{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[IpPoolsListDetailResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NetworkVO.getIpPoolsDetailAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=0&apiKey=pc.api.ipPool.getIpByPool&placeholder=%d", poolId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[IpPoolsListDetailResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getNetworkIpVmAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[NetworkIpVmListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NetworkVO.getNetworkIpVmAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.vm.getList", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[NetworkIpVmListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getHostByIdAsync:(FetchObjectCompletionBlock)completionBlock widthHostId:(int)hostid{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[HostVO alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HostVO.getHostVOAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.host.getHostById&apiType=GET&placeholder=%d",[RemoteObject getCurrentDatacenterVO].id, hostid]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[HostVO alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

@end
