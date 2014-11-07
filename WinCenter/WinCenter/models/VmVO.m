//
//  vmVO.m
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-29.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import "VmVO.h"

@implementation VmVO

- (NSString *) isInstallTools_text{
    return ([self.isInstallTools isEqualToString:@"true"] ? @"已安装" : @"未安装");
}
- (NSString*)osType_imageName{

    if([self.osType rangeOfString:@"window" options:NSCaseInsensitiveSearch].length>0){
        return @"os-win";
    }else if([self.osType rangeOfString:@"cent" options:NSCaseInsensitiveSearch].length>0){
        return @"os-centos";
    }else if([self.osType rangeOfString:@"suse" options:NSCaseInsensitiveSearch].length>0){
        return @"os-suse";
    }else if([self.osType rangeOfString:@"hat" options:NSCaseInsensitiveSearch].length>0){
        return @"os-redhat";
    }else{
        return @"os-others";
    }
    
}
- (NSString*)osType_imageName_big{
    
    if([self.osType rangeOfString:@"window" options:NSCaseInsensitiveSearch].length>0){
        return @"os-win-big";
    }else if([self.osType rangeOfString:@"cent" options:NSCaseInsensitiveSearch].length>0){
        return @"os-centos-big";
    }else if([self.osType rangeOfString:@"suse" options:NSCaseInsensitiveSearch].length>0){
        return @"os-suse-big";
    }else if([self.osType rangeOfString:@"hat" options:NSCaseInsensitiveSearch].length>0){
        return @"os-redhat-big";
    }else{
        return @"os-others-big";
    }
    
}
- (NSString*)state_text{
    NSDictionary *stateDict = @{
        @"OK":@"运行中",
        @"EXECUTING":@"部署中",
        @"CREATED":@"待部署",
        @"STARTING":@"正在启动",
        @"STOPPED":@"已关机",
        @"STOPPING":@"关机中",
        @"DELETING":@"删除中",
        @"RESIZING":@"调整中",
        @"RESTARTING":@"重启中",
        @"CONVERTING":@"转换中",
        @"RESUMEING":@"恢复中",
        @"SUSPENDING":@"挂起中",
        @"SUSPENDED":@"挂起",
        @"UNKNOWN":@"未知",
        @"CONVERTING":@"转换中",
        @"RELOCATING":@"迁移中",
        @"BACKUPING":@"备份中",
        @"RESTORING":@"还原中",
        @"SNAPSHOT_ADDING":@"创建快照中",
        @"SNAPSHOT_DELING":@"删除快照中",
        @"SNAPSHOT_RECOVERING":@"快照还原中",
        @"RENAMEING":@"修改名称中",
        @"EXPORTING":@"导出中",
        @"UN_MOUNTING_ISO":@"弹出iso中",
        @"MOUNTING_ISO":@"挂载iso中",
        @"CLONING":@"正在克隆",
        @"SAVE_AS_TEMPLATE":@"另存为模板中"
    };
    
    
    NSString *result = [stateDict valueForKey:[self.state uppercaseString]];
    if((result==nil) || [result isEqualToString:@""]){
        result = self.state;
    }
    return result;
}

- (UIColor *)state_color{
    if([self.state isEqualToString:@"OK"]){
        return PNGreen;
    }else if([self.state isEqualToString:@"STOPPED"]){
        return [UIColor lightGrayColor];
    }else{
        return PNBlue;
    }
}

