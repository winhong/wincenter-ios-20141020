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

- (float)totalCpu_value{
    if(self.totalCpu > 1000.0 ){
        return (self.totalCpu/1000.0);
    }else{
        return self.totalCpu;
    }
    
}
- (NSString*)totalCpu_unit{
    if(self.totalCpu > 1000.0 ){
        return @"GHz";
    }else{
        return @"MHz";
    }
    
}

- (float)totalStorage_value{
    if(self.totalStorage > 1024.0 ){
        return (self.totalStorage/1024.0);
    }else{
        return self.totalStorage;
    }
    
}
- (NSString*)totalStorage_unit{
    if(self.totalStorage > 1024.0 ){
        return @"TB";
    }else{
        return @"GB";
    }
    
}

- (float)availCpu_value{
    if(self.availCpu > 1000.0 ){
        return (self.availCpu/1000.0);
    }else{
        return self.availCpu;
    }
    
}
- (NSString*)availCpu_unit{
    if(self.availCpu > 1000.0 ){
        return @"GHz";
    }else{
        return @"MHz";
    }
    
}

- (float)availStorage_value{
    if(self.availStorage > 1024.0 ){
        return (self.availStorage/1024.0);
    }else{
        return self.availStorage;
    }
    
}
- (NSString*)availStorage_unit{
    if(self.availStorage > 1024.0 ){
        return @"TB";
    }else{
        return @"GB";
    }
    
}

- (float)usedCpu_value{
    if((self.totalCpu - self.availCpu) > 1000.0 ){
        return ((self.totalCpu - self.availCpu)/1000.0);
    }else{
        return (self.totalCpu - self.availCpu);
    }
    
}
- (NSString*)usedCpu_unit{
    if((self.totalCpu - self.availCpu) > 1000.0 ){
        return @"GHz";
    }else{
        return @"MHz";
    }
    
}

- (float)usedStorage_value{
    if((self.totalStorage -self.availStorage) > 1024.0 ){
        return ((self.totalStorage -self.availStorage)/1024.0);
    }else{
        return (self.totalStorage -self.availStorage);
    }
    
}
- (NSString*)usedStorage_unit{
    if((self.totalStorage -self.availStorage) > 1024.0 ){
        return @"TB";
    }else{
        return @"GB";
    }
    
}

-(NSString*)hypervisor_text{
    if ([self.hypervisor isEqualToString:@"winserver"]) {
        return @"WinServer";
    }else{
        return self.hypervisor;
    }
}

- (void) getPoolVOSync:(FetchObjectCompletionBlock)completeBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completeBlock([[PoolVO alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PoolVO.getPoolVOAsync" ofType:@"json"]]], nil);
        return;
    }
    
    UNIHTTPJsonResponse *jsonResponse = [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.resourcePool.getResourcePool&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id, self.resourcePoolId]];
    }] asJson:nil];
    
    completeBlock([[PoolVO alloc] initWithJSONData:jsonResponse.rawBody], nil);
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
- (void) getHostListAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[HostListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PoolVO.getHostListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.host.queryHostByPool&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id, self.resourcePoolId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[HostListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getHostListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[HostListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PoolVO.getHostListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.host.queryHostByPool&placeholder=%d&params=firstResult%%3D%ld%%26maxResult%%3D%ld", [RemoteObject getCurrentDatacenterVO].id, self.resourcePoolId, referList.count, referList.count+per_page]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[HostListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getStorageListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[StorageListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PoolVO.getStorageListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.storage.storagePools&params=resourcePoolId%%3D%d%%26firstResult%%3D%ld%%26maxResult%%3D%ld", [RemoteObject getCurrentDatacenterVO].id, self.resourcePoolId, referList.count, referList.count+per_page]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[StorageListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getVmListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[VmListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PoolVO.getVmListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.vm.getList&params=poolId%%3D%d%%26firstResult%%3D%ld%%26maxResult%%3D%ld", [RemoteObject getCurrentDatacenterVO].id, self.resourcePoolId, referList.count, referList.count+per_page]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[VmListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getHaMaxHostFailuresAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[PoolMaxHostFailuresVO alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PoolVO.getMaxHostFailuresAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.ha.getResPoolUsability&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id, self.resourcePoolId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[PoolMaxHostFailuresVO alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getHaInfoAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[PoolHaInfoVO alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PoolVO.getHaInfoAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.ha.getResPoolUsability&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id, self.resourcePoolId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[PoolHaInfoVO alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getStoragePoolAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[PoolStoragesVO alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PoolVO.getStoragePoolAsync" ofType:@"json"]]].storages, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.ha.getResPoolStorage&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id, self.resourcePoolId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[PoolStoragesVO alloc] initWithJSONData:jsonResponse.rawBody].storages, error);
    }];
}

@end
