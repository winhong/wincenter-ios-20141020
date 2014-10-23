//
//  DatacenterDetailCollectionHeader.h
//  WinCenter-iPad
//
//  Created by apple on 14-10-11.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VmDashboardHeader : UICollectionReusableView


@property (weak, nonatomic) IBOutlet UILabel *vmCount;

@property (weak, nonatomic) IBOutlet UILabel *osTypeWin;
@property (weak, nonatomic) IBOutlet UILabel *osTypeLinux;
@property (weak, nonatomic) IBOutlet UILabel *statusOthers;
@property (weak, nonatomic) IBOutlet UILabel *statusOk;
@property (weak, nonatomic) IBOutlet UILabel *statusDis;

@property (weak, nonatomic) IBOutlet UILabel *vmCount2;
@property (weak, nonatomic) IBOutlet UILabel *statusOthers2;
@property (weak, nonatomic) IBOutlet UILabel *statusOk2;
@property (weak, nonatomic) IBOutlet UILabel *statusDis2;
@property (weak, nonatomic) IBOutlet UILabel *osTypeWin2;
@property (weak, nonatomic) IBOutlet UILabel *osTypeLinux2;

@property (weak, nonatomic) IBOutlet UIView *vmOsTypeChart;
@property (weak, nonatomic) IBOutlet UIView *vmStatusChart;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end
