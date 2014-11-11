//
//  LicenseVO.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-29.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "LicenseVO.h"

@implementation LicenseVO

+ (void) checkLicenseAsync:(FetchObjectCompletionBlock)completeBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completeBlock([[LicenseCheckVO alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LicenseVO.checkLicenseAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:@"/pc/licServlet?action=checkLic"];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completeBlock([[LicenseCheckVO alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

+ (void) getLicenseVOAsync:(FetchObjectCompletionBlock)completeBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completeBlock([[LicenseVO alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LicenseVO.getLicenseVOAsync" ofType:@"json"]]], nil);
        return;
    }
    
    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:@"/pc/licServlet?action=query"    ];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        completeBlock([[LicenseVO alloc] initWithJSONData:jsonResponse.rawBody], error);
    }];
}

@end
