//
//  ControlRecordVO.h
//  WinCenter-iPad
//
//  Created by 黄茂坚 on 14-9-29.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ControlRecordVO : NSObject

@property NSString *taskName;
@property int executeTime;
@property NSString *endTime;
@property int progress;
@property NSString *state;
@property NSString *user;
@property NSString *targetName;
@property int resPoolId;
@property int hostId;
@property int vmId;

+ (void) getControlRecordListViaObject:(RemoteObject*)remoteObject async:(FetchObjectCompletionBlock)completeBlock;

@end
