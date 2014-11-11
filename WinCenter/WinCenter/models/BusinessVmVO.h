//
//  BusinessVmVO.h
//  WinCenter-iPad
//
//  Created by huadi on 14-9-26.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessVmVO : NSObject
@property int vmId;
@property NSString *name;
@property int startOrder;
@property int delayInterval;
@property NSString *state;
@property NSString *operationState;

- (NSString*)state_text;
- (UIColor *)state_color;

@end
