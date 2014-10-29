//
//  UserVO.h
//  WinCenter-iPad
//
//  Created by huadi on 14-9-17.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserVO : RemoteObject

@property int id;
@property NSString *name;
@property NSString *account;
@property NSString *password;
@property NSString *email;
@property NSString *mobilephone;

@property NSString *telephone;
@property NSString *remark;
@property NSString *createTime;
@property NSString *lastUpdateTime;
@property NSString *state;

@property NSString *onLine;
@property NSString *role;
@property NSString *roleName;
@property NSString *failCount;
@property NSString *locked;

+ (void) getUserVOAsync:(FetchObjectCompletionBlock)completeBlock;
- (void) modifyPassword:(FetchObjectCompletionBlock)completeBlock withOldPassword:(NSString*)OldPassword withPassword:(NSString*)NewPassword;
@end
