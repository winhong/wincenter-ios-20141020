//
//  LoginVO.h
//  WinCenter-Common
//
//  Created by apple on 14-9-30.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginVO : RemoteObject

+ (void) login:(NSString *)userName withPassword:(NSString*)password withSucceedBlock:(BasicCompletionBlock)succeedBlock withFailedBlock:(BasicCompletionBlock)failedBlock;

@end
