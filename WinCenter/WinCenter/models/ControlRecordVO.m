//
//  ControlRecordVO.m
//  WinCenter-iPad
//
//  Created by 黄茂坚 on 14-9-29.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "ControlRecordVO.h"

@implementation ControlRecordVO

+ (void) getControlRecordListViaObject:(RemoteObject*)remoteObject async:(FetchObjectCompletionBlock)completeBlock referTo:(NSMutableArray*)referList{
    
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completeBlock([[ControlRecordListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ControlRecordVO.getControlRecordListViaObject" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        if(remoteObject==nil){
            [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.task.getList&params=firstResult%%3D%ld%%26maxResult%%3D%ld", [RemoteObject getCurrentDatacenterVO].id, referList.count, referList.count+per_page]];
        }
        else if([remoteObject isKindOfClass:[PoolVO class]]){[simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.task.getList&params=firstResult%%3D%ld%%26maxResult%%3D%ld%%26resPoolId%%3D%d", [RemoteObject getCurrentDatacenterVO].id, referList.count, referList.count+per_page, ((PoolVO*)remoteObject).resourcePoolId]];
        }
        else if([remoteObject isKindOfClass:[HostVO class]]){[simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.task.getList&params=firstResult%%3D%ld%%26maxResult%%3D%ld%%26hostId%%3D%d", [RemoteObject getCurrentDatacenterVO].id, referList.count, referList.count+per_page, ((HostVO*)remoteObject).hostId]];
        }
        else if([remoteObject isKindOfClass:[StorageVO class]]){[simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.task.getList&params=firstResult%%3D%ld%%26maxResult%%3D%ld%%26storagePoolId%%3D%d", [RemoteObject getCurrentDatacenterVO].id, referList.count, referList.count+per_page, ((StorageVO*)remoteObject).storagePoolId]];
        }
        else if([remoteObject isKindOfClass:[VmVO class]]){[simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.task.getList&params=firstResult%%3D%ld%%26maxResult%%3D%ld%%26vmId%%3D%d", [RemoteObject getCurrentDatacenterVO].id, referList.count, referList.count+per_page, ((VmVO*)remoteObject).vmId]];
        }
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completeBlock([[ControlRecordListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

@end
