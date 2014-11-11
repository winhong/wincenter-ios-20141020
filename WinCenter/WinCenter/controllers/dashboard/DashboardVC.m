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
    
    [DatacenterVO getDatacenterListAsync:^(id object, NSError *error) {
        if(((DatacenterListResult*)object).dataCenters.count>0){
            [RemoteObject setCurrentDatacenterVO:[((DatacenterListResult*)object).dataCenters firstObject]];
            [self refresh];
            if(((DatacenterListResult*)object).dataCenters.count>1){
                [self.tabBarVC setSelectedIndex:7];
                [self.menuVC setSelectedItemIndex:7];
            }else{
                [self.tabBarVC setSelectedIndex:0];
                [self.menuVC setSelectedItemIndex:0];
            }
        }else{
            [self refreshWhenNil];
            [self.tabBarVC setSelectedIndex:7];
            [self.menuVC setSelectedItemIndex:7];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"尚没有配置任何数据中心，请联系系统管理员！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
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

- (void)didFinished:(DatacenterVO *)vo{
    [RemoteObject setCurrentDatacenterVO:vo];
    [self refresh];
    [self.tabBarVC setSelectedIndex:0];
    [self.menuVC setSelectedItemIndex:0];
}

- (void)refreshWhenNil{
    self.title = @"";
    
    for(UIViewController *subVC in self.tabBarVC.childViewControllers){
        [subVC removeFromParentViewController];
    }
    
    UINavigationController *nav;
    
    for(int i=0; i<7; i++){
        [self.tabBarVC addChildViewController:[UIViewController new]];
    }
    
    //刷新
    nav = [self.storyboard instantiateViewController:@"DatacenterTableVCNav"];
    DatacenterTableVC *tableVC = [[nav childViewControllers] firstObject];
    tableVC.delegate = self;
    [self.tabBarVC addChildViewController:nav];
    
    //设置
    nav = [[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateViewController:@"PopOptionsVCNav"];
    [self.tabBarVC addChildViewController:nav];
}

- (void)refresh{
    self.title = [RemoteObject getCurrentDatacenterVO].name;
    
    for(UIViewController *subVC in self.tabBarVC.childViewControllers){
        [subVC removeFromParentViewController];
    }
    
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

    UINavigationController *nav;
    
    //网络
    nav = [[UIStoryboard storyboardWithName:@"Network" bundle:nil] instantiateViewController:@"NetworkDashboardVCNav"];
    [self.tabBarVC addChildViewController:nav];
    
//    //告警
//    [self.tabBarVC addChildViewController:[MSCalendarViewController new]];
//    
//    //搜索
//    [self.tabBarVC addChildViewController:[[UINavigationController alloc] initWithRootViewController:[UIViewController new]]];
    
    //刷新
    nav = [self.storyboard instantiateViewController:@"DatacenterTableVCNav"];
    DatacenterTableVC *tableVC = [[nav childViewControllers] firstObject];
    tableVC.delegate = self;
    [self.tabBarVC addChildViewController:nav];
    
    //设置
    nav = [[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateViewController:@"PopOptionsVCNav"];
    [self.tabBarVC addChildViewController:nav];
}

@end
