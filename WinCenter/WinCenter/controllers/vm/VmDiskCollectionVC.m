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
    [self.vmVO getVmVolumnListAsync:^(NSArray *allRemote, NSError *error) {
        [self.dataList setValue:allRemote forKey:self.vmVO.name];
        [self.collectionView headerEndRefreshing];
        [self.collectionView footerEndRefreshing];
        [self.collectionView reloadData];
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VmDiskCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VmDiskCollectionCell" forIndexPath:indexPath];

    VmDiskVO *vmDiskVO = (VmDiskVO *) [self.dataList valueForKey:self.dataList.allKeys[indexPath.section]][indexPath.row];
    cell.title.text = vmDiskVO.name;
    cell.label1.text = [vmDiskVO type_text];
    cell.label2.text = vmDiskVO.storagePoolName;
    cell.label3.text = [NSString stringWithFormat:@"%dGB", vmDiskVO.size];
    if (indexPath.row % 2 == 1) {
        cell.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    }else{
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}


@end
