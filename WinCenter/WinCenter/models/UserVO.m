//
//  UserVO.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-17.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "UserVO.h"



@implementation UserVO

- (NSString*) roleName_text{
    switch (self.role) {
        case 1:
            return @"云平台管理员";
        case 2:
            return @"资源池管理员";
        case 3:
            return @"业务系统管理员";
        default:
            return @"未知类型";
    }
}

+ (void) getUserVOAsync:(FetchObjectCompletionBlock)completeBlock{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        completeBlock([[UserListResult alloc] initWithJSONData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UserVO.getUserVOAsync" ofType:@"json"]]].users[0], nil);
        return;
    }
    
//    [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
//        [simpleRequest setUrl:@"/pc/sys/users?account=admin&password=WTHtk1eyckFZUs3vFKsDAdiscP16uTGA"];
//    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
//        completeBlock([[UserListResult alloc] initWithJSONData:jsonResponse.rawBody].users[0], error);
//    }];
    
    [[UNIRest post:^(UNISimpleRequest *simpleRequest) {
        [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet"]];
        [simpleRequest setParameters:@{@"connectorId":[NSString stringWithFormat:@"%d", 0],
                                       @"apiKey":@"pc.api.user.getUsers",
                                       @"placeholder": [NSString stringWithFormat:@""],
                                       @"params": @"firstResult=0&state=1",
                                       @"apiType": @"GET"}];
    }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
        UserListResult *result = [[UserListResult alloc] initWithJSONData:jsonResponse.rawBody].users;
        NSString *user = [[NSUserDefaults standardUserDefaults] stringForKey:@"USER_NAME"];
        UserVO *curUser = [UserVO new];
        for (UserVO *userVO in result) {
            if ([user isEqualToString:userVO.account]) {
                curUser = userVO;
                break;
            }
        }
        completeBlock(curUser, error);
    }];
}

- (void) modifyPassword:(FetchObjectCompletionBlock)completeBlock withOldPassword:(NSString*)OldPassword withPassword:(NSString*)NewPassword{
    
    [UserVO getUserVOAsync:^(id object, NSError *error) {
        UserVO *userVO = object;
        [[UNIRest post:^(UNISimpleRequest *simpleRequest) {
            [simpleRequest setUrl:[NSString stringWithFormat:@"/restServlet"]];
            [simpleRequest setParameters:@{@"connectorId":[NSString stringWithFormat:@"%d", 0],
                                           @"apiKey":@"pc.api.user.modifyPassword",
                                           @"placeholder": [NSString stringWithFormat:@"%d",userVO.id],
                                           @"content": [NSString stringWithFormat:@"{\"oldPassword\":\"%@\",\"password\":\"%@\"}",OldPassword,NewPassword],
                                           @"apiType": @"PUT"}];
        }] asJsonAsync:^(UNIHTTPJsonResponse *jsonResponse, NSError *error) {
            completeBlock([[ModifyPasswordResultVO alloc] initWithJSONData:jsonResponse.rawBody], error);
        }];

    }];

}

@end
