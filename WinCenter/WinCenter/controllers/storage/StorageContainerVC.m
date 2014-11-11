//
//  StorageContainerVC.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "StorageContainerVC.h"
#import "StorageDetailInfoVC.h"
#import "PopControlRecordVC.h"

@implementation StorageContainerVC

-(void)reloadData{
    [self.storageVO getStorageVOAsync:^(id object, NSError *error) {
        self.storageVO = object;
        [self refreshMainInfo];
    }];
}

-(void)refreshMainInfo{
    if((self.storageVO.hostName ==nil) || [self.storageVO.hostName isEqualToString:@""]){
        self.pathLabel.text = [NSString stringWithFormat:@"%@ → %@", [RemoteObject getCurrentDatacenterVO].name, self.storageVO.resourcePoolName];
    }else{
        self.pathLabel.text = [NSString stringWithFormat:@"%@ → %@ → %@", [RemoteObject getCurrentDatacenterVO].name, self.storageVO.resourcePoolName, self.storageVO.hostName];
    }
    self.titleLabel.text = self.storageVO.storagePoolName;
    self.statusLabel.text = [self.storageVO state_text];
    self.statusLabel.textColor = [self.storageVO state_color];
    self.name.text = self.storageVO.storagePoolName;
    if (self.name.text.length > 26) {
        self.name.font = [UIFont systemFontOfSize:24.0f];
    }
    self.status.text = [self.storageVO state_text];
    self.title = self.storageVO.storagePoolName;
}

-(void)refresh{
    [self refreshMainInfo];
    
    NSMutableArray *pages = [[NSMutableArray alloc] initWithCapacity:1];
    
    StorageDetailInfoVC *vc;
    vc = [self.storyboard instantiateViewController:@"StorageDetailInfoVC"];
    vc.storageVO = self.storageVO;
    [pages addObject:vc];
    
    StorageDiskCollectionVC *diskCollectionVC = [self.storyboard instantiateViewController:@"StorageDiskCollectionVC"];
    diskCollectionVC.storageVO = self.storageVO;
    [pages addObject:diskCollectionVC];
    
    self.pages = pages;
    
    [super refresh];
}

-(IBAction)showControlRecordVC:(id)sender{
    if(self.popover!=nil){
        [self.popover dismissPopoverAnimated:NO];
    }
    UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateInitialViewController];
    PopControlRecordVC *controlVC = [[nav childViewControllers] firstObject];
    controlVC.remoteObject = self.storageVO;
    self.popover = [[UIPopoverController alloc] initWithContentViewController:nav];
    UIButton *button = (UIButton*)sender;
    //self.popover.passthroughViews=@[self.buttonTask];
    [self.popover presentPopoverFromRect:button.bounds inView:button permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

-(IBAction)showControlRecordVCWithBarItem:(id)sender{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateInitialViewController];
        PopControlRecordVC *controlVC = [[nav childViewControllers] firstObject];
        controlVC.remoteObject = self.storageVO;
        [self.navigationController pushViewController:controlVC animated:YES];
    }else{
        if(self.popover!=nil){
            [self.popover dismissPopoverAnimated:NO];
        }
        UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateInitialViewController];
        PopControlRecordVC *controlVC = [[nav childViewControllers] firstObject];
        controlVC.remoteObject = self.storageVO;
        self.popover = [[UIPopoverController alloc] initWithContentViewController:nav];
        UIBarButtonItem *button = (UIBarButtonItem*)sender;
        [self.popover presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}

@end
