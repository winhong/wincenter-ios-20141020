//
//  VmIsoCollectionVC.m
//  WinCenter
//
//  Created by 黄茂坚 on 14/11/7.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "VmIsoCollectionVC.h"
#import "VmIsoCollectionCell.h"

@implementation VmIsoCollectionVC

-(void)reloadData{
    [self.vmVO getVmIsoListAsync:^(id object, NSError *error) {
        NSUInteger recordTotal = ((VmIsoListResult*)object).isos.count;
        
        [self.vmVO getVmIsoListAsync:^(id object, NSError *error) {
            [self.dataList addObjectsFromArray:((VmIsoListResult*)object).isos];
            [self.collectionView headerEndRefreshing];
            if(self.dataList.count >= recordTotal){
                [self.collectionView footerFinishingLoading];
            }else{
                [self.collectionView footerEndRefreshing];
            }
            [self.collectionView reloadData];
        } referTo:self.dataList];
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VmIsoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VmIsoCollectionCell" forIndexPath:indexPath];
    
    if(self.dataList.count==0) return cell;
    
    VmIsoVO *vmIsoVO = (VmIsoVO *) self.dataList[indexPath.row];
    cell.isoName.text = vmIsoVO.isoName;
    cell.isoPath.text = vmIsoVO.path;
    cell.isoSize.text = [NSString stringWithFormat:@"%.2f%@",[vmIsoVO isoSize_value],[vmIsoVO isoSize_unit]];
    cell.status.text = [vmIsoVO state_text];
    cell.status.textColor = [vmIsoVO state_color];
    if (indexPath.row % 2 == 1) {
        cell.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    }else{
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}


@end
