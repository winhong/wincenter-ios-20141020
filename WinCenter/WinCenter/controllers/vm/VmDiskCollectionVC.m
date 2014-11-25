//
//  VmNicCollectionVC.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "VmDiskCollectionVC.h"
#import "VmDiskCollectionCell.h"

@implementation VmDiskCollectionVC

-(void)reloadData{
    [self.vmVO getVmVolumnListAsync:^(id object, NSError *error) {
        NSUInteger recordTotal = ((VmDiskListResult*)object).volumes.count;
        
        [self.vmVO getVmVolumnListAsync:^(id object, NSError *error) {
            [self.dataList addObjectsFromArray:((VmDiskListResult*)object).volumes];
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
    
    VmDiskCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VmDiskCollectionCell" forIndexPath:indexPath];

    if(self.dataList.count==0) return cell;
    
    VmDiskVO *vmDiskVO = (VmDiskVO *) self.dataList[indexPath.row];
    cell.title.text = vmDiskVO.name;
    cell.status.text = [vmDiskVO state_text];
    cell.status.textColor = [vmDiskVO state_color];
    cell.label1.text = [vmDiskVO type_text];
    cell.label2.text = vmDiskVO.storagePoolName;
    cell.label3.text = [NSString stringWithFormat:@"%.2fGB", vmDiskVO.size];
    cell.share_image.hidden = [vmDiskVO.shared isEqualToString:@"false"];
    if (indexPath.row % 2 == 1) {
        cell.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    }else{
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}


@end
