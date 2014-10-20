//
//  UserVO.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-17.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "UserVO.h"


@implementation UserVO

+ (void) getUserVOAsync:(FetchObjectCompletionBlock)completeBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completeBlock([[UserListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UserVO.getUserVOAsync" ofType:@"json"]]].users[0], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:@"/pc/sys/users?account=admin&password=WTHtk1eyckFZUs3vFKsDAdiscP16uTGA"];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completeBlock([[UserListResult alloc] initWithJSONData:jsonResponse.rawBody].users[0], error);
    }];
}

@end
