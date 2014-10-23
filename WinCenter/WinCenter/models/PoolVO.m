//
//  PoolVO.m
//  0805
//
//  Created by 黄茂坚 on 14-8-5.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import "PoolVO.h"

@implementation PoolVO

-(NSString*)versionDate_text{
    NSDate *Runtime = [[NSDate alloc]initWithTimeIntervalSince1970:self.versionDate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:Runtime];
}

-(float)cpuRatio{
    return (self.totalCpu-self.availCpu)/self.totalCpu*100;
}

-(UIColor *)cpuRatioColor{
    float ratio = [self cpuRatio];
    if(ratio>80){
        return PNRed;
    }else if(ratio>60){
        return PNYellow;
    }else{
        return PNGreen;
    }
}


-(float)memoryRatio{
    return (self.totalMemory-self.availMemory)/self.totalMemory*100;
}

-(UIColor *)memoryRatioColor{
    float ratio = [self memoryRatio];
    if(ratio>80){
        return PNRed;
    }else if(ratio>60){
        return PNYellow;
    }else{
        return PNGreen;
    }
}

-(float)storageRatio{
    return (self.totalStorage-self.availStorage)/self.totalStorage*100;
}

-(UIColor *)storageRatioColor{
    float ratio = [self storageRatio];
    if(ratio>80){
        return PNRed;
    }else if(ratio>60){
        return PNYellow;
    }else{
        return PNGreen;
    }
}

- (void) getPoolVOAsync:(FetchObjectCompletionBlock)completeBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completeBlock([[PoolVO alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PoolVO.getPoolVOAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.resourcePool.getResourcePool&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id, self.resourcePoolId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completeBlock([[PoolVO alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getPoolElasticAsync:(FetchObjectCompletionBlock)completeBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completeBlock([[PoolElasticInfo alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PoolVO.getPoolElasticAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.wlb.getInfo&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id, self.resourcePoolId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completeBlock([[PoolElasticInfo alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}


- (NSArray *) getHostLisWithlimit:(int)count error:(NSError **)error{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        return [[HostListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PoolVO.getHostLisWithlimit" ofType:@"json"]]].hosts;
    }
    
    UNIHTTPJsonResponse *jsonResponse = [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.host.queryHostByPool&placeholder=%d&params=resourcePoolId%%3D%d", [RemoteObject getCurrentDatacenterVO].id, self.resourcePoolId, count]];
    }] asJson:nil];
    return [[HostListResult alloc] initWithJSONData:jsonResponse.rawBody].hosts;
}
- (void) getHostListAsync:(FetchAllCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[HostListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PoolVO.getHostListAsync" ofType:@"json"]]].hosts, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.host.queryHostByPool&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id, self.resourcePoolId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[HostListResult alloc] initWithJSONData:jsonResponse.rawBody].hosts, error);
    }];
}

- (NSArray *) getStorageList:(NSError **)error{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        return [[StorageListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PoolVO.getStorageList" ofType:@"json"]]].resultList;
    }
    
    UNIHTTPJsonResponse *jsonResponse = [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.storage.storagePools&params=resourcePoolId%%3D%d", [RemoteObject getCurrentDatacenterVO].id, self.resourcePoolId]];
    }] asJson:nil];
    return [[StorageListResult alloc] initWithJSONData:jsonResponse.rawBody].resultList;
}

- (void) getStorageListAsync:(FetchAllCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[StorageListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PoolVO.getStorageListAsync" ofType:@"json"]]].resultList, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.storage.storagePools&params=resourcePoolId%%3D%d", [RemoteObject getCurrentDatacenterVO].id, self.resourcePoolId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[StorageListResult alloc] initWithJSONData:jsonResponse.rawBody].resultList, error);
    }];
}

- (NSArray *) getVmListWithlimit:(int)count error:(NSError **)error{
    //if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        return [[VmListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PoolVO.getVmListWithlimit" ofType:@"json"]]].vms;
    //}
    
    UNIHTTPJsonResponse *jsonResponse = [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.vm.getList&params=poolId%%3D%d%%26firstResult%%3D0%%26maxResult%%3D%d", [RemoteObject getCurrentDatacenterVO].id, self.resourcePoolId, 7]];
    }] asJson:nil];
    
    return [[VmListResult alloc] initWithJSONData:jsonResponse.rawBody].vms;
}
- (void) getVmListAsync:(FetchAllCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[VmListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PoolVO.getVmListAsync" ofType:@"json"]]].vms, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.vm.getList&params=poolId%%3D%d", [RemoteObject getCurrentDatacenterVO].id, self.resourcePoolId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[VmListResult alloc] initWithJSONData:jsonResponse.rawBody].vms, error);
    }];
}


@end
