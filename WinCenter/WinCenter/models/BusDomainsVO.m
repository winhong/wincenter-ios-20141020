//
//  BusDomainsVO.m
//  WinCenter
//
//  Created by 黄茂坚 on 14/10/31.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "BusDomainsVO.h"

@implementation BusDomainsVO


- (void) getBusinessListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList{
    
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        
        completionBlock([[BusinessListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BusDomainsVO.getBusinessListAsync" ofType:@"json"]]], nil);
        
        return;
        
    }
    
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest){
        
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet?connectorId=0&apiKey=pc.api.busDomain.getBusDomBean&placeholder=%d&params=firstResult%%3D%ld%%26maxResult%%3D%ld",self.busDomainId, referList.count, referList.count+per_page]];
        
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        
        completionBlock([[BusinessListResult alloc] initWithJSONData:jsonResponse.rawBody], error);
        
    }];
    
}


@end
