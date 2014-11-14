//
//  PoolHostCollectionVC.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "HostCollectionVC.h"
#import "HostCollectionCell.h"
#import "HostContainerVC.h"

@implementation HostCollectionVC

- (IBAction)refreshAction:(id)sender {
    [self.collectionView headerBeginRefreshing];
}

-(void)reloadData{
    [self.poolVO getHostListAsync:^(id object, NSError *error) {
        NSUInteger recordTotal = ((HostListResult*)object).hosts.count;
        
        [self.poolVO getHostListAsync:^(id object, NSError *error) {
            [self.dataList addObjectsFromArray:((HostListResult*)object).hosts];
            [self.collectionView headerEndRefreshing];
            if(self.dataList.count >= recordTotal){
                [self.collectionView footerFinishingLoading];
            }else{
                [self.collectionView footerEndRefreshing];
            }
            [self.collectionView reloadData];
            self.parentViewController.parentViewController.navigationItem.rightBarButtonItem.enabled = true;
        } referTo:self.dataList];
        
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HostCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HostCollectionCell" forIndexPath:indexPath];
    
    if(self.dataList.count==0) return cell;
    
    HostVO *hostVO = (HostVO *) self.dataList[indexPath.row];
    cell.title.text = hostVO.hostName;
    cell.label1.text = hostVO.ip;
    if(hostVO.ip == nil){
        cell.label1.text = @"无法获取网络";
        cell.label1.textColor = [UIColor lightGrayColor];
    }else{
        cell.label1.textColor = [UIColor blackColor];
    }
    cell.label2.text = [NSString stringWithFormat:@"%d",hostVO.virtualMachineNum];
    cell.label3.text = [NSString stringWithFormat:@"%d",hostVO.cpuSlots];
    cell.label4.text = [NSString stringWithFormat:@"%d",hostVO.cpu];
    cell.label5.text = [NSString stringWithFormat:@"%.2fGB",hostVO.memory/1024.0];
    cell.label6.text = [NSString stringWithFormat:@"%.2f%@",[hostVO storage_value],[hostVO storage_unit]];
    cell.status.text = [hostVO state_text];
    cell.status.textColor = [hostVO state_color];
    cell.status_image.layer.cornerRadius = 6;
    cell.status_image.backgroundColor = [hostVO state_color];
    
    cell.progress_1.litEffect = NO;
    cell.progress_1.numBars = 10;
    cell.progress_1.value = [self formatCountData:hostVO.virtualMachineNum/16.0];
    cell.progress_1.backgroundColor = [UIColor clearColor];
    cell.progress_1.outerBorderColor = [UIColor clearColor];
    cell.progress_1.innerBorderColor = [UIColor clearColor];
    
    cell.progress_2.litEffect = NO;
    cell.progress_2.numBars = 10;
    cell.progress_2.value = [self formatCountData:hostVO.storage/640.0];
    cell.progress_2.backgroundColor = [UIColor clearColor];
    cell.progress_2.outerBorderColor = [UIColor clearColor];
    cell.progress_2.innerBorderColor = [UIColor clearColor];
    
    cell.progress_3.litEffect = NO;
    cell.progress_3.numBars = 10;
    cell.progress_3.value = [self formatCountData:hostVO.cpuSlots/16.0];
    cell.progress_3.backgroundColor = [UIColor clearColor];
    cell.progress_3.outerBorderColor = [UIColor clearColor];
    cell.progress_3.innerBorderColor = [UIColor clearColor];
    
    cell.progress_4.litEffect = NO;
    cell.progress_4.numBars = 10;
    cell.progress_4.value = [self formatCountData:hostVO.cpu/(2*8*4.0)];
    cell.progress_4.backgroundColor = [UIColor clearColor];
    cell.progress_4.outerBorderColor = [UIColor clearColor];
    cell.progress_4.innerBorderColor = [UIColor clearColor];
    
    cell.progress_5.litEffect = NO;
    cell.progress_5.numBars = 10;
    cell.progress_5.value = [self formatCountData:hostVO.memory/(1024.0*256.0)];
    cell.progress_5.backgroundColor = [UIColor clearColor];
    cell.progress_5.outerBorderColor = [UIColor clearColor];
    cell.progress_5.innerBorderColor = [UIColor clearColor];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *root = [[UIStoryboard storyboardWithName:@"Host" bundle:nil] instantiateInitialViewController];
    HostContainerVC *vc;
    if([root isKindOfClass:[HostContainerVC class]]){
        vc = (HostContainerVC*) root;
    }else{
        vc = [[root childViewControllers] firstObject];
    }
    vc.hostVO = (HostVO *) self.dataList[indexPath.row];
    
    if(self.isDetailPagePushed){
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self presentViewController:root animated:YES completion:nil];
    }
}


@end
