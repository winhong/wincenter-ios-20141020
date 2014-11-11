//
//  WaringInfoVO.h
//  WinCenter-iPad
//
//  Created by 黄茂坚 on 14-9-29.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WarningInfoVO : RemoteObject

@property int warningId;
@property int warningUuid;
@property NSString *objectId;
@property NSString *objectName;
@property NSString *objectType;
@property NSString *objectUuid;
@property NSString *objectSource;
@property NSString *name;
@property NSString *type;
@property NSString *body;
@property NSString *createTime;
@property NSString *priority;
@property NSString *address;
@property NSString *readed;
@property NSString *poolOriginalId;
@property NSString *uri;

+ (void) getWarningInfoListViaObject:(RemoteObject*)remoteObject Async:(FetchObjectCompletionBlock)completeBlock referTo:(NSMutableArray*)referList;
-(NSString*)readed_text;
-(UIColor*)readed_Color;

@end