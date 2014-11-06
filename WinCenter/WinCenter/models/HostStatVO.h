//
//  HostStatVO.h
//  WinCenter-iPad
//
//  Created by huadi on 14-9-28.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HostStatVO : NSObject

@property float cpuUsed;
@property float cpuTotal;
@property float cpuUsedPer;

@property float vmMemUsed;
@property float freeMem;
@property float xenMemUsed;
@property float totalMem;

@property float totalStorage;
@property float usedStorage;
@property float storageUsedPer;

-(float)cpuRatio;

-(UIColor *)cpuRatioColor;

-(float)memoryRatio;

-(UIColor *)memoryRatioColor;

-(float)storageRatio;

-(UIColor *)storageRatioColor;

- (float)totalCpu_value;
- (NSString*)totalCpu_unit;

- (float)availCpu_value;
- (NSString*)availCpu_unit;

- (float)totalStorage_value;
- (NSString*)totalStorage_unit;

- (float)availStorage_value;
- (NSString*)availStorage_unit;

- (float)usedCpu_value;
- (NSString*)usedCpu_unit;

- (float)usedStorage_value;
- (NSString*)usedStorage_unit;
@end
