//
//  PoolVmCollectionVC.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "VmCollectionVC.h"
#import "VmCollectionCell.h"
#import "VmContainerVC.h"

@implementation VmCollectionVC

-(void)reloadData{
    if(self.poolVO){
        [self.poolVO getVmListAsync:^(id object, NSError *error) {
            [self.dataList addObjectsFromArray:((VmListResult*)object).vms];
            
            [self.collectionView headerEndRefreshing];
            if(self.dataList.count >= ((VmListResult*)object).recordTotal){
                [self.collectionView footerFinishingLoading];
            }else{
                [self.collectionView footerEndRefreshing];
            }
            [self.collectionView reloadData];
            self.parentViewController.parentViewController.navigationItem.rightBarButtonItem.enabled = true;
        } referTo:self.dataList];
    }else{
        [self.hostVO getVmListAsync:^(id object, NSError *error) {
            [self.dataList addObjectsFromArray:((VmListResult*)object).vms];
            
            [self.collectionView headerEndRefreshing];
            if(self.dataList.count >= ((VmListResult*)object).recordTotal){
                [self.collectionView footerFinishingLoading];
            }else{
                [self.collectionView footerEndRefreshing];
            }
            [self.collectionView reloadData];
            self.parentViewController.parentViewController.navigationItem.rightBarButtonItem.enabled = true;
        } referTo:self.dataList];
    }
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VmCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VmCollectionCell" forIndexPath:indexPath];
    
    if(self.dataList.count==0) return cell;
    
    VmVO *vmVO = (VmVO *) self.dataList[indexPath.row];
    cell.title.text = vmVO.name;
    cell.label1.text = vmVO.ip;
    if(vmVO.ip == nil || [vmVO.ip isEqualToString:@""]){
        cell.label1.text = @"无法获取网络";
        cell.label1.textColor = [UIColor lightGrayColor];
    }else{
        cell.label1.textColor = [UIColor blackColor];
    }
    cell.label2.text = [NSString stringWithFormat:@"%d", vmVO.vcpu];
    cell.label3.text = [NSString stringWithFormat:@"%.2fGB", vmVO.memory/1024.0];
    cell.label4.text = [NSString stringWithFormat:@"%dGB", vmVO.storage];
    
    HostVO *hostVO = [HostVO new];
    hostVO.hostId = vmVO.ownerHostId;
//    [hostVO getHostVOAsync:^(id object, NSError *error) {
//        HostVO *hostVO = (HostVO*) object;
//        if([hostVO.state isEqualToString:@"DISCONNECT"]){
//            cell.status.text = @"未知";
//            cell.status.text = [UIColor lightGrayColor];
//        }else{
//            cell.status.text = [vmVO state_text];
//            cell.status.textColor = [vmVO state_color];
//        }
//    }];

    cell.status_image.layer.cornerRadius = 6;
    cell.status_image.backgroundColor = [vmVO state_color];
    cell.osType.text = vmVO.osType;
    cell.osType_image.image = [UIImage imageNamed:[vmVO osType_imageName]];
    
    cell.progress_1.litEffect = NO;
    cell.progress_1.numBars = 10;
    cell.progress_1.value = [self formatCountData:vmVO.vcpu/(2*8*4.0)];;
    cell.progress_1.backgroundColor = [UIColor clearColor];
    cell.progress_1.outerBorderColor = [UIColor clearColor];
    cell.progress_1.innerBorderColor = [UIColor clearColor];
    
    cell.progress_2.litEffect = NO;
    cell.progress_2.numBars = 10;
    cell.progress_2.value = [self formatCountData:vmVO.memory/(1024.0*16.0)];;
    cell.progress_2.backgroundColor = [UIColor clearColor];
    cell.progress_2.outerBorderColor = [UIColor clearColor];
    cell.progress_2.innerBorderColor = [UIColor clearColor];
    
    cell.progress_3.litEffect = NO;
    cell.progress_3.numBars = 10;
    cell.progress_3.value = [self formatCountData:vmVO.storage/320.0];;
    cell.progress_3.backgroundColor = [UIColor clearColor];
    cell.progress_3.outerBorderColor = [UIColor clearColor];
    cell.progress_3.innerBorderColor = [UIColor clearColor];
    
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
    vc.vmVO = (VmVO *) self.dataList[indexPath.row];
    if(self.isDetailPagePushed){
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self presentViewController:root animated:YES completion:nil];
    }}

@end
