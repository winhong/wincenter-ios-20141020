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

@end