- (NSString *)memoryType_text{
    NSDictionary *dict = @{
                                @"shared":@"共享",
                                @"privilege":@"专享",
                                @"reservation":@"预留",
                                @"custom":@"自定义调整"
                                };
    
    
    NSString *result = [dict valueForKey:self.memoryType];
    if((result==nil) || [result isEqualToString:@""]){
        result = self.memoryType;
    }
    return result;
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

- (void) getVmVOAsync:(FetchObjectCompletionBlock)completeBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completeBlock([[VmVO alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"VmVO.getVmVOAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.vm.vminfo&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id, self.vmId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completeBlock([[VmVO alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getVmVolumnListAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[VmDiskListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"VmVO.getVmVolumnListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.vm.getVolumes&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id, self.vmId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[VmDiskListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getVmVolumnListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[VmDiskListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"VmVO.getVmVolumnListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.vm.getVolumes&placeholder=%d&params=firstResult%%3D%ld%%26maxResult%%3D%ld", [RemoteObject getCurrentDatacenterVO].id, self.vmId, referList.count, referList.count+per_page]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[VmDiskListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}
/////////
- (void) getVmIsoListAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[VmIsoListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"VmVO.getVmIsoListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.vm.getVmIsos&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id, self.vmId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[VmIsoListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getVmIsoListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[VmIsoListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"VmVO.getVmIsoListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.vm.getVmIsos&placeholder=%d&params=firstResult%%3D%ld%%26maxResult%%3D%ld", [RemoteObject getCurrentDatacenterVO].id, self.vmId, referList.count, referList.count+per_page]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[VmIsoListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}
//////////
- (void) getVmNicListAsync:(FetchObjectCompletionBlock)completionBlock withType:(BOOL)isExternal referTo:(NSMutableArray*)referList{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completionBlock([[VmNetworkListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"VmVO.getVmNicListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.vm.getNics&placeholder=%d&params=type%%3D%@%%26firstResult%%3D%ld%%26maxResult%%3D%ld", [RemoteObject getCurrentDatacenterVO].id, self.vmId, (isExternal ? @"EXTERNAL" : @"INTERNAL"), referList.count, referList.count+per_page]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[VmNetworkListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}


- (void) vmRestart:(BasicCompletionBlock)completionBlock{
    [[UNIRest post:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet"]];
        [simpleRequest setParameters:@{@"connectorId":[NSString stringWithFormat:@"%d", [RemoteObject getCurrentDatacenterVO].id],
                                       @"apiKey":@"pc.winserver.vm.vminfoReStart",
                                       @"placeholder": [NSString stringWithFormat:@"%d", self.vmId],
                                       @"content": @"{\"state\":\"RESTART\"}",
                                       @"apiType": @"PUT"}];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock(error);
    }];
}

- (void) vmStart:(BasicCompletionBlock)completionBlock{
    [[UNIRest post:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet"]];
        [simpleRequest setParameters:@{@"connectorId":[NSString stringWithFormat:@"%d", [RemoteObject getCurrentDatacenterVO].id],
                                       @"apiKey":@"pc.winserver.vm.vminfoPowerOn",
                                       @"placeholder": [NSString stringWithFormat:@"%d", self.vmId],
                                       @"content": @"{\"state\":\"OK\"}",
                                       @"apiType": @"PUT"}];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock(error);
    }];
}

- (void) vmStop:(BasicCompletionBlock)completionBlock{
    [[UNIRest post:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet"]];
        [simpleRequest setParameters:@{@"connectorId":[NSString stringWithFormat:@"%d", [RemoteObject getCurrentDatacenterVO].id],
                                       @"apiKey":@"pc.winserver.vm.vminfoPowerOff",
                                       @"placeholder": [NSString stringWithFormat:@"%d", self.vmId],
                                       @"content": @"{\"state\":\"STOPPED\"}",
                                       @"apiType": @"PUT"}];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
            completionBlock(error);
    }];
}

- (void) vmGetMigrateTargets:(FetchObjectCompletionBlock)completionBlock{
    [[UNIRest post:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet"]];
        [simpleRequest setParameters:@{@"connectorId":[NSString stringWithFormat:@"%d", [RemoteObject getCurrentDatacenterVO].id],
                                       @"apiKey":@"pc.winserver.vm.migrateTargets",
                                       @"placeholder": [NSString stringWithFormat:@"%d", self.vmId],
                                       @"params": @"migrateType=vm",
                                       @"apiType": @"GET"}];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock([[VmMigrateTargetsVO alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];

}

- (void) vmMigrate:(BasicCompletionBlock)completionBlock widthTargetHostId:(int)hostId{
    [[UNIRest post:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet"]];
        [simpleRequest setParameters:@{@"connectorId":[NSString stringWithFormat:@"%d", [RemoteObject getCurrentDatacenterVO].id],
                                       @"apiKey":@"pc.winserver.vm.migrate",
                                       @"placeholder": [NSString stringWithFormat:@"%d", self.vmId],
                                       @"content": [NSString stringWithFormat:@"{\"hostId\":\"%d\",\"migrateType\":\"vm\"}",hostId],
                                       @"apiType": @"PUT"}];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock(error);
    }];
    
}

- (void) vmConfigCPU:(BasicCompletionBlock)completionBlock withVCPU:(int)vcpu withCPUCap:(int)cpuCap withCPUWeight:(int)cpuWeight{
    [[UNIRest post:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet"]];
        [simpleRequest setParameters:@{@"connectorId":[NSString stringWithFormat:@"%d", [RemoteObject getCurrentDatacenterVO].id],
                                       @"apiKey":@"pc.winserver.vm.vminfoResizeCpu",
                                       @"placeholder": [NSString stringWithFormat:@"%d", self.vmId],
                                       @"content": [NSString stringWithFormat:@"{\"state\":\"RESIZE\",\"vcpu\":\"%d\",\"cpuCap\":\"%d\",\"cpuWeight\":%d}",vcpu,cpuCap,cpuWeight],
                                       @"apiType": @"PUT"}];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock(error);
    }];
    
}

- (void) vmConfigMemory:(BasicCompletionBlock)completionBlock withReservation:(int)reservation withMinMem:(int)minMem{
    [[UNIRest post:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet"]];
        [simpleRequest setParameters:@{@"connectorId":[NSString stringWithFormat:@"%d", [RemoteObject getCurrentDatacenterVO].id],
                                       @"apiKey":@"pc.winserver.vm.vminfoResizeMem",
                                       @"placeholder": [NSString stringWithFormat:@"%d", self.vmId],
                                       @"content": [NSString stringWithFormat:@"{\"state\":\"RESIZE\",\"reservation\":\"%d\",\"minMem\":\"%d\"}",reservation,minMem],
                                       @"apiType": @"PUT"}];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completionBlock(error);
    }];
    
}

- (void) getRaphaelAsync:(FetchObjectCompletionBlock)completionBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        NSData *result = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"VmVO.getVmSnashotAsync.josn" ofType:@"json"]];
        NSObject *obj = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        completionBlock(obj, nil);
        return;
    }
    
    [[UNIRest post:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet"]];
        [simpleRequest setParameters:@{@"connectorId":[NSString stringWithFormat:@"%d", [RemoteObject getCurrentDatacenterVO].id],
                                       @"apiKey":@"pc.winserver.snapShot.getSnapShots",
                                       @"placeholder": @"",
                                       @"params": [NSString stringWithFormat:@"vmId=%d",self.vmId],
                                       @"apiType": @"GET"}];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        NSData *result = jsonResponse.rawBody ;
        //NSObject *obj = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSString *objStr = [[NSString alloc]initWithData:result  encoding:NSUTF8StringEncoding];
        completionBlock(objStr, nil);
    }];
}

- (void) getPerformanceAsync:(FetchObjectCompletionBlock)completionBlock withStartTime:(float)startTime{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        NSData *result = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"VmVO.getPerformanceAsync" ofType:@"json"]];
        NSObject *obj = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        completionBlock(obj, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.vm.getVmPerformance&params=startTime=%.f&cf=AVERAGE&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id,startTime, self.vmId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        NSData *result = jsonResponse.rawBody ;
        NSObject *obj = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        completionBlock(obj, nil);
        
        //completionBlock([[NSString alloc] initWithData:jsonResponse.rawBody encoding:NSUTF8StringEncoding], error);
    }];
}

- (BOOL) isDynamicCpu_img{
    if ([self.isDynamicCpu isEqualToString:@"true"]) {
        return YES;
    }else{
        return NO;
    }
}
- (BOOL) isDynamicMemWce_img{
    if ([self.isDynamicMem isEqualToString:@"true"]) {
        return YES;
    }else{
        return NO;
    }
}


@end
