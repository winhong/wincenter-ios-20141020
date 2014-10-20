//
//  DatacenterDashboardVC.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-11.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "DAshboardVC.h"
#import "DTNavigationController.h"
#import "MSCalendarViewController.h"

@interface DashboardVC ()

@end

@implementation DashboardVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.menuVC.tabBarVC = self.tabBarVC;
    
    [DatacenterVO getDatacenterListAsync:^(NSArray *allRemote, NSError *error) {
        if(allRemote.count>0){
            [RemoteObject setCurrentDatacenterVO:[allRemote firstObject]];
            [self refresh];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"尚没有配置任何数据中心，请联系虚拟化平台管理员！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
            [alert show];
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toMenuVC"]){
        self.menuVC = segue.destinationViewController;
    }else if([segue.identifier isEqualToString:@"toTabBarVC"]){
        self.tabBarVC = segue.destinationViewController;
    }
    
}

- (void)refresh{
    self.title = [RemoteObject getCurrentDatacenterVO].name;
    
    NSArray *viewControllers = @[@"DatacenterDetailInfoVCNav",
                                 @"PoolDashboardVCNav",@"HostDashboardVCNav",@"VmDashboardVCNav",
                                 @"StorageDashboardVCNav", @"BusinessDashboardVCNav"];
    for(NSString *viewControllerName in viewControllers){
        UINavigationController *nav = [self.storyboard instantiateViewController:viewControllerName];
        //UIViewController *vc = [[nav childViewControllers] firstObject];
        //DTNavigationController *navigation = [DTNavigationController navigationWithRootViewController:vc folderStyle:DTFolderBarStyleFixedHomeAndAtionButton];
        //navigation.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.tabBarVC addChildViewController:nav];
    }

    //网络
    [self.tabBarVC addChildViewController:[[UINavigationController alloc] initWithRootViewController:[UIViewController new]]];
    
    [self.tabBarVC addChildViewController:[MSCalendarViewController new]];
    
    //搜索
    [self.tabBarVC addChildViewController:[[UINavigationController alloc] initWithRootViewController:[UIViewController new]]];
    
    UINavigationController *nav;
    nav = [self.storyboard instantiateViewController:@"DatacenterTableVCNav"];
    [self.tabBarVC addChildViewController:nav];
    
    nav = [[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateViewController:@"PopOptionsVCNav"];
    [self.tabBarVC addChildViewController:nav];
    
    [self.tabBarVC setSelectedIndex:0];
    
    [self.menuVC setSelectedItemIndex:0];
}

@end
