//
//  DatacenterDetailCollectionHeader.h
//  WinCenter-iPad
//
//  Created by apple on 14-10-11.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PoolDashboardHeader : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *poolCount;
@property (weak, nonatomic) IBOutlet UILabel *hostCount;
@property (weak, nonatomic) IBOutlet UILabel *vmCount;
@property (weak, nonatomic) IBOutlet UILabel *businessCount;
@property (weak, nonatomic) IBOutlet UILabel *businessVmCount;
@property (weak, nonatomic) IBOutlet UILabel *haPoolCount;
@property (weak, nonatomic) IBOutlet UILabel *elasticCalPoolCount;

@property (weak, nonatomic) IBOutlet UILabel *poolCount2;
@property (weak, nonatomic) IBOutlet UILabel *haPoolCount2;
@property (weak, nonatomic) IBOutlet UILabel *elasticCalPoolCount2;

@property (weak, nonatomic) IBOutlet UILabel *cpuUnitCount2;
@property (weak, nonatomic) IBOutlet UILabel *cpuUsedCount2;
@property (weak, nonatomic) IBOutlet UILabel *cpuUnitUnusedCount2;
@property (weak, nonatomic) IBOutlet UILabel *memerySize2;
@property (weak, nonatomic) IBOutlet UILabel *memeryUsedSize2;
@property (weak, nonatomic) IBOutlet UILabel *memoryUnusedSize2;
@property (weak, nonatomic) IBOutlet UILabel *storageSize2;
@property (weak, nonatomic) IBOutlet UILabel *storageUsedSize2;
@property (weak, nonatomic) IBOutlet UILabel *storageUnusedSize2;

@property (weak, nonatomic) IBOutlet UIView *cpuChartGroup;
@property (weak, nonatomic) IBOutlet UIView *memoryChartGroup;
@property (weak, nonatomic) IBOutlet UIView *storageChartGroup;
@property (weak, nonatomic) IBOutlet UIView *hostTypeChart;
@property (weak, nonatomic) IBOutlet UIView *hostStatusChart;
@property (weak, nonatomic) IBOutlet UIView *storageShareChart;
@property (weak, nonatomic) IBOutlet UIView *storageUseChart;
@property (weak, nonatomic) IBOutlet UIView *vmOsTypeChart;
@property (weak, nonatomic) IBOutlet UIView *vmStatusChart;
@property (weak, nonatomic) IBOutlet UIView *businessAllocateChart;

@property (weak, nonatomic) IBOutlet UILabel *cpuUnitCount;
@property (weak, nonatomic) IBOutlet UILabel *cpuUsedCount;
@property (weak, nonatomic) IBOutlet UILabel *cpuUnitUnusedCount;
@property (weak, nonatomic) IBOutlet UILabel *memerySize;
@property (weak, nonatomic) IBOutlet UILabel *memeryUsedSize;
@property (weak, nonatomic) IBOutlet UILabel *memoryUnusedSize;
@property (weak, nonatomic) IBOutlet UILabel *storageSize;
@property (weak, nonatomic) IBOutlet UILabel *storageUsedSize;
@property (weak, nonatomic) IBOutlet UILabel *storageUnusedSize;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end
