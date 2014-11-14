//
//  storageVO.m
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-28.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import "StorageVO.h"

@implementation StorageVO
-(NSString *)state_text{
    NSDictionary *state_dict = @{
                                 @"OK":@"活动",
                                 @"plugException":@"挂载异常",
                                 @"unPlug":@"未挂载",
                                 @"Pluging":@"挂载中",
                                 @"DeletIng":@"删除中",
                                 @"RemoveIng":@"移除中",
                                 @"UnPlugIng":@"卸载中",
                                 @"DetachIng":@"分离中",
                                 @"ReattachIng":@"连接中"
                                 
                                 };
    NSString *result = [state_dict valueForKey:self.state];
    
    if((result==nil) || [result isEqualToString:@""]){
        result = self.state;
    }
    return result;
}
- (UIColor *)state_color{
    if([self.state isEqualToString:@"OK"]){
        return PNGreen;
    }else if([self.state isEqualToString:@"unPlug"]){
        return [UIColor lightGrayColor];
    }else{
        return PNYellow;
    }
}
-(NSString *)shared_text{
    NSDictionary *shared_dict = @{
                                 @"false":@"非共享",
                                 @"true":@"共享"
                                 };
    NSString *result = [shared_dict valueForKey:self.shared];
    
    if((result==nil) || [result isEqualToString:@""]){
        result = self.shared;
    }
    return result;
}


-(float)usedRatio{
    if (self.totalStorage == 0) {
        return 0;
    }else{
        return (self.totalStorage - self.availStorage)/self.totalStorage*100;
    }
    
}

-(UIColor *)usedRatioColor{
    float ratio = [self usedRatio];
    if(ratio>80){
        return PNRed;
    }else if(ratio>60){
        return PNYellow;
    }else{
        return PNGreen;
    }
}

-(float)allocatedRatio{
    if (self.totalStorage == 0) {
        return 0;
    }else{
        return self.allocatedStorage/self.totalStorage*100;
    }
    
}

-(UIColor *)allocatedRatioColor{
    float ratio = [self allocatedRatio];
    if(ratio>80){
        return PNRed;
    }else if(ratio>60){
        return PNYellow;
    }else{
        return PNGreen;
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

- (float)allocatedStorage_value{
    if(self.allocatedStorage > 1024.0 ){
        return (self.allocatedStorage/1024.0);
    }else{
        return self.allocatedStorage;
    }
    
}
- (NSString*)allocatedStorage_unit{
    if(self.allocatedStorage > 1024.0 ){
        return @"TB";
    }else{
        return @"GB";
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

- (void) getStorageVOAsync:(FetchObjectCompletionBlock)completeBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completeBlock([[StorageVO alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StorageVO.getStorageVOAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.storage.storageDetail&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id, self.storagePoolId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completeBlock([[StorageVO alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getStorageVolumnListAsync:(FetchObjectCompletionBlock)completeBlock referTo:(NSMutableArray*)referList{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completeBlock([[StorageVolumnListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StorageVO.getStorageVolumnListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.volumn.getVolumns&params=storagePoolId%%3D%d%%26firstResult%%3D%ld%%26maxResult%%3D%ld", [RemoteObject getCurrentDatacenterVO].id, self.storagePoolId, referList.count, referList.count+per_page]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completeBlock([[StorageVolumnListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}
-(NSString *)is_shared{
    if (![self.shared isEqualToString:@"true"]) {
        return @"是";
    }else{
        return @"否";
    }
}
-(NSString *)is_defaulted{
    if (![self.defaulted isEqualToString:@"true"]) {
        return @"是";
    }else{
        return @"否";
    }
}
-(NSString *)type_text{
    NSString *str = self.type;
    if([str isEqualToString:@"lvm"]){
        return @"本地LVM";
    }else if([str isEqualToString:@"udev"]){
        return @"可移动存储";
    }else if([str isEqualToString:@"lvmoiscsi"]){
        return @"iSCSI";
    }else if([str isEqualToString:@"nfs"]){
        return @"NFS";
    }else if([str isEqualToString:@"lvmohba"]){
        return @"FC SAN";
    }else{
        return [str uppercaseString];
    }
}

@end
