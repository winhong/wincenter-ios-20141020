//
//  BusinessVO.m
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-28.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import "BusinessVO.h"

@implementation BusinessVO
-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"BusinessVmVO" forKeyPath:@"propertyArrayMap.wceBusVms"];
    }
    return self;
}

- (void) getBusinessVOAsync:(FetchObjectCompletionBlock)completeBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completeBlock([[BusinessVO alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BusinessVO.getBusinessVOAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.wce.vApp.getVApp&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id, self.busId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completeBlock([[BusinessVO alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

- (void) getBusinessVmListAsync:(FetchAllCompletionBlock)completeBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completeBlock([[BusinessVO alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BusinessVO.getBusinessVOAsync" ofType:@"json"]]].wceBusVms, nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=%d&apiKey=pc.wce.vApp.getVApp&placeholder=%d", [RemoteObject getCurrentDatacenterVO].id, self.busId]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completeBlock([[BusinessVO alloc] initWithJSONData:jsonResponse.rawBody].wceBusVms, error);
    }];
}

@end
