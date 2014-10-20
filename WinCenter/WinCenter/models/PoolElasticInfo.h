//
//  PoolElasticInfo.h
//  WinCenter-iPad
//
//  Created by huadi on 14-9-28.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PoolElasticInfo : NSObject

@property NSString *balancingMode;
@property float cpuThreshold;
@property float memThreshold;
@property NSString *intervalTime;
@property NSString *nextStartTime;

- (NSString*)intervalTime_text;
@end
