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
- (IBAction)showMenu:(id)sender {
    [self.frostedViewController presentMenuViewController];
}

- (IBAction)refreshAction:(id)sender {
    self.navigationItem.rightBarButtonItem.enabled = false;     
    [self.collectionView headerBeginRefreshing];
}

-(void)reloadData{
    
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
    
    self.dataList = [[NSMutableArray alloc] initWithCapacity:0];
    
    [super viewDidLoad];
    
    __unsafe_unretained typeof(self) week_self = self;
    
    [self.collectionView addHeaderWithCallback:^{
        [week_self.dataList removeAllObjects];
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
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    if(self.dataList.count>0){
//        return 1;
//    }else{
//        return 0;
//    }
//}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Warning" bundle:nil] instantiateInitialViewController];
        UIViewController *vc = [[nav childViewControllers] firstObject];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if(self.popover!=nil){
            [self.popover dismissPopoverAnimated:NO];
        }
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"Warning" bundle:nil] instantiateInitialViewController];
        self.popover = [[UIPopoverController alloc] initWithContentViewController:vc];
        UIBarButtonItem *button = (UIBarButtonItem*)sender;
        [self.popover presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}

-(IBAction)showControlRecordVC:(id)sender{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateInitialViewController];
        UIViewController *vc = [[nav childViewControllers] firstObject];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if(self.popover!=nil){
            [self.popover dismissPopoverAnimated:NO];
        }
        UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateInitialViewController];
        self.popover = [[UIPopoverController alloc] initWithContentViewController:nav];
        UIBarButtonItem *button = (UIBarButtonItem*)sender;
        [self.popover presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if(actionSheet==self.poolListActionSheet){
        if(buttonIndex==2){
            self.poolVO = nil;
            self.allPoolOptionBarButton.title = @"全部";
            self.isOutofPool = FALSE;
            [self.dataList removeAllObjects];
            [self.collectionView headerBeginRefreshing];
        }else if(buttonIndex>=3){
            NSLog(@"%@", [actionSheet buttonTitleAtIndex:buttonIndex]);
            if([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"游离物理主机"]){
                self.poolVO = nil;
                self.allPoolOptionBarButton.title = @"游离物理主机";
                self.isOutofPool = TRUE;
                [self.dataList removeAllObjects];
                [self.collectionView headerBeginRefreshing];
            }else{
                self.poolVO = self.poolList[(buttonIndex-3)];
                self.allPoolOptionBarButton.title = self.poolVO.resourcePoolName;
                self.isOutofPool = FALSE;
                [self.dataList removeAllObjects];
                [self.collectionView headerBeginRefreshing];
            }
        }
    }else{
        if(buttonIndex==2){
            self.busDomainVO = nil;
            self.allBusinessOptionBarButton.title = @"全部";
            self.isUnGroup = FALSE;
            [self.dataList removeAllObjects];
            [self.collectionView headerBeginRefreshing];
        }else if(buttonIndex>=3){
            NSLog(@"%@", [actionSheet buttonTitleAtIndex:buttonIndex]);
            if([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"未分配业务系统"]){
                self.busDomainVO = nil;
                self.allBusinessOptionBarButton.title = @"未分配业务系统";
                self.isUnGroup = TRUE;
                [self.dataList removeAllObjects];
                [self.collectionView headerBeginRefreshing];
            }else{
                self.busDomainVO = self.busDomainsList[(buttonIndex-3)];
                self.allBusinessOptionBarButton.title = self.busDomainVO.busDomainName;
                self.isUnGroup = FALSE;
                [self.dataList removeAllObjects];
                [self.collectionView headerBeginRefreshing];
            }
        }
        
    }
    
    
}
- (IBAction)showPoolListSelect:(id)sender {
    [[RemoteObject getCurrentDatacenterVO] getPoolListAsync:^(id object, NSError *error) {
        self.poolList = ((PoolListResult*)object).resourcePools;
        
        self.poolListActionSheet = [[UIActionSheet alloc] initWithTitle:@"过滤条件" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:[NSString stringWithFormat:@"当前：%@", self.allPoolOptionBarButton.title] otherButtonTitles: nil];
        [self.poolListActionSheet addButtonWithTitle:@"全部"];
        for(PoolVO *pool in self.poolList){
            [self.poolListActionSheet addButtonWithTitle:pool.resourcePoolName];
        }
        [self.poolListActionSheet addButtonWithTitle:@"游离物理主机"];
        [self.poolListActionSheet showFromBarButtonItem:sender animated:YES];
        
    }];
}
- (IBAction)showBusinessListSelect:(id)sender {
    [[RemoteObject getCurrentDatacenterVO] getBusDomainsListAsync:^(id object, NSError *error) {
        self.busDomainsList = ((BusDomainsListResult*)object).busDomains;
        
        self.businessListActionSheet = [[UIActionSheet alloc] initWithTitle:@"过滤条件" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:[NSString stringWithFormat:@"当前：%@", self.allBusinessOptionBarButton.title] otherButtonTitles: nil];
        [self.businessListActionSheet addButtonWithTitle:@"全部"];
        for(BusDomainsVO *busDomains in self.busDomainsList){
            [self.businessListActionSheet addButtonWithTitle:busDomains.busDomainName];
        }
        [self.businessListActionSheet addButtonWithTitle:@"未分配业务系统"];
        [self.businessListActionSheet showFromBarButtonItem:sender animated:YES];
        
    }];
}

@end
