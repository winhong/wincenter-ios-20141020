//
//  BusinessVmCollectionVC.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-9.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "BusinessVmCollectionVC.h"
#import "BusinessVmCollectionCell.h"
#import "VmContainerVC.h"

@interface BusinessVmCollectionVC ()

@end

@implementation BusinessVmCollectionVC

- (void)viewDidLoad
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.collectionView.backgroundColor = [UIColor clearColor];
    }
    
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

- (void) reloadData{
    [self.businessVO getBusinessVmListAsync:^(id object, NSError *error) {
        self.dataList = ((BusinessVO*)object).wceBusVms;
        [self.collectionView headerEndRefreshing];
        [self.collectionView footerEndRefreshing];
        [self.collectionView reloadData];
        
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BusinessVmCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BusinessVmCollectionCell" forIndexPath:indexPath];
    
    BusinessVmVO *vmvo = (BusinessVmVO*)self.dataList[indexPath.row];
    cell.name.text = vmvo.name;
    cell.startOrder.text = [NSString stringWithFormat:@"%d", vmvo.startOrder];
    cell.delayInterval.text = [NSString stringWithFormat:@"%d", vmvo.delayInterval];
    cell.state.text = [vmvo state_text];
    cell.state.textColor = [vmvo state_color];
    if (indexPath.row % 2 == 1) {
        cell.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    }else{
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *root = [[UIStoryboard storyboardWithName:@"VM" bundle:nil] instantiateInitialViewController];
    VmContainerVC *vc;
    if([root isKindOfClass:[VmContainerVC class]]){
        vc = (VmContainerVC*) root;
    }else{
        vc = [[root childViewControllers] firstObject];
    }
    BusinessVmVO *businessVmvo = (BusinessVmVO*)self.dataList[indexPath.row];
    VmVO *vmvo = [[VmVO alloc] init];
    vmvo.vmId = businessVmvo.vmId;
    vmvo.name = businessVmvo.name;
    vc.vmVO = vmvo;
    if(self.isDetailPagePushed){
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self presentViewController:root animated:YES completion:nil];
    }
}
@end
