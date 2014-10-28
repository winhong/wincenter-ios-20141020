//
//  DatacenterDashboardVC.h
//  WinCenter-iPad
//
//  Created by apple on 14-10-11.
//  Copyright (c) 2014年 huadi. All rights reserved.
//
#import "DashboardMenuVC.h"
#import "DatacenterTableVC.h"

@interface DashboardVC : UIViewController<DatacenterTableVCDelegate>

@property DashboardMenuVC *menuVC;
@property UITabBarController *tabBarVC;

- (void)refresh;

@end
