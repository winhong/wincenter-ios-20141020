//
//  DatacenterDashboardMenuVC.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-10.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "DashboardMenuVC.h"
#import "MasterContainerVC.h"

@interface DashboardMenuVC ()
@property (weak, nonatomic) IBOutlet UIButton *menuHome;
@property (weak, nonatomic) IBOutlet UIButton *menuPool;
@property (weak, nonatomic) IBOutlet UIButton *menuHost;
@property (weak, nonatomic) IBOutlet UIButton *menuVm;
@property (weak, nonatomic) IBOutlet UIButton *menuStorage;
@property (weak, nonatomic) IBOutlet UIButton *menuBusiness;
@property (weak, nonatomic) IBOutlet UIButton *menuNetwork;
@property (weak, nonatomic) IBOutlet UIButton *menuWarning;
@property (weak, nonatomic) IBOutlet UIButton *menuSearch;
@property (weak, nonatomic) IBOutlet UIButton *menuSelect;
@property (weak, nonatomic) IBOutlet UIButton *menuSetting;
@property (weak, nonatomic) IBOutlet UIButton *menuExpand;

@property NSArray *menuItems;

@property NSInteger selectedIndex;

@end

@implementation DashboardMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuItems = @[self.menuHome,
                       self.menuPool,
                       self.menuHost,
                       self.menuVm,
                       self.menuStorage,
                       self.menuBusiness,
                       self.menuNetwork,
                       self.menuWarning,
                       self.menuSearch,
                       self.menuSelect,
                       self.menuSetting,
                       self.menuExpand];
}

- (IBAction)switchTabBar:(id)sender {
    NSInteger currentIndex =  ((UIButton*)sender).tag;
    [self setSelectedItemIndex:currentIndex];
    [self.tabBarVC setSelectedIndex:currentIndex];
}

- (void) setSelectedItemIndex:(NSInteger)index{
    UIButton *previousButton = self.menuItems[self.selectedIndex];
    previousButton.backgroundColor = [UIColor colorWithRed:25/255.0 green:29/255.0 blue:45/255.0 alpha:1];
    previousButton.selected = NO;
    self.selectedIndex = index;
    UIButton *currentButton = self.menuItems[self.selectedIndex];
    currentButton.backgroundColor = [UIColor colorWithRed:71/255.0 green:145/255.0 blue:210/255.0 alpha:1];
    currentButton.selected = YES;
    
    
}
- (IBAction)doubleClickItem:(id)sender {
    NSInteger currentIndex =  ((UIButton*)((UITapGestureRecognizer*)sender).view).tag;
    UIViewController *nav = [[self.tabBarVC childViewControllers] objectAtIndex:currentIndex];
    if([nav isKindOfClass:[UINavigationController class]]){
        [((UINavigationController*)nav) popToRootViewControllerAnimated:YES];
    }
}


@end
