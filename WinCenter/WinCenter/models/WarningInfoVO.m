//
//  WaringInfoVO.m
//  WinCenter-iPad
//
//  Created by 黄茂坚 on 14-9-29.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "WarningInfoVO.h"

@implementation WarningInfoVO


+ (void) getWarningInfoListViaObject:(RemoteObject*)remoteObject Async:(FetchObjectCompletionBlock)completeBlock referTo:(NSMutableArray*)referList{
    
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completeBlock([[WarningInfoListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"WarningInfoVO.getWarningInfoListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        if(remoteObject==nil){
            [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.warning.getVmWarningList&params=firstResult%%3D%ld%%26maxResult%%3D%ld", [RemoteObject getCurrentDatacenterVO].id, referList.count, referList.count+per_page]];
        }else if([remoteObject isKindOfClass:[PoolVO class]]){
            [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.warning.getVmWarningList&params=objectId%%3D%d%%26objectType%%3DRESOURCE_POOL%%26firstResult%%3D%ld%%26maxResult%%3D%ld", [RemoteObject getCurrentDatacenterVO].id, ((PoolVO*)remoteObject).resourcePoolId, referList.count, referList.count+per_page]];
        }else if([remoteObject isKindOfClass:[HostVO class]]){
            [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.warning.getVmWarningList&params=objectId%%3D%d%%26objectType%%3DHOST%%26firstResult%%3D%ld%%26maxResult%%3D%ld", [RemoteObject getCurrentDatacenterVO].id, ((HostVO*)remoteObject).hostId, referList.count, referList.count+per_page]];
        }else if([remoteObject isKindOfClass:[VmVO class]]){
            [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.warning.getVmWarningList&params=objectId%%3D%d%%26objectType%%3DVM%%26firstResult%%3D%ld%%26maxResult%%3D%ld", [RemoteObject getCurrentDatacenterVO].id, ((VmVO*)remoteObject).vmId, referList.count, referList.count+per_page]];
        }else if([remoteObject isKindOfClass:[StorageVO class]]){
            [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.warning.getVmWarningList&params=objectId%%3D%d%%26objectType%%3DSTORAGE%%26firstResult%%3D%ld%%26maxResult%%3D%ld", [RemoteObject getCurrentDatacenterVO].id, ((StorageVO*)remoteObject).storagePoolId, referList.count, referList.count+per_page]];
        }
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completeBlock([[WarningInfoListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}
-(UIColor*)readed_Color{
    if ([self.readed isEqualToString:@"false"]) {
        return [UIColor redColor];
    }else{
        return [UIColor lightGrayColor];
    }
}
-(NSString*)readed_text{
    if ([self.readed isEqualToString:@"false"]) {
        return @"未读";
    }else{
        return @"已读";
    }
}

@end
