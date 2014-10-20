//
//  DatacenterDashboardMenuVC.h
//  WinCenter-iPad
//
//  Created by apple on 14-10-10.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardMenuVC : UITableViewController

@property UITabBarController *tabBarVC;

- (void) setSelectedItemIndex:(NSInteger)index;

@end
