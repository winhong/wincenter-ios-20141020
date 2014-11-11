//
//  HostContainerVC.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "HostContainerVC.h"
#import "HostDetailInfoVC.h"
#import "MasterCollectionVC.h"
#import "VmCollectionVC.h"
#import "StorageCollectionVC.h"
#import "HostNetworkCollectionVC.h"
#import "HostNicCollectionVC.h"
#import "PopControlRecordVC.h"
#import "RealtimeCurveVC.h"

@implementation HostContainerVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createVm)];
//    self.navigationItem.rightBarButtonItem = item;
}

-(void)createVm{
    [self performSegueWithIdentifier:@"toCreateVm" sender:self];
}

- (void)reloadData{
    [self.hostVO getHostVOAsync:^(id object, NSError *error) {
        self.hostVO = object;
        [self refreshMainInfo];
    }];
}

- (void)refreshMainInfo{
    self.pathLabel.text = [NSString stringWithFormat:@"%@ → %@", [RemoteObject getCurrentDatacenterVO].name, self.hostVO.resourcePoolName];
    self.titleLabel.text = self.hostVO.hostName;
    if (self.titleLabel.text.length > 26) {
        self.titleLabel.font = [UIFont systemFontOfSize:24.0f];
    }
    self.ipLabel.text = self.hostVO.ip;
    self.statusLabel.text = [self.hostVO state_text];
    //self.statusLabel.textColor = [self.hostVO state_color];
    self.resourcePoolName.text = self.hostVO.resourcePoolName;
    if ([self.hostVO.resourcePoolName isEqualToString: @"null"]) {
        self.resourcePoolName.text = @"( 游离 )";
    }
    
    NSDate *Runtime = [[NSDate alloc]initWithTimeIntervalSince1970:self.hostVO.startRunTime];
    NSDate *Now = [NSDate new];
    NSTimeInterval time=[Now timeIntervalSinceDate:Runtime];
    int Day = (int)time/(3600*24.0);
    int Hour = (int)(time - 3600*24.0*Day)/3600.0;
    int Minute = (int)(time - 3600*24.0*Day - 3600.0*Hour)/60.0;
    self.runningTime.text = [NSString stringWithFormat:@"%d天%d小时%d分",Day,Hour,Minute];
    
    self.title = self.hostVO.hostName;
}

-(void)refresh{
    [self reloadData];
    
    NSMutableArray *pages = [[NSMutableArray alloc] initWithCapacity:5];
    
    HostDetailInfoVC *detailVC = [self.storyboard instantiateViewController:@"HostDetailInfoVC"];
    detailVC.hostVO = self.hostVO;
    [pages addObject:detailVC];
    
    
    RealtimeCurveVC *performVC = [[UIStoryboard storyboardWithName:@"Performance" bundle:nil] instantiateViewController:@"HostDetailPerformanceVC"];
    performVC.HostVO = self.hostVO;
    performVC.chartType = @"host";
    [pages addObject:performVC];
    
    VmCollectionVC *hostVmCollectionVC = [[UIStoryboard storyboardWithName:@"VM" bundle:nil] instantiateViewController:@"VmCollectionVC"];
    hostVmCollectionVC.hostVO = self.hostVO;
    [pages addObject:hostVmCollectionVC];
    
    StorageCollectionVC *hostStorageCollectionVC = [[UIStoryboard storyboardWithName:@"Storage" bundle:nil] instantiateViewController:@"StorageCollectionVC"];
    hostStorageCollectionVC.hostVO = self.hostVO;
    [pages addObject:hostStorageCollectionVC];
    
    HostNetworkCollectionVC *hostNetworkCollectionVC1 = [self.storyboard instantiateViewController:@"HostNetworkCollectionVC"];
    hostNetworkCollectionVC1.hostVO = self.hostVO;
    hostNetworkCollectionVC1.isExternal = TRUE;
    [pages addObject:hostNetworkCollectionVC1];
    
    HostNetworkCollectionVC *hostNetworkCollectionVC2 = [self.storyboard instantiateViewController:@"HostNetworkCollectionVC"];
    hostNetworkCollectionVC2.hostVO = self.hostVO;
    hostNetworkCollectionVC2.isExternal = FALSE;
    [pages addObject:hostNetworkCollectionVC2];
    
    HostNicCollectionVC *hostNicCollectionVC1 = [self.storyboard instantiateViewController:@"HostNicCollectionVC"];
    hostNicCollectionVC1.hostVO = self.hostVO;
    hostNicCollectionVC1.isGrouped = TRUE;
    [pages addObject:hostNicCollectionVC1];
    
    HostNicCollectionVC *hostNicCollectionVC2 = [self.storyboard instantiateViewController:@"HostNicCollectionVC"];
    hostNicCollectionVC2.hostVO = self.hostVO;
    hostNicCollectionVC2.isGrouped = FALSE;
    [pages addObject:hostNicCollectionVC2];
    
    self.pages = pages;
    
    [super refresh];
}

-(IBAction)showControlRecordVC:(id)sender{
    if(self.popover!=nil){
        [self.popover dismissPopoverAnimated:NO];
    }
    UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateInitialViewController];
    PopControlRecordVC *controlVC = [[nav childViewControllers] firstObject];
    controlVC.remoteObject = self.hostVO;
    self.popover = [[UIPopoverController alloc] initWithContentViewController:nav];
    UIButton *button = (UIButton*)sender;
    //self.popover.passthroughViews=@[self.buttonTask];
    [self.popover presentPopoverFromRect:button.bounds inView:button permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

-(IBAction)showControlRecordVCWithBarItem:(id)sender{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateInitialViewController];
        PopControlRecordVC *controlVC = [[nav childViewControllers] firstObject];
        controlVC.remoteObject = self.hostVO;
        [self.navigationController pushViewController:controlVC animated:YES];
    }else{
        if(self.popover!=nil){
            [self.popover dismissPopoverAnimated:NO];
        }
        UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateInitialViewController];
        PopControlRecordVC *controlVC = [[nav childViewControllers] firstObject];
        controlVC.remoteObject = self.hostVO;
        self.popover = [[UIPopoverController alloc] initWithContentViewController:nav];
        UIBarButtonItem *button = (UIBarButtonItem*)sender;
        [self.popover presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}

-(IBAction)showWarningInfoVCWithBarItem:(id)sender{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Warning" bundle:nil] instantiateInitialViewController];
        PopWarningInfoVC *controlVC = [[nav childViewControllers] firstObject];
        controlVC.remoteObject = self.hostVO;
        [self.navigationController pushViewController:controlVC animated:YES];
    }else{
        if(self.popover!=nil){
            [self.popover dismissPopoverAnimated:NO];
        }
        UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Warning" bundle:nil] instantiateInitialViewController];
        PopWarningInfoVC *controlVC = [[nav childViewControllers] firstObject];
        controlVC.remoteObject = self.hostVO;
        self.popover = [[UIPopoverController alloc] initWithContentViewController:nav];
        UIBarButtonItem *button = (UIBarButtonItem*)sender;
        [self.popover presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}

@end
