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
                                 @"unPlug":@"未挂载"
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
    return (self.totalStorage - self.availStorage)/self.totalStorage*100;
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
    return self.allocatedStorage/self.totalStorage*100;
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

- (void) getStorageVolumnListAsync:(FetchAllCompletionBlock)completeBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completeBlock([[StorageVolumnListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StorageVO.getStorageVolumnListAsync" ofType:@"json"]]].resultList, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.volumn.getVolumns&params=storagePoolId%%3D%d", [RemoteObject getCurrentDatacenterVO].id, self.storagePoolId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completeBlock([[StorageVolumnListResult alloc] initWithJSONData:jsonResponse.rawBody].resultList, error);
    }];
}


@end
