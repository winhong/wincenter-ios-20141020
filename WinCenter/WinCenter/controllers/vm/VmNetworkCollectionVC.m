//
//  VmNetworkCollectionVC.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "VmNetworkCollectionVC.h"
#import "VmNetworkCollectionCell.h"

@implementation VmNetworkCollectionVC

-(void)reloadData{
    [self.vmVO getVmNicListAsync:^(NSArray *allRemote, NSError *error) {
        [self.dataList setValue:allRemote forKey:self.vmVO.name];
        [self.collectionView headerEndRefreshing];
        [self.collectionView footerEndRefreshing];
        [self.collectionView reloadData];
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VmNetworkCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VmNetworkCollectionCell" forIndexPath:indexPath];

    VmNetworkVO *vmNetworkVO = (VmNetworkVO *) [self.dataList valueForKey:self.dataList.allKeys[indexPath.section]][indexPath.row];
    cell.title.text = vmNetworkVO.name;
    cell.label1.text = [vmNetworkVO type_text];
    cell.label2.text = vmNetworkVO.ip;
    cell.label3.text = vmNetworkVO.macAddr;
    cell.label4.text = [NSString stringWithFormat:@"%d", vmNetworkVO.vlanId];
    if (indexPath.row % 2 == 1) {
        cell.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    }else{
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}


@end
