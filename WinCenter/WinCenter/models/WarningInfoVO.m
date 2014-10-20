//
//  WaringInfoVO.m
//  WinCenter-iPad
//
//  Created by 黄茂坚 on 14-9-29.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "WarningInfoVO.h"

@implementation WarningInfoVO


+ (void) getWarningInfoListAsync:(FetchAllCompletionBlock)completeBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completeBlock([[WarningInfoListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"WarningInfoVO.getWarningInfoListAsync" ofType:@"json"]]].alarms, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.warning.getVmWarningList&params=firstResult%%3D0%%26maxResult%%3D12", [RemoteObject getCurrentDatacenterVO].id]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completeBlock([[WarningInfoListResult alloc] initWithJSONData:jsonResponse.rawBody].alarms, error);
    }];
}


@end
