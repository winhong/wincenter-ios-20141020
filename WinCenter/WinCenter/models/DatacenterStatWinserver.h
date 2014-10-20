//
//  DatacenterStatWinserver.h
//  WinCenter-iPad
//
//  Created by huadi on 14-9-26.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatacenterStatWinserver : NSObject

@property int resPoolNumber;
@property int hostNubmer;
@property int vmNumber;
@property int appNumber;

@property float totalCpu;
@property float totalMemory;
@property float totalStorage;
@property float availCpu;
@property float availMemory;
@property float availStorage;


-(float)cpuRatio;

-(UIColor *)cpuRatioColor;

-(float)memoryRatio;

-(UIColor *)memoryRatioColor;

-(float)storageRatio;

-(UIColor *)storageRatioColor;

@end
