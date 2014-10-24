//
//  HostVO.m
//  0805
//
//  Created by 黄茂坚 on 14-8-5.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import "HostVO.h"

@implementation HostVO
- (NSString*)state_text{
    NSDictionary *stateDict = @{
                                @"OK":@"开机",
                                @"DISCONNECT":@"离线",
                                @"MAINTAIN":@"维护",
                                @"RESTART":@"重启"
                                };
    
    NSString *result = [stateDict valueForKey:self.state];
    if((result==nil) || [result isEqualToString:@""]){
        result = self.state;
    }
    return result;
}

- (UIColor *)state_color{
    if([self.state isEqualToString:@"OK"]){
        return PNGreen;
    }else if([self.state isEqualToString:@"DISCONNECT"]){
        return [UIColor lightGrayColor];
    }else{
        return PNYellow;
    }
}

- (void) getHostVOAsync:(FetchObjectCompletionBlock)completeBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completeBlock([[HostVO alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HostVO.getHostVOAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.host.getHostById&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id, self.hostId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completeBlock([[HostVO alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getHostStatVOAsync:(FetchObjectCompletionBlock)completeBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completeBlock([[HostStatVO alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HostVO.getHostStatVOAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.host.getHostResourceStats&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id, self.hostId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completeBlock([[HostStatVO alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getHostNetworkExternalListAsync:(FetchAllCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[HostNetworkListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HostVO.getHostNetworkExternalListAsync" ofType:@"json"]]].networks, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.network.getNetWorksList&params=hostId%%3D%d%%26type%%3DEXTERNAL", [RemoteObject getCurrentDatacenterVO].id, self.hostId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[HostNetworkListResult alloc] initWithJSONData:jsonResponse.rawBody].networks, error);
    }];
}

- (void) getHostNetworkInternalListAsync:(FetchAllCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[HostNetworkListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HostVO.getHostNetworkInternalListAsync" ofType:@"json"]]].networks, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.network.getNetWorksList&params=hostId%%3D%d%%26type%%3DINTERNAL", [RemoteObject getCurrentDatacenterVO].id, self.hostId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[HostNetworkListResult alloc] initWithJSONData:jsonResponse.rawBody].networks, error);
    }];
}

- (void) getHostNicUngroupedListAsync:(FetchAllCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[HostNicListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HostVO.getHostNicUngroupedListAsync" ofType:@"json"]]].pnis, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.network.getnetWorkAdaptersList&params=hostId%%3D%d%%26isNotNull%%3DbondModel", [RemoteObject getCurrentDatacenterVO].id, self.hostId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[HostNicListResult alloc] initWithJSONData:jsonResponse.rawBody].pnis, error);
    }];
    
}

- (void) getHostNicGroupedListAsync:(FetchAllCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[HostNicListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HostVO.getHostNicGroupedListAsync" ofType:@"json"]]].pnis, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.network.getnetWorkAdaptersList&params=hostId%%3D%d%%26isNull%%3DbondModel", [RemoteObject getCurrentDatacenterVO].id, self.hostId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[HostNicListResult alloc] initWithJSONData:jsonResponse.rawBody].pnis, error);
    }];
}

- (void) getStorageListAsync:(FetchAllCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[StorageListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HostVO.getStorageListAsync" ofType:@"json"]]].resultList, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.host.storages&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id, self.hostId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[StorageListResult alloc] initWithJSONData:jsonResponse.rawBody].resultList, error);
    }];
}

- (void) getVmListAsync:(FetchAllCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[VmListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HostVO.getVmListAsync" ofType:@"json"]]].vms, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.vm.getList&params=ownerHostId%%3D%d", [RemoteObject getCurrentDatacenterVO].id, self.hostId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[VmListResult alloc] initWithJSONData:jsonResponse.rawBody].vms, error);
    }];
}

- (void) getActivityVmAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[HostActivityVmStateVO alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HostVO.getActivityVmAsync" ofType:@"json"]]].state, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.host.staticVmState&params=ownerHostId%%3D%d&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id, self.hostId,self.hostId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[HostActivityVmStateVO alloc] initWithJSONData:jsonResponse.rawBody].state, error);
    }];
}

- (void) getPerformanceAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        NSData *result = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Host.getPerformanceAsync" ofType:@"json"]];
        NSObject *obj = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        completionBlock(obj, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.vm.getVmPerformance&startTime=1414121919000&cf=AVERAGE&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id, self.hostId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        NSData *result = jsonResponse.rawBody ;
        NSObject *obj = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        completionBlock(obj, nil);

        //completionBlock([[NSString alloc] initWithData:jsonResponse.rawBody encoding:NSUTF8StringEncoding], error);
    }];
}
@end
