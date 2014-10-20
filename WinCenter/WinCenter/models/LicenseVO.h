//
//  LicenseVO.h
//  WinCenter-iPad
//
//  Created by huadi on 14-9-29.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LicenseVO : RemoteObject

@property LicenseWciVO *wci;
@property int useedCount;
@property int remianDays;

+ (void) getLicenseVOAsync:(FetchObjectCompletionBlock)completeBlock;

@end

