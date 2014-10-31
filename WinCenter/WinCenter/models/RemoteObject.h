//
//  RemoteObject.h
//  WinCenter-iPad
//
//  Created by huadi on 14-9-25.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BasicCompletionBlock)(NSError *error);

typedef void(^FetchObjectCompletionBlock)(id object, NSError *error);

#define per_page 12

@class DatacenterVO;

@interface RemoteObject : NSObject

+(void)setCurrentDatacenterVO:(DatacenterVO*)datacenterVO;
+(DatacenterVO *)getCurrentDatacenterVO;

@end
