//
//  HostDetailBaseinfoVC.h
//  wincenterDemo01
//
//  Created by huadi on 14-8-15.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HostDetailInfoVC : UIViewController

@property HostVO *hostVO;
@property HostStatVO *statVO;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;
@property HostActivityVmVO *activityVm;
@property HostNetworkListResult *hostNetworkList;

@property PNCircleChart *circleChart;
@property PNCircleChart *circleChart2;
@property PNCircleChart *circleChart3;
@end
