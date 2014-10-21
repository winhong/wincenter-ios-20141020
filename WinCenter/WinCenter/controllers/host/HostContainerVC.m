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

@implementation HostContainerVC

-(void)refresh{
    self.pathLabel.text = [NSString stringWithFormat:@"%@ → %@", [RemoteObject getCurrentDatacenterVO].name, self.hostVO.resourcePoolName];
    self.titleLabel.text = self.hostVO.hostName;
    self.ipLabel.text = self.hostVO.ip;
    self.statusLabel.text = [self.hostVO state_text];
    self.statusLabel.textColor = [self.hostVO state_color];
    
    self.title = self.hostVO.hostName;
    
    NSMutableArray *pages = [[NSMutableArray alloc] initWithCapacity:5];
    
    HostDetailInfoVC *detailVC = [self.storyboard instantiateViewController:@"HostDetailInfoVC"];
    detailVC.hostVO = self.hostVO;
    [pages addObject:detailVC];
    
    
    UIViewController *performVC = [[UIStoryboard storyboardWithName:@"Performance" bundle:nil] instantiateViewController:@"HostDetailPerformanceVC"];
    [pages addObject:performVC];
    
    VmCollectionVC *hostVmCollectionVC = [[UIStoryboard storyboardWithName:@"VM" bundle:nil] instantiateViewController:@"VmCollectionVC"];
    hostVmCollectionVC.hostVO = self.hostVO;
    [pages addObject:hostVmCollectionVC];
    
    StorageCollectionVC *hostStorageCollectionVC = [[UIStoryboard storyboardWithName:@"Storage" bundle:nil] instantiateViewController:@"StorageCollectionVC"];
    hostStorageCollectionVC.hostVO = self.hostVO;
    [pages addObject:hostStorageCollectionVC];
    
    HostNetworkCollectionVC *hostNetworkCollectionVC = [self.storyboard instantiateViewController:@"HostNetworkCollectionVC"];
    hostNetworkCollectionVC.hostVO = self.hostVO;
    [pages addObject:hostNetworkCollectionVC];
    
    HostNicCollectionVC *hostNicCollectionVC = [self.storyboard instantiateViewController:@"HostNicCollectionVC"];
    hostNicCollectionVC.hostVO = self.hostVO;
    [pages addObject:hostNicCollectionVC];
    
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

@end
