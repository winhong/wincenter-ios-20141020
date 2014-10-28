//
//  DatacenterDetailInfoVC.h
//  wincenterDemo01
//
//  Created by apple on 14-9-1.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatacenterDetailInfoVC : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *name;
@property (weak, nonatomic) IBOutlet UILabel *poolCount;
@property (weak, nonatomic) IBOutlet UILabel *hostCount;
@property (weak, nonatomic) IBOutlet UILabel *vmCount;
@property (weak, nonatomic) IBOutlet UILabel *businessCount;
@property (weak, nonatomic) IBOutlet UILabel *cpuUnitCount2;
@property (weak, nonatomic) IBOutlet UILabel *memerySize2;
@property (weak, nonatomic) IBOutlet UILabel *storageSize2;
@property (weak, nonatomic) IBOutlet UILabel *dissociateHostNumber;

@property (weak, nonatomic) IBOutlet UILabel *cpuUnitCount;
@property (weak, nonatomic) IBOutlet UILabel *cpuUsedCount;
@property (weak, nonatomic) IBOutlet UILabel *cpuUnitUnusedCount;
@property (weak, nonatomic) IBOutlet UILabel *memerySize;
@property (weak, nonatomic) IBOutlet UILabel *memeryUsedSize;
@property (weak, nonatomic) IBOutlet UILabel *memoryUnusedSize;
@property (weak, nonatomic) IBOutlet UILabel *storageSize;
@property (weak, nonatomic) IBOutlet UILabel *storageUsedSize;
@property (weak, nonatomic) IBOutlet UILabel *storageUnusedSize;
//@property (weak, nonatomic) IBOutlet UILabel *networkIpCount;
//@property (weak, nonatomic) IBOutlet UILabel *networkIpUsedCount;
//@property (weak, nonatomic) IBOutlet UILabel *networkIpUnusedCount;

@property (weak, nonatomic) IBOutlet UIProgressView *cpuProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *memoryProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *storageProgress;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;

@property (weak, nonatomic) IBOutlet UILabel *cpuUsedInfo;
@property (weak, nonatomic) IBOutlet UILabel *memeryUsedInfo;
@property (weak, nonatomic) IBOutlet UILabel *storageUsedInfo;

@property PNCircleChart *circleChart;
@property PNCircleChart *circleChart2;
@property PNCircleChart *circleChart3;
- (void)refresh;
- (void)switchButtonSelected:(NSInteger)index;

@end
