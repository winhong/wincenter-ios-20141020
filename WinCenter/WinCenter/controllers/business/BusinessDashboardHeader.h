//
//  DatacenterDetailCollectionHeader.h
//  WinCenter-iPad
//
//  Created by apple on 14-10-11.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessDashboardHeader : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIBarButtonItem *name;
@property (weak, nonatomic) IBOutlet UILabel *businessCount;
@property (weak, nonatomic) IBOutlet UILabel *businessVmCount;

@property (weak, nonatomic) IBOutlet UILabel *alloctedBus;
@property (weak, nonatomic) IBOutlet UILabel *unalloctedBus;
@property (weak, nonatomic) IBOutlet UILabel *businessCount2;
@property (weak, nonatomic) IBOutlet UILabel *businessVmCount2;
@property (weak, nonatomic) IBOutlet UILabel *alloctedBus2;
@property (weak, nonatomic) IBOutlet UILabel *unalloctedBus2;
@property (weak, nonatomic) IBOutlet UIView *businessAllocateChart;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end
