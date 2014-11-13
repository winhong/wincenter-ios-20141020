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
                                @"OK":@"运行中",
                                @"DISCONNECT":@"故障",
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
        return PNBlue;
    }
}


- (float)localStorage_value{
    if(self.localStorage > 1024.0 ){
        return (self.localStorage/1024.0);
    }else{
        return self.localStorage;
    }
    
}
- (NSString*)localStorage_unit{
    if(self.localStorage > 1024.0 ){
        return @"TB";
    }else{
        return @"GB";
    }
    
}

- (float)storage_value{
    if(self.storage > 1024.0 ){
        return (self.storage/1024.0);
    }else{
        return self.storage;
    }
    
}
- (NSString*)storage_unit{
    if(self.storage > 1024.0 ){
        return @"TB";
    }else{
        return @"GB";
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

- (void) getHostNetworkListAsync:(FetchObjectCompletionBlock)completionBlock withType:(BOOL)isExternal referTo:(NSMutableArray*)referList{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[HostNetworkListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HostVO.getHostNetworkExternalListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.network.getNetWorksList&params=hostId%%3D%d%%26type%%3D%@%%26firstResult%%3D%ld%%26maxResult%%3D%ld", [RemoteObject getCurrentDatacenterVO].id, self.hostId, (isExternal ? @"EXTERNAL" : @"INTERNAL"), referList.count, referList.count+per_page]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[HostNetworkListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getHostNetworkListAllAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[HostNetworkListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HostVO.getHostNetworkExternalListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.network.getNetWorksList&params=hostId=%d&firstResult=%d", [RemoteObject getCurrentDatacenterVO].id, self.hostId,0]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[HostNetworkListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getHostNicListAsync:(FetchObjectCompletionBlock)completionBlock withType:(BOOL)isGrouped referTo:(NSMutableArray*)referList{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[HostNicListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HostVO.getHostNicGroupedListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.network.getnetWorkAdaptersList&params=hostId%%3D%d%%26%@%%3DbondModel%%26firstResult%%3D%ld%%26maxResult%%3D%ld", [RemoteObject getCurrentDatacenterVO].id, self.hostId, (!isGrouped ? @"isNull" : @"isNotNull"), referList.count, referList.count+per_page]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[HostNicListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getStorageListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[StorageListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HostVO.getStorageListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.host.storages&placeholder=%d&params=firstResult%%3D%ld%%26maxResult%%3D%ld", [RemoteObject getCurrentDatacenterVO].id, self.hostId, referList.count, referList.count+per_page]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[StorageListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getVmListAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[VmListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HostVO.getVmListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.vm.getList&params=ownerHostId%%3D%d", [RemoteObject getCurrentDatacenterVO].id, self.hostId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[VmListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getVmListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[VmListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HostVO.getVmListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.vm.getList&params=ownerHostId%%3D%d%%26firstResult%%3D%ld%%26maxResult%%3D%ld", [RemoteObject getCurrentDatacenterVO].id, self.hostId, referList.count, referList.count+per_page]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[VmListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
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

- (void) getPerformanceAsync:(FetchObjectCompletionBlock)completionBlock withStartTime:(float)startTime{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        NSData *result = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Host.getPerformanceAsync" ofType:@"json"]];
        NSObject *obj = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        completionBlock(obj, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.host.getHostPerformance&params=startTime=%.f&cf=AVERAGE&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id,startTime, self.hostId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        NSData *result = jsonResponse.rawBody ;
        NSObject *obj = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        completionBlock(obj, nil);

        //completionBlock([[NSString alloc] initWithData:jsonResponse.rawBody encoding:NSUTF8StringEncoding], error);
    }];
}
@end
