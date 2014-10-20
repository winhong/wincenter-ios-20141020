//
//  LoginVO.m
//  WinCenter-Common
//
//  Created by apple on 14-9-30.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "LoginVO.h"

@implementation LoginVO

+ (void) login:(NSString *)userName withPassword:(NSString*)password withSucceedBlock:(BasicCompletionBlock)succeedBlock withFailedBlock:(BasicCompletionBlock)failedBlock{
    
    [[NSUserDefaults standardUserDefaults] setValue:@"FAILED" forKey:@"LOGIN_STATE"];
    
    [[UNIRest post:^(UNISimpleRequest *simpleRequest) {
        
        [simpleRequest setUrl:@"/loginServlet"];
        [simpleRequest setParameters:@{@"userName":userName, @"password":password}];
        
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        
        if([[[NSUserDefaults standardUserDefaults] stringForKey:@"LOGIN_STATE"] isEqualToString:@"SUCCESS"]){
            succeedBlock(error);
        }else{
            failedBlock(error);
        }
        
    }];
}

@end
