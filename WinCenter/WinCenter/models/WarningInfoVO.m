//
//  WaringInfoVO.m
//  WinCenter-iPad
//
//  Created by 黄茂坚 on 14-9-29.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "WarningInfoVO.h"

@implementation WarningInfoVO


+ (void) getWarningInfoListAsync:(FetchObjectCompletionBlock)completeBlock referTo:(NSMutableArray*)referList{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completeBlock([[WarningInfoListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"WarningInfoVO.getWarningInfoListAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.winserver.warning.getVmWarningList&params=firstResult%%3D%ld%%26maxResult%%3D%ld", [RemoteObject getCurrentDatacenterVO].id, referList.count, referList.count+per_page]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completeBlock([[WarningInfoListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}


@end
