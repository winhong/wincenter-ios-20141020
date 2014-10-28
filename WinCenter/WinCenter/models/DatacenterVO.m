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

+ (void) getDatacenterListAsync:(FetchAllCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[DatacenterListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getDatacenterListAsync" ofType:@"json"]]].dataCenters, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:@"/pc/rm/dataCenters"];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[DatacenterListResult alloc] initWithJSONData:jsonResponse.rawBody].dataCenters, error);
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

- (void) getBusinessListAsync:(FetchAllCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[BusinessListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getBusinessListAsync" ofType:@"json"]]].resultList, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.wce.vApp.getVApps", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[BusinessListResult alloc] initWithJSONData:jsonResponse.rawBody].resultList, error);
    }];
}

- (void) getBusinessListAsync:(FetchAllCompletionBlock)completionBlock limit:(int)count{
    if(count==0){
        return [self getBusinessListAsync:completionBlock];
    }
    
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[BusinessListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getBusinessListAsync.limit" ofType:@"json"]]].resultList, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.wce.vApp.getVApps&params=firstResult%%3D0%%26maxResult%%3D%d", self.id, count]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[BusinessListResult alloc] initWithJSONData:jsonResponse.rawBody].resultList, error);
    }];
}

- (void) getPoolListAsync:(FetchAllCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[PoolListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getPoolListAsync" ofType:@"json"]]].resourcePools, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.resourcePool.getResourcePools", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[PoolListResult alloc] initWithJSONData:jsonResponse.rawBody].resourcePools, error);
    }];
}
- (void) getPoolListAsync:(FetchAllCompletionBlock)completionBlock limit:(int)count{
    
    if(count==0){
        return [self getPoolListAsync:completionBlock];
    }
    
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[PoolListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getPoolListAsync.limit" ofType:@"json"]]].resourcePools, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.resourcePool.getResourcePools&params=firstResult%%3D0%%26maxResult%%3D%d", self.id, count]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[PoolListResult alloc] initWithJSONData:jsonResponse.rawBody].resourcePools, error);
    }];
}

- (void) getHostListAsync:(FetchAllCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[HostListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getHostListAsync" ofType:@"json"]]].hosts, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.host.getHosts", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[HostListResult alloc] initWithJSONData:jsonResponse.rawBody].hosts, error);
    }];
    
}

- (void) getHostListAsync:(FetchAllCompletionBlock)completionBlock limit:(int)count{
    
    if(count==0){
        return [self getHostListAsync:completionBlock];
    }
    
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[HostListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getHostListAsync.limit" ofType:@"json"]]].hosts, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.host.getHosts&params=firstResult%%3D0%%26maxResult%%3D%d", self.id, count]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[HostListResult alloc] initWithJSONData:jsonResponse.rawBody].hosts, error);
    }];
    
}


- (void) getVmListAsync:(FetchAllCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[VmListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getVmListAsync" ofType:@"json"]]].vms, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.vm.list", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[VmListResult alloc] initWithJSONData:jsonResponse.rawBody].vms, error);
    }];
    
}

- (void) getVmListAsync:(FetchAllCompletionBlock)completionBlock limit:(int)count{
    
    if(count==0){
        return [self getVmListAsync:completionBlock];
    }
    
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[VmListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getVmListAsync.limit" ofType:@"json"]]].vms, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.vm.list&params=firstResult%%3D0%%26maxResult%%3D%d", self.id, count]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[VmListResult alloc] initWithJSONData:jsonResponse.rawBody].vms, error);
    }];
    
}


- (void) getStorageListAsync:(FetchAllCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[StorageListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getStorageListAsync" ofType:@"json"]]].resultList, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.storage.storagePools", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[StorageListResult alloc] initWithJSONData:jsonResponse.rawBody].resultList, error);
    }];
    
}

- (void) getStorageListAsync:(FetchAllCompletionBlock)completionBlock limit:(int)count{
    
    if(count==0){
        return [self getStorageListAsync:completionBlock];
    }
    
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[StorageListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getStorageListAsync.limit" ofType:@"json"]]].resultList, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.storage.storagePools&params=firstResult%%3D0%%26maxResult%%3D%d", self.id, count]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[StorageListResult alloc] initWithJSONData:jsonResponse.rawBody].resultList, error);
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

- (void) getBusinessAllAsync:(FetchAllCompletionBlock)completionBlock{
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

- (void) getBusinessUnallocatedAsync:(FetchAllCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[BusinessListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DatacenterVO.getBusinessUnalloctedListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.wce.vApp.getVApps&BusDomainId=null", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[BusinessListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];

}

- (void) getNetworkInsideAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[NetworkListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Network.getInsideAsync" ofType:@"json"]]].networks, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.network.getNetWorksList&params=type=INTERNAL", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[NetworkListResult alloc] initWithJSONData:jsonResponse.rawBody].networks, error);
    }];
}

- (void) getNetworkOutsideAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[NetworkListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Network.getOutsideAsync" ofType:@"json"]]].networks, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.network.getNetWorksList&params=type=EXTERNAL", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[NetworkListResult alloc] initWithJSONData:jsonResponse.rawBody].networks, error);
    }];
}

- (void) getIpPoolsAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[IpPoolsListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NetworkVO.getIpPoolsAsync" ofType:@"json"]]].ipPools, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.api.ipPool.getIpPools", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[IpPoolsListResult alloc] initWithJSONData:jsonResponse.rawBody].ipPools, error);
    }];
}

- (void) getNetworkIpVmAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[NetworkIpVmListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Network.getIpPoolsAsync" ofType:@"json"]]].ipPools, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.api.ipPool.getIpPools", self.id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[IpPoolsListResult alloc] initWithJSONData:jsonResponse.rawBody].ipPools, error);
    }];
}

@end
