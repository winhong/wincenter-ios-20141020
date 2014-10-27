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

@implementation MasterCollectionVC

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
    
    self.pools = [[NSMutableDictionary alloc] initWithDictionary:@{}];
    self.pools_needMoreButton = [[NSMutableDictionary alloc] initWithDictionary:@{}];
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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

- (IBAction)showPoolListSelect:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"过滤条件" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"全部资源池" otherButtonTitles:@"资源池A",@"资源池B", nil];
    [sheet showFromBarButtonItem:sender animated:YES];
}
@end
