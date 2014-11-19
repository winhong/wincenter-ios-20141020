//
//  DatacenterDetailCollectionCell.h
//  wincenterDemo01
//
//  Created by apple on 14-8-31.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F3BarGauge.h"

@interface HostDashboardCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *belongs;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIView *status_image;
@property (weak, nonatomic) IBOutlet UILabel *share;
@property (weak, nonatomic) IBOutlet UIImageView *share_image;
@property (weak, nonatomic) IBOutlet UILabel *ip;
@property (weak, nonatomic) IBOutlet UILabel *vmCount;
@property (weak, nonatomic) IBOutlet UILabel *storageSize;
@property (weak, nonatomic) IBOutlet UILabel *cpuSlots;
@property (weak, nonatomic) IBOutlet UILabel *cpu;
@property (weak, nonatomic) IBOutlet UILabel *memorySize;
@property (weak, nonatomic) IBOutlet UILabel *osType;
@property (weak, nonatomic) IBOutlet UIImageView *osType_image;
@property (weak, nonatomic) IBOutlet UIImageView *linkState;
@property (weak, nonatomic) IBOutlet UIImageView *type_image;
@property (weak, nonatomic) IBOutlet F3BarGauge *progress_1;
@property (weak, nonatomic) IBOutlet F3BarGauge *progress_2;
@property (weak, nonatomic) IBOutlet F3BarGauge *progress_3;
@property (weak, nonatomic) IBOutlet F3BarGauge *progress_4;
@property (weak, nonatomic) IBOutlet F3BarGauge *progress_5;


@end
