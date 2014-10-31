//
//  DatacenterDetailCollectionVC.m
//  wincenterDemo01
//
//  Created by apple on 14-8-31.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "MasterCollectionVC.h"
#import "PoolListResult.h"
#import "PoolVO.h"
#import "HostVO.h"
#import "HostListResult.h"
#import "StorageVO.h"
#import "StorageListResult.h"
#import "VmVO.h"
#import "VmListResult.h"
#import "BusinessVO.h"
#import "BusinessListResult.h"
#import "NetworkVO.h"
#import "NetworkListResult.h"
#import "MasterContainerVC.h"
#import "HostDashboardVC.h"

@implementation MasterCollectionVC

-(void)reloadData{
    
}
-(void)reloadOtherHosts{
    
}
- (void)viewDidAppear:(BOOL)animated{
    //[self.collectionView reloadData];
}
- (void)viewDidLoad
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.collectionView.backgroundColor = [UIColor clearColor];
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.backActionButton.title = @"";
    }
    
    self.dataList = [[NSMutableDictionary alloc] initWithDictionary:@{}];
    
    [super viewDidLoad];
    
    __unsafe_unretained typeof(self) week_self = self;
    
    [self.collectionView addHeaderWithCallback:^{
        [week_self reloadData];
    } dateKey:@"collection"];
    
    [self.collectionView addFooterWithCallback:^{
        [week_self reloadData];
    }];
    
    //[self.collectionView headerBeginRefreshing];
    [week_self reloadData];
    //[self.collectionView headerEndRefreshing];
    //[self.collectionView footerEndRefreshing];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataList.allKeys.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return ((NSArray*)[self.dataList valueForKey:self.dataList.allKeys[section]]).count;
}
-(IBAction)dismissModal:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(IBAction)backToCollectionVC:(UIStoryboardSegue*)segue{
    
}

- (float) formatCountData:(float) num{
    float Num = 0.0;
    if (num < 0.1 && num != 0) {
        Num = 0.1;
    }else{
        Num = num;
    }
    return Num;
}

-(IBAction)showWarningInfoVC:(id)sender{
    if(self.popover!=nil){
        [self.popover dismissPopoverAnimated:NO];
    }
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Warning" bundle:nil] instantiateInitialViewController];
    self.popover = [[UIPopoverController alloc] initWithContentViewController:vc];
    UIBarButtonItem *button = (UIBarButtonItem*)sender;
    [self.popover presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(IBAction)showControlRecordVC:(id)sender{
    if(self.popover!=nil){
        [self.popover dismissPopoverAnimated:NO];
    }
    UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateInitialViewController];
    self.popover = [[UIPopoverController alloc] initWithContentViewController:nav];
    UIBarButtonItem *button = (UIBarButtonItem*)sender;
    [self.popover presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        self.poolVO = nil;
        self.allPoolOptionBarButton.title = @"全部资源池";
        [self reloadData];
    }else if([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"游离物理主机"]){
        [self reloadOtherHosts];
        self.allPoolOptionBarButton.title = @"游离物理主机";
        [self reloadOtherHosts];
    }else{
        self.poolVO = self.poolList[(buttonIndex-2)];
        self.allPoolOptionBarButton.title = self.poolVO.resourcePoolName;
        [self reloadData];
    }
}
- (IBAction)showPoolListSelect:(id)sender {
    [[RemoteObject getCurrentDatacenterVO] getPoolListAsync:^(NSArray *allRemote, NSError *error) {
        self.poolList = allRemote;
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"过滤条件" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"全部资源池" otherButtonTitles: nil];
        for(PoolVO *pool in allRemote){
            [sheet addButtonWithTitle:pool.resourcePoolName];
        }
        if([self isKindOfClass:HostDashboardVC.class]){
            [sheet addButtonWithTitle:@"游离物理主机"];
        }
        [sheet showFromBarButtonItem:sender animated:YES];

    }];
    }
- (IBAction)showBusinessListSelect:(id)sender {
    [[RemoteObject getCurrentDatacenterVO] getBusDomainsListAsync:^(NSArray *allRemote, NSError *error) {
        self.busDomainsList = allRemote;
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"过滤条件" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"全部业务系统" otherButtonTitles: nil];
        for(BusDomainsVO *busDomains in allRemote){
            [sheet addButtonWithTitle:busDomains.busDomainName];
        }
        if([self isKindOfClass:HostDashboardVC.class]){
            [sheet addButtonWithTitle:@"未分配业务系统"];
        }
        [sheet showFromBarButtonItem:sender animated:YES];
        
    }];
}

@end
