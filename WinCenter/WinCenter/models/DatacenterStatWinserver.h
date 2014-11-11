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

@property int dissociateHostNumber;

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

- (float)totalCpu_value;
- (NSString*)totalCpu_unit;

- (float)availCpu_value;
- (NSString*)availCpu_unit;

- (float)totalMemory_value;
- (NSString*)totalMemory_unit;

- (float)availMemory_value;
- (NSString*)availMemory_unit;

- (float)totalStorage_value;
- (NSString*)totalStorage_unit;

- (float)availStorage_value;
- (NSString*)availStorage_unit;

- (float)usedCpu_value;
- (NSString*)usedCpu_unit;

- (float)usedMemory_value;
- (NSString*)usedMemory_unit;

- (float)usedStorage_value;
- (NSString*)usedStorage_unit;

@end
